# Architecture — 双层架构 (M3 + Pipeline)

> 当前版本: v0.0.3 (2026-08-08)
> 决策记录: [`decisions/0003-two-layer-architecture.md`](../decisions/0003-two-layer-architecture.md)

## 1. 顶层视图

整个系统分**两层**:

```
┌──────────────────────────────────────────────────────────┐
│  M3 层 (mavis-agents/)                                  │
│  ──────────────────────────────────────────────────────  │
│  顶层 persona + 端到端工作流 + PUA 闭环                    │
│  跟用户直接对话, 调度下层 sub-agent                       │
│  看不到 raw PDF / HTML, 只吃结构化 YAML/MD               │
│                                                          │
│  当前 canonical: shouren-researcher                       │
│    → 已移入 reference/, frozen                           │
│    → 后续 vi-orchestrator 接棒 (本轮不做)                 │
└──────────────────────────┬───────────────────────────────┘
                           │ 调用
                           ▼
┌──────────────────────────────────────────────────────────┐
│  Pipeline 层 (agents/ + prompts/)                       │
│  ──────────────────────────────────────────────────────  │
│  01 data-collector → 02 data-cleaner → 04 analyst        │
│                          │              ↓                │
│                          │            05 writer          │
│                          │              ↓                │
│                       [03 terminal]    06 visual         │
│                          (旁路, 01/04 可调用)            │
│                                                          │
│  • 只产 YAML / MD 结构化输出                              │
│  • 不接触 raw PDF / 散装 HTML                            │
│  • 不写 pptx / docx (那是 05/06)                         │
└──────────────────────────────────────────────────────────┘
```

**核心原则**:
1. **M3 是 persona, pipeline 是 worker** — 不混淆
2. **数据单向流** — 不可逆
3. **状态显式化** — 每次跑生成 session 目录
4. **03 可选** — 01 可不依赖 03, 04 可不依赖 03

## 2. 数据流 (一图)

```
用户 → M3 (守仁研究)
            │
            │  ① target = 0700.HK
            ▼
       00 session
       (创建 outputs/0700.HK-腾讯/2026-08-08/)
            │
            ▼
   ┌── 01 data-collector ──┐
   │  input:  target, scope │  02 data-cleaner
   │  output: collection.yaml│ ──────┐
   │  raw/ 下放 PDF/HTML    │       │
   └────────────────────────┘       ▼
                              02 输出 cleaned.yaml
   ┌── 03 terminal-bridge ──┐       │
   │  input:  query         │       │
   │  output: terminal_data │       ▼
   │  (可选, 01 和 04 都可调)│   04 analyst
   └────────────────────────┘   input: cleaned + 可选 terminal
                              output: analysis.yaml + analysis.md
                                    │
                                    ▼
                              05 writer
                              input: analysis
                              output: report.md + summary.docx + data.xlsx
                                    │
                                    ▼
                              06 visual-designer
                              input: report.md
                              output: report-final.pdf + deck.pptx + onepager.png
```

## 3. 状态模型

每次跑一个标的 = 一个 session, 落在一个目录里:

```
outputs/<target>/<date>/
├── 00-session.yaml            # 顶层: target, started_at, per-stage status
├── 01-collector/
│   ├── collection.yaml        # 01 输出契约
│   └── raw/                   # 招股书 PDF / 媒体 HTML
├── 02-cleaner/
│   ├── cleaned.yaml           # 02 输出契约
│   └── extracted/             # 拆出的表格 / 文本
├── 03-terminal/               # 可选
│   └── terminal_data.yaml     # 03 输出契约
├── 04-analyst/
│   ├── analysis.yaml          # 04 输出契约
│   └── analysis.md            # 04 给人读
├── 05-writer/
│   ├── report.md              # 05 主输出
│   ├── report-summary.docx
│   └── report-data.xlsx
├── 06-visual/
│   ├── report-final.pdf       # 6 主输出
│   ├── deck.pptx
│   └── onepager.png
└── 99-eval/
    ├── scores.md              # 跑分总表
    └── per-agent/
        ├── 01-collector.md
        ├── 04-analyst.md
        └── 05-writer.md
```

**为什么用文件不用 DB**:
- 透明 — `cat`/`vim` 直接看
- 可 git 化 — 跑分/样例都能入仓做历史
- 跨人零成本 — Ryan 和 shine040 各看各的 outputs/ 不冲突 (每人本机一份)
- 阶段 0/1 够用; 真要 DB 是阶段 3 之后的事

## 4. 编排逻辑

**M3 调用 pipeline 的 5 步**:

| 阶段 | M3 干的事 | 调用 agent | 失败处理 |
|---|---|---|---|
| ① 启动 | 收用户指令, 创建 session 目录, 写 00-session.yaml | — | — |
| ② 采集 | 调 01, 传 target + scope; 拿回 collection.yaml | 01 | 重试 3 次 → 标 partial → 用户决策 |
| ③ 清洗 | 调 02, 传 collection; 拿回 cleaned.yaml | 02 | 退化为只跑有边框表; OCR 失败标"不可用" |
| ④ 分析 | 调 04, 传 cleaned + 可选 03 数据; 拿回 analysis.yaml | 04 | LLM 拍脑袋检查: 强制每条带 source ref |
| ⑤ 写报+视觉 | 调 05 + 06, 拿回 PDF/PPT/Word/xlsx | 05 → 06 | PUA 6 项 checklist, 缺一不交付 |

**关键约束**:
- M3 不碰 raw PDF / HTML — 只看 YAML/MD
- 任何 agent 的 output 都要带 `generated_at` + `model_version` 字段
- 跨 agent 数据通过 `outputs/<target>/<date>/<NN>-<name>/*.yaml` 传
- 同一 session 内可重跑某个 stage, 上游结果可缓存 (`00-session.yaml` 标记 status)
- 03 是旁路 — 01 和 04 都可以调, 04 强依赖 02 但弱依赖 03

## 5. 版本与契约

| 维度 | 规则 |
|---|---|
| Agent spec | `agents/0N-<name>.md` 头部永远标当前版本 (e.g. v0.1) |
| Prompt | `prompts/<agent>/vN.M.md`, N 是主版本 (破坏性), M 是次版本 (微调) |
| I/O 契约 | 集中在 [`docs/contracts.md`](contracts.md), 契约版本号跟 agent spec 走 |
| 兼容性 | 同一主版本下, 上游改 output schema 必须先升 02/04, 再让 01 跟 |
| ADR | 任何"改方向"的决定走 [`decisions/`](../decisions/README.md) |

## 6. M3 ↔ Pipeline 关系

**M3 知道的事**:
- 用户是谁, 想要什么
- 目标标的, 输出格式
- PUA 闭环 / 整体节奏
- 哪些 stage 跑过 / 跑挂了

**M3 不知道的事** (应该不知道, 否则越界):
- 招股书 PDF 在哪个盘
- Wind 凭证怎么存
- 财务表怎么 OCR
- PPT 怎么排版

**反向**:
- Pipeline 不直接跟用户对话
- Pipeline 不做"该跑哪个标的"决策
- Pipeline 不做"该不该交付"的最终判断 (那是 M3 的 PUA 闭环)

## 7. 演进路径 (Roadmap 衔接)

| 阶段 | 本架构的角色 |
|---|---|
| 阶段 0 (✅) | 协作流 + 本架构定义 |
| 阶段 1 | 在 0700.HK 跑通端到端 (01→02→04→05→06), 验证契约和状态模型 |
| 阶段 2 | 跑分常态化, PUA 闭环自动化 |
| 阶段 3 | 数据源扩展, 多标的对标 — 此时考虑引入 DB 替代文件系统 (待评估) |

---

**更新历史**:
- 2026-08-08: 初版 (随 v0.0.3 一并入仓), 决策见 ADR 0003

# ADR-0004: Agent 职责边界重新划分 (Agent Role Boundaries)

> **状态**: 采纳 (2026-08-08)
> **拍板人**: Ryan LI
> **驱动**: cha-initiation-2026 项目 04-analyst 越界写了"评级 / 目标价 / 投资建议"

## 背景 (Context)

2026-08-08 cha-initiation-2026 项目的 04-analyst 输出 (analysis.md) 跟 05-writer 输出 (report.docx) 都包含了:
- 投资评级 (HOLD)
- 目标价 (US$9.55)
- "我们认为" 主观多头段落
- 投资建议 (BUY 触发条件 / SELL 触发条件)

**问题**: 评级 / 目标价 / 投资建议是**主观多头判断**, 属于人类投资决策范畴, Agent 不该越界做这步。

Ryan 拍板: Agent 职责是"帮人加速理解一个公司, 不帮人下结论"。
- ✅ 收集 + 整理 + 呈现 (重复劳动, 机器擅长)
- ❌ 判断 + 评级 + 目标价 (主观多头, 只有人该做)

## 决策 (Decision)

### 1. 5 角色矩阵 (2 Agent + 3 Human)

| 角色 | 类别 | 职责 |
|---|---|---|
| **role01: collector** | Agent | 收集 + 整理 + 汇总 |
| **role02: verifier** | Agent | 多源 cross-check + 异常检测 |
| **role03: question-asker** | Human | 提问 / 追问 / 筛选 |
| **role04: draft writer** | Human | 综合 + 写初稿 |
| **role05: modifier** | Human | 修改 + 视觉化 + 排版 |

### 2. 之前 6 子 agent pipeline 的映射变化

| 老 agent | 新角色 | 变化 |
|---|---|---|
| 01-data-collector | role01 collector (子模块) | 收紧, 不写判断 |
| 02-data-cleaner | role01 collector (子模块) | 保留 |
| 03-terminal-bridge | role01 collector (子模块) | 保留 |
| **04-analyst** | **role01 collector (信息呈现) + role03 提问提示** | **取消 Agent 写评级** |
| **05-writer** | **role04 辅助工具** | **取消 Agent 写研报** |
| **06-visual-designer** | **role05 辅助工具** | **取消 Agent 视觉化** |

### 3. cha-initiation-2026 项目的回炉

之前 (2026-08-08 v0.x) 的 04-analyst + 05-writer 输出越界, 改为:

- **04-analyst/analysis.md**: 删除"投资评级 / 目标价 / 我们认为" 等主观多头段落, 只留**信息呈现**
  - 数据 + source
  - 同业可比表 (raw)
  - 卖方观点汇总 (≥3 家)
  - 风险清单 (raw, 不解读)
  - 监控 KPI 阈值 (数据点, 不触发动作)
- **05-writer/report.docx**: 改为 **财务三表 Excel** (Sheet 1-7 标准) + 卖方观点汇总表 + 风险清单表, 不是 Word 研报

### 4. 工作流 (Stage 1-3)

```
Stage 1 收集 (Agent 跑)         → raw + cleaned + excel + peer + sell-side
Stage 2 互动 (Human 提问, Agent 答) → 提问清单 + 补充收集
Stage 3 写稿 (Human 写)          → draft writer 出初稿 → modifier 出终稿
```

## 影响 (Consequences)

### 正面
- ✅ Agent 边界清晰, 不再越界
- ✅ 投资决策权 (评级 / 目标价) 100% 留给 Human
- ✅ 数据可溯源, 漂亮话减少
- ✅ Stage 2 互动环节, 提升认知深度 (Ryan 拍板 80% 认知在 Stage 2 形成)

### 负面 / 风险
- ⚠️ Human 工作量上升 (Stage 2 提问 + Stage 3 写稿)
- ⚠️ "漂亮的初稿" 减少 (Agent 输出偏 raw), 对 Human 信息消化能力要求高
- ⚠️ 评测标准 (eval/scoring-sheets) 要跟着改 — 04 不再评"评级准确度", 改评"信息完整度 / source 覆盖度"

### 缓解措施
- 文档化 (docs/agent-roles.md) 让每个角色边界清楚
- ADR 走决策流, 任何角色越界立刻 catch
- v1 阶段 04/05/06 三个 spec 文件保留作为 Human role 的工具说明, 标 "由 Human 使用, 不由 Agent 自动执行"

## 替代方案 (Alternatives Considered)

### 备选 1: Agent 写"参考评级" (recommendation), Human 可推翻
- ❌ 拒: "参考评级" 也是判断, 一旦 Agent 写了, Human 会被锚定
- 即使标 "(供参考)", 心理学上会偏

### 备选 2: Agent 写"两个对冲观点", Human 选
- ❌ 拒: 信息呈现 (role01 collector) 阶段不应预设观点框架
- "对冲观点" 是 analysis 层级, 应是 role03 question-asker 提出来

### 备选 3: Agent 写"5 档情景概率", Human 调
- ⚠️ 部分采纳: Agent 可以给"卖方一致目标价区间" (raw), 但不给"我认为应该 30/50/20 概率"
- 概率分配是主观判断, Human 来

## 实施 (Implementation)

### 已完成 (2026-08-08)
- [x] `docs/agent-roles.md` v1.0 写入 (22.7KB, 11 节)
- [x] `decisions/0004-agent-role-boundaries.md` (本 ADR)
- [x] `projects/cha-initiation-2026/04-analyst/analysis.md` 改写 (删除评级 / 目标价 / 投资建议)
- [x] `projects/cha-initiation-2026/05-writer/` 重做 (Excel 财务三表 + 卖方观点表, 删 Word 研报)
- [x] `projects/cha-initiation-2026/05-writer/financials.xlsx` 7 sheet 财务表

### 待办 (下周)
- [ ] `agents/04-analyst.md` v1.1 改写 (取消 Agent 写评级, 改为 "Human 使用的工具说明")
- [ ] `agents/05-writer.md` v1.1 改写 (取消 Agent 写研报, 改为 "Human 使用的工具说明")
- [ ] `agents/06-visual-designer.md` v1.1 改写 (同上)
- [ ] `eval/scoring-sheets/04-analyst.md` v1.1 改写 (不评"评级", 改评"信息完整度 / source 覆盖度")
- [ ] `eval/scoring-sheets/05-writer.md` v1.1 改写 (不评"研报质量", 改评"Excel 完整性 / 数据可溯源性")

## 相关文档 (References)

- `docs/agent-roles.md` — 完整职责总纲
- ADR-0002 (shouren 归档) — 同样原则: 边界清晰, 决策留给人
- ADR-0003 (双层架构 M3 + Pipeline) — M3 跑 Stage 1 收集, Human 跑 Stage 2-3
- `agents/README.md` — 6 子 agent 总览 (待 v1.1 改写)

## 决策日期

- 提案: 2026-08-08
- 拍板: 2026-08-08 (Ryan LI, 当日)
- 实施: 2026-08-08
- 状态: ✅ 采纳, v1.0 在 cha-initiation-2026 项目落地

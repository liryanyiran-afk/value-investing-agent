# 0003 — 双层架构 (M3 + Pipeline)

## 状态
已接受 (2026-08-08)

## 背景
`value-investing-agent` 仓库 v0.0.2 之前, 6 个 pipeline sub-agent (`agents/01-06`) 和 1 个 M3 agent
(`mavis-agents/shouren-researcher.md`) 各自有 spec, 但**两层关系未定义**, 关键缺失:

1. **谁调度谁**: 没人说 M3 是 orchestrator, 也没人说 pipeline 是 worker
2. **数据流向**: 6 个 agent 的 input/output 各自描述, 但跨 agent 传数据靠什么没规定
3. **状态怎么存**: 一次跑标的的中间结果放哪里, 重跑怎么续, 没规定
4. **契约维护**: I/O YAML 在 6 个 agent spec 重复, 改一处要改 6 处
5. **跑分体系**: 通用 rubric 有, 但每个 agent 的具体打分卡没有

直接堆 feature 会**埋下结构问题**, 越晚改越痛.

## 决策
采用**两层架构**:

```
┌────────────────────────────────────────┐
│  M3 层 (mavis-agents/)                 │
│  顶层 persona + orchestrator + PUA     │
│  跟用户对话, 调度下层, 看不到 raw 数据  │
└─────────────────┬──────────────────────┘
                  │ 调用
                  ▼
┌────────────────────────────────────────┐
│  Pipeline 层 (agents/ + prompts/)      │
│  01 → 02 → 04 → 05 → 06 (主链)        │
│  03 旁路 (01 / 04 可调)                │
│  只产 YAML / MD, 不可见 PPT/PDF        │
└────────────────────────────────────────┘
```

### 配套
- **状态 = 文件系统**: `outputs/<target>/<date>/<NN>-<name>/<file>.yaml`,
  跨 agent 数据走这条路径, 不引 DB
- **契约集中**: `docs/contracts.md` 是 single source of truth,
  6 个 agent spec 引用, 改一处改一处 (在 PR 内同步)
- **跑分卡**: `eval/scoring-sheets/<NN>-<name>.md`,
  01/04/05/06 各一份 (4 份), 02/03 用通用 6 维度
- **每个 agent spec 顶部加 Pipeline Position 段**, 标明上下游 / 读写路径 / 契约引用

### 4 个核心原则
1. M3 是 persona, pipeline 是 worker — 不混淆
2. 数据单向流 — 不可逆
3. 状态显式化 — 每次跑生成 session 目录
4. 03 可选 — 01 可不依赖 03, 04 可不依赖 03

## 候选方案

### A. 单一扁平架构 (M3 + Pipeline 混在一起)
- 一个 agent 同时是 persona + worker
- 缺点: 责任不清, 测试困难
- **不采纳**

### B. 严格三层 (orchestrator / pipeline / data)
- 引入显式 orchestrator agent (e.g. `00-orchestrator.md`)
- 缺点: 多一层抽象, 阶段 0/1 用不上, 提前抽象
- **不采纳 (阶段 3 之后如有需要再开 ADR supersede)**

### C. 双层 (M3 persona + Pipeline worker) ✅
- 跟现有 shouren-researcher 形态对齐
- 抽象刚好, 不多不少
- 阶段 0/1/2 够用
- **采纳**

## 后果
- ✅ 架构清晰, 角色分明
- ✅ 状态/契约/跑分各归各位
- ✅ 6 个 agent spec 全部有 Pipeline Position 段
- ✅ shouren 跟 04 关系明确 (见 ADR 0002)
- ⚠️ 阶段 1 跑通后, 可能要补"跨 stage 重跑 / 状态恢复"机制
  (目前只能全量重跑, 不支持断点续跑)
- ⚠️ 阶段 3 数据源扩展时, 文件系统状态可能要换 DB
  (到时候开 ADR supersede 本决策)

## 关联
- [`docs/architecture.md`](../docs/architecture.md) — 详细架构图 / 数据流 / 状态模型
- [`docs/contracts.md`](../docs/contracts.md) — 6 agent I/O 契约
- [`docs/workflow.md`](../docs/workflow.md) — 协作流程 (已有, 本决策不冲突)
- ADR 0002 — shouren 归档 (本决策的伴生)
- ADR 0001 — _暂无 (待阶段 1 真实标的后补)_

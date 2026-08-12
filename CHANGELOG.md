# Changelog

> Agent 整体的版本演进历史。每完成一次大迭代，加一条。

格式:
```
## [Y.MM.DD] — <一句话标题>
### Added
### Changed
### Fixed
### Eval
- v0.1: X / 10
- v0.2: X / 10 (Δ +X)
```

## [0.0.4] — 2026-08-12 — analyst v0.2 子框架 + 创新药 18A SOP 沉淀 (凌科案首跑)

### Added
- `prompts/analyst/v0.2-biotech-18a-sop.md` — 创新药 18A 港股 IPO 行研 SOP (6 步法 + POS 表 + 头对头 5 维 + rNPV 6 段式 + 决策价带 + 敏感性 + 10 条陷阱)
- `prompts/analyst/CHANGELOG.md` — analyst prompt 版本演进记录
- `eval/scores/2026-08-12-analyst.md` — 凌科药业案跑分 (7.92 / 10, 内部可用, 距客户发线 85 差 8 分)

### Changed
- ROADMAP 阶段 1: analyst 状态从 🟡 placeholder → 🟢 in-progress (首个真实样例 = 凌科药业)

### Notes
- 这是 04 analyst 的首个真实样例, 也是 6 步法从 scaffold 到实操的首次验证
- 跑分卡按 [`eval/scoring-sheets/04-analyst.md`](eval/scoring-sheets/04-analyst.md) 10 维度
- 关键发现: 结构完整 + 工程化到位 (973 公式 0 错误), 但市占率假设的 5 维 sanity check 是从结构到洞察的核心跨越点
- 下次研究同类标的 (候选: 派格/旺山/同源康/科伦博泰) 验证 SOP 稳健性

### Eval
- 04 analyst (凌科案): **7.92 / 10** (内部可用 60 ✅, 投决会 75 ✅, 客户发 85 ❌, 头部对标 90 ❌)
- 维度细分: 准确性 8 / 完整性 9 / 深度 8 / 可读性 8 / 实用性 8 / 视觉 7 / 估值算法透明度 8 / 错位视角证据强度 8 / 蓝军自攻击 8 / KPI 阈值清晰度 7

## [0.0.3] — 2026-08-08 — 双层架构 + shouren 归档 (M3 + Pipeline 体系成型)

### Added
- `docs/architecture.md` — 双层架构 (M3 + Pipeline) 定义, 含数据流 / 状态模型 / 编排逻辑
- `docs/contracts.md` — 6 agent I/O 契约 single source of truth
- `eval/scoring-sheets/01-data-collector.md` — 8 维度具体打分卡
- `eval/scoring-sheets/04-analyst.md` — 10 维度 (最细) + PUA 6 项对应
- `eval/scoring-sheets/05-writer.md` — 8 维度
- `eval/scoring-sheets/06-visual-designer.md` — 9 维度 + 跨平台 checklist
- `prompts/analyst/extraction-notes.md` — shouren → 04 v0.2 提炼对照表
- `prompts/terminal-bridge/v0.1.md` placeholder (从缺到齐)
- `prompts/writer/v0.1.md` placeholder (从缺到齐)
- `prompts/visual-designer/v0.1.md` placeholder (从缺到齐)
- `mavis-agents/reference/README.md` — 归档规则说明
- `decisions/0002-shouren-as-archive.md` — shouren 降级为参考档案
- `decisions/0003-two-layer-architecture.md` — 双层架构决策

### Changed
- `mavis-agents/shouren-researcher.md` — 移入 `mavis-agents/reference/`, 顶部加 🧊 frozen banner
- `mavis-agents/skills-manifest.md` — 跟随移入 `mavis-agents/reference/`
- `mavis-agents/README.md` — 重写, 加 M3/Pipeline 关系段 + reference 说明
- `mavis-agents/install.sh` — 改为只装 active agents, 不再装 shouren (注释说明)
- 6 个 `agents/0N-xxx.md` — 顶部加 Pipeline Position 段 (位置 / 上下游 / 读写路径 / 契约引用)
- `prompts/{terminal-bridge,writer,visual-designer}/v0.1.md` — placeholder 内容从无到齐
- `decisions/README.md` — 加 0002/0003 索引
- `ROADMAP.md` — 加架构段 + 阶段 1 配套 + 阶段 3 DB 评估项

### Fixed
- 无

### Notes
- 这是阶段 0 的"设计定型"迭代, 阶段 1 (真实标的全链路) 在此基础上开跑
- 6 个 agent spec 全部带 Pipeline Position 段, 跨人 review 一眼看清上下游
- shouren 在 Ryan 机器上已 install 的实例保留, 仓内 spec 冻结不影响本地
- 未来 M3 顶层 agent (vi-orchestrator) 启动时, 需 reference shouren 的 PUA / 5 页结构, 不另起

### Eval
- 协作流: 阶段 0 全绿 (5/5 项) — v0.0.2 时已闭环, v0.0.3 增加设计定型 1 项 (6/6)
- prompt / agent eval: 待首个真实样例 (阶段 1 启动)

## [0.0.2] — 2026-08-08 — 守仁研究 (Shouren Researcher) agent 上线
### Added
- `mavis-agents/shouren-researcher.md` — 守仁资产研究 卖方研究分析师 spec
- `mavis-agents/README.md` — Mavis agent 索引
- `mavis-agents/install.sh` — 一键安装脚本
- `mavis-agents/skills-manifest.md` — 24 个配套 skill 清单
- Ryan 机已 install (`shouren-researcher`), 朋友机待 install

### Changed
- 从 `bitgates-researcher` (BitGates Research Institute) 改名 `shouren-researcher` (守仁资产研究)
- 删除 `taste-skill-v1` (本地无此 skill, 不传)
- 配套 skill 从 25 减为 24, 全内置 ✅

### Notes
- agent name / display name / institution 全部更新
- 朋友机跑 `./install.sh` 自动同步到 `shouren-researcher`

## [0.0.1] — 2026-08-08 — 协作流闭环验证
### Added
- `scripts/push_via_api.py` — Ryan 本机用, 绕 github.com 网络拦
- ROADMAP 阶段 0 全绿 (PR #1, PR #2 双账号 review 验证)
- 协作者 shine040 加入

### Changed
- 阶段 0 状态从 scaffolding 升级到 ✅ 完成
- 6 个 agent 负责人占位 (_Ryan / shine040 选其一_, 待分工)

### Fixed
- 无

### Eval
- 协作流: 阶段 0 全绿 (5/5 项)
- prompt / agent eval: 待首个真实样例

## [0.0.0] — 2026-08-08 — 仓库初始化
### Added
- 6 个子 agent 目录 & placeholder 规格文件
- Prompt 版本管理结构 (`prompts/<agent>/vN.M/`)
- 评分体系目录 (`eval/rubric.md`, `eval/scores/`)
- ADR 模板
- 数据源 / 协作流 / onboarding 文档
- GitHub Issue 模板 × 3, PR 模板 × 1

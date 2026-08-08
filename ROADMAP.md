# Roadmap

> 6 个子 agent 的推进看板。每完成一格打钩。

## 协作者
- **Ryan LI** (liryanyiran-afk) — owner
- **shine040** — collaborator (待补全名)

## 架构
v0.0.3 起采用**双层架构** (M3 + Pipeline), 详见 [`docs/architecture.md`](docs/architecture.md) + ADR 0003.
shouren-researcher 已在 ADR 0002 中降级为参考档案 (`mavis-agents/reference/`), 不再演进.

## 状态总览

| # | Agent 模块 | 负责人 | 状态 | 当前版本 | 阻塞项 |
|---|---|---|---|---|---|
| 01 | data-collector | _Ryan / shine040 选其一_ | 🟡 scaffolding | v0.1 placeholder | 数据源接入 |
| 02 | data-cleaner | _同上_ | 🟡 scaffolding | v0.1 placeholder | 待 01 输出 |
| 03 | terminal-bridge | _同上_ | 🟡 scaffolding | v0.1 placeholder | 终端 API 凭证 |
| 04 | analyst | _同上_ | 🟡 scaffolding | v0.1 placeholder → v0.2 起点 | 价值投资框架定稿 |
| 05 | writer | _同上_ | 🟡 scaffolding | v0.1 placeholder | 买方研报模板 |
| 06 | visual-designer | _同上_ | 🟡 scaffolding | v0.1 placeholder | 设计规范定稿 |

> 状态图例: ⚪ not-started · 🟡 scaffolding · 🟢 in-progress · ✅ done · 🔴 blocked

## 阶段 0 — 协作流跑通 (✅ 完成 2026-08-08)
- [x] GitHub repo 初始化
- [x] 目录结构 & 模板文件就位
- [x] 两人各跑一次完整 PR 流程 (PR #1, PR #2, 双账号 review 验证)
- [x] 不同账号 review 闭环 (liryanyiran-afk approved shine040 的 PR)
- [x] 跑分体系 rubric v0.1 框架就位 (具体跑分待首个真实样例)
- [x] 数据源接入清单 (docs/data-sources.md 确认 A股 + 港股通港股)
- [x] **v0.0.3 双层架构定义 + 契约集中 + 4 份具体打分卡 + shouren 归档** (本轮)

> 备注: Ryan 本机 github.com 被网络拦, push 走 `scripts/push_via_api.py` 绕 Contents API.
> 朋友机 (shine040, MacBook Air 3) 正常 git push 即可. 双机协作混跑已跑通.

## 阶段 1 — 单 agent 跑通 (目标: 1 个真实标的全链路)
- [ ] **01 data-collector** 能从至少 1 个数据源拿回数据 (候选: 0700.HK 腾讯 2025 年报)
- [ ] **04 analyst v0.2** 在 1 个真实标的上产出可读分析
  - 起点: 从 `mavis-agents/reference/shouren-researcher.md` 提炼 PUA 6 项 / 三档估值 / 蓝军
  - 详细对照表: [`prompts/analyst/extraction-notes.md`](prompts/analyst/extraction-notes.md)
- [ ] **05 writer** 输出首份"接近头部机构水平"的研报
- [ ] **06 visual-designer** 给出可复用视觉规范

### 阶段 1 配套
- [x] `docs/architecture.md` — 双层架构 (M3 + Pipeline)
- [x] `docs/contracts.md` — 6 agent I/O 契约
- [x] `eval/scoring-sheets/{01,04,05,06}.md` — 4 份具体打分卡
- [x] 6 个 `agents/0N-xxx.md` 顶部加 Pipeline Position 段
- [x] ADR 0002 (shouren 归档) + ADR 0003 (双层架构)

## 配套 (已就位)
- [x] `mavis-agents/reference/shouren-researcher` (守仁研究) — frozen, 不再 install
- [x] 24 个配套 skill 全内置 ✅, 见 `mavis-agents/reference/skills-manifest.md` (taste-skill-v1 已删除)

## 阶段 2 — pipeline 串联
- [ ] 01 → 02 → 04 → 05 → 06 端到端跑通 (按 `docs/architecture.md` 状态模型)
- [ ] eval/ 跑分机制常态化 (4 张打分卡都用上)
- [ ] 假设 → 验证 → 决策闭环
- [ ] 跨 stage 重跑 / 状态恢复 (architecture 已知 limitation)

## 阶段 3 — 提质 & 扩展
- [ ] 数据源扩展 (港股通 → 全港股 → A+H+US)
- [ ] 多标的对标分析
- [ ] 研报模板覆盖 (首次覆盖 / 深度跟踪 / 行业策略)
- [ ] _可选_: 文件系统状态 → DB (需开新 ADR supersede 0003)

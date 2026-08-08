# Roadmap

> 6 个子 agent 的推进看板。每完成一格打钩。

## 状态总览

| # | Agent 模块 | 负责人 | 状态 | 当前版本 | 阻塞项 |
|---|---|---|---|---|---|
| 01 | data-collector | _待分配_ | 🟡 scaffolding | v0.1 placeholder | 数据源接入 |
| 02 | data-cleaner | _待分配_ | 🟡 scaffolding | v0.1 placeholder | 待 01 输出 |
| 03 | terminal-bridge | _待分配_ | 🟡 scaffolding | v0.1 placeholder | 终端 API 凭证 |
| 04 | analyst | _待分配_ | 🟡 scaffolding | v0.1 placeholder | 价值投资框架定稿 |
| 05 | writer | _待分配_ | 🟡 scaffolding | v0.1 placeholder | 买方研报模板 |
| 06 | visual-designer | _待分配_ | 🟡 scaffolding | v0.1 placeholder | 设计规范定稿 |

> 状态图例: ⚪ not-started · 🟡 scaffolding · 🟢 in-progress · ✅ done · 🔴 blocked

## 阶段 0 — 协作流跑通 (当前)
- [x] GitHub repo 初始化
- [x] 目录结构 & 模板文件就位
- [ ] 两人各跑一次完整 PR 流程 (改 README typo → PR → review → merge)
- [ ] 跑分体系 rubric v0.1 共识
- [ ] 数据源接入清单确认

## 阶段 1 — 单 agent 跑通
- [ ] 01 data-collector 能从至少 1 个数据源拿回数据
- [ ] 04 analyst 在 1 个真实标的上产出可读分析
- [ ] 05 writer 输出首份"接近头部机构水平"的研报
- [ ] 06 visual-designer 给出可复用视觉规范

## 阶段 2 — pipeline 串联
- [ ] 01 → 02 → 04 → 05 → 06 端到端跑通
- [ ] eval/ 跑分机制常态化
- [ ] 假设 → 验证 → 决策闭环

## 阶段 3 — 提质 & 扩展
- [ ] 数据源扩展 (港股通 → 全港股 → A+H+US)
- [ ] 多标的对标分析
- [ ] 研报模板覆盖 (首次覆盖 / 深度跟踪 / 行业策略)

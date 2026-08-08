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

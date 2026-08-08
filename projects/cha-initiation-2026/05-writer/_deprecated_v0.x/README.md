# Deprecated — v0.x 越界输出 (2026-08-08)

> 这些文件是 **v0.x 阶段 role01 collector + role05 writer 越界** 的产物, 已废弃。
> 改用 **v1.0 collector-only** 输出:
> - `../04-analyst/analysis.md` (Stage 1 信息汇总, 不判断)
> - `./financials.xlsx` (7 sheet 财务三表)

## 越界点

- `report.docx` (v0.x) 写了 **HOLD 评级 / US$9.55 目标价 / 投资建议** — **是 Human role04 的工作, Agent 不该越界**
- `build_report.py` (v0.x) 是生成越界 docx 的脚本 — 保留作为反例, 不再使用

## 相关决策

- ADR-0004 (2026-08-08): Agent 职责边界重新划分, 5 角色矩阵 (2 Agent + 3 Human)
- `../../docs/agent-roles.md` v1.0: 完整职责总纲

## 维护规则

- 这两个文件**只读**, 任何修改视为违例
- 下次有人想用 `build_report.py` 重新生成 `report.docx` — **先读 agent-roles.md §1.2**

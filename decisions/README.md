# Architecture Decision Records (ADR)

> 关键决策按时间顺序归档, 一旦接受就不可修改 (只能新开 ADR supersede)。

## 文件命名
`NNNN-<short-title>.md`, N 是 4 位顺序号。

例: `0001-use-value-investing-framework.md`

## 模板
复制 `0000-template.md` 起新。

## 流程
1. 提 Issue, label `decision-needed`
2. 写 `decisions/NNNN-<title>.md`
3. 描述背景 / 候选方案 / 选择 / 理由 / 后果
4. PR, 双方 review → 合并
5. 合并后, 在 README 索引加一行

## 索引
| # | 标题 | 状态 | 日期 |
|---|---|---|---|
| 0002 | [shouren-researcher 降级为参考档案](0002-shouren-as-archive.md) | 已接受 | 2026-08-08 |
| 0003 | [双层架构 (M3 + Pipeline)](0003-two-layer-architecture.md) | 已接受 | 2026-08-08 |

## 重要决策 (会改变方向的)
- 价值投资方法论选择 (Graham / Buffett / Munger / Marks 等) — _待定_
- 数据源选择 — _已记录在 `docs/data-sources.md`_
- 视觉风格定调 — _已记录在 `agents/06-visual-designer.md` (wancheng 配色)_
- 模板选择 — _已记录在 `agents/05-writer.md` (initiation 优先)_
- 是否引入新模块 — _已记录在 ADR 0003 (双层架构, 不引第三层)_
- 架构分层 (M3 vs Pipeline) — **ADR 0003**

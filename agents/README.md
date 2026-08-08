# 子 Agent 目录

> 6 个子 agent 各自的规格说明。每个 agent 一个文件，按 pipeline 顺序编号。

## Pipeline 总览

```
[01 collector] → [02 cleaner] → [04 analyst] → [05 writer] → [06 visual-designer]
        ↓
   [03 terminal-bridge] ← 在 01 / 04 阶段被调用
```

| # | Agent | 职责 | 输入 | 输出 |
|---|---|---|---|---|
| 01 | data-collector | 拉取原始数据 | 标的 / 数据源指定 | 原始 JSON / PDF / 网页 |
| 02 | data-cleaner | 数据清洗 & 结构化 | 原始数据 | 结构化表格 / 时序 |
| 03 | terminal-bridge | 金融终端 API 接入 | API 调用 | 标准化数据点 |
| 04 | analyst | 价值投资分析 | 清洗后数据 + 终端数据 | 分析要点 / 估值 / 风险 |
| 05 | writer | 研报书写 | 分析结果 | 买方研报 markdown 稿 |
| 06 | visual-designer | 视觉呈现 | markdown 稿 | PDF / PPT / 一页纸 |

## 命名约定
- 文件名: `0N-<short-name>.md`
- 每个文件包含: 职责 / 输入输出契约 / 调用方式 / 依赖 / 失败模式 / 负责人

## 当前状态
所有 agent 处于 🟡 scaffolding 阶段，规格文件是 placeholder，等分工后填实。

# Project — 霸王茶姬 (CHAGEE) Initiation 报告

> **目标**: 头部投行标准 Initiation of Coverage, 走 value-investing-agent 全 pipeline (01→02→04→05→06)
> **目标公司**: 霸王茶姬 CHAGEE (NASDAQ: CHA)
> **启动**: 2026-08-08
> **负责人**: Ryan LI

## 标的画像

| 字段 | 值 |
|---|---|
| 公司全名 | Cha Panda Group Cayman Limited (霸王茶姬品牌母公司) |
| 股票代码 | NASDAQ: CHA |
| 上市日期 | 2025-04-17 (NASDAQ) |
| 行业 | 餐饮 / 现制茶饮 |
| 主要市场 | 中国大陆 + 东南亚 |
| 商业模式 | 直营 + 加盟混合, 重 "原叶鲜奶茶" 单品 |
| 主要可比 | 蜜雪冰城 (HKEX: 2097), 茶百道 (HKEX: 2555), 古茗 (HKEX: 1364), 奈雪的茶 (HKEX: 2150) |

## Pipeline 进度

- [x] **00-session**: config 设定
- [ ] **01 collector**: 拉原始素材 (F-1 / 10-K / 10-Q / news / 行情)
- [ ] **02 cleaner**: PDF→结构化数据
- [ ] **03 terminal**: (可选) 拉行情 / 估值锚
- [ ] **04 analyst**: 价值投资分析 (业务 / 财务 / 估值 / 风险 / 蓝军 / KPI)
- [ ] **05 writer**: 5 页投行研报 (md + docx + xlsx)
- [ ] **06 visual**: PDF + PPTX + 一页纸
- [ ] **99 eval**: 跨 agent 跑分卡

## 状态

- 2026-08-08: 项目启动, scaffold 完成
- 进行中: 01 collector

## 目录约定

```
cha-initiation-2026/
├── 00-session/         # config + 决策
├── 01-collector/       # 01 输出
│   ├── items/          # collection items (元信息)
│   └── raw/            # 原始文件 (PDF/HTML, 不入仓)
├── 02-cleaner/         # 02 输出 (cleaned.yaml)
├── 03-terminal/        # 03 输出 (可选)
├── 04-analyst/         # 04 输出 (analysis.yaml + analysis.md)
├── 05-writer/          # 05 输出 (md + docx + xlsx)
├── 06-visual/          # 06 输出 (pdf + pptx + onepager)
└── 99-eval/            # 跨 agent 跑分
```

## 关联

- 上层架构: [`../../docs/architecture.md`](../../docs/architecture.md)
- 契约: [`../../docs/contracts.md`](../../docs/contracts.md)
- 评分卡: [`../../eval/scoring-sheets/`](../../eval/scoring-sheets/)
- Pipeline 子 agent: [`../../agents/`](../../agents/)

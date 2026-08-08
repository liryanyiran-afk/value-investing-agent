# 02 — data-cleaner

> 数据清洗 & 结构化 agent。把 01 拉来的原始素材 (PDF/HTML/JSON) 整理成结构化数据。

## Pipeline Position
- 位置: 2/6
- 上游: 01 data-collector
- 下游: 04 analyst
- 读取: `outputs/<target>/<date>/01-collector/collection.yaml`
- 写入: `outputs/<target>/<date>/02-cleaner/cleaned.yaml` + `extracted/`
- 契约: 见 [`docs/contracts.md`](../docs/contracts.md#02-data-cleaner)
- 架构: 见 [`docs/architecture.md`](../docs/architecture.md)
- 跑分卡: 用通用 6 维度 (02 是工具型 agent, 不单建打分卡)

## 职责
- PDF 文字 / 表格抽取 (财务三表, 业务数据)
- 命名实体识别 (公司 / 人物 / 产品)
- 时序数据对齐 (报告期 / 截止日标准化)
- 多源交叉验证 (同一指标不同来源对比)
- 异常值标记 (突然跳变 / 缺测)

## 输入契约
```yaml
collection: <01 的输出>
options:
  extract_tables: true
  normalize_dates: true  # 全部转 ISO 8601
  cross_validate: true
  flag_outliers: true
  language: "auto"  # auto | zh | en
```

## 输出契约
```yaml
cleaned:
  target: ...
  cleaned_at: "..."
  financials:
    - period: "2025-12-31"
      metric: "revenue"
      value: 66020000000
      unit: "HKD"
      source_ref: ["hkex_AR_2025_p.45", "wind_2026Q1"]
      confidence: 0.95
  business_segments:
    - name: "游戏"
      revenue_share: 0.52
      yoy_growth: 0.11
  qualitative:
    - fact: "管理层 2024 年完成回购 150 亿 HKD"
      source_ref: "hkex_AR_2024_p.12"
  data_quality:
    outliers: []
    missing: ["2023 半年报 wind 端无"]
```

## 调用方式
- LLM 调用专用工具:
  - PDF 文字 / 表格 (pdfplumber / pypdf / pypdfium2)
  - OCR 兜底 (图像 PDF / 扫描件)
  - 命名实体 (LLM 自身)
- 大文档分批处理 (跨页表合并提示)

## 依赖
- 01 的输出
- 本地 PDF 处理工具链

## 失败模式 & 应对
- 财务表跨页错位: 显式 prompt 提示"这是跨页表, 合并读"
- 无边框表 (繁体多列) 抽取失败: 走视觉 OCR 兜底
- 数字单位混淆 (亿 / 万 / 百万): 显式 normalize + sanity check
- 数据冲突: 优先级: 公告原文 > 终端 > 媒体

## 负责人
_待分配_

## 当前 prompt
`prompts/data-cleaner/v0.1.md`

## 跑分
`eval/scores/<date>-data-cleaner.md`

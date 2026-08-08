# 01 — data-collector

> 原始数据拉取 agent。从公开数据源 & 终端拉取标的相关的所有原始素材。

## Pipeline Position
- 位置: 1/6 (start)
- 上游: — (无)
- 下游: 02 data-cleaner
- 读取: —
- 写入: `outputs/<target>/<date>/01-collector/collection.yaml` + `raw/`
- 契约: 见 [`docs/contracts.md`](../docs/contracts.md#01-data-collector)
- 架构: 见 [`docs/architecture.md`](../docs/architecture.md)
- 跑分卡: [`eval/scoring-sheets/01-data-collector.md`](../eval/scoring-sheets/01-data-collector.md)

## 职责
- 给定标的 (股票代码 / 公司名), 拉取:
  - 招股书 / 财报 PDF
  - 公司公告
  - 行业研报
  - 主流财经媒体覆盖
  - 工商 / 监管数据
- 多源融合, 输出统一 JSON 结构

## 输入契约
```yaml
target:
  ticker: "0700.HK"  # 港股 / A股
  market: "HK"  # HK | A
  name: "腾讯控股"  # 备查
scope:
  years: 5  # 历史区间
  sources: ["hkex", "wind", "caijing", "company-website"]
  include_prospectus: true
```

## 输出契约
```yaml
collection:
  target: ...
  collected_at: "2026-08-08T..."
  items:
    - source: "hkex"
      type: "annual_report"
      url: "..."
      local_path: "outputs/<target>/<date>/raw/0700_AR2025.pdf"
      fetched_at: "..."
      size_bytes: ...
    - source: "wind"
      type: "price_history"
      data: "outputs/<target>/<date>/raw/0700_price_5y.csv"
```

## 调用方式
- LLM 通过工具调用 (web_fetch / download / API)
- 或专门的 Python 脚本 (`scripts/collector_<source>.py`)

## 依赖
- 03 terminal-bridge (终端 API)
- 公开 URL 抓取 (web_fetch / playwright)
- PDF 下载 (markitdown / pypdf)
- 数据源: HKEX 披露易, 上交所, 深交所, 公司 IR, 主流财经媒体

## 失败模式 & 应对
- 招股书 PDF 大 / 多页: 分页抓取, 落本地后处理
- 终端 API 限流: 退避重试 + 缓存
- 媒体页面 JS 渲染: 走 playwright
- 数据源 404 / 改版: 标记 + Issue

## 负责人
_待分配_

## 当前 prompt
`prompts/data-collector/v0.1.md`

## 跑分
`eval/scores/<date>-data-collector.md`

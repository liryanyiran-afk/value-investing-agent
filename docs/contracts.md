# Contracts — 6 个 Agent I/O 契约汇总

> 当前版本: v0.0.3 (2026-08-08)
> 与 [`docs/architecture.md`](architecture.md) 配套使用
>
> 本文件是**契约的 single source of truth**。
> 各 `agents/0N-xxx.md` 中重复的 input/output YAML 段应**与本文件保持一致**,
> 如有冲突, 以本文件为准, 并在 PR 中同步更新对应 agent spec。

---

## 索引

- [01 data-collector](#01-data-collector)
- [02 data-cleaner](#02-data-cleaner)
- [03 terminal-bridge](#03-terminal-bridge)
- [04 analyst](#04-analyst)
- [05 writer](#05-writer)
- [06 visual-designer](#06-visual-designer)

---

## 01 data-collector

### Input

```yaml
target:
  ticker: "0700.HK"          # 港股 / A股
  market: "HK"                # HK | A
  name: "腾讯控股"             # 备查
scope:
  years: 5                    # 历史区间
  sources: ["hkex", "wind", "caijing", "company-website"]
  include_prospectus: true
```

### Output

```yaml
collection:
  target: ...
  collected_at: "2026-08-08T..."
  model_version: "data-collector-v0.1"
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

落盘: `outputs/<target>/<date>/01-collector/collection.yaml` + `raw/`

---

## 02 data-cleaner

### Input

```yaml
collection: <01 的输出, 读 collection.yaml>
options:
  extract_tables: true
  normalize_dates: true       # 全部转 ISO 8601
  cross_validate: true
  flag_outliers: true
  language: "auto"             # auto | zh | en
```

### Output

```yaml
cleaned:
  target: ...
  cleaned_at: "..."
  model_version: "data-cleaner-v0.1"
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

落盘: `outputs/<target>/<date>/02-cleaner/cleaned.yaml` + `extracted/`

---

## 03 terminal-bridge

### Input

```yaml
query:
  endpoint: "price_history"    # 见支持的端点列表
  target: "0700.HK"
  params:
    start: "2021-01-01"
    end: "2026-08-08"
    frequency: "daily"
  preferred_terminal: "wind"   # wind | bloomberg | choice | ifind
  fallback: ["choice", "ifind"]
```

### Output

```yaml
result:
  endpoint: "price_history"
  target: "0700.HK"
  fetched_from: "wind"
  fetched_at: "..."
  model_version: "terminal-bridge-v0.1"
  data:
    - date: "2021-01-04"
      open: 564.0
      high: 580.0
      low: 561.0
      close: 575.5
      volume: 18500000
  unit_meta:
    currency: "HKD"
    adjusted: false
  cache_hit: false
```

**支持的端点 (v0.1)**:
- `price_history` — 历史行情
- `fundamental_snapshot` — 当前基本面快照
- `financials` — 财务三表
- `index_constituents` — 指数成分股
- `dividend_history` — 分红历史
- `analyst_estimates` — 卖方一致预期

落盘: `outputs/<target>/<date>/03-terminal/terminal_data.yaml` (03 跑过后)

---

## 04 analyst

### Input

```yaml
cleaned: <02 的输出, 读 cleaned.yaml>
terminal: <03 的输出, 读 terminal_data.yaml, 可选>
options:
  framework: "graham-buffett-munger"   # 价值投资框架 (可换)
  scenarios: ["bear", "base", "bull"]
  valuation_methods: ["dcf", "relative", "asset"]
  output_language: "zh-HK"
```

### Output

```yaml
analysis:
  target: ...
  generated_at: "..."
  model_version: "analyst-v0.1"
  business_thesis:
    summary: "1-2 句话定位"
    moats: [...]
    management_quality: ...
    business_quality_score: 1-10
  financials:
    three_statement_summary: ...
    dupont: ...
    cash_quality: ...
  valuation:
    methods:
      dcf:
        bear: 320
        base: 480
        bull: 620
        assumptions: ...
      relative:
        pe_target: 22
        ...
    weighted_fair_value: 472     # 三档概率加权
    current_price: 380
    upside: 0.24
  risks:
    - level: "high"
      description: ...
      mitigant: ...
  contrarian_view:
    consensus: "市场认为 XXX"
    our_view: "我们认为 YYY"
    evidence: ["招股书 p.45", "灼识咨询", "Wind 2026Q2"]
  monitoring_kpis:
    - name: "月活用户"
      current: "1.2 亿"
      threshold_yellow: "< 1.0 亿"
      threshold_red: "< 0.8 亿"
      source: "公司月报"
```

**默认价值投资框架**:
- Graham: 安全边际
- Buffett: 护城河, 长期 ROE, 管理层
- Munger: 多元心智模型, 反向思考
- Marks: 二阶思维, 周期定位

落盘: `outputs/<target>/<date>/04-analyst/analysis.yaml` + `analysis.md`

---

## 05 writer

### Input

```yaml
analysis: <04 的输出, 读 analysis.yaml>
options:
  template: "initiation"          # initiation | deep-dive | sector-strategy
  language: "zh-HK"               # zh-HK | zh-CN | en
  length: "deep"                  # flash | standard | deep
  audience: "buy-side-pm"         # 买方 PM | 卖方客户 | 内部投决会
```

### Output

```yaml
report:
  target: ...
  type: "initiation"
  title: "..."
  subtitle: "..."
  sections:
    - "投资要点"                  # 4 cards: thesis / 不同视角 / 风险 / 监控
    - "公司画像"
    - "行业空间"
    - "护城河"
    - "财务分析"
    - "估值"
    - "风险"
    - "蓝军自攻击"
    - "监控指标"
    - "结论"
  metadata:
    coverage_initiated: "2026-08-08"
    rating: "BUY"                # BUY | HOLD | SELL
    target_price: 472
    current_price: 380
    upside: 0.24
  source_refs_inlined: true
```

**写作铁律 (PUA 6 项)**:
1. 估值有算法: 三档情景 + 概率加权
2. 错位视角有证据: 每条论据带具体数字 + source
3. 数据可溯源: (招股书 + 页码) / (灼识) / (Wind YYYY.M.DD)
4. SWOT 4 象限齐
5. 蓝军自攻击 ≥ 3 条
6. 监控 KPI 必须给阈值

落盘: `outputs/<target>/<date>/05-writer/report.md` + `report-summary.docx` + `report-data.xlsx`

---

## 06 visual-designer

### Input

```yaml
report: <05 的输出, 读 report.md>
options:
  output_formats: ["pdf", "pptx", "onepager"]
  branding: "wancheng"            # wancheng | neutral | custom
  density: "standard"             # flash | standard | deep
  color_mode: "light"             # light | dark
```

### Output

```yaml
deliverables:
  - format: "pdf"
    path: "outputs/<target>/<date>/report-final.pdf"
    pages: 5
    size_kb: ...
  - format: "pptx"
    path: "outputs/<target>/<date>/deck.pptx"
    slides: 12
  - format: "onepager"
    path: "outputs/<target>/<date>/onepager.png"
    dimensions: "1920x1080"
```

**投行 5 页标准结构**:
- P1 Cover: 机构 + 评级 + 目标价 + 现价 + 潜在涨幅
- P2 Investment Thesis: 4 cards + 错位视角 evidence-based
- P3 Company + Industry: 画像 + 产品矩阵 + TAM + 竞争格局
- P4 Financials + Valuation: 营收图 + ASP/毛利 + 估值三档情景
- P5 Risks + SWOT + 蓝军 + KPI

**字体铁律** (跨平台):
- 拉丁: `Calibri`
- 东亚: `SimSun` (Win) / macOS 自动 fallback
- 严拒: Songti SC / Helvetica Neue / PingFang SC / Avenir

**配色 (默认 wancheng-style)**:
- 主色: 宣纸白 #FBF8F3
- 强调: 香槟金 #C9A961
- 风险: 酒红 #8B1A1A
- 中性: 藏青 #1F2A44 / 古铜金 #B08D57

落盘: `outputs/<target>/<date>/06-visual/{report-final.pdf, deck.pptx, onepager.png}`

---

## 通用约定

### 必带字段
每个 agent 的 output 顶层都带:
- `target` — 标的标识
- `generated_at` — ISO 8601 时间戳
- `model_version` — 当前 spec/prompt 版本 (e.g. `analyst-v0.1`)

### 文件命名
- YAML 文件 snake_case
- 文件路径在 YAML 里以**相对 session 根目录**的方式表达 (e.g. `outputs/0700.HK-腾讯/2026-08-08/raw/...`)
- `<target>` 实际写法: `<ticker>-<name>` (例: `0700.HK-腾讯`), 中文名短

### 跨 agent 数据流
- 01 → 02: `01-collector/collection.yaml` → `02-cleaner/cleaned.yaml`
- 02 → 04: `02-cleaner/cleaned.yaml` → `04-analyst/analysis.yaml`
- 03 → 01 或 04: `03-terminal/terminal_data.yaml` (按 endpoint 调)
- 04 → 05: `04-analyst/analysis.yaml` + `04-analyst/analysis.md` → `05-writer/report.md`
- 05 → 06: `05-writer/report.md` → `06-visual/*.{pdf,pptx,png}`

### 升级契约
- 破坏性变更 (字段重命名/删除/语义变) → 升主版本 (v0.x → v1.x), 走 ADR
- 新增可选字段 → 升次版本 (v0.1 → v0.2)
- 调整注释/说明 → 不升版本

---

**更新历史**:
- 2026-08-08: 初版 (随 v0.0.3 入仓)

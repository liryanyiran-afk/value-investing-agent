# 06 — visual-designer

> 视觉呈现 agent。把 05 的研报 markdown 稿转成 PDF / PPT / 一页纸, 视觉达头部机构水平。

## Pipeline Position
- 位置: 6/6 (end)
- 上游: 05 writer
- 下游: — (end, 交付给用户)
- 读取: `outputs/<target>/<date>/05-writer/report.md`
- 写入: `outputs/<target>/<date>/06-visual/{report-final.pdf, deck.pptx, onepager.png}`
- 契约: 见 [`docs/contracts.md`](../docs/contracts.md#06-visual-designer)
- 架构: 见 [`docs/architecture.md`](../docs/architecture.md)
- 跑分卡: [`eval/scoring-sheets/06-visual-designer.md`](../eval/scoring-sheets/06-visual-designer.md)

## 职责
- 跨平台字体规范 (Calibri + SimSun, 不碰 macOS 专有字体)
- 投行研报 5 页标准结构
- KPI 卡 / 财务表 / 图表 视觉统一
- 配色: 主色 + 强调色 + 风险色, 不杂
- 输出多格式: PDF / PPTX / 一页纸 PNG

## 输入契约
```yaml
report: <05 的输出 markdown>
options:
  output_formats: ["pdf", "pptx", "onepager"]
  branding: "wancheng"  # wancheng | neutral | custom
  density: "standard"  # flash | standard | deep
  color_mode: "light"  # light | dark
```

## 输出契约
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

## 投行研报 5 页标准结构
- **P1 Cover**: 机构 + 评级 + 目标价 + 现价 + 潜在涨幅
- **P2 Investment Thesis**: 4 cards + 错位视角 evidence-based
- **P3 Company + Industry**: 画像 + 产品矩阵 + TAM + 竞争格局
- **P4 Financials + Valuation**: 营收图 + ASP/毛利 + 估值三档情景
- **P5 Risks + SWOT + 蓝军 + KPI**: 评级重申 + 催化剂 + SWOT + 蓝军 + 监控阈值

## 字体铁律
- 拉丁字体: `Calibri` (跨平台)
- 东亚字体: `SimSun` (Win) / macOS 自动 fallback
- 等宽数字: `Calibri Bold` 优先
- 严拒: Songti SC / Helvetica Neue / PingFang SC / Avenir (macOS 专有)

## 配色 (默认 wancheng-style, 可换)
- 主色: 宣纸白 #FBF8F3
- 强调: 香槟金 #C9A961
- 风险: 酒红 #8B1A1A
- 中性: 藏青 #1F2A44 / 古铜金 #B08D57

## 调用方式
- `python-pptx` 生成 PPT
- `PyMuPDF` 或 `wkhtmltopdf` 转 PDF
- LLM 辅助: 配色方案选型, 排版微调
- 不依赖设计师手工

## 依赖
- 05 的 markdown
- `design-system/style.md` 规范
- python-pptx, PyMuPDF, pdf2image

## 失败模式 & 应对
- 字体回退: 强制设置 ea/cs 字体
- KPI 卡重叠: 独立 card 渲染, 不堆叠
- 跨页表错位: 视觉化前 sanity check
- 中英数字字距: Calibri Bold 解决

## 负责人
_待分配_

## 当前 prompt
`prompts/visual-designer/v0.1.md`

## 跑分
`eval/scores/<date>-visual-designer.md`

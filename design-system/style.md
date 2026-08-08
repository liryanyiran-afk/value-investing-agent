# Visual Style Guide (v0.1)

> 投行研报视觉规范。跨平台, 跨 agent, 跨格式 (PDF/PPT/一页纸) 统一。

## 字体铁律
- **拉丁字体**: `Calibri` (Win/macOS/Linux 都自带)
- **东亚字体**: `SimSun` (Win 必有, macOS PowerPoint 自动 fallback)
- **数字强调**: `Calibri Bold`
- **严拒**: Songti SC / Helvetica Neue / PingFang SC / Avenir (macOS 专有)

## 配色 (wancheng 默认)
```
--color-bg:        #FBF8F3   /* 宣纸白 主背景 */
--color-primary:   #C9A961   /* 香槟金 强调 */
--color-danger:    #8B1A1A   /* 酒红 风险 / 卖出 */
--color-warning:   #B08D57   /* 古铜金 中性提示 */
--color-text:      #1F2A44   /* 藏青 正文 */
--color-muted:     #8B8B8B   /* 灰 次要 */
--color-success:   #2D5F3F   /* 暗绿 买入 / 正向 */
```

## KPI 卡 (核心组件)
- 高度 ≥ 1.2"
- 顶部色块 (状态色) + 数字 (Calibri Bold 36pt) + 底部 en_label (SimSun 9pt)
- 卡片间距 ≥ 0.15"
- 独立 add_rect, 不堆叠

## 投行研报 5 页结构
- **P1 Cover**: 机构 / 评级 / 目标价 / 现价 / 潜在涨幅
- **P2 Investment Thesis**: 4 cards + 错位视角
- **P3 Company + Industry**: 画像 / 产品 / TAM / 竞争
- **P4 Financials + Valuation**: 营收图 / ASP / 估值三档
- **P5 Risks + SWOT + 蓝军 + KPI**: 评级 / 催化剂 / SWOT / 蓝军 / 监控阈值

## 图表规范
- 折线图: 主色 + 灰虚线 (均值)
- 柱状图: 主色 + 强调色 (重点年份)
- 表格: 三线表 (顶 / 底 / 表头底线), 无竖线
- 数据标签: 始终显示, Calibri 9pt

## 间距
- 页边距: 0.5" (PDF) / 0.4" (PPT)
- 段间距: 12pt
- 章节间距: 24pt

## 待补充
- [ ] glossary.md (中英术语对照)
- [ ] templates/ 研报模板
- [ ] bench-visual/ 视觉参考

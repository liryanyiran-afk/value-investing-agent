# Scoring Sheet — 06 visual-designer

> 通用 6 维度见 [`eval/rubric.md`](../rubric.md). 本表是 06 的具体打分卡.
> 满分 100, 通过线见 rubric 末尾.

## 跑分时机
每次跑完一个 session, 在 `outputs/<target>/<date>/99-eval/per-agent/06-visual.md` 填一份.

## 维度 (9 项) — 06 是视觉 agent, 维度侧重跨平台 & 一致性

### 通用 6 维度 (继承 rubric.md, 总权重 50%)

| # | 维度 | 权重 | 1-3 差 | 4-6 中 | 7-10 好 |
|---|---|---|---|---|---|
| 1 | 准确性 | 5% | 数字跟 05 report 对不上 | 数字对, 偶有错位 | 100% 一致, 跨 PDF/PPT/PNG 全对齐 |
| 2 | 完整性 | 5% | 缺 1+ 格式 (PDF/PPT/PNG) | 三格式齐但有缺页 | PDF/PPT/PNG 三格式齐, PPT ≥ 10 slides |
| 3 | 深度 | 5% | 只 PUA checklist, 无 KPI 卡 | 有图表但稀疏 | KPI 卡 + 财务表 + 图表均衡 |
| 4 | 可读性 | 10% | 字小, 行距密 | 段落清晰 | 字号合规 (≥ 7pt), 行距 1.2+, 安全区 y ≤ 5.4 |
| 5 | 视觉 | 20% | 配色杂, 字体乱 | 主色统一, 字体一致 | 配色 (主+强调+风险+中性) 齐, 字体 (Calibri+SimSun) 双声明 |
| 6 | 实用性 | 5% | 客户拿不出手 | 内部能用 | 投行版式, 5 页标准结构, 客户可发 |

### 06 特化 (3 项, 总权重 50%) — 06 最大的风险是跨平台 & 一致性

| # | 维度 | 权重 | 1-3 差 | 4-6 中 | 7-10 好 |
|---|---|---|---|---|---|
| 7 | 字体跨平台一致性 | 20% | macOS 专有字体, Win 必乱 | 拉丁字体齐, 东亚字体缺 | Calibri (latin) + SimSun (eastAsia) 双声明, macOS/Win 一致 |
| 8 | 5 页结构标准 | 15% | 章节乱, 跟模板偏 | 主体对, 章节顺序小差 | P1 Cover / P2 Thesis / P3 Company / P4 Financials / P5 Risks 严格 |
| 9 | 跨页表/图无错位 | 15% | 跨页表全错 | 个别图错 | 跨页表合并正确, 跨页图切位合理, KPI 卡不重叠 |

## 填表示例

```yaml
# outputs/0700.HK-腾讯/2026-08-08/99-eval/per-agent/06-visual.md
target: 0700.HK-腾讯
session_date: 2026-08-08
agent: 06-visual-designer
model_version: visual-designer-v0.1

scores:
  准确性: 9           # 权重 5%
  完整性: 9           # 权重 5%
  深度: 7             # 权重 5%
  可读性: 8           # 权重 10%
  视觉: 9             # 权重 20%  (wancheng 配色齐)
  实用性: 8           # 权重 5%
  字体跨平台一致性: 9 # 权重 20%  (Calibri + SimSun 双声明)
  5页结构标准: 9      # 权重 15%
  跨页表图无错位: 8   # 权重 15%

total: 8.50           # /10 → 85/100
notes: |
  - PDF 5 页严丝合缝, 跨 Win 字体一致
  - KPI 卡 4 个不重叠
  - 跨页财务表合并正确
  - 唯一小问题: P3 行业空间图切位略偏左
```

## 通过线
- **scaffolding**: ≥ 40
- **内部可用**: ≥ 60
- **投决会上**: ≥ 75
- **对客户发**: ≥ 85 (06 是对外门面, 跟 05 同线)
- **头部对标**: ≥ 90

## 跨平台字体 checklist (每次必跑)
- [ ] python-pptx 设置 `font.name = "Calibri"` (latin)
- [ ] python-pptx 设置 `_element.rPr.ea.set("SimSun")` (eastAsia)
- [ ] PDF 字体嵌入 (`embed_font`)
- [ ] 跨平台验证: macOS Preview + Windows Adobe Reader 都过

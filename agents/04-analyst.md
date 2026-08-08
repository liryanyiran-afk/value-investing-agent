# 04 — analyst

> 价值投资分析 agent。基于清洗后的数据, 输出可投决的分析框架。

## Pipeline Position
- 位置: 4/6 (pipeline 中枢)
- 上游: 02 data-cleaner (强), 03 terminal-bridge (弱, 可选)
- 下游: 05 writer
- 读取: `outputs/<target>/<date>/02-cleaner/cleaned.yaml` (+ 可选 `03-terminal/terminal_data.yaml`)
- 写入: `outputs/<target>/<date>/04-analyst/analysis.yaml` + `analysis.md`
- 契约: 见 [`docs/contracts.md`](../docs/contracts.md#04-analyst)
- 架构: 见 [`docs/architecture.md`](../docs/architecture.md)
- 跑分卡: [`eval/scoring-sheets/04-analyst.md`](../eval/scoring-sheets/04-analyst.md) (10 维度, 最细)
- 参考档案: [`mavis-agents/reference/shouren-researcher.md`](../mavis-agents/reference/shouren-researcher.md) (frozen v0.1, 提炼计划见 [`prompts/analyst/extraction-notes.md`](../prompts/analyst/extraction-notes.md))

## 职责
- 业务理解: 商业模式 / 护城河 / 管理层
- 财务分析: 三大表 + 杜邦 + 现金流质量
- 估值: DCF / 相对估值 / 资产价值, 三档情景 (BEAR/BASE/BULL)
- 风险: 蓝军自攻击, 列 3 条对冲自己论点的观点
- 跟踪指标: 给出可量化的监控 KPI (含阈值)
- 与"市场共识"的错位视角: 共识是什么, 我们为什么不同

## 输入契约
```yaml
cleaned: <02 的输出>
terminal: <03 的输出, 可选>
options:
  framework: "graham-buffett-munger"  # 价值投资框架 (可换)
  scenarios: ["bear", "base", "bull"]
  valuation_methods: ["dcf", "relative", "asset"]
  output_language: "zh-HK"
```

## 输出契约
```yaml
analysis:
  target: ...
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
    weighted_fair_value: 472  # 三档概率加权
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

## 价值投资框架 (默认)
- **本杰明·格雷厄姆**: 安全边际 (margin of safety)
- **巴菲特**: 护城河, 长期 ROE, 管理层
- **芒格**: 多元心智模型, 反向思考
- **霍华德·马克斯**: 二阶思维, 周期定位

后续可加:
- 彼得·林奇 (六类股)
- 菲利普·费雪 (深度访谈调研)
- 段永平 / 张磊 (中国语境)

## 调用方式
- LLM + 02 / 03 的结构化数据
- 模型需用最强档 (M3 / Claude Opus 级别), 推理密集任务

## 依赖
- 02 的清洗后数据
- 03 的实时数据
- `eval/benchmarks/` 下的头部机构研报做对照

## 失败模式 & 应对
- LLM 拍脑袋: 强制每条结论带 source ref
- 估值武断: 强制三档情景, 概率显式
- 蓝军缺失: 强制 ≥3 条对冲观点
- KPI 模糊: 强制数字 + 阈值

## 负责人
_待分配_

## 当前 prompt
`prompts/analyst/v0.1.md`

## 跑分
`eval/scores/<date>-analyst.md`

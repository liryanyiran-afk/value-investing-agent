# 05 — writer

> 研报书写 agent。把 04 的分析结果写成"接近头部金融机构水平"的买方研报。

## 职责
- 套用头部研报模板 (首次覆盖 / 深度跟踪 / 行业策略)
- 把分析点串成有逻辑链的叙事
- 中英双语/繁简 视场景
- 严格避免: 空泛结论 / 拍脑袋数字 / 缺源数据

## 输入契约
```yaml
analysis: <04 的输出>
options:
  template: "initiation"  # initiation | deep-dive | sector-strategy
  language: "zh-HK"  # zh-HK | zh-CN | en
  length: "deep"  # flash | standard | deep
  audience: "buy-side-pm"  # 买方 PM | 卖方客户 | 内部投决会
```

## 输出契约
```yaml
report:
  target: ...
  type: "initiation"
  title: "..."
  subtitle: "..."
  sections:
    - "投资要点"  # 4 cards: thesis / 不同视角 / 风险 / 监控
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
    rating: "BUY"  # BUY | HOLD | SELL
    target_price: 472
    current_price: 380
    upside: 0.24
  source_refs_inlined: true
```

## 头部机构研报模板 (默认参考)
- 摩根士丹利 BluePaper
- 高盛 Initiation of Coverage
- 中金 / 中信 / 招商 深度首次覆盖
- 桥水 Daily Observations (宏观框架)
- 喜马拉雅资本 致股东信 (价值投资叙事)

## 写作铁律 (PUA checklist)
1. 估值必须有算法: 三档情景 + 概率加权, 期望值 ≈ 目标价
2. 错位视角必须有证据: 每条论据带具体数字 + source
3. 数据必须可溯源: (招股书 + 页码) / (灼识) / (Wind YYYY.M.DD)
4. SWOT 4 象限齐
5. 蓝军自攻击 ≥ 3 条
6. 监控 KPI 必须给阈值
7. 标题 / 小标题 用陈述句, 不用标题党

## 调用方式
- LLM 主流档 (M3 / Claude Sonnet)
- 多轮迭代: 1) 框架 2) 填充 3) 编辑 4) PUA checklist

## 依赖
- 04 的分析输出
- `eval/benchmarks/` 参考研报
- `design-system/style.md` 写作风格

## 失败模式 & 应对
- 套话多: 强制每段引数据
- 数字孤证: 强制 2+ 来源
- 推理跳步: 强制写"因为 X, 所以 Y" 链
- 中英文混杂不规整: 强制统一术语表 (在 design-system/ 里维护)

## 负责人
_待分配_

## 当前 prompt
`prompts/writer/v0.1.md`

## 跑分
`eval/scores/<date>-writer.md`

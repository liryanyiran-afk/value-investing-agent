# Agent 职责总纲 (Agent Roles & Boundaries)

> **版本**: v1.0 (2026-08-08)
> **拍板人**: Ryan LI
> **状态**: 正式采纳, 取代 2026-08-08 之前的临时约定
> **相关 ADR**: [ADR-0004](../decisions/0004-agent-role-boundaries.md)

---

## 0. 一句话总纲 (The One-Liner)

> **Agent 帮人加速理解一个公司, 不帮人下结论。**
> Agent 把杂、慢、散的信息, 整理成清、快、整的呈现, 留判断空间给真正出钱的人。

---

## 1. 总原则 (Core Principles)

### 1.1 大道至简
"主观多头的投资需要全方面 (但又可以一句话) 明白公司的商业结构" — Ryan
- 一句话能说清的就别堆
- 全方面覆盖 = 不漏关键 (商业 / 财务 / 竞争 / 风险 / 估值), 不是堆字数
- 一句话总结 = 每个核心论点都要有 elevator pitch 版本

### 1.2 Agent 不直接输出 (Boundary)
Agent **不**做:
- ❌ 给出投资评级 (BUY / HOLD / SELL)
- ❌ 给出目标价 (US$xx.xx)
- ❌ 写"投资建议" / "我们认为应该..." 段落
- ❌ 替用户做主观多头判断
- ❌ 用漂亮话代替数据 (sloppy 论证)

Agent **做**:
- ✅ 收集信息 (按预设框架, 不遗漏)
- ✅ 整理数据 (可溯源, 多源 cross-check)
- ✅ 呈现信息 (清晰结构 + 关键数字 + source ref)
- ✅ 加速 (把"2 小时翻招股书" 变成 "5 分钟看汇总")
- ✅ 重复劳动 (跨公司 / 跨期 / 跨报告的统一格式)

### 1.3 人机互动 (Interactive)
不是"输入一次 → 输出研报" 的单轮, 是多轮:
```
Stage 1: 收集 (Agent 跑预设框架)    → 输出初稿
Stage 2: 互动 (Human 提问 / 追问)     → Agent 补充 / 放大 / 交叉验证
Stage 3: 收敛 (Human 综合判断)       → 写研报
```

Agent 输出的"初稿"信息会比较杂, 漂亮话比较多, 多个信息源关联性可能不大 — 这是 **正常** 的, 因为是 Stage 1 的收集, 不是最终结论。

### 1.4 数据真实可溯源 (Verifiable)
每条数据必须有 source:
- 一手 (招股书 / SEC 公告 / 公司财报): 标 "(招股书 p.123)" / "(20-F FY2025)"
- 二手 (卖方研报 / 行业报告): 标 "(国泰海通 2025-04-06)" / "(Wind 2026-07-31)"
- 三手 (新闻 / 公众号): 标 "(经济导报 2026-07-10)" 并降权

**禁止**:
- ❌ 无 source 的"听说" / "市场认为" / "业内人士透露"
- ❌ 跨 source 时不区分一手 vs 二手
- ❌ 估算数字不标 "(估)"

---

## 2. 角色矩阵 (Role Matrix)

| 角色 | 类别 | 职责 | 输出 | 边界 |
|---|---|---|---|---|
| **role01: collector** | **Agent** | 收集 + 整理 + 汇总 | 信息初稿 (raw + cleaned) | **不判断, 不评级, 不写建议** |
| **role02: verifier** | **Agent** | 多源 cross-check + 异常检测 | 验证报告 (✓ / ⚠ / ✗) | **不写结论, 标数据可信度** |
| **role03: question-asker** | **Human** | 提问 / 追问 / 筛选 | 提问清单 (按优先级) | **判断哪些信息重要** |
| **role04: draft writer** | **Human** | 综合 + 写初稿 | 研报初稿 | **做主观多头判断, 落笔** |
| **role05: modifier** | **Human** | 修改 + 视觉化 + 排版 | 最终研报 | **调文字 / 调结构 / 调视觉** |

**核心**: 5 个角色中, **2 个 Agent + 3 个 Human**。Agent 干"机器擅长"的事 (重复 / 速度 / 一致性), Human 干"只有人擅长"的事 (判断 / 追问 / 风格)。

---

## 3. 各角色具体职责 (Detailed Role Specs)

### 3.1 role01: collector (Agent) — 数据采集员

**输入契约**:
```yaml
target: <公司名 / 股票代码>
framework: "initiation" | "deep-dive" | "sector-strategy" | "event-driven"
scope:
  - "business model"        # 商业模式 (卖什么 / 怎么赚钱)
  - "industry"              # 行业空间 (TAM / SAM / SOM / 趋势)
  - "financials"            # 财务 (三表 + 关键指标)
  - "competition"           # 竞争格局 (peer / 市占率 / 护城河)
  - "risk"                  # 风险 (公司 / 行业 / 监管)
  - "valuation"             # 估值 (卖方一致预期 / 关键倍数)
  - "governance"            # 治理 (管理层 / 股权 / 关联交易)
  - "sell-side view"        # 卖方观点 (≥3 家券商)
deadline: <YYYY-MM-DD>
```

**输出契约** (Stage 1 完成时):
```yaml
outputs:
  raw_collected.md:        # 原始数据 + source (按 framework 分类)
  cleaned_summary.md:      # 清洗后汇总 (去除 noise, 保留关键)
  excel_financials.xlsx:   # 财务三表 (raw data + 关键指标计算)
  peer_comps_table.md:     # 同业可比 (统一口径)
  sell_side_views.md:      # 卖方观点汇总 (≥3 家)
  data_quality_flags.md:   # 数据可信度标记 (哪些是估算, 哪些冲突)
```

**职责清单** (按 framework 拆):
- **business model**: 公司画像 / 创始人 / 主营业务 / 收入结构 / 客户结构
- **industry**: 行业规模 (TAM/SAM/SOM) / 增速 / 头部市占率 / 政策环境
- **financials**: 损益表 (3-5 年) / 资产负债表 / 现金流量表 / 关键比率
- **competition**: Top 5 同业 (营收 / 净利 / 估值) / 差异化 / 护城河
- **risk**: 公司特有风险 / 行业系统性风险 / 监管风险 / 黑天鹅
- **valuation**: 卖方一致预期 (P/E / P/S / EV/EBITDA) / 目标价区间 / 评级分布
- **governance**: 管理层背景 / 股权结构 / 关联交易 / 审计意见
- **sell-side view**: ≥3 家券商 (评级 / 目标价 / 核心论点 / 风险提示)

**关键约束**:
- ❌ **不**给"投资建议"
- ❌ **不**给"目标价"
- ❌ **不**写"我们认为应该..."
- ✅ **可以**列"卖方目标价区间 $X - $Y, 评级分布: BUY x 家, HOLD x 家, SELL x 家"
- ✅ **可以**标"⚠️ 此数据估算 / ⚠️ 多个 source 冲突, 待 verifier 验证"

### 3.2 role02: verifier (Agent) — 数据验证员

**输入**: collector 的 outputs (特别是 cleaned_summary.md + excel_financials.xlsx)

**输出契约**:
```yaml
verification_report.md:
  source_cross_check:
    - data_point: "FY2025 营收 ¥12.91B"
      sources:
        - {src: "20-F FY2025",       type: "primary",   value: "12,907,407 千元"}
        - {src: "东方财富",            type: "secondary", value: "12.91B"}
        - {src: "蜜雪 2097.HK 公告",   type: "secondary", value: "n/a"}
      status: "✓ 一致"
    - data_point: "蜜雪 2025 净利 ¥5.88B"
      sources:
        - {src: "蜜雪 2097.HK 公告",  type: "primary",   value: "58.8 亿元"}
        - {src: "经济导报 2026-07-10", type: "secondary", value: "58.87 亿元"}
        - {src: "钛媒体",             type: "tertiary",  value: "59.27 亿元"}
      status: "⚠ 一手=58.8, 二手=58.87, 三手=59.27, 差异 < 1%, 取一手"

  conflict_flags:
    - "Q1 26 加盟门店净增数: 公司公告 -97 vs 推算 -230 (含 Q4 25), 需确认统计口径"
    - "蜜雪海外门店数: 招股书 4,479 vs 公告 4,467, 差异可能为闭店时点"

  data_quality:
    high_confidence: ["FY 损益表 (SEC XBRL)", "门店数 (公告)"]
    medium_confidence: ["单店 GMV (估算)", "市占率 (推算)"]
    low_confidence: ["海外单店模型 (无披露)", "加盟商续约率 (无披露)"]
```

**关键约束**:
- ❌ **不**给"数据看起来是假的" 等主观判断
- ✅ **只**标"一手 vs 二手 vs 三手", "一致 vs 冲突", "高 / 中 / 低可信度"
- ✅ **不**改原始数据, 只标 flags

### 3.3 role03: question-asker (Human) — 提问员

**职责**: 看完 collector + verifier 输出后, 列提问清单
- 哪些信息**关键但缺失**?
- 哪些数据**冲突**需要 deeper dive?
- 哪些数字**异常**需要解释?
- 哪些卖方观点**值得放大**?

**输出**: 提问清单 (按优先级), 喂回给 collector 跑 Stage 2

**提问模板**:
```yaml
priority_1 (must answer):
  - "Q: 加盟商为什么在 Q4 25 起撤退? 行业性 vs 公司性?"
    hint: "对比蜜雪 2024-2025 海外关店率, 茶百道 2024 闭店率 11.4%"

priority_2 (nice to have):
  - "Q: 自营店单店 EBITDA 是正还是负?"
    hint: "公司不直接披露, 可用: 自营营收 ¥802M - 自营 Opex ¥497M - 摊销 = ?"

priority_3 (如果时间允许):
  - "Q: 海外 138 家店单店模型 (租金 / 人工 / 回本周期)?"
    hint: "招股书北美首店可能披露, 找 20-F risk factors 章节"
```

**为什么是 Human**: 判断"什么重要"需要投资经验 + 行业认知, AI 没这能力

### 3.4 role04: draft writer (Human) — 写稿人

**职责**: 综合 collector + verifier + question-asker 的输出, 写研报初稿
- 选 narrative (为什么这公司现在值得看)
- 给评级 (BUY / HOLD / SELL)
- 给目标价
- 写"我们认为" 段落 (主观多头判断, 这里才出现)
- 用 SWOT / DCF / 同业可比 框架落笔

**输入**: 全部前序 outputs (collector cleaned + verifier report + 提问清单 + 回答)

**为什么是 Human**: 主观多头判断是投资决策, 出钱的人 (PM / IC) 必须是写稿人, AI 不能替代

### 3.5 role05: modifier (Human) — 修改 + 视觉化

**职责**: 把 draft writer 的初稿改得更专业 + 视觉化
- 调结构 / 调文字 / 调标题党
- 加图表 (KPI 卡 / 对比表 / 折线图)
- 排版 (投行风格 / 行距 / 配色)
- 终稿 (P0 错误 / 引用规范 / 免责声明)

**为什么是 Human**: 文字 + 视觉风格是"机构品牌", 每家投行不一样, AI 难学

---

## 4. 工作流 (Workflow)

```
┌────────────────────────────────────────────────────────────┐
│ Stage 1: 收集 (Agent 跑预设框架)                            │
│                                                            │
│  Human (role03) 提供 framework + scope + 截止日期           │
│       ↓                                                    │
│  Agent (role01 collector) 跑 8 大模块                        │
│       ↓                                                    │
│  输出: raw_collected.md + cleaned_summary.md                │
│       + excel_financials.xlsx + peer_comps_table.md        │
│       + sell_side_views.md + data_quality_flags.md         │
│       ↓                                                    │
│  Agent (role02 verifier) 跑多源 cross-check                 │
│       ↓                                                    │
│  输出: verification_report.md (✓ / ⚠ / ✗ 标记)             │
└────────────────────────────────────────────────────────────┘
                            ↓
┌────────────────────────────────────────────────────────────┐
│ Stage 2: 互动 (Human 提问, Agent 回答)                      │
│                                                            │
│  Human (role03) 读 collector + verifier 输出                 │
│       ↓                                                    │
│  列提问清单 (priority_1 / 2 / 3)                            │
│       ↓                                                    │
│  Agent (role01) 跑补充收集                                  │
│       ↓                                                    │
│  Human (role03) 再读, 再提问                                │
│       ↓                                                    │
│  ... (循环, 直到信息收敛)                                    │
└────────────────────────────────────────────────────────────┘
                            ↓
┌────────────────────────────────────────────────────────────┐
│ Stage 3: 写稿 (Human 综合, Agent 辅助)                      │
│                                                            │
│  Human (role04 draft writer) 读全部前序输出                   │
│       ↓                                                    │
│  选 narrative, 给评级, 给目标价, 写主观多头段落              │
│       ↓                                                    │
│  Human (role05 modifier) 改文字 + 加图表 + 排版              │
│       ↓                                                    │
│  输出: 最终研报 (.docx / .pdf)                              │
└────────────────────────────────────────────────────────────┘
```

**时间分配典型比例** (一个 1 周 initiation):
- Stage 1: 30% (Agent 跑, 1-2 天)
- Stage 2: 40% (人机互动, 2-3 天, 这里是 80% 的认知形成)
- Stage 3: 30% (Human 写, 1-2 天)

---

## 5. 跟之前 6 子 agent pipeline 的差异 (Comparison)

之前架构 (2026-08-08 之前):
```
01 collector → 02 cleaner → 03 terminal → 04 analyst → 05 writer → 06 visual
                  ↓              ↓             ↓            ↓            ↓
            数据清洗         终端调用      估值分析     研报撰写    视觉设计
            (Agent)         (Agent)      (Agent❌)   (Agent❌)   (Agent)
```

问题: 04 analyst / 05 writer 越界写了"评级 + 目标价 + 投资建议" — **是 Human 的工作**

新架构 (2026-08-08 起):
```
role01 collector (Agent) → role02 verifier (Agent)
        ↓
[Stage 1 收集] → [Stage 2 互动: Human 提问 + Agent 跑补充]
        ↓
role03 question-asker (Human) → 提问清单
        ↓
[Stage 3 写稿]
        ↓
role04 draft writer (Human) → role05 modifier (Human)
        ↓
最终研报
```

**新架构中, 之前的 6 子 agent 重新映射**:
- 01 collector → role01 collector (职能保留, **边界收紧** — 不写判断)
- 02 cleaner → role01 collector 的子模块 (数据清洗)
- 03 terminal → role01 collector 的子模块 (调用 SEC EDGAR / 卖方研报)
- 04 analyst → **删除 Agent 身份**, 改为 role01 collector 的"信息呈现" 模块
- 05 writer → **删除 Agent 身份**, 改为 role04 draft writer (Human) 的辅助工具
- 06 visual → **删除 Agent 身份**, 改为 role05 modifier (Human) 的辅助工具

**关键变化**: 04/05/06 三个 Agent 角色取消, 他们的工作 (分析 / 写稿 / 视觉) 是 Human role03/04/05 的事

---

## 6. 财务三表 Excel 标准 (Financial Excel Standard)

> role01 collector 输出的 `excel_financials.xlsx` 必须包含以下 sheets

### Sheet 1: 损益表 (Income Statement) — Raw Data
- 来源: 招股书 / 20-F / 年报
- 列: 收入 / 成本 / 毛利 / 销售费用 / 管理费用 / 研发费用 / 营业利润 / 净利 / Non-GAAP 净利
- 期间: 至少 3 年 (FY2023 / FY2024 / FY2025) + 最新季度 (Q1 2026)
- 货币: 统一 (CNY 或 USD, 一致即可)
- 单位: 千元 (raw) 或 百万 (round), 标清楚

### Sheet 2: 资产负债表 (Balance Sheet) — Raw Data
- 来源: 同上
- 列: 现金 / 应收账款 / 存货 / 流动资产合计 / 固定资产 / 总资产 / 短期借款 / 应付账款 / 流动负债 / 长期借款 / 总负债 / 股东权益
- 期间: 同上 (季度末时点)

### Sheet 3: 现金流量表 (Cash Flow) — Raw Data
- 来源: 同上
- 列: 经营活动现金流入 / 流出 / 净额 / 投资活动 / 融资活动 / 期末现金
- 期间: 同上

### Sheet 4: 关键指标 (Key Ratios) — Calculated
> 这一 sheet 是 **role01 collector 计算** (不是 Human 算), 但**不解读**, 留给人
- 利润率: 毛利率 / 营业利润率 / 净利率 / Non-GAAP 净利率
- 增长率: 营收 YoY / 净利 YoY / 营业利润 YoY
- 运营效率: 应收账款周转天数 / 存货周转天数 / 资产周转率
- 偿债能力: 流动比率 / 资产负债率 / 净负债 / 净负债/EBITDA
- 回报率: ROE / ROA / ROIC
- 现金流: 经营现金流 / 净利润 (质量比) / 自由现金流 (OCF - CapEx)

### Sheet 5: 季度趋势 (Quarterly Trend) — Time Series
- 8 季度时序 (Q1 25 ~ Q1 26)
- 营收 / 净利 / 门店数 / 单店 GMV / 现金流
- 适合画趋势图

### Sheet 6: 业务分拆 (Segment / Channel) — Breakdown
- 加盟 vs 自营 (收入 / 成本 / 毛利 / 利润率)
- 大陆 vs 海外 (门店 / GMV / 营收)
- 按品类 (茶饮 / 咖啡 / 烘焙) 如果有披露

### Sheet 7: 同业可比 (Peer Comp) — Cross Section
- 列: 公司 / 代码 / 营收 / 净利 / 净利率 / 市值 / TTM PE / Forward PE
- 行: 4-6 家可比 (同业 + 海外可比 if any)
- 来源标清楚 (哪个数从哪个公告 / 卖方报告)

**Excel 格式规范**:
- ❌ **不**用合并单元格 (难处理)
- ✅ **用** named ranges (e.g. `Revenue_FY25` 而不是 `B5`)
- ✅ **用** conditional formatting 标红异常值 (e.g. 净利率从 20% 跌到 9%)
- ✅ **每行**加 source 链接 (Hyperlink 到原始 PDF / 网页)
- ✅ **每个 sheet** 顶部加 frozen row (header 不滚动)
- ✅ **不**用颜色美化 (这是数据表, 不是 PPT)

---

## 7. 多源交叉验证方法 (Multi-Source Cross-Check)

> role02 verifier 跑

### 7.1 三手分类
- **一手 (Primary)**: 公司公告 / SEC 文件 / 招股书 / 审计报告
- **二手 (Secondary)**: 卖方研报 / 行业报告 (灼识 / 弗若斯特 / Wind) / 交易所披露
- **三手 (Tertiary)**: 新闻 / 公众号 / 行业自媒体

**降权规则**: 三手数据如跟一手冲突, 默认采信一手 + 标 ⚠️
**采信规则**: 一手 vs 二手冲突, 优先一手; 但如果是会计准则差异 (e.g. 经调 vs GAAP), 列出两个

### 7.2 异常检测 (Anomaly Detection)
verifier 必须标以下异常:
- 数字跳变 (e.g. 净利率从 20% 跌到 9% — 标记 ⚠️)
- 跨期不一致 (e.g. Q1 + Q2 + Q3 + Q4 ≠ 全年, 可能是会计准则或合并范围变化)
- 单位混乱 (e.g. 一段说 ¥B 一段说 ¥M, 标 ⚠️)
- 同一公司不同 source 给不同数 (标 ✗, 取最新一手)

### 7.3 不可验证数据 (Unverifiable)
以下数据**默认不可验证**, 标 ✗ + 降权:
- 远期预测 (FY2027+), 除非有公司指引
- 同业可比 (用其他公司公告 / 卖方研报时, source 必须各自标)
- 行业 TAM/SAM (来自咨询公司估算, 标 "(灼识咨询估算)")

---

## 8. 反例: 之前错在哪 (Anti-Patterns)

### ❌ 反例 #1: agent 写"我们给予 HOLD 评级, 目标价 US$9.55"

```yaml
错在哪:
  - "HOLD" / "目标价" 是 **主观多头判断** (人类决策)
  - Agent 没这权限, 也不该假装有
  - 即使 Agent 算的数对, "评级" 这个动作本身就是越界

对的做法:
  - Agent 输出: "基于 Forward PE 17.0x vs 同业 median 14.7x, 当前估值溢价 15.6%"
  - Agent 输出: "卖方一致目标价区间 $X - $Y (≥3 家)"
  - Agent 输出: "卖方评级分布: BUY x 家, HOLD x 家, SELL x 家"
  - Human (role04) 看完后, 自己做评级判断
```

### ❌ 反例 #2: agent 写"投资建议: 关注加盟萎缩风险"

```yaml
错在哪:
  - "投资建议" 是 Human role04 的事
  - Agent 可以列风险, 但 **不**给"建议"

对的做法:
  - Agent 输出: "Q4 2025 起连续 2 季度加盟净关, 净关 230 家, 数据源 (6-K Q1 2026)"
  - Agent 输出: "⚠️ 加盟萎缩原因公司未明确, 可能是 (a) 加盟商撤退 (b) 公司主动调整"
  - Human 看完后, 自己判断"是不是 risk"
```

### ❌ 反例 #3: agent 用漂亮话代替数据

```yaml
错在哪:
  - "中国新茶饮龙头, 品牌力强, 海外布局领先" — 漂亮话, 无数据
  - 投资人不该被形容词说服

对的做法:
  - Agent 输出: "门店 7,531 (Q1 26), 同业对比: 蜜雪 59,823 / 古茗 13,554 / 茶百道 8,621, CHA 排第 3"
  - Agent 输出: "海外门店 138, 海外 GMV Q1 26 426M (YoY +139%), 占比 5.4%"
  - Human 看完后, 自行判断"是不是龙头"
```

### ❌ 反例 #4: agent 不标 source, 一句话带过

```yaml
错在哪:
  - "市场预计 2026 净利 ¥5B" — 哪个市场? 哪家研报? 哪一天?
  - 投资决策最忌"据说"

对的做法:
  - Agent 输出: "卖方一致预期 (截至 2026-07-31): 蜜雪 2026 净利 ¥5.12B (东吴 2025-04-23), 实际 FY25 ¥5.88B, 隐含 -13% YoY"
  - source + date + 实际对比, 三件齐
```

---

## 9. 失败模式 & 应对 (Failure Modes)

| 失败模式 | 原因 | 应对 |
|---|---|---|
| Agent 输出研报级文字 | 没读 agent-roles.md | 强制 review, 标"v0 草案" + 不允许评级 / 目标价 / 投资建议词 |
| 数据无 source | collector 偷懒 | verifier 拒收, 标 ✗ |
| 卖方观点被美化 | collector 抄研报 | verifier 对比原始 PDF, 标 ⚠️ |
| Human 不提问, 直接信 Agent | role03 缺位 | role03 必须写提问清单才能进 Stage 3 |
| Human 不写稿, 让 Agent 写 | role04 缺位 | Stage 3 必须是 Human 主笔, Agent 只辅助 |
| 信息太多, Human 看不完 | collector 输出过载 | 强制结构化: 每 sheet ≤ 50 行, 每节 ≤ 5 个 bullet |
| 投资逻辑跳步 (从 A 到 C 没 B) | 漂亮话堆砌 | 强制写"因为 X, 所以 Y" 链, 跳步就拒收 |

---

## 10. 跟 6 子 agent pipeline 的对应关系 (Mapping)

| 老 agent spec (v0.1) | 新角色 (v1.0) | 变化 |
|---|---|---|
| agents/01-data-collector.md | role01 collector (子模块) | 收紧: 不写判断 |
| agents/02-data-cleaner.md | role01 collector (子模块: 清洗) | 保留 |
| agents/03-terminal-bridge.md | role01 collector (子模块: 终端) | 保留 |
| agents/04-analyst.md | **role01 collector (信息呈现) + role03 question-asker 提示** | **取消 Agent 写评级** |
| agents/05-writer.md | **role04 draft writer 辅助工具** | **取消 Agent 写研报** |
| agents/06-visual-designer.md | **role05 modifier 辅助工具** | **取消 Agent 视觉化** |

**实施**: v1 阶段, 04/05/06 三个 spec 文件保留作为 Human role 的**工具说明**, 明确标 "由 Human 使用, 不由 Agent 自动执行"

---

## 11. 当前采纳状态 (Adoption Status)

- [x] v1.0 文档完成 (2026-08-08)
- [x] ADR-0004 记录 (取代之前临时架构)
- [x] cha-initiation-2026 项目的 04/05 输出回炉重做 (v0.x 越界, 改 v1.0 collector-only)
- [x] 财务三表 Excel 标准 (Sheet 1-7) 在 cha-initiation-2026/05-writer/ 落地
- [ ] 6 子 agent spec 文件 v1 重写 (下周, Human 写)
- [ ] 评测标准 (eval/scoring-sheets) 跟着改 (下周)

---

**维护人**: Ryan LI (拍板) + shine040 (review) + Mavis (执行)

**变更规则**: 改这份文档需要 ADR 走决策流 (跟 ADR-0002 / 0003 一样)

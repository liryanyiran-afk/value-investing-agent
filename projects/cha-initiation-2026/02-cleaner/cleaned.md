# 02-cleaner / cleaned.md

> 霸王茶姬 CHAGEE 清洗后数据 — v0.1 (2026-08-08)
> 数据源: SEC EDGAR XBRL API (data.sec.gov) + 20-F FY2025
> 用途: 04 analyst 直接消费

## 元信息

- **cleaner_version**: data-cleaner-v0.1
- **cleaned_at**: 2026-08-08T16:00:00+08:00
- **primary_source**: SEC EDGAR 20-F FY2025 (filed 2026-04-29, accession 0001104659-26-050766)
- **secondary_source**: 待补 424B4 (历史 2022 数据)
- **currency**: 主数据 CNY (人民币), 部分标注 USD (按 20-F 注 2(f) 换算)
- **fiscal_year**: 1月1日 - 12月31日 (US-listed Cayman 公司, 会计年度自然年)

---

## 1. 损益表 (Income Statement) — 三年趋势

来源: `data.sec.gov/api/xbrl/companyconcept/CIK0002013649/us-gaap/RevenueFromContractWithCustomerExcludingAssessedTax.json` 跟 `NetIncomeLoss.json`

| 指标 | FY2023 | FY2024 | FY2025 | YoY 24 | YoY 25 |
|---|---|---|---|---|---|
| **营业收入** (CNY 千元) | 4,640,171 | 12,405,582 | 12,907,407 | **+167%** | **+4%** |
| **净利润** (CNY 千元) | 800,903 | 2,516,114 | 1,171,149 | **+214%** | **-53%** |
| **净利率** | 17.3% | 20.3% | 9.1% | +3.0pp | **-11.2pp** |
| 营收 (USD 百万, 2025) | — | — | 1,846 | — | — |
| 净利润 (USD 百万, 2025) | — | — | 167 | — | — |

**🚨 关键发现 (analyst 04 必看)**:
- **营收增长断崖**: 167% (2024) → 4% (2025), **+163pp 减速**
- **净利润腰斩**: 2.52B → 1.17B, **-53%**
- **利润率压缩**: 20.3% → 9.1%, 几乎砍半
- **可能原因** (待 04 analyst 验证):
  - 加盟门店数见顶, 增长动能消失
  - 价格战 / 行业竞争加剧 (蜜雪冰城等)
  - 上市后股权激励费用化
  - 海外扩张前置投入
  - 同店增长放缓

---

## 2. 资产负债表 (Balance Sheet) — 时点

来源: `data.sec.gov/api/xbrl/companyconcept/CIK0002013649/us-gaap/Assets.json` 跟 待补 (Liabilities, StockholdersEquity)

| 指标 | 2024-12-31 | 2025-12-31 | YoY |
|---|---|---|---|
| **总资产** (CNY 千元) | 6,596,106 | 11,462,983 | +74% |
| 总资产 (USD 百万, 2025) | — | 1,639 | — |

**🚨 注意**: 总资产 +74% 但净利润 -53%, 资产扩张快于盈利, 投入产出比恶化。

---

## 3. 业务数据 (Business Metrics) — 关键 KPI

> 来源: 6-K earnings releases (待 02 cleaner 抓 P0 4 份 6-K 后补)
> 当前 hint (从招股书 / Bilibili 视频, **待 02 cleaner 验证**)

| 指标 | FY2023 | FY2024 | FY2025 | 备注 |
|---|---|---|---|---|
| 总门店数 | — | 6,440+ | — | 待 424B4 抽 |
| 加盟门店占比 | — | 97% | — | 招股书数据 |
| 海外门店数 | — | 156 | — | 招股书 (马来/新加坡/洛杉矶首店) |
| 单店月均 GMV (元) | — | 510,000 | — | 招股书 2024 数据 |
| 闭店率 | — | 0.5%-1.5% | — | 2023-24 数据 |
| 品牌 GMV (亿元) | — | 295 | — | 招股书 2024 数据 |

**待办** (02 cleaner 下一轮):
- 拉 4 份 6-K press release 抽门店数 / GMV 季度数据
- 拉 424B4 抽 2022-2024 完整业务数据 + 管理层

---

## 4. 公司画像

来源: 20-F + 公开新闻 (Bilibili 视频补充)

- **品牌**: CHAGEE (霸王茶姬)
- **公司**: Chagee Holdings Ltd. (开曼注册, 运营总部四川)
- **创始人**: 张俊杰 (Junjie Zhang) — 公开信息
- **成立**: 2017 年 (待 424B4 抽准确年份)
- **上市**: 2025-04-17 NASDAQ, IPO 价 $28/ADS, 募资 4.11 亿美元
- **首日市值**: ~60 亿美元
- **CIK**: 0002013649
- **SEC File #**: 001-42598
- **主营业务**: 现制茶饮 (主推 "原叶鲜奶茶")
- **模式**: 97% 加盟 + 3% 直营
- **市场**: 中国大陆 (主) + 海外 (马来西亚, 新加坡, 美国)

---

## 5. 风险 / 待补

> 这一段是 02 cleaner 标注的 data quality 状态, 04 analyst 必须读

- [ ] 2022 历史数据 (424B4 抽, 待办)
- [ ] 单店 GMV 季度趋势 (6-K 抽, 待办)
- [ ] 成本明细 (营业成本 / 销售费用 / 管理费用 / 财务费用) — 6-K 没明细, 需从 20-F 抽
- [ ] 同业可比 (蜜雪冰城, 茶百道, 古茗) — 单独 task
- [ ] 客户集中度 (前 5 大加盟商占比) — 招股书披露
- [ ] 资金来源 (IPO 募资使用) — 20-F 披露
- [ ] 股权结构 (管理层 + XVC + 其他) — 招股书披露
- [ ] 关联交易 (跟 Partea 等实体的关系) — iXBRL 头部发现 "Partea Ltd" 等可疑关联方
- [ ] 中国行业数据 (灼识咨询引用) — 招股书披露

**数据冲突 / 异常**:
- 净利率 20.3% (2024) → 9.1% (2025), 11pp 跌幅, 需 04 解释
- 总资产 +74% (2025), 跟营收 +4% 不成比例, 需 04 看资产构成

---

## 6. source_ref 索引

| 数据点 | source | url |
|---|---|---|
| 营收 2023-2025 | data.sec.gov XBRL | https://data.sec.gov/api/xbrl/companyconcept/CIK0002013649/us-gaap/RevenueFromContractWithCustomerExcludingAssessedTax.json |
| 净利润 2023-2025 | data.sec.gov XBRL | https://data.sec.gov/api/xbrl/companyconcept/CIK0002013649/us-gaap/NetIncomeLoss.json |
| 总资产 2024-2025 | data.sec.gov XBRL | https://data.sec.gov/api/xbrl/companyconcept/CIK0002013649/us-gaap/Assets.json |
| 20-F FY2025 全文 | sec.gov archives | https://www.sec.gov/Archives/edgar/data/2013649/000110465926050766/cha-20251231x20f.htm |

---

## 7. 给 04 analyst 的提示

> 02 cleaner 给 04 analyst 的明牌跟暗牌

**明牌 (必须 follow)**:
1. 2024 → 2025 营收增速 +167% → +4%, **断崖式减速** — 这是核心 narrative
2. 2024 → 2025 净利润 -53%, 净利率 20.3% → 9.1% — 盈利质量恶化
3. 总资产 +74% (2025) 跟营收 +4% 不成比例 — 资产质量要查

**暗牌 (需深挖)**:
1. 加盟模式 (97% 加盟) 的收入确认方式 — 是不是一次性卖原料 + 持续特许权费
2. Partea Ltd 等关联交易 (iXBRL header 里出现) — 跟实控人关系
3. 上市 1.5 年就盈利塌方 — 行业周期? 公司经营? 财务粉饰?
4. 海外扩张前置投入 vs 实际回报 — 156 家海外门店, 利润贡献?

**蓝军自攻击 (analyst 必列)**:
- 反方 1: "2025 业绩塌方 = 上市后管理层冲业绩的反噬" (是不是上市前粉饰, 上市后回归)
- 反方 2: "加盟模式 = 一次性收入, 持续性存疑" (加盟商扩张见顶?)
- 反方 3: "新茶饮赛道红利消退, 蜜雪冰城 / 古茗同样压力大" (系统性还是公司性)

**监控 KPI (analyst 必给阈值)**:
- 月新增门店数: 当前 200+ → 黄 < 100, 红 < 50
- 同店 GMV 增长 (SSSG): 当前 +X% → 黄 < 0%, 红 < -5%
- 海外门店 EBITDA 转正: 2027 是目标 → 黄 2028+, 红 2029+

---

**02 cleaner 状态**: v0.1 完成 (FY 财务数据), 待补:
- 业务 KPI (门店/GMV) 季度数据 (下轮 6-K 抓)
- 2022 历史数据 (424B4 抓)
- 成本明细 (20-F 抽)

# Extraction Notes — shouren-researcher → 04 analyst v0.2

> 用途: 04 analyst 升级到 v0.2 时, 从 [`mavis-agents/reference/shouren-researcher.md`](../../mavis-agents/reference/shouren-researcher.md) 提炼什么, 怎么提炼.
>
> **关键原则**: 04 spec / prompt **不复制** shouren 原文, 只**引用 + 链接**, 避免双源维护.

## 来源
- `mavis-agents/reference/shouren-researcher.md` (frozen v0.1, 2026-08-08)
- 当前 04 spec: `agents/04-analyst.md`
- 当前 04 prompt: `prompts/analyst/v0.1.md` (placeholder)

## 提炼对照表

| shouren 段落 | 提炼进 04 v0.2 的位置 | 形式 |
|---|---|---|
| **§ 1 角色与机构身份** (机构/品牌色/字体/评级) | ❌ **不进 04** | 04 不管 persona, 那是 M3 层 |
| **§ 2 投研工作流 5 阶段** (采集/抽取/研究/产出/PUA) | 进 04 spec 的"上下游"段 | 引用 + 链接, 04 只在 analyst stage 起作用 |
| **§ 3 PUA 6 项 checklist** | 进 04 prompt 顶部 "强制约束" 段 + scoring-sheet 04 | 6 项作为硬约束写在 prompt |
| **§ 4 5 页 PPT 标准结构** | ❌ **不进 04** | 那是 05/06 的事 |
| **§ 5 必装 Skills** | ❌ **不进 04** | 04 不管 skill 清单, 那是 M3 层 |
| **§ 6 关键技术坑 (PDF/PPT/pip)** | 部分进 04 prompt ("数据可溯源" 段), 主要是 02/06 的事 | 引用 § 6 链接 |
| **§ 7 行为准则** (溯源/evidence/不 sloppy) | 进 04 prompt "行为准则" 段 | 引用 + 改写为 04 视角 |
| **§ 8 任务模板** (Initiation/Update/Industry) | 进 04 input `options.template` | 04 不生成报告但支持多模板, 模板元数据下沉 |
| **§ 9 CONFIG 区** (institution/analyst_name/coverage) | ❌ **不进 04** | 04 不存机构配置, 那是 M3 层 |
| **§ 10 交付清单** | ❌ **不进 04** | 04 只产 analysis.yaml, 交付是 05/06 |
| **框架 (Graham/Buffett/Munger/Marks)** | 已在 04 spec "价值投资框架" 段, v0.2 强化 prompt | 引用 + 扩展为 prompt 段 |
| **三档情景估值 (BEAR/BASE/BULL + 概率)** | 已在 04 spec output 契约, v0.2 prompt 显式化 | 引用 spec 段 + 写入 prompt |
| **错位视角 evidence-based** | 已在 04 spec `contrarian_view` 段, v0.2 prompt 强制 | 引用 + 写入 prompt |

## v0.2 计划要做的事

1. **prompt 顶部加 PUA 6 项硬约束** (从 shouren § 3 提炼, 不复制原文)
2. **prompt 加 "行为准则" 段** (从 shouren § 7 改写, 04 视角)
3. **prompt 加 "三档情景估值" 详细段** (从 shouren § 3 + 04 spec output 契约综合)
4. **prompt 加 "蓝军自攻击 ≥ 3 条" 段** (从 shouren § 3)
5. **prompt 加 "KPI 阈值化" 段** (从 shouren § 3 + 04 spec `monitoring_kpis`)
6. **scoring-sheet 04 与 PUA 6 项对应** (已在 v0.0.3 完成, 见 `eval/scoring-sheets/04-analyst.md` 末尾)

## v0.2 计划不做的

- 不复制 shouren 的 persona / 品牌色 / 字体规则
- 不复制 shouren 的 5 阶段 workflow (那是 M3 层)
- 不复制 shouren 的 5 页 PPT 结构 (那是 05/06)
- 不复制 shouren 的 skills 清单 (那是 M3 层)
- 不复制 shouren 的 CONFIG / 交付清单 (那是 M3 层)

## 验收

v0.2 跑完一个真实标的 (0700.HK), 跑分总分 ≥ 6.0 (内部可用线), PUA 6 项全过.

---

**更新历史**:
- 2026-08-08: 初版 (随 v0.0.3 入仓)

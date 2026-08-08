# 0002 — shouren-researcher 降级为参考档案

## 状态
已接受 (2026-08-08)

## 背景
Ryan LI 在 M3 顶层 agent 上沉淀了一份完整的卖方研究方法论 (`mavis-agents/shouren-researcher.md`),
同时项目主仓有 `agents/04-analyst` (Pipeline sub-agent). 两份 spec 在"投研分析"这个主题上
内容高度重叠, 容易造成维护混乱 (改一个忘另一个).

此外, shouren-researcher 已经成型 (从 bitgates-researcher 改名而来, 配套 24 skill 清单),
属于"前期积累, 已稳定"的状态, 不再频繁迭代.

## 决策
1. `mavis-agents/shouren-researcher.md` **降级为参考档案**, 移入 `mavis-agents/reference/`, 不再演进
2. 文件顶部加 🧊 `frozen v0.1` banner, 明确不再维护
3. `mavis-agents/skills-manifest.md` 跟随 shouren 移入 `reference/`
4. `mavis-agents/install.sh` 默认**不**装 shouren (注释说明 + 手动 install 命令)
5. 当前 canonical 投研分析由 `agents/04-analyst.md` 承担
6. 提炼 shouren 进 04 v0.2 的计划单独写在 `prompts/analyst/extraction-notes.md`
7. 未来 M3 顶层 agent (e.g. `vi-orchestrator`) 启动时, 应**继承 shouren 的 persona voice / PUA 闭环**, 不另起炉灶

## 候选方案

### A. 保留两份, 明确分工
- shouren 仍是 M3 在用 persona
- 04-analyst 独立, 不引用 shouren
- 缺点: 双源维护, 改 persona 时 04 跟不动
- **不采纳**

### B. 删除 shouren, 只留 04
- 把 shouren 的方法论全部塞进 04
- 缺点: 04 突然变大, 失去 M3/Pipeline 分层
- **不采纳**

### C. 冻结归档 + 提炼路径 ✅
- shouren 保留为参考档案, 04 引用, 提炼路径明确
- 优: 单一 canonical (04 演进), 沉淀不丢, M3/Pipeline 边界清晰
- **采纳**

## 后果
- ✅ 单一 canonical: `agents/04-analyst.md` + `prompts/analyst/vN.M.md` 演进
- ✅ Ryan 前期方法论保留可追溯, 不丢
- ✅ 04 v0.2 升级有明确起点 (从 shouren 提炼)
- ✅ M3 vs Pipeline 分层清晰 (见 ADR 0003)
- ⚠️ Ryan 机器上已 install 的 shouren-researcher 本地实例保留, 不动
  (仓内 spec 冻结 ≠ Mavis 本地实例失效)
- ⚠️ shine040 机器如要追溯, 手动 install 命令在 `mavis-agents/README.md` 末尾
- ⚠️ 未来新 vi-orchestrator 必须 reference shouren 的 PUA 6 项 / 5 页结构, 不要重写

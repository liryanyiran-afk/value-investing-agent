# Reference — M3 Agent 参考档案

> 归档规则说明

## 定位

本目录存放**已冻结 / 仅作参考**的 M3 agent spec. **不演进, 不安装 (除非要回顾)**.

| 状态 | 含义 | 是否演进 | 是否在 install.sh 装 |
|---|---|---|---|
| 🟢 active | 当前在用, 持续演进 | ✅ 是 | ✅ 是 |
| 🧊 frozen | 已成型的历史成果, 仅供未来参考 | ❌ 否 | ⚠️ 可选, 注释明示 |
| 📜 archived | 完全过时, 留作历史档案 | ❌ 否 | ❌ 否 |

## 当前文件

| 文件 | 状态 | 备注 |
|---|---|---|
| `shouren-researcher.md` | 🧊 frozen v0.1 | Ryan LI 设计, M3 卖方研究方法论. 提炼进 04-analyst, 见 `../../../prompts/analyst/extraction-notes.md` |
| `skills-manifest.md` | 🧊 frozen v0.1 | shouren 配套 24 skill 清单, 跟 shouren 一起冻结 |

## 添加新文件到本目录

1. 把原 `mavis-agents/<name>.md` `git mv` 到本目录
2. 顶部加状态 banner (🧊 frozen 或 📜 archived)
3. 在本 README 索引加一行
4. 写一份 ADR 解释为什么降级 (`decisions/NNNN-<reason>.md`)

## 为什么需要 reference/

- **避免双源维护**: shouren 与 04-analyst 内容高度重叠, 容易改一个忘另一个
- **保留方法论沉淀**: Ryan 前期投入不丢, 后续提炼有据
- **清晰 M3 vs Pipeline 边界**: 详见 [`../../../docs/architecture.md`](../../../docs/architecture.md)

# Mavis Agents

> 在本机 Mavis 安装的可调用 agent. 跟着项目走, 两人 (Ryan + shine040) 共享同一套定义.

## 与项目主体的关系

`mavis-agents/` 下的 spec 是 **M3 层 (顶层 persona + orchestrator)**, 跟 `agents/01-06` 的 **Pipeline 层 (worker)** 是两层架构, 详见 [`../docs/architecture.md`](../docs/architecture.md).

| 层 | 文件位置 | 角色 | 状态 |
|---|---|---|---|
| M3 (persona + orchestrator) | `mavis-agents/*.md` | 顶层对话, 调度下层 | 🟢 active / 🧊 frozen / 📜 archived |
| Pipeline (sub-agents) | `agents/01-06` + `prompts/<agent>/` | 数据 / 分析 / 写报 / 出图 | 🟢 evolving |

`mavis-agents/reference/` 存放**已冻结的参考档案**, 详见 [`reference/README.md`](reference/README.md).

## 目录

### Active Agents (本机装 + 演进中)

_暂无 (shouren-researcher 已移入 reference/, 后续 vi-orchestrator 启动时在此添加)_

### Reference (冻结, 仅供查阅)

| Agent | 用途 | 状态 | 备注 |
|---|---|---|---|
| `reference/shouren-researcher` | 守仁资产研究 卖方研究分析师, 5 页 PPT + PUA 闭环 | 🧊 frozen v0.1 (2026-08-08) | Ryan 前期方法论, 提炼进 04-analyst v0.2 |

## 安装 (本机)

```bash
./install.sh
```

**注意**: install.sh 默认**不**安装 reference/ 里的 frozen agents. 如要追溯, 手动 install:

```bash
mavis agent create \
  --name "shouren-researcher" \
  --display-name "Shouren Research" \
  --description "守仁资产研究 卖方研究分析师, 5 页 PPT + PUA 闭环" \
  --system-prompt "$(awk '/^````markdown$/{flag=1; next} /^````$/{flag=0} flag' reference/shouren-researcher.md)"
```

## 调用 Active Agent

Active agent 安装后, 在 Mavis UI 里:

```
@<agent-name> <任务>
```

或在 mavis 命令行:

```bash
mavis agent invoke <agent-name> --task "<任务>"
```

## 跨人共享

Active agent 定义在 git 仓里, 两人各跑一次 `./install.sh` 即同步.

**注意**: 改任何 spec 后, 两人本机不会自动更新, 各自 pull + 重跑 install:

```bash
cd value-investing-agent
git pull
cd mavis-agents
./install.sh  # 会覆盖更新
```

## 添加新 Agent

### Active (要演进)
1. 在 `mavis-agents/` 根新建 `<name>.md` (含完整 system prompt)
2. 在 `install.sh` 加一段 `if [ -f "<name>.md" ]` 块
3. 在本 README "Active" 索引加一行
4. commit + push
5. 朋友 pull + 跑 install

### Frozen (要归档)
1. `git mv mavis-agents/<name>.md mavis-agents/reference/<name>.md`
2. 顶部加 🧊 banner
3. 在 `reference/README.md` 索引加一行
4. 写一份 ADR (`decisions/NNNN-<reason>.md`)
5. install.sh 注释说明"不再装"

## 关联

- 上层项目: `value-investing-agent` (本仓根)
- 架构: [`../docs/architecture.md`](../docs/architecture.md)
- Pipeline 子 agent: `../agents/01-06`
- Prompt 版本: `../prompts/`
- ADR 索引: [`../decisions/README.md`](../decisions/README.md)

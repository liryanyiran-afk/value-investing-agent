# Mavis Agents

> 在本机 Mavis 安装的可调用 agent. 跟着项目走, 两人 (Ryan + shine040) 共享同一套定义.

## 目录

| Agent | 用途 | 状态 |
|---|---|---|
| `bitgates-researcher` | 投行/卖方研究分析师, 5 页 PPT + PUA 闭环 | 🟢 v0.1 (2026-08-08) |

## 安装 (本机)

```bash
./install.sh
```

或手动:

```bash
mavis agent create \
  --name "bitgates-researcher" \
  --display-name "BitGates Researcher" \
  --description "投行/卖方研究分析师, 5 页 PPT + PUA 闭环" \
  --system-prompt "$(cat bitgates-researcher.md)"
```

## 调用

安装后, 在 Mavis UI 里:

```
@bitgates-researcher 给 0700.HK 出一份 Initiation 报告
```

或在 mavis 命令行:

```bash
mavis agent invoke bitgates-researcher --task "给 0700.HK 出 Initiation 报告"
```

## 跨人共享

Agent 定义在 git 仓里, 两人各跑一次 `./install.sh` 即同步.

**注意**: 改任何 spec 后, 两人本机不会自动更新, 各自 pull + 重跑 install:

```bash
cd value-investing-agent
git pull
cd mavis-agents
./install.sh  # 会覆盖更新
```

## 添加新 Agent

1. 在 `mavis-agents/` 新建 `<name>.md` (含完整 system prompt)
2. 在 `install.sh` 加一行
3. 在本 README 索引加一行
4. commit + push
5. 朋友 pull + 跑 install

## 关联

- 上层项目: `value-investing-agent` (本仓根)
- pipeline 子 agent: `agents/01-06`
- prompt 版本: `prompts/`

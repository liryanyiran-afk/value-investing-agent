#!/bin/bash
# install.sh — 在本机 Mavis 装上本目录所有 ACTIVE agent
# 用法: ./install.sh
# 依赖: mavis CLI 已配置 (mavis agent list 能跑)
#
# 范围: 只装 mavis-agents/ 根下的 active agents.
#       reference/ 下的 frozen agents 不在此装 (归档, 见 ../decisions/0002-shouren-as-archive.md)

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo "=== Mavis Agents Installer (active only) ==="
echo "目录: $SCRIPT_DIR"
echo

# 检查 mavis
if ! command -v mavis >/dev/null 2>&1; then
    echo "❌ mavis CLI 不在 PATH, 请先配置 Mavis"
    echo "   参考: https://mavis.dev/docs/agent-create"
    exit 1
fi

# 检查 mavis 是否登录/配好
if ! mavis agent list >/dev/null 2>&1; then
    echo "❌ mavis agent list 失败, 检查 mavis 是否已登录"
    exit 1
fi

# 当前 active agents 列表 (按需追加)
# 注意: shouren-researcher 已在 reference/ 里 frozen, 本脚本不装
ACTIVE_AGENTS=()

# 检测根目录下有 system prompt block 的 .md 文件
for f in *.md; do
    if [ -f "$f" ] && grep -q '^````markdown$' "$f" 2>/dev/null; then
        ACTIVE_AGENTS+=("$f")
    fi
done

if [ ${#ACTIVE_AGENTS[@]} -eq 0 ]; then
    echo "⚠ mavis-agents/ 根下没找到 active agent spec"
    echo "  冻结的 agent 在 reference/, 不会被装"
    echo "  (历史: shouren-researcher 2026-08-08 移入 reference/)"
fi

# 装每个 active agent
for spec_file in "${ACTIVE_AGENTS[@]}"; do
    AGENT_NAME=$(basename "$spec_file" .md)
    DISPLAY_NAME=$(grep -m1 'display_name' "$spec_file" | sed -E 's/.*\*\*display_name\*\*:[[:space:]]*//' | sed -E "s/.*\`([^\`]+)\`.*/\1/; s/[[:space:]].*//")
    DESCRIPTION=$(grep -m1 'description' "$spec_file" | sed -E 's/.*\*\*description\*\*:[[:space:]]*//' | sed 's/[[:space:]]*$//')

    if [ -z "$DISPLAY_NAME" ]; then
        DISPLAY_NAME="$AGENT_NAME"
    fi

    if mavis agent get "$AGENT_NAME" >/dev/null 2>&1; then
        echo "→ $AGENT_NAME 已存在, 更新中..."
        PROMPT=$(awk '/^````markdown$/{flag=1; next} /^````$/{flag=0} flag' "$spec_file")
        mavis agent update \
            --agent-name "$AGENT_NAME" \
            --display-name "$DISPLAY_NAME" \
            --description "$DESCRIPTION" \
            --system-prompt "$PROMPT" 2>&1 || \
        echo "  (update 失败, 尝试 delete + create)"
    else
        echo "→ 安装 $AGENT_NAME..."
        PROMPT=$(awk '/^````markdown$/{flag=1; next} /^````$/{flag=0} flag' "$spec_file")
        mavis agent create \
            --name "$AGENT_NAME" \
            --display-name "$DISPLAY_NAME" \
            --description "$DESCRIPTION" \
            --system-prompt "$PROMPT"
    fi
    echo "  ✓ $AGENT_NAME 就位"
done

echo
echo "=== 安装完成 ==="
echo

if [ ${#ACTIVE_AGENTS[@]} -gt 0 ]; then
    echo "已装 active agent(s):"
    for a in "${ACTIVE_AGENTS[@]}"; do
        echo "  - $(basename "$a" .md)"
    done
else
    echo "未装任何 active agent (本轮 reference/ 优先)"
fi

echo
echo "调用示例 (装了的 agent):"
for a in "${ACTIVE_AGENTS[@]}"; do
    name=$(basename "$a" .md)
    echo "  @$name <任务>"
done

echo
echo "---"
echo "要追溯 shouren-researcher (frozen):"
echo "  mavis agent create --name shouren-researcher --display-name 'Shouren Research' \\"
echo "    --description '守仁资产研究 卖方研究分析师, 5 页 PPT + PUA 闭环' \\"
echo "    --system-prompt \"\$(awk '/^\\\`\\\`\\\`\\\`markdown\$/{flag=1; next} /^\\\`\\\`\\\`\\\`\$/{flag=0} flag' reference/shouren-researcher.md)\""

#!/bin/bash
# install.sh — 在本机 Mavis 装上本目录所有 agent
# 用法: ./install.sh
# 依赖: mavis CLI 已配置 (mavis agent list 能跑)

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo "=== Mavis Agents Installer ==="
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

# 装 shouren-researcher
if [ -f "shouren-researcher.md" ]; then
    AGENT_NAME="shouren-researcher"
    DISPLAY_NAME="Shouren Research"
    DESCRIPTION="守仁资产研究 卖方研究分析师, 5 页 PPT + PUA 闭环"
    if mavis agent get "$AGENT_NAME" >/dev/null 2>&1; then
        echo "→ $AGENT_NAME 已存在, 更新中..."
        PROMPT=$(awk '/^````markdown$/{flag=1; next} /^````$/{flag=0} flag' shouren-researcher.md)
        mavis agent update \
            --agent-name "$AGENT_NAME" \
            --display-name "$DISPLAY_NAME" \
            --description "$DESCRIPTION" \
            --system-prompt "$PROMPT" 2>&1 || \
        echo "  (update 失败, 尝试 delete + create)"
    else
        echo "→ 安装 $AGENT_NAME..."
        PROMPT=$(awk '/^````markdown$/{flag=1; next} /^````$/{flag=0} flag' shouren-researcher.md)
        mavis agent create \
            --name "$AGENT_NAME" \
            --display-name "$DISPLAY_NAME" \
            --description "$DESCRIPTION" \
            --system-prompt "$PROMPT"
    fi
    echo "  ✓ $AGENT_NAME 就位"
else
    echo "⚠ shouren-researcher.md 不存在, 跳过"
fi

echo
echo "=== 安装完成 ==="
echo
echo "验证:"
mavis agent list 2>&1 | grep -A1 "shouren-researcher" || echo "  (没找到, 查 mavis agent list)"
echo
echo "调用示例:"
echo "  @shouren-researcher 给 0700.HK 出 Initiation 报告"

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

# 装 bitgates-researcher
if [ -f "bitgates-researcher.md" ]; then
    if mavis agent get bitgates-researcher >/dev/null 2>&1; then
        echo "→ bitgates-researcher 已存在, 更新中..."
        # Mavis 没原生 update command, 用 create (同名会覆盖, 视具体实现)
        mavis agent update \
            --agent-name "bitgates-researcher" \
            --system-prompt "$(cat bitgates-researcher.md)" 2>&1 || \
        echo "  (update 失败, 尝试 delete + create)"
    else
        echo "→ 安装 bitgates-researcher..."
        # 从 .md 文件提取 system prompt 部分
        # 文件结构: 元信息 + ````markdown ... ```` 包裹的 system prompt
        PROMPT=$(awk '/^````markdown$/{flag=1; next} /^````$/{flag=0} flag' bitgates-researcher.md)
        mavis agent create \
            --name "bitgates-researcher" \
            --display-name "BitGates Researcher" \
            --description "投行/卖方研究分析师, 5 页 PPT + PUA 闭环" \
            --system-prompt "$PROMPT"
    fi
    echo "  ✓ bitgates-researcher 就位"
else
    echo "⚠ bitgates-researcher.md 不存在, 跳过"
fi

echo
echo "=== 安装完成 ==="
echo
echo "验证:"
mavis agent list 2>&1 | grep -A1 "bitgates-researcher" || echo "  (没找到, 查 mavis agent list)"
echo
echo "调用示例:"
echo "  @bitgates-researcher 给 0700.HK 出 Initiation 报告"

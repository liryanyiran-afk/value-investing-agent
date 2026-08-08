# 03 — terminal-bridge

> 金融终端 API 接入层。统一封装 Wind / Bloomberg / Choice / iFinD 等的差异, 暴露标准化数据点。

## Pipeline Position
- 位置: 旁路 (01 和 04 都可以调用, 不是必经 stage)
- 上游: — (按需被 01 / 04 调用)
- 下游: — (写入供 01 / 04 读)
- 读取: —
- 写入: `outputs/<target>/<date>/03-terminal/terminal_data.yaml`
- 契约: 见 [`docs/contracts.md`](../docs/contracts.md#03-terminal-bridge)
- 架构: 见 [`docs/architecture.md`](../docs/architecture.md)
- 跑分卡: 用通用 6 维度 (03 是工具型 agent, 不单建打分卡)

## 职责
- 封装主流金融数据 API
- 统一数据格式 (字段命名 / 单位 / 时区)
- 鉴权 & 限流处理
- 数据缓存 (避免重复扣额度)
- 失败时降级 (终端 A 拿不到 → 终端 B)

## 输入契约
```yaml
query:
  endpoint: "price_history"  # 见支持的端点列表
  target: "0700.HK"
  params:
    start: "2021-01-01"
    end: "2026-08-08"
    frequency: "daily"
  preferred_terminal: "wind"  # wind | bloomberg | choice | ifind
  fallback: ["choice", "ifind"]
```

## 输出契约
```yaml
result:
  endpoint: "price_history"
  target: "0700.HK"
  fetched_from: "wind"
  fetched_at: "..."
  data:
    - date: "2021-01-04"
      open: 564.0
      high: 580.0
      low: 561.0
      close: 575.5
      volume: 18500000
  unit_meta:
    currency: "HKD"
    adjusted: false
  cache_hit: false
```

## 支持的端点 (v0.1 范围)
- `price_history` — 历史行情
- `fundamental_snapshot` — 当前基本面快照
- `financials` — 财务三表
- `index_constituents` — 指数成分股
- `dividend_history` — 分红历史
- `analyst_estimates` — 卖方一致预期

## 实现位置
- `scripts/terminal_<name>.py` — 每个终端一个适配器
- `scripts/bridge.py` — 统一入口, 调度 + fallback

## 依赖
- Wind Py 客户端 (或 WSS)
- Bloomberg BLPAPI (有 license 时)
- Choice iFinD
- iFinD 同花顺

## 失败模式 & 应对
- 凭证过期: 告警 + 强制重新登录
- 限流: 退避 + 队列
- 终端 A 全挂: 走 fallback, 仍挂则 fail loud
- 时区错: 全部统一到 HKT (GMT+8)

## 安全
- API 凭证绝不入仓 (见根 `.gitignore`)
- 凭证放 `~/.config/vi-agent/credentials.yaml` (不进仓)
- 调脚本前需 env var 注入

## 负责人
_待分配_

## 当前 prompt
`prompts/terminal-bridge/v0.1.md`

## 跑分
`eval/scores/<date>-terminal-bridge.md`

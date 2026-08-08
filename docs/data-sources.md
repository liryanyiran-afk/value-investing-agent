# 数据源 — A股 + 港股通港股

> 当前数据范围: A股 + 港股通港股 (基于 2Mind 现有数据库)。后续可能扩展。

## A股数据源

### 监管 / 公告
- **上交所 (SSE)**: `sse.com.cn` — 公告 / 招股书
- **深交所 (SZSE)**: `szse.cn` — 公告 / 招股书
- **巨潮资讯 (cninfo)**: `cninfo.com.cn` — 法定信披, 最权威

### 财务 / 行情
- **Wind** (付费, 2Mind 接入)
- **Choice (东方财富)** (付费)
- **同花顺 iFinD** (付费)

### 媒体 / 研究
- 财新 (caixin.com)
- 第一财经
- 证券时报 / 中国证券报

## 港股通港股数据源

### 监管 / 公告
- **HKEX 披露易 (HKEXnews)**: `www1.hkexnews.hk` — 公告 / 招股书 / 通函
- 港股通名单: `hkex.com.hk` 定期更新

### 财务 / 行情
- **Wind** (H-share coverage)
- **Bloomberg** (如 2Mind 有 license)
- **AAStocks** (港股, 部分免费)

### 媒体 / 研究
- 智通财经 (zhitongcaijing.com)
- 港股研究社
- 信报 (HKET)
- 华尔街见闻 (国际部分)

## 接入优先级
1. **HKEX 披露易** (港股) — 公开, 全, 必接
2. **巨潮资讯** (A股) — 公开, 全, 必接
3. **Wind** — 付费, 走 03 terminal-bridge
4. 其他按需

## 凭证管理
- 所有凭证放 `~/.config/vi-agent/credentials.yaml` (不进仓)
- 调 03 terminal-bridge 前注入 env
- 见根 `.gitignore`

## 后续扩展
- 美股 (10-K / 10-Q via SEC)
- 港股非港股通 (国际配售部分)
- A+H 双重上市公司
- 行业垂直数据 (新能源车 / 半导体 / 医药等)

新增数据源走 ADR 流程 (decisions/000N-add-data-source-xxx.md)

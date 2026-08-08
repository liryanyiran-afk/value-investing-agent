# 01-collector/items/

> collection.yaml 的索引, 详细元信息看 `../collection.yaml`

## 优先级图例
- **P0** (must have): 4 份 — 20-F / 6K-Q4 / 6K-Q1-2026 / 424B4
- **P1** (should have): 4 份 — 3 份季报 (Q1-Q3 2025) + F-1/A
- **P2** (nice to have): 3 份 — F-1 原始 / 行业数据 / 媒体覆盖

## 文件清单

| ID | Form | 期间 | 提交日 | 优先级 |
|---|---|---|---|---|
| 20F-FY2025 | 20-F | 2025-12-31 | 2026-04-29 | P0 |
| 6K-2026Q1 | 6-K | 2026-03-31 | 2026-05-29 | P0 |
| 6K-2025Q4 | 6-K | 2025-12-31 | 2026-03-31 | P0 |
| 424B4-FINAL | 424B4 | IPO 2025 | 2025-04-18 | P0 |
| 6K-2025Q3 | 6-K | 2025-09-30 | 2025-11-28 | P1 |
| 6K-2025Q2 | 6-K | 2025-06-30 | 2025-08-29 | P1 |
| 6K-2025Q1 | 6-K | 2025-03-31 | 2025-05-30 | P1 |
| F1A-FINAL | F-1/A | IPO 2025 | 2025-04-14 | P1 |
| F1-ORIG | F-1 | IPO 2025 | 2025-03-25 | P2 |
| PRICE-DAILY | yahoo | 2025-04-17 → 2026-08-08 | — | P0 |
| INDUSTRY-CY2024 | 灼识 | 2024 | — | P1 |
| MEDIA-COVERAGE | web | 2025-2026 | — | P2 |

## raw/ 目录约定

- `raw/` 放原始文件 (PDF/HTML/JSON), **不入仓** (gitignore)
- 02 cleaner 只读 raw/, 输出到 `02-cleaner/`
- 命名: `{id}.{ext}` (例: `20F-FY2025.htm`, `424B4-FINAL.htm`)

## 待办
- [ ] 下载 P0 4 份 (raw/)
- [ ] 下载 P1 4 份 (raw/)
- [ ] 抓 Yahoo Finance 日线 (PRICE-DAILY → raw/price_daily.csv)
- [ ] 02 cleaner 启动后, 从 collection.yaml 读 items, 逐个抽

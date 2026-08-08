# Outputs — 真实跑出来的样本

> 每次完整跑通一个标的, 在这里开一个目录。

## 目录结构
```
outputs/
└── <target>-<date>/
    ├── raw/                # 01 拉来的原始素材 (gitignore)
    ├── cleaned/            # 02 清洗后数据
    ├── analysis.md         # 04 分析结果
    ├── report-final.md     # 05 研报 markdown
    ├── report-final.pdf    # 06 PDF
    ├── deck.pptx           # 06 PPT
    └── onepager.png        # 06 一页纸
```

## 命名
- `<target>`: 股票代码 + 公司名, 例 `0700.HK-腾讯`
- `<date>`: 跑通日期, 例 `2026-08-08`

## 敏感数据
- 内部未公开研报 / 持仓 / 业绩预告 → 不入仓
- 入仓前脱敏: 删掉任何客户/内部人名 / 持仓金额 / 未公开数字
- 公开数据 (招股书 / 公告 / 媒体) 可入仓

## 跑分
每个 output 目录里要带 `eval.md`, 引用 `eval/scores/<date>-<agent>.md`

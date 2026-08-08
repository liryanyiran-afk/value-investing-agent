# 评分体系

> 跑分是 prompt 迭代的唯一真相。

## 目录结构
```
eval/
├── rubric.md          # 评分维度定义 (1-10)
├── scores/            # 每次跑分记录
│   └── <date>-<agent>-v<N>.md
└── benchmarks/        # 头部机构研报 (作对照基准)
    └── <name>-<date>.md
```

## 跑分流程
1. 拿真实标的全流程跑一次
2. 按 `rubric.md` 各维度评分
3. 写 `eval/scores/<date>-<agent>-v<N>.md`
4. PR 关联, 在 PR 描述里写"相对上一版 Δ"

## 评分频率
- prompt 每个新版本必跑
- 标的: 至少 1 个真实 (公开) 标的 + 1 个内部标的 (脱敏后)
- benchmark: 每季度跟头部机构研报对标

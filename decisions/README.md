# Architecture Decision Records (ADR)

> 关键决策按时间顺序归档, 一旦接受就不可修改 (只能新开 ADR supersede)。

## 文件命名
`NNNN-<short-title>.md`, N 是 4 位顺序号。

例: `0001-use-value-investing-framework.md`

## 模板
复制 `0000-template.md` 起新。

## 流程
1. 提 Issue, label `decision-needed`
2. 写 `decisions/NNNN-<title>.md`
3. 描述背景 / 候选方案 / 选择 / 理由 / 后果
4. PR, 双方 review → 合并
5. 合并后, 在 README 索引加一行

## 索引
_暂无_

## 重要决策 (会改变方向的)
- 价值投资方法论选择 (Graham / Buffett / Munger / Marks 等)
- 数据源选择
- 视觉风格定调
- 模板选择
- 是否引入新模块

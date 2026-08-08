# Prompts — 版本管理

> 每个 agent 的 prompt 按版本归档。改一个版本 = 新开一个文件，不覆盖。

## 目录结构
```
prompts/
├── data-collector/
│   ├── v0.1.md
│   ├── v0.2.md
│   └── CHANGELOG.md
├── cleaner/
│   ├── v0.1.md
│   └── CHANGELOG.md
├── ... (其他 agent 同构)
```

## 版本号约定
- `v0.x` — scaffolding 阶段
- `v1.x` — 首次跑通真实标的后稳定
- `v2.x` — 达到头部机构标准

每个版本:
- 独立 md 文件, 自带元信息头
- 在 `CHANGELOG.md` 留一行: 版本 / 日期 / 改了什么 / 跑分

## 改 prompt 流程
1. 从 `main` 拉分支: `prompts/<agent>/v0.2-xxx`
2. 复制 `v0.1.md` 为新版本
3. 改, 顶部写好元信息
4. 拿真实样例跑 (存 `outputs/<sample>/`)
5. 写 `eval/scores/<date>-<agent>.md` 跑分
6. PR, 标题: `[<agent>] prompt v0.2: <一句话改动>`

## 当前状态
所有 agent 都在 `v0.1` placeholder, 待分工后实填。

# Contributing — 协作公约

## 角色
- 2 位核心成员，共同 owner
- 任何决策需至少 1 人 review 后合并

## 主线
- `main` 受保护，必须 PR 合并
- 禁止直接 push `main`

## 分支命名
格式: `<module>/<short-desc>`
- `collector/add-wind-api`
- `analyst/v0.3-add-dcf-block`
- `writer/restruct-template`
- `docs/data-source-update`

## Commit 规范
格式: `[<module>] <action>: <desc>`

- `[collector] prompt: v0.2 add retry logic`
- `[writer] template: 调整"投资建议"章节顺序`
- `[docs] data-sources: 加入港股通名单 v2026Q3`
- `[eval] rubric: 财务分析维度加 2 项`

action 取值: `prompt` / `spec` / `template` / `docs` / `eval` / `chore` / `fix`

## PR 流程
1. 从最新 `main` 拉分支
2. 完成改动 + 在 `prompts/<agent>/` 留版本号
3. 跑一次小测试 (拿真实样例跑一次, 存 output 到 `outputs/<sample>/`)
4. 在 `eval/scores/<date>-<agent>.md` 留一份跑分
5. 提 PR, 描述里写:
   - 改了哪个 agent / 哪个 prompt 版本
   - 相对上一版的关键差异
   - 跑分变化 (前后对比)
   - 关联的 Issue
6. 对方 review → 通过 → 合并
7. 合并后更新 `ROADMAP.md` 状态 + `CHANGELOG.md`

## 决策走 ADR
任何"会改变方向"的决定 (换框架、加模块、改方法论) 走 `decisions/` 流程：
1. 提 Issue, label `decision-needed`
2. 写一份 `decisions/NNNN-<title>.md`, 列出候选 + 选择 + 理由
3. 双方 agree → 合并 ADR

## Issue 三类
- `hypothesis` — 假设待验证 (例: "DCF 估值加入 sensitivity table 能提升说服力")
- `bug` — 出错了 / 输出了明显问题
- `eval-feedback` — 跑分有但想讨论

模板见 `.github/ISSUE_TEMPLATE/`

## 异步沟通节奏
- 不是紧急: 走 GitHub Issue / Discussion
- 紧急: 直接 IM
- 默认 24h 内回复对方留的 PR / Issue

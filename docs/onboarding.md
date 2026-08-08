# Onboarding — 5 分钟上手

> 新成员 (含两人相互补位) 5 分钟内跑通第一次 PR。

## 0. 一次性配 (5 分钟)

### GitHub 账号
- 注册 GitHub 账号, 发 username 给 owner
- owner 加 collaborator (Settings → Collaborators)

### 本地环境
```bash
# 装 gh CLI (macOS)
brew install gh
gh auth login   # 选 HTTPS, 浏览器授权

# 克隆
gh repo clone liryanyiran-afk/value-investing-agent
cd value-investing-agent

# 配 git 身份
git config user.name "你的名字"
git config user.email "你的邮箱"
```

### 数据源凭证 (如要跑 03 terminal-bridge)
- Wind / Choice / iFinD 凭证
- 放 `~/.config/vi-agent/credentials.yaml` (不进仓)
- 模板见 `docs/credentials.template.yaml` (后续补)

## 1. 跑通一次 PR (10 分钟)

目标: 改一个 typo, 提 PR, 让对方合并, 确认流程跑通。

```bash
# 同步最新
git checkout main
git pull

# 拉分支
git checkout -b docs/typo-fix-readme

# 改 README 某个字
echo "" >> README.md  # 或其他无害改动

# 提 PR
git add README.md
git commit -m "[docs] fix: README typo"
git push -u origin docs/typo-fix-readme
gh pr create --title "[docs] fix README typo" --body "流程跑通测试"
```

对方 review → approve → 合并 → 你 `git pull` 同步。

## 2. 接第一个 task

看 `ROADMAP.md`, 选一个 🟡 scaffolding 的 agent, 跟你朋友分工。

## 3. 第一个 prompt 版本 (例: 04 analyst)

```bash
git checkout -b analyst/v0.2-xxx

# 1. 复制 v0.1 模板
cp prompts/analyst/v0.1.md prompts/analyst/v0.2.md

# 2. 改内容 (顶部元信息 + 实际 prompt)
$EDITOR prompts/analyst/v0.2.md

# 3. 拿真实样例跑
# 选 0700.HK 腾讯 2025 年报, 全流程跑
# 输出存 outputs/0700.HK-腾讯/2026-XX-XX/

# 4. 写跑分
cp eval/scores/_template.md eval/scores/2026-XX-XX-analyst-v0.2.md
$EDITOR eval/scores/2026-XX-XX-analyst-v0.2.md

# 5. commit + PR
git add prompts/analyst/v0.2.md eval/scores/... outputs/...
git commit -m "[analyst] prompt v0.2: <一句话改动>"
git push -u origin analyst/v0.2-xxx
gh pr create --title "[analyst] prompt v0.2: <改动>" --body "见 PR 模板"
```

## 4. 跑分卡
- 看 `eval/rubric.md` 评分维度
- 1-10 打分, 加权汇总
- 跟上一版对比, 写 Δ

## 5. 走 ADR
任何"会改变方向"的决定 (换方法论, 加模块), 提 Issue `decision-needed`, 写 `decisions/NNNN-xxx.md`。

## 6. 问问题
- 提 Issue (走模板)
- 紧急: IM
- 看 `docs/workflow.md` 了解更多

## 7. 跑通的标准
- 第一次 PR 成功合并
- 第一次跑分记录入库
- 第一次完整 pipeline (01→02→04→05→06) 端到端跑出 1 个真实标的

完成这 3 步, 协作流就彻底跑通了, 后面就是模块迭代的事。

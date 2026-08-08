# 协作流程详解

> 两人 (Ryan + 朋友) 怎么在 GitHub 上跑通协作。

## 一次性 setup (各人各跑一次)

```bash
# 1. 克隆 repo
gh repo clone liryanyiran-afk/value-investing-agent
cd value-investing-agent

# 2. 配置 git
git config user.name "你的名字"
git config user.email "你的邮箱"

# 3. 配 SSH key (GitHub) 或 PAT
# GitHub Settings → SSH and GPG keys → 新建
# 或 Settings → Tokens → 选 repo scope

# 4. 安装 gh CLI (如有)
brew install gh
gh auth login
```

## 日常流程

### 接到一个 task (例: 改进 analyst prompt)

```bash
# 1. 同步最新
git checkout main
git pull

# 2. 拉分支
git checkout -b analyst/v0.2-add-dcf-block

# 3. 改 prompt
# 编辑 prompts/analyst/v0.2.md (从 v0.1 复制, 改)

# 4. 跑通一次真实样例
# 拿 0700.HK 腾讯跑完整 pipeline
# 输出存 outputs/0700.HK-腾讯/2026-XX-XX/

# 5. 写跑分
# 编辑 eval/scores/2026-XX-XX-analyst-v0.2.md

# 6. commit
git add prompts/analyst/v0.2.md eval/scores/... outputs/...
git commit -m "[analyst] prompt v0.2: 加入 DCF 块"

# 7. push & PR
git push -u origin analyst/v0.2-add-dcf-block
gh pr create \
  --title "[analyst] prompt v0.2: 加入 DCF 块" \
  --body "见 PR 模板, 已附跑分 Δ +5"
```

### 对方 review PR
```bash
# 拉到本地看
gh pr checkout <PR-number>

# 跑一遍验证
# ... 看完跑分, 检查代码/Prompt 改动 ...

# 通过
gh pr review --approve

# 或提修改建议
gh pr review --request-changes --body "L42 改用三档情景而非单点"
```

### 合并
```bash
# 合并后, 同步到本地 main
git checkout main
git pull
```

## 异步沟通

### Issue 三类
- `hypothesis` — 假设待验证
- `bug` — 出错
- `eval-feedback` — 跑分有但想讨论

例:
```bash
gh issue create \
  --template hypothesis.md \
  --title "假设: DCF 估值加入 sensitivity table 能提升说服力"
```

### Discussion
- 临时性讨论 / 想法 / 不需要 action 的
- 走 GitHub Discussions tab

## 紧急
- 走 IM (微信 / WhatsApp), 但事后沉淀到 Issue

## 节奏
- 默认 24h 内回复 PR / Issue
- 周一 / 周三 / 周五 各 sync 一次 (15 分钟, 看 ROADMAP.md + open PRs)
- 月度: 跑分汇总 + 视觉对标 + 决策复盘

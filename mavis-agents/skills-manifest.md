# Skills Manifest

> BitGates Researcher agent 跑起来需要的 skill 清单. 两人 (Ryan + shine040) 都要保证自己 Mavis 都装好.

## 总览

| 类别 | 数量 | 状态 |
|---|---|---|
| 投研核心 | 6 | 全内置 ✅ |
| 研报产出 | 10 | 9 内置, 1 待确认 ⚠️ |
| PDF/数据 | 3 | 全内置 ✅ |
| 协作 | 4 | 全内置 ✅ |
| 质量 | 2 | 全内置 ✅ |
| **总计** | **25** | **24 ✅ 1 ⚠️** |

## 详细清单

### 投研核心 (6/6 ✅)

| Skill | 状态 | 备注 |
|---|---|---|
| `deep-research` | ✅ 内置 | survey-grade 文献调查 |
| `pe-ipo-screening` | ✅ 内置 | 港股 IPO 私募视角筛选 |
| `hkex-ipo-sponsor-analytics` | ✅ 内置 | 港交所保荐人情报 |
| `hk-stock-tracker` | ✅ 内置 | 港股实时行情 |
| `pua` | ✅ 内置 | PUA/try-harder productivity |
| `pre-submission-reviewer` | ✅ 内置 | 提交前 5 维审校 |

### 研报产出 (9/10 ✅, 1 ⚠️)

| Skill | 状态 | 备注 |
|---|---|---|
| `pptx` | ✅ 内置 | python-pptx + PptxGenJS |
| `docx` | ✅ 内置 | Word 文档 |
| `xlsx` | ✅ 内置 | Excel 表格 |
| `imagegen-frontend-web` | ✅ 内置 | 研报封面图生成 |
| `imagegen-frontend-mobile` | ✅ 内置 | 移动端图 |
| `brandkit` | ✅ 内置 | 品牌指南生成 |
| `taste-skill-v1` | ⚠️ **需确认** | spec 写的名字, 实际可能是 `design-taste-frontend-v1`. 跟 Ryan 确认后改成统一名 |
| `high-end-visual-design` | ✅ 内置 | 高端视觉规范 |
| `design-taste-frontend` | ✅ 内置 | UI/UX 强制 |
| `impeccable` | ✅ 内置 | 设计审查 |

### PDF/数据 (3/3 ✅)

| Skill | 状态 | 备注 |
|---|---|---|
| `convert` | ✅ 内置 | markitdown wrapper |
| `pdf` | ✅ 内置 | PyMuPDF 渲染 / 表单 |
| `transcribe` | ✅ 内置 | 音频转写 |

### 协作 (4/4 ✅)

| Skill | 状态 | 备注 |
|---|---|---|
| `agently-mail` | ✅ 内置 | 邮件操作 |
| `lark-tools` | ✅ 内置 | 飞书全套 |
| `gh-address-comments` | ✅ 内置 | GitHub PR 评论 |
| `gh-fix-ci` | ✅ 内置 | GitHub Actions 修复 |

### 质量 (2/2 ✅)

| Skill | 状态 | 备注 |
|---|---|---|
| `full-output-enforcement` | ✅ 内置 | 禁 placeholder |
| `security-best-practices` | ✅ 内置 | 安全审查 |

## 验证 (各人本机跑)

```bash
# 列已装 skill, 看是否有缺
mavis skill list 2>&1 | grep -E "deep-research|pe-ipo|hkex-ipo|hk-stock|pua|pre-sub|pptx|docx|xlsx" | head -20
```

如果发现某个没装:

```bash
# Mavis 7+ 默认带, 缺的话查官方 install
mavis skill install <skill-name>
```

## 待 Ryan 确认

**`taste-skill-v1`** 是不是指:
- (a) `design-taste-frontend-v1` (内置 v1 版)
- (b) 一个新 skill, 需要单独装
- (c) 别的什么

定下来后, 更新 `bitgates-researcher.md` 第 5 节, 统一名字.

## 选装 (非必需, 看场景)

- `wancheng-design-doc` — 万成资本设计系统 (Ryan 已在用)
- `wancheng-design-event` — 万成资本活动物料
- `plan-mode` — 复杂任务先规划
- `define-goal` — 目标定义
- `mavis` — Mavis 自身管理

不是 BitGates 必需, 但 Ryan 的日常工作流里常用.

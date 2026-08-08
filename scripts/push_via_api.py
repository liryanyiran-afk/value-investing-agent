#!/usr/bin/env python3
"""
push_via_api.py — 绕过 github.com 直连封禁, 用 Contents API 推文件到 GitHub.

用法:
  python3 scripts/push_via_api.py                  # 自动检测 git status 里的改动
  python3 scripts/push_via_api.py --all            # 推所有本地文件
  python3 scripts/push_via_api.py README.md agents/01-data-collector.md  # 推指定文件
  python3 scripts/push_via_api.py --message "[docs] my message"           # 自定义 commit msg

依赖:
  - gh CLI 已登录 (gh auth status 验证)
  - 仓库存在且有 admin 权限

原理:
  github.com 主域在本机被网络层拦, 但 api.github.com 通.
  Contents API 走 api.github.com, 所以能 push. 代价:
  - 每个文件一个 commit (历史会碎, scaffold 阶段可接受)
  - 真正线上 git push 还是会卡, 后面如果用 GitHub Pro + Actions, 改用 SSH 走 22 端口代理

什么时候不用这个:
  - 改了大量文件 (>20): 用 --all 一次性, 比一个个 `git add` + push 干净
  - 真要一次性 commit: 上 GitHub Pro / 走 SSH 代理
"""
import subprocess
import sys
import os
import base64
import json
import argparse
from pathlib import Path

REPO_DIR = Path(__file__).resolve().parent.parent
REPO_OWNER = "liryanyiran-afk"
REPO_NAME = "value-investing-agent"
BRANCH = "main"
DEFAULT_COMMIT_MSG = "update via push_via_api.py"

SKIP_PATTERNS = {".git", "scripts/__pycache__"}
BINARY_SKIP_SUFFIX = {".png", ".jpg", ".jpeg", ".gif", ".pdf", ".zip", ".tar", ".gz"}


def run(cmd, **kw):
    return subprocess.run(cmd, capture_output=True, timeout=30, **kw)


def list_local_files() -> list[str]:
    """所有本地文件 (相对仓库根), 排除 .git 和脚本缓存."""
    files = []
    for root, dirs, fnames in os.walk(REPO_DIR):
        dirs[:] = [d for d in dirs if d not in SKIP_PATTERNS]
        for f in fnames:
            full = Path(root) / f
            rel = full.relative_to(REPO_DIR)
            files.append(str(rel))
    return sorted(files)


def git_status_files() -> list[str]:
    """git status --short 里标 M / ?? / A 的文件, 跳过 D (删)."""
    r = run(["git", "-C", str(REPO_DIR), "status", "--short"])
    if r.returncode != 0:
        return []
    out = []
    for line in r.stdout.decode("utf-8", errors="replace").splitlines():
        if not line.strip():
            continue
        # 格式: "XY filename"  X 是 index, Y 是 worktree
        # 关注: M (index or worktree), ?? (untracked), A (added)
        if line.startswith("??"):
            path = line[3:].strip()
        else:
            parts = line.split(maxsplit=1)
            if len(parts) < 2:
                continue
            path = parts[1].strip()
            # 跳过删除的 (D / AD)
            if "D" in parts[0]:
                continue
        if path.startswith('"') and path.endswith('"'):
            path = path[1:-1]
        out.append(path)
    return out


def push_file(rel_path: str, content: bytes, commit_msg: str) -> tuple[bool, str]:
    b64 = base64.b64encode(content).decode("ascii")
    body = {
        "message": commit_msg,
        "content": b64,
        "branch": BRANCH,
    }
    api_path = f"/repos/{REPO_OWNER}/{REPO_NAME}/contents/{rel_path}"

    def call_gh(payload: dict) -> subprocess.CompletedProcess:
        return run(
            ["gh", "api", "-X", "PUT", "--input", "-", api_path],
            input=json.dumps(payload).encode("utf-8"),
        )

    r = call_gh(body)
    if r.returncode == 0:
        return True, "ok"

    stderr = r.stderr.decode("utf-8", errors="replace")
    if "already_exists" in stderr or '"sha"' in stderr and "exists" in stderr.lower():
        # 文件已存在 → 拿 SHA 后 update
        r2 = run(["gh", "api", f"/repos/{REPO_OWNER}/{REPO_NAME}/contents/{rel_path}?ref={BRANCH}"])
        if r2.returncode == 0:
            try:
                sha = json.loads(r2.stdout)["sha"]
            except Exception:
                return False, f"get-sha-parse-fail: {r2.stdout[:200].decode()}"
            body["sha"] = sha
            r3 = call_gh(body)
            if r3.returncode == 0:
                return True, "updated"
            return False, f"update-failed: {r3.stderr[:200].decode()}"
        return False, f"get-sha-failed: {r2.stderr[:200].decode()}"
    return False, f"put-failed: {stderr[:300]}"


def main():
    p = argparse.ArgumentParser(description="Push files to GitHub via Contents API (bypasses github.com block)")
    p.add_argument("files", nargs="*", help="Specific files to push (relative paths)")
    p.add_argument("--all", action="store_true", help="Push ALL files in the repo")
    p.add_argument("--message", "-m", default=DEFAULT_COMMIT_MSG, help="Commit message")
    p.add_argument("--dry-run", action="store_true", help="Show what would be pushed, but don't push")
    args = p.parse_args()

    if args.all:
        targets = list_local_files()
        mode = "all"
    elif args.files:
        targets = args.files
        mode = "explicit"
    else:
        targets = git_status_files()
        mode = "git-status"

    if not targets:
        print(f"模式: {mode} → 无文件可推")
        if mode == "git-status":
            print("提示: git status 没有 M / A / ?? 改动的文件, 跑这个命令没东西推")
            print("      如要推全部, 加 --all")
        return 0

    print(f"模式: {mode} | 目标 {len(targets)} 个文件 | 仓库: {REPO_OWNER}/{REPO_NAME}@{BRANCH}")
    if args.dry_run:
        for f in targets:
            print(f"  [dry-run] {f}")
        return 0
    print()

    ok, fail = 0, 0
    failures = []
    for i, f in enumerate(targets, 1):
        full = REPO_DIR / f
        if not full.exists():
            print(f"  [{i:>2}/{len(targets)}] ✗ {f} (本地不存在)")
            fail += 1
            failures.append(f)
            continue
        # 跳过二进制
        if full.suffix.lower() in BINARY_SKIP_SUFFIX:
            print(f"  [{i:>2}/{len(targets)}] ⏭ {f} (二进制, 跳过)")
            continue
        try:
            content = full.read_bytes()
        except Exception as e:
            print(f"  [{i:>2}/{len(targets)}] ✗ {f} (读取失败: {e})")
            fail += 1
            failures.append(f)
            continue
        success, msg = push_file(f, content, args.message)
        marker = "✓" if success else "✗"
        print(f"  [{i:>2}/{len(targets)}] {marker} {f} ({len(content):,}B, {msg})")
        if success:
            ok += 1
        else:
            fail += 1
            failures.append(f)

    print(f"\n汇总: {ok} 成功 / {fail} 失败 / 总 {len(targets)}")
    if failures:
        print(f"失败文件: {failures}")
    return 0 if fail == 0 else 1


if __name__ == "__main__":
    sys.exit(main())

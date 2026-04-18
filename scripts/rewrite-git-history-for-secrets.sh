#!/usr/bin/env bash
# 過去コミットに含まれる秘密値を履歴から除去する（公開リポジトリ化の前に実行を推奨）。
#
# 前提: git-filter-repo をインストール
#   brew install git-filter-repo
#
# 置換ルール（旧文字列==>新文字列、1行1ペア）はコミットしないこと。
#   scripts/filter-repo-replacements.local.txt に記載（.gitignore 済み）
#
# 使い方:
#   1. リポジトリのバックアップ
#   2. 必要なら filter-repo-replacements.local.txt を作成
#   3. このスクリプトをリポジトリルートで実行
#   4. リモートを付け直して force push
#
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

if ! command -v git-filter-repo >/dev/null 2>&1; then
  echo "git-filter-repo が見つかりません。brew install git-filter-repo などで入れてください。"
  exit 1
fi

FILTER_ARGS=(--force --path ios/GoogleService-Info.plist --invert-paths)

LOCAL_RULES="$ROOT/scripts/filter-repo-replacements.local.txt"
if [[ -f "$LOCAL_RULES" ]]; then
  FILTER_ARGS+=(--replace-text "$LOCAL_RULES")
else
  echo "注意: $LOCAL_RULES が無いため、--replace-text はスキップします（plist のみ履歴から削除）。"
fi

echo "Running git filter-repo (this rewrites ALL commits)..."
git filter-repo "${FILTER_ARGS[@]}"

echo "Done. 次: git remote add origin <url> （filter-repo が remote を外している場合）"
echo "     その後 force push してください。"

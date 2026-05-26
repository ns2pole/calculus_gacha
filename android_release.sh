#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

export LANG="${LANG:-ja_JP.UTF-8}"
export LC_ALL="${LC_ALL:-ja_JP.UTF-8}"
export RUBYOPT="${RUBYOPT:-} -EUTF-8:UTF-8"

if [[ ! -f ".env" ]]; then
  echo "ERROR: .env が見つかりません。REVENUECAT_ANDROID_API_KEY を .env に設定してください。" >&2
  exit 1
fi

set -a
# shellcheck disable=SC1091
source ".env"
set +a

if [[ -z "${REVENUECAT_ANDROID_API_KEY:-}" ]]; then
  echo "ERROR: REVENUECAT_ANDROID_API_KEY が未設定です。" >&2
  exit 1
fi

echo "Android release を開始します。"

if command -v bundle >/dev/null 2>&1 && [[ -f "Gemfile" ]]; then
  bundle exec fastlane android release_all "$@"
else
  fastlane android release_all "$@"
fi

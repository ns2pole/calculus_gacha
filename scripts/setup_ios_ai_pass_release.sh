#!/usr/bin/env bash
# iOS AIチューター Pass リリースの事前セットアップ（App Store Connect IAP 作成）
# 使い方: ./scripts/setup_ios_ai_pass_release.sh
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

export LANG="${LANG:-ja_JP.UTF-8}"
export LC_ALL="${LC_ALL:-ja_JP.UTF-8}"
export RUBYOPT="${RUBYOPT:-} -EUTF-8:UTF-8"

if [[ -f ".env" ]]; then
  set -a
  # shellcheck disable=SC1091
  source ".env"
  set +a
fi

echo "=== iOS AIチューター Pass: App Store Connect IAP 作成 ==="
echo ""

if command -v bundle >/dev/null 2>&1 && [[ -f "Gemfile" ]]; then
  bundle exec ruby scripts/create_ios_ai_tutor_pass_iap.rb
else
  ruby scripts/create_ios_ai_tutor_pass_iap.rb
fi

echo ""
echo "=== あなたがやること（残り）==="
echo "0. App Store Connect → ビジネス → 契約 で Paid Apps Agreement が有効か確認"
echo "1. 契約署名後、再度 ./scripts/setup_ios_ai_pass_release.sh を実行（IAP 未作成なら）"
echo "2. Codemagic → revenuecat_credentials → REVENUECAT_IOS_API_KEY を追加（未設定なら）"
echo "3. Codemagic → ios-app-store-release を実行"
echo "4. 審査提出後、App Store Connect で IAP がバージョンに紐付いているか確認"
echo ""
echo "詳細: docs/IOS_AI_PASS_RELEASE.md"

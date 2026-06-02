#!/usr/bin/env bash
# Codemagic 審査提出用: release_notes.json を生成する。
# Codemagic UI の環境変数で上書き可能（未設定時は Fastfile と同じデフォルト）。
set -euo pipefail

RELEASE_NOTES_JA="${RELEASE_NOTES_JA:-バグ修正と改善を行いました。}"
RELEASE_NOTES_EN="${RELEASE_NOTES_EN:-Bug fixes and improvements.}"
PROMOTIONAL_TEXT_JA="${PROMOTIONAL_TEXT_JA:-ランダム出題で微分積分と物理を効率的に学ぼう！}"
PROMOTIONAL_TEXT_EN="${PROMOTIONAL_TEXT_EN:-Learn calculus and physics efficiently with random questions!}"
SUPPORT_URL="${SUPPORT_URL:-https://www.notion.so/calculus-gacha-joy-math-27ae4f0afd3b80cb9754ce138cbc80ca?source=copy_link}"

export RELEASE_NOTES_JA RELEASE_NOTES_EN PROMOTIONAL_TEXT_JA PROMOTIONAL_TEXT_EN SUPPORT_URL

python3 - <<'PY'
import json
import os

data = [
    {
        "language": "ja",
        "text": os.environ["RELEASE_NOTES_JA"],
        "promotional_text": os.environ["PROMOTIONAL_TEXT_JA"],
        "support_url": os.environ["SUPPORT_URL"],
    },
    {
        "language": "en-US",
        "text": os.environ["RELEASE_NOTES_EN"],
        "promotional_text": os.environ["PROMOTIONAL_TEXT_EN"],
        "support_url": os.environ["SUPPORT_URL"],
    },
]
with open("release_notes.json", "w", encoding="utf-8") as f:
    json.dump(data, f, ensure_ascii=False, indent=2)
    f.write("\n")
PY

echo "=== release_notes.json (App Store 審査提出用) ==="
cat release_notes.json

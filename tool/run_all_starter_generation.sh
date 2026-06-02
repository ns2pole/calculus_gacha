#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT/functions"
export GEMINI_API_KEY="$(firebase functions:secrets:access GEMINI_API_KEY 2>/dev/null | head -1)"
cd "$ROOT"
TOTAL="$(node -e "console.log(JSON.parse(require('fs').readFileSync('tool/starter_problems_manifest.json','utf8')).length)")"
while true; do
  DONE="$(node -e "try{const p=require('./tool/starter_replies_progress.json');console.log(Object.keys(p).length)}catch(e){console.log(0)}")"
  if [ "$DONE" -ge "$TOTAL" ]; then
    echo "All $TOTAL problems generated."
    break
  fi
  echo "Progress: $DONE / $TOTAL"
  node tool/generate-starter-quick-replies.mjs --resume --limit 20 || true
  sleep 2
done

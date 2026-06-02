# 初回 AI チップ（ハードコード）の再生成

## データ

- マニフェスト: `tool/starter_problems_manifest.json`（合同式 mod 除く全ガチャ問題）
- 進捗（git 無視）: `tool/starter_replies_progress.json`
- 生成物: `lib/data/ai_chat/starter_quick_replies_by_problem_id.dart`

## 手順

```bash
# 1. 問題一覧を更新（任意）
python3 tool/export_starter_problems.py

# 2. Functions をビルド
cd functions && npm run build && cd ..

# 3. 全件生成（途中再開可）
export GEMINI_API_KEY="$(cd functions && firebase functions:secrets:access GEMINI_API_KEY 2>/dev/null | head -1)"
./tool/run_all_starter_generation.sh

# または一部だけ
node tool/generate-starter-quick-replies.mjs --resume --limit 10
node tool/generate-starter-quick-replies.mjs --id "YOUR-PROBLEM-UUID"
```

アプリは `AiChatContext.problemId` で `lookupStarterQuickReplies` を参照し、**初回 API は呼びません**。

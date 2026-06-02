# 初回 AI チップの再生成

本番データ: [`lib/data/ai_chat/starter_quick_replies_by_problem_id.dart`](../lib/data/ai_chat/starter_quick_replies_by_problem_id.dart)（227 問）

スクリプト: [`tool/local/ai_starter_codegen/`](local/ai_starter_codegen/)（リポジトリ同梱）

## 再生成の流れ

詳細は [`tool/local/ai_starter_codegen/README_starter_quick_replies.md`](local/ai_starter_codegen/README_starter_quick_replies.md) を参照。

```bash
python3 tool/local/ai_starter_codegen/export_starter_problems.py
cd functions && npm run build && cd ..
export GEMINI_API_KEY="$(cd functions && firebase functions:secrets:access GEMINI_API_KEY 2>/dev/null | head -1)"
./tool/local/ai_starter_codegen/run_all_starter_generation.sh
```

Gemini ロジックは `functions/src/starterQuickReplies.ts`。HTTP の `aiChatStarterReplies` は削除済みです。

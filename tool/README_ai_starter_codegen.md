# 初回 AI チップの再生成（ローカル専用）

生成スクリプトは **git に含めません**（`.gitignore`）。クローン後はこの README の手順で `tool/local/ai_starter_codegen/` を用意してください。

同梱データ: [`lib/data/ai_chat/starter_quick_replies_by_problem_id.dart`](../lib/data/ai_chat/starter_quick_replies_by_problem_id.dart)（227 問）

## 初回セットアップ

既にリポジトリに同梱されている場合は [`tool/local/ai_starter_codegen/`](../tool/local/ai_starter_codegen/) をそのまま使えます。  
別マシンでは、過去コミットから `tool/` 配下の生成スクリプトをコピーするか、チーム内で共有してください。

## 再生成の流れ

詳細は `tool/local/ai_starter_codegen/README_starter_quick_replies.md` を参照。

```bash
python3 tool/local/ai_starter_codegen/export_starter_problems.py
cd functions && npm run build && cd ..
export GEMINI_API_KEY="$(cd functions && firebase functions:secrets:access GEMINI_API_KEY 2>/dev/null | head -1)"
./tool/local/ai_starter_codegen/run_all_starter_generation.sh
```

Functions の `starterQuickReplies.ts`（Gemini 呼び出しロジック）は再生成用に **リポジトリに残しています**。HTTP の `aiChatStarterReplies` は削除済みです。

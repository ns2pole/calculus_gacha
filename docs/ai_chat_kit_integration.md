# ai_chat_kit 統合ガイド

## 概要

`packages/ai_chat_kit` は「1 問に紐づく AI チャット」UI と HTTP クライアントを提供します。問題型・課金・認証はホストアプリがアダプタで渡します。

## joymath での使い方

```dart
JoymathAiChatLauncher.open(
  context: context,
  session: JoymathSessionMapper.fromMathProblem(
    context: context,
    problem: problem,
    problemIndex: idx + 1,
    hintShown: hintShown,
    answerShown: answerShown,
    questionText: questionText,
    referenceAnswer: referenceAnswer,
    referenceSolution: referenceSolution,
  ),
  textRenderer: buildTex,
  initialMessages: history,
  onMessagesChanged: (messages) => saveHistory(messages),
);
```

## 別アプリへの移植チェックリスト

1. `pubspec.yaml` に `ai_chat_kit`（path または git）を追加
2. `AiChatSessionPayload` を組み立てる Mapper を 1 本書く
3. `AiChatHostPorts` を実装（文言・認証ヘッダ・任意の課金 UI・starter チップ）
4. `HttpAiChatClient` + 自アプリの `AI_CHAT_ENDPOINT`
5. `AiChatKit.showSession(...)` を問題画面から呼ぶ
6. iOS: `NSMicrophoneUsageDescription`, `NSSpeechRecognitionUsageDescription`
7. iOS/macOS Podfile: `PERMISSION_MICROPHONE=1`, `PERMISSION_SPEECH_RECOGNIZER=1`（`permission_handler` 用。未設定だと常に拒否扱い）
8. Android: `RECORD_AUDIO`

## 音声入力

- マイクボタン: タップで開始／停止
- モード切替: 自動送信 / 送信ボタンで送る（`SharedPreferences` に保存）
- UI 言語の連携: `MaterialApp` の `Locale`（`Localizations.localeOf`）を基準に、音声認識の `localeId` と API の `locale`（`ja` / `en`）を同じ規則で選択

## HTTP API

リクエスト形式は `AiChatRequestCodec` と `functions/src/requestValidator.ts` を参照。

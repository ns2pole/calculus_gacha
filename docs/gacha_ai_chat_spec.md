# ガチャ AI チャット仕様（ボトムシート）

## 概要

`GachaPage` の各問題カードにある **「AIに聞く」** から、画面下の **ボトムシート** でその問題専用の AI 対話を行う。

- 役割: 答えの代わりではなく、**考える時間を支えるチューター**（方針・ヒント・用語・類題での橋渡し）
- スコープ: **1 ボタン = そのスロットの 1 問専用**（3 問ガチャで会話を混ぜない）
- 将来: **画像送信**（途中式・計算用紙の添削）。Phase 1 では UI/API を拡張しやすい形だけ用意する

**対象画面（Phase 1）**: `lib/pages/gacha/gacha_page.dart`  
**対象外（当面）**: `CongruenceGachaPage`（別仕様で後追い可）

---

## UI: ボトムシート

### 起動

- 「AIに聞く」タップ → `showModalBottomSheet`（または `DraggableScrollableSheet`）
- `isScrollControlled: true`（キーボード時に入力欄が隠れない）
- 初期高さ: 画面の **55〜65%** 程度。ドラッグで拡大可

### レイアウト（上から）

```
┌─────────────────────────────────────┐
│ [─] ドラッグハンドル                  │
│ この問題（折りたたみ可・1行プレビュー）  │  ← MixedTextMath 省略表示
├─────────────────────────────────────┤
│ メッセージ一覧（スクロール）           │
├─────────────────────────────────────┤
│ [📷] 入力欄………………… [送信]            │  ← 📷 は Phase 2 で有効化
└─────────────────────────────────────┘
```

| 領域 | 内容 |
|------|------|
| ヘッダー | タイトル `AIに聞く`、閉じる `×` |
| 問題プレビュー | 問題文の先頭〜N 文字。タップで展開 |
| メッセージ | ユーザー / AI。数式は `MixedTextMath` |
| フッター | テキスト入力、送信、**画像ボタン（Phase 1 は disabled + tooltip）** |

### 初回表示（固定に近い AI 挨拶 + 3 択）

シートを開いた直後、**ユーザー操作なし**で以下を表示する。

1. **AI メッセージ（固定文言・l10n）**

   > 途中式や迷っている点があれば教えてください！  
   > 下から選ぶか、そのまま入力しても大丈夫です。

2. **選択チップ（3 つ）** — タップで即ユーザー発言として送信

   | ID | 表示文言（ja 案） | 送信後の AI モード |
   |----|-------------------|-------------------|
   | `approach_hint` | 問題の解法の方針・ヒントを知りたい | `HintMode.level1` |
   | `easier_analog` | 類題でもう少し簡単に説明してほしい | `AnalogMode` |
   | （なし） | 自由入力のみ | 入力欄 |

3. **テキスト入力欄** — 常に表示

**注意**: 「答えを教えて」系のチップは **置かない**。

### 会話中 UI（Phase 1）

| 要素 | タイミング |
|------|------------|
| 「もう少し詳しく」 | AI がヒント系を返した後。`hintLevel` を +1（最大 3） |
| ローディング | API 待ち中は AI 側にインジケータ |
| エラー | 再試行ボタン + 短い説明 |

---

## 対話フロー

### 全体

```
[開始]
  問題コンテキストを API に渡す（ユーザーは貼らない）
  固定挨拶 + 3 択を UI 表示（AI 生成はしない）

[ラウンド 1〜]
  チップ or 自由入力
    → approach_hint / 方針系の質問 → レベル 1〜3
    → easier_analog → 類題モード
    → 自由入力 → 意図分類して上記いずれか相当で返す

[段階アップ]
  「もう少し詳しく」→ hintLevel +1（答え未表示時は level 3 でも最終答え禁止）

[答え連動]
  アプリで「答えを見る」後 → AnswerRevealed モード（解説補足・別解可）

[終了]
  シートを閉じる。履歴は problemId + slotIndex で保持（Phase 1 はローカルのみ可）
```

### モード別 AI の振る舞い

#### A. 方針・ヒント（`approach_hint` / 自由入力の解法系）

| hintLevel | 返す内容 |
|-----------|----------|
| 1 | 全体の方針・「何を確認するか」 |
| 2 | 次の 1 手の式変形・チェックポイント |
| 3 | 部分式まで（**本問の最終答え・全手順は出さない**） |

返答フォーマット（推奨）:

1. 共感 1 行
2. ヒント本体（箇条書き 2〜3、LaTeX）
3. 確認質問 1 つ

#### B. 類題でもう少し簡単に（`easier_analog`）

| Phase | 内容 |
|-------|------|
| **Phase 1** | プロンプト内の **固定テンプレ例** またはカテゴリ別「簡単例」1 問を提示 → 解説 → 本問への橋渡し 1 行 |
| **Phase 2** | AI がその場で簡単例を生成（品質監視・難度上限をプロンプトで指定） |

**共通ルール**: 本問の **最終答えは出さない**。例題の答えは例題としてのみ。

#### C. 自由入力

- 途中式・迷い・用語 → A 相当
- 「簡単な例で」→ B 相当
- 「答えだけ」→ 下記「拒否テンプレ」

### 拒否・誘導テンプレ

**「答えだけ教えて」等（`answerShown == false`）**

> 答えは画面の「答えを見る」から確認できます。見たあと、分からないところだけ聞いてください。  
> それまでの間は、方針や次の 1 ステップで一緒に進めましょう。

2 回目以降も同趣旨。アプリ UI を優先する。

---

## アプリ状態との連動（必須）

ボトムシートを開く・メッセージ送信のたびに、以下を API / プロンプトに渡す。

| フィールド | 型 | 説明 |
|------------|-----|------|
| `problemId` | String | `MathProblem.id` |
| `slotIndex` | int | 0..2 |
| `prefsPrefix` | String | `integral` 等 |
| `hintShown` | bool | カード上でヒント表示済みか |
| `answerShown` | bool | `_showAnswer[idx]` |
| `hintLevel` | int | 0..3（「もう少し詳しく」で増加） |
| `questionText` | String | `getLocalizedQuestion` 等 |
| `hintText` | String? | `hintShown` のときのみ |
| `answerText` | String? | `answerShown` のときのみ |
| `shortExplanation` | String? | `answerShown` 推奨時のみ |
| `category` / `level` | String | 類題・難度調整用 |

### 開示ルール

| `answerShown` | AI に許可 |
|---------------|-----------|
| `false` | 方針・用語・次の 1 手・類題。 **最終答え・本問の全手順禁止** |
| `true` | 解説の補足・別解・「なぜ」の深掘り。アプリ解説と矛盾する場合は **アプリ側を優先** とプロンプトで指示 |

| `hintShown` | 補足 |
|-------------|------|
| `false` | `hintText` は API に渡さない |
| `true` | 渡す。AI はヒントと矛盾しない |

---

## データモデル（画像拡張を見据える）

### `GachaAiMessage`（案）

```dart
enum GachaAiMessageRole { user, assistant, system }

enum GachaAiAttachmentType { image } // 将来: pdf 等

class GachaAiAttachment {
  final String localPath;      // Phase 1 未使用
  final String? remoteUrl;     // アップロード後
  final String mimeType;
  final int width;
  final int height;
}

class GachaAiMessage {
  final String id;
  final GachaAiMessageRole role;
  final String text;
  final List<GachaAiAttachment> attachments; // 空でも可
  final DateTime createdAt;
  final String? choiceId; // approach_hint | easier_analog | null
}
```

### `GachaAiSession`（案）

```dart
class GachaAiSession {
  final String sessionId;       // uuid
  final String problemId;
  final int slotIndex;
  final String prefsPrefix;
  final List<GachaAiMessage> messages;
  final int hintLevel;
  final DateTime updatedAt;
}
```

**保存キー（案）**: `joymath_simple/gacha_ai/{prefsPrefix}/{problemId}/slot_{slotIndex}`  
アカウント切り替え時は `clearAccountSpecificData` の対象パターンに **後から追加**。

---

## API 設計（実装時）

### Phase 1（テキストのみ）

- エンドポイント: TBD（Cloud Functions / 直接 OpenAI 等）
- リクエスト: `session` + `newUserMessage` + `context`（上表）
- レスポンス: `assistantText`（Markdown/LaTeX 混在可）
- ストリーミング: 任意（Phase 1 は一括でも可）

### システムプロンプト要点

- 日本語・敬体・簡潔
- 数学は LaTeX（`$...$` / `$$...$$`）
- `answerShown == false` なら最終答え禁止
- アプリの `hintText` / 解説と矛盾したらアプリ優先
- 1 ターンあたりの長さ上限（目安 400〜600 字）

### Phase 2（画像・マルチモーダル）

| 項目 | 方針 |
|------|------|
| UI | フッターの 📷 を有効化。ギャラリー + カメラ（`image_picker` 等） |
| 制限 | 1 メッセージ 1〜2 枚、長辺 2048px、JPEG 品質 85、最大 5MB/枚 |
| 送信 | 画像を Storage に upload → URL を API に渡す（base64 直送は避ける） |
| 用途プロンプト | 「途中式・計算用紙の添削。正誤より**誤りの位置と次の 1 手**を指摘」 |
| プライバシー | 利用規約に「画像は AI 解析のため送信」と明記。保持期間 TBD |
| 計算用紙連携 | `ScratchPaperPage` から「AIに聞く」で画像を渡す **共有 Intent**（Phase 2） |

**Phase 1 でやっておくこと**

- `GachaAiMessage.attachments` を常にリストで持つ
- フッターに **disabled の画像ボタン** + `l10n.askAiImageComingSoon` 的 tooltip
- API クライアントのリクエスト型に `attachments: []` を含める

---

## 実装フェーズ

| Phase | 内容 |
|-------|------|
| **1a** | ボトムシート UI、固定挨拶、3 チップ、自由入力、送信スタブ or API 接続 |
| **1b** | コンテキスト連動、`hintLevel`、「もう少し詳しく」、答え表示連動 |
| **1c** | セッションのローカル保存・再開 |
| **2a** | 類題の AI 生成（品質ルール付き） |
| **2b** | 画像添付・マルチモーダル API・添削プロンプト |
| **2c** | 計算用紙からの画像渡し |
| **3** | 利用回数制限・プレミアム・オフライン |

---

## l10n キー（追加予定）

| キー | ja 案 |
|------|-------|
| `askAiSheetTitle` | AIに聞く |
| `askAiGreeting` | 途中式や迷っている点があれば教えてください！\n下から選ぶか、そのまま入力しても大丈夫です。 |
| `askAiChoiceApproach` | 問題の解法の方針・ヒントを知りたい |
| `askAiChoiceAnalog` | 類題でもう少し簡単に説明してほしい |
| `askAiMoreDetail` | もう少し詳しく |
| `askAiSend` | 送信 |
| `askAiPlaceholder` | メッセージを入力 |
| `askAiAnswerUseButton` | （拒否テンプレ全文） |
| `askAiImageComingSoon` | 画像の送信は準備中です |
| `askAiError` | 通信に失敗しました。もう一度お試しください。 |

既存: `askAi`（ボタンラベル）

---

## ファイル構成（実装時の案）

```
lib/
  models/gacha_ai_message.dart
  models/gacha_ai_session.dart
  services/gacha/gacha_ai_chat_service.dart    # API + プロンプト組み立て
  services/gacha/gacha_ai_session_store.dart   # SharedPreferences 等
  widgets/gacha/ai_chat_bottom_sheet.dart      # UI
  pages/gacha/gacha_page.dart                  # onPressed → show sheet
```

---

## テスト観点

- [ ] シート開閉でガチャのスクロール位置が壊れない
- [ ] 3 スロットで別 `sessionId` / `problemId`
- [ ] `answerShown == false` で API モックが最終答えを返さない（プロンプト + 事後チェック任意）
- [ ] ヒント未表示時に `hintText` がリクエストに含まれない
- [ ] 「もう少し詳しく」で `hintLevel` が増え、3 回目以降の挙動
- [ ] 画像ボタン disabled（Phase 1）
- [ ] Phase 2: 画像付きメッセージが履歴に保存・再表示される

---

## 改訂履歴

| 日付 | 内容 |
|------|------|
| 2026-05-25 | 初版（ボトムシート・3 択開始・画像拡張予定） |

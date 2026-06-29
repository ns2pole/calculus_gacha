# プライバシーポリシー — 【極】微積ガチャ！ (Calculus Gacha!)

> **公開ページ（正本）**: [Notion — プライバシーポリシー](https://www.notion.so/calculus-gacha-joy-math-27ae4f0afd3b80cb9754ce138cbc80ca)  
> 本リポジトリの `docs/privacy_policy.md` は実装と同期するための下書きです。内容を変更したら Notion 側も同様に更新してください。  
> 最終更新: 2026-06-03

**【極】微積ガチャ！（以下「当アプリ」）** は、アプリ提供に必要なユーザーデータを取得・保存します。本ポリシーでは、収集・利用される情報、保存先、第三者提供、ユーザーの権利について説明します。

---

## 1. 収集する情報

当アプリは次の情報を収集します。

### ● Firebase Authentication 経由で取得される情報

- **メールアドレス**
- **電話番号**（電話番号認証を利用した場合）
- **認証用 UID**
- **認証プロバイダから提供されるユーザー情報**
  - Sign in with Apple：メールアドレス（初回のみ）、ユーザー識別子
  - Google Sign-In：メールアドレス、表示名、アイコン等

### ● Cloud Firestore に保存されるユーザーデータ

- **認証情報**（UID、メールアドレス、電話番号など）  
  ※メールアドレス・電話番号は主に Firebase Authentication 側で管理され、Firestore には UID をキーとしたユーザーデータが紐づきます。
- **ガチャ設定**（難易度設定、出題履歴）  
  例: `users/{UID}/settings/gacha_settings/gacha_types/{ガチャ種別}`
- **学習記録**（○ / △ / × など）  
  例: `users/{UID}/learning_records/{問題ID}`
- **ユーザーのアプリ内設定、作成データ**（必要な範囲で）  
  例: `users/{UID}/settings/user_settings`、`users/{UID}/settings/other_settings/...`、プレミアム購入状態の設定
- **AI チューターの会話履歴**（問題ごと）  
  ログイン中に AI チューターを利用した場合、メッセージ本文・問題 ID・更新日時を Firestore に保存します（端末内はキャッシュ。Firestore が正本）。  
  例: `users/{Firebase UID}/ai_chat_sessions/{問題ID}`  
  未ログイン時は、端末ごとの **インストール ID** を所有者 ID として同コレクションに保存することがあります（`users/{インストール ID}/ai_chat_sessions/...`）。ログイン後、当該端末の履歴は Firebase UID 配下へ移行されることがあります。1 問題あたり最大 50 メッセージを保持します。  
  **AI の返答（assistant）** については、表示用に整形した本文（`text`）に加え、サーバーで数式修復を行う前の本文（`textRaw`）を保存することがあります。`textRaw` は数式表示の品質改善・不具合調査のために利用し、ユーザーへの表示には用いません。
- **AI 機能の利用上限管理に必要な情報**（利用回数、利用区分など）  
  例: `ai_chat_usage/{ハッシュ化されたキー}`（月次の利用回数、無料 / 有料区分、集計期間、識別情報の種別など）
- **AI チューター Pass 等の購入状態**（購入ごとの有効期限など）  
  例: `users/{Firebase UID}/ai_tutor_passes/{Pass ID}`（商品 ID: `ai_tutor_one_year_500yen_consumable`・消耗型。購入ごとに 500 回・1 年間の枠を保持。買い増し時は古い枠から順に消費）。旧商品 ID `ai_tutor_subsc_500yen` で購入した場合も、サーバー側で同一の Pass 形式（500 回・1 年）として付与・管理します。

### ● AI チューター機能の利用時に送信される情報

AI チューターへの 1 回の送信ごとに、当アプリは **Google Cloud Functions** 経由で **Google Gemini API** に、以下を送信します。

- **ユーザーが入力した質問文**（自由入力およびクイック返信チップの内容）
- **会話履歴**（直近のやり取り。API リクエストに含めて送信）
- **問題文、カテゴリ、レベル、参照解答・参照解説など、回答生成に必要な問題コンテキスト**  
  あわせて、ヒント表示済み / 答え表示済みかどうかの状態を送信することがあります。
- **利用状況管理のための識別情報**（Firebase UID、インストール ID、IP アドレス等のいずれか）  
  サーバー側では、次の優先順で利用者を識別します。  
  1. ログイン済み → Firebase UID（認証トークンから取得）  
  2. 未ログインで端末にインストール ID がある → インストール ID  
  3. 上記がない → IP アドレスをハッシュ化した値  
  リクエスト本文には `clientInstallationId`（インストール ID）を含めます。App Check トークンも送信します。
- **Pass 状態（無料 / 有料）に応じた利用上限判定情報**  
  無料: 月 15 回（日本時間の月単位でリセット）。有料（AI チューター Pass）: 購入ごとに 1 年間 500 回。**無料枠が残っている間は無料枠を優先して消費**し、使い切った後に Pass を消費します。複数 Pass 購入分は合算され、古い購入分から順に消費されます。

**補足（サーバー上の会話本文）**: Cloud Functions は回答生成の処理中に会話内容を扱いますが、**会話履歴の永続保存は Cloud Firestore（および端末内キャッシュ）で行います**。サーバーは応答時に修復前の `textRaw` をクライアントへ渡し、クライアントが Firestore に保存します。Cloud Functions 自体は会話本文を長期保存しません。

### ● 課金情報（RevenueCat による管理）

- 購入状態（サブスクリプションの有効 / 無効）
- 購入履歴（App Store 経由）

※アプリ側にはクレジットカード情報は **一切保存されません**。

### ● 端末内（ローカル）に保存されるデータ

- AI チューターの会話履歴（キャッシュ）
- インストール ID
- 学習記録・設定等（クラウド同期の設定に応じて端末内にも保持）

---

## 2. 保存先および処理者

ユーザーデータは次の事業者のサービスに保存または処理されます。

- **Google Firebase（Google LLC）**
  - Cloud Firestore
  - Firebase Authentication（メール・電話番号認証）
  - Cloud Functions（AI リクエストの中継、利用上限管理、アカウント削除処理）
  - Firebase App Check
- **Google LLC**
  - Gemini API（AI チューター回答生成）
  - Google Sign-In 認証
- **RevenueCat（RevenueCat, Inc.）**
  - 課金状態の管理
- **Apple Inc.**
  - Sign in with Apple 認証
  - App Store 課金処理

---

## 3. データの利用目的

収集した情報は、次の目的のためにのみ使用されます。

- アプリの機能提供および改善
- ログイン認証（メール認証・電話番号認証・外部プロバイダ認証）
- 学習記録や設定データの同期
- AI チューター機能の提供（会話の再開を含む）
- アプリ内課金の状態管理
- AI チューター機能による回答生成
- AI 機能の不正利用防止および利用上限管理
- サブスクリプション状態に応じた機能提供の制御

**広告目的のトラッキングには使用しません。**

---

## 4. 第三者提供

当アプリは、収集したユーザーデータを以下の事業者に保存または処理しますが、

### ✔ マーケティング目的で第三者に販売・共有することはありません。

提供先：

- Google LLC（Firebase / Gemini / Google Sign-In）
- RevenueCat, Inc.
- Apple Inc.

AI チューター利用時に送信されたテキストおよび問題コンテキストは、回答生成のため Google（Gemini API）のサーバーで処理されます。各事業者のプライバシーポリシーもあわせてご確認ください。

---

## 5. データ保有期間

ユーザーデータは、ユーザーのアカウントが存在する限り保持されます。

AI チューター機能に関連するデータは次のとおりです。

- **会話履歴**: ログイン中（または未ログイン時のインストール ID 配下）に Cloud Firestore および端末内に保持。問題ごとに最大 50 メッセージ。
- **利用上限管理**: `ai_chat_usage` に利用回数等を保持（無料は月次、Pass は購入単位ごと）。
- **Gemini API への送信データ**: 回答生成処理のため Google のサーバーで処理されます。保持期間は Google のポリシーに従います。

Cloud Functions 上では、会話本文を永続保存せず、利用上限管理に必要な情報（利用回数等）を Firestore に保存します。

ユーザーがアカウント削除を実行した場合、合理的な期間内に Firebase UID に紐づく関連データ（会話履歴・学習記録・設定等を含む `users/{UID}` 配下）を削除します。

---

## 6. データ削除とお問い合わせ

当アプリは、アプリ内からアカウント削除を申請できる機能を提供しています。

アカウント削除が完了すると、当アプリで管理する当該アカウントに紐づくデータは合理的な期間内に削除されます。

未ログイン時にインストール ID 配下へ保存された会話履歴・利用回数は、端末のアプリ削除により端末内キャッシュは消去されますが、Cloud Firestore 上に残る場合があります。

データの閲覧・訂正・削除（AI 関連データを含む）の要望は、以下のメールアドレスにご連絡ください。

📧 **spaceofstar2@gmail.com**

---

## 7. アプリ内解析ツールについて

当アプリでは、以下の通りです。

- **アプリ内で Firebase Analytics（自動収集機能）は使用していません。**
- 必要以上の行動トラッキングは行いません。
- RevenueCat により、アプリの利用状況（サブスクリプション状態、アプリ起動回数などの匿名の使用データ）が収集される場合があります。これらは課金機能の提供およびアプリ改善のためにのみ利用されます。

---

## 付録: 実装との対応（開発者向け）

| 区分 | 主な保存先 / 送信先 |
|------|---------------------|
| 認証 | Firebase Authentication |
| ガチャ設定 | `users/{uid}/settings/gacha_settings/gacha_types/{gachaType}` |
| 学習記録 | `users/{uid}/learning_records/{problemId}` |
| アプリ設定 | `users/{uid}/settings/...` |
| AI 会話履歴 | `users/{uid or installationId}/ai_chat_sessions/{problemId}` |
| AI 利用回数 | `ai_chat_usage/{hash}` |
| AI Pass 状態 | `users/{uid}/ai_tutor_passes/{passId}` |
| AI 推論リクエスト | Cloud Functions `aiChat` → Gemini API |

関連実装: `lib/services/ai/ai_chat_session_store.dart`、`lib/services/auth/firestore_ai_chat_service.dart`、`functions/src/auth.ts`、`functions/src/rateLimiter.ts`、`FIRESTORE_SECURITY_RULES.md`

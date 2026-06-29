# iOS AIチューター Pass リリース（最小手順）

Android 済み・Codemagic リリース前提。

## あなたがやること

### 0. App Store Connect の契約を署名（未完了なら必須）

App Store Connect → **ビジネス** → **契約** で **Paid Apps Agreement**（有料アプリ契約）が **有効** になっていることを確認。  
未署名だと IAP 作成 API が 403 で拒否される。

### 1. IAP を自動作成（1 回だけ）

手元 Mac で:

```bash
./scripts/setup_ios_ai_pass_release.sh
```

必要: App Store Connect API キー（`.p8`）。Codemagic と同じ `AuthKey_ATBD5UGJTG.p8` を  
`~/.appstoreconnect/private_keys/` に置くか、`.env` に `ASC_PRIVATE_KEY` を貼る。

スクリプトが App Store Connect に以下を作成する:

- 製品 ID: `ai_tutor_one_year_500yen_consumable`
- タイプ: 消耗型
- 価格: ¥500
- 日本語 / 英語の表示名・説明

### 2. Codemagic に Secret を 1 つ追加（未設定なら）

| グループ | Secret | 値 |
|---------|--------|-----|
| `revenuecat_credentials` | `REVENUECAT_IOS_API_KEY` | RevenueCat の iOS Public Key（`appl_`） |

`appstore_credentials` / `firebase_credentials` は既存のまま。

RevenueCat で App Store Connect API が繋がっていれば、IAP 作成後に Product が自動同期される。  
未同期なら Entitlement `ai_tutor_one_year_consumable` と Offering `default` に紐付ける。

### 3. Codemagic でビルド

ワークフロー **`ios-app-store-release`** を実行。

審査提出後、App Store Connect で **App内課金** が新バージョンに紐付いているか確認（未紐付けなら手動追加）。

---

## リポジトリ側で済んでいること

- `codemagic.yaml`: `AI_CHAT_ENDPOINT` / `REVENUECAT_IOS_API_KEY` の dart-define
- `Info.plist`: マイク・音声認識の用途説明
- `Podfile`: 音声入力パーミッション
- `Runner.entitlements`: Sign in with Apple
- `Products.storekit`: ローカル StoreKit テスト用に AI Pass 登録済み

## 審査用メモ（コピペ用）

```
Sandbox テスター: （あなたの Sandbox アカウント）

AIチューター Pass の確認手順:
1. アプリを起動し Google または Apple でログイン
2. 任意の問題から AI チャットを開く
3. 無料枠上限に達するか、Pass 購入画面から「AIチューター Pass」を購入
4. 購入後、AI チャットが利用可能になることを確認
```

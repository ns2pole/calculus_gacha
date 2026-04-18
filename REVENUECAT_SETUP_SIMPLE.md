# RevenueCat設定ガイド（簡潔版）

## 設定の流れ

1. **App Store Connectでアプリ内課金を作成** → RevenueCat設定 → **アプリバージョンと一緒に提出**

---

## 1. App Store Connectでアプリ内課金を作成

### iOS
1. App Store Connect → アプリ選択 → 「機能」→「App内課金」
2. 「+」→「App内課金アイテムを作成」
3. **製品ID**: `indefinite_equation_option_160yen`
4. **タイプ**: 非消耗型
5. **価格**: ¥160
6. **表示名**: 不定方程式オプション
7. **説明**: 不定方程式ガチャを利用可能にします
8. メタデータ入力後、「送信準備完了」にする（**まだ提出しない**）

### Android
1. Google Play Console → アプリ選択 → 「収益化」→「アプリ内商品」
2. 「商品を作成」
3. **商品ID**: `indefinite_equation_option_160yen`
4. **タイプ**: 管理対象の商品（非消耗型）
5. **価格**: ¥160
6. **名前**: 不定方程式オプション
7. **説明**: 不定方程式ガチャを利用可能にします
8. 「有効」にする

---

## 2. RevenueCatダッシュボードで設定

### 2.1. アプリ追加（初回のみ）
1. [RevenueCat](https://app.revenuecat.com/)にログイン
2. プロジェクト作成 → 「+ Add App」
3. **iOS**: Bundle ID `com.joymath`
4. **Android**: Package Name `com.joymath`

### 2.1.5. App Store Connect API認証情報の設定（重要！）

**エラー「Connection issue. Make sure the App Store Connect API credentials are configured properly.」が出た場合、この設定が必要です。**

1. **App Store ConnectでAPIキーを作成**
   - [App Store Connect](https://appstoreconnect.apple.com/)にログイン
   - 「ユーザーとアクセス」→「キー」タブをクリック
   - 「+」ボタンで新しいキーを生成
   - **キー名**: RevenueCat（任意の名前）
   - **アクセス**: 「管理者」または「App管理」を選択
   - 「生成」をクリック
   - **重要**: キーファイル（.p8）をダウンロード（後で再ダウンロードできない）
   - **キーID**と**発行者ID**をメモ

2. **RevenueCatダッシュボードで認証情報を設定**
   - RevenueCatダッシュボードでアプリを選択
   - 「**Settings**」タブをクリック
   - 「**App Store Connect API**」セクションを探す
   - 以下の情報を入力：
     - **Key ID**: App Store Connectで取得したキーID
     - **Issuer ID**: App Store Connectで取得した発行者ID
     - **Private Key**: ダウンロードした.p8ファイルの内容をコピー＆ペースト
   - 「**Save**」をクリック

3. **確認**
   - 数秒待ってから、Productsページを再読み込み
   - エラーが消えていれば成功

### 2.2. APIキー取得
1. RevenueCatダッシュボードの左サイドバーで「**API Keys**」をクリック
2. 画面に表示されるAPIキー一覧から：
   - **iOS用**: 「iOS」セクションの「**Public API Key**」（`appl_`で始まる）をコピー
   - **Android用**: 「Android」セクションの「**Public API Key**」（`goog_`で始まる）をコピー
3. `lib/services/revenuecat_service.dart`を開く
4. 以下の行を探して、コピーしたキーに置き換え：
   ```dart
   static const String _iosApiKey = 'YOUR_IOS_API_KEY';  // ここにiOSのPublic API Keyを貼り付け
   static const String _androidApiKey = 'YOUR_ANDROID_API_KEY';  // ここにAndroidのPublic API Keyを貼り付け
   ```

### 2.3. Products追加（RevenueCatダッシュボード → Products画面）

**重要**: ここで設定する「**Store Product ID**」が、App Store Connectで設定した製品IDと一致する必要があります。

**画面**: RevenueCatダッシュボードの「Products」ページ

1. 左サイドバーで「**Products**」をクリック（Products一覧画面が開く）
2. 右上の「**+ Add**」または「**New Product**」ボタンをクリック（商品追加フォームが開く）
3. フォームに入力：
   - **Identifier**: `indefinite_equation_option_160yen`（RevenueCat内での識別子、自由に決められる）
   - **Store**: ドロップダウンから「**App Store**」を選択（iOS用）
   - **Store Product ID**: `indefinite_equation_option_160yen`（**ここが重要！App Store Connectで設定した製品IDと完全に一致させる**）
4. 「**Add Product**」をクリック（iOS用の商品が追加される）
5. **Android用も追加**: もう一度「**+ Add**」をクリックして、同じIdentifierで**Store**だけ「**Google Play Store**」を選択して追加
   - **Store Product ID**も同じ`indefinite_equation_option_160yen`にする（Google Play Consoleで設定した商品IDと同じ）

**⚠️ 「Store Product IDが見つからない」エラーが出た場合**

RevenueCatダッシュボードで「Store Product IDが見つからない」というエラーが出る場合、以下の手順を確認してください：

**注意**: StoreKit Configurationファイルをインポートできている場合、App Store Connect API認証情報は正しく設定されています。以下の原因を確認してください：

1. **アプリ内課金のステータスを確認（最も重要！）**
   - App Store Connect → アプリ選択 → 「機能」→「App内課金」
   - `indefinite_equation_option_160yen`のステータスを確認
   - **「下書き」のままの場合は、「送信準備完了」に変更してください**
   - RevenueCatは「送信準備完了」状態の商品しか認識しません
   - ステータス変更後、数分待ってから再度試してください（反映に時間がかかることがあります）

2. **App Store Connectでアプリ内課金が作成されているか確認**
   - App Store Connect → アプリ選択 → 「機能」→「App内課金」
   - `indefinite_equation_option_160yen`という製品IDの商品が存在するか確認
   - 存在しない場合は、**1. App Store Connectでアプリ内課金を作成**の手順を実行してください

3. **製品IDのタイポを確認**
   - App Store Connectで設定した製品IDをコピー＆ペーストして使用してください
   - 手入力の場合、スペースや大文字小文字の違いがないか確認してください
   - 正しい製品ID: `indefinite_equation_option_160yen`（すべて小文字、アンダースコア区切り）

4. **RevenueCatダッシュボードを再読み込み**
   - ブラウザでページを再読み込み（Cmd+R / Ctrl+R）
   - または、RevenueCatダッシュボードから一度ログアウトして再度ログインしてください
   - ステータス変更後は、数分待ってから再度試してください

**⚠️ シミュレーターで商品情報が取得できない場合（200円が表示される）**

シミュレーターでアプリを起動して、価格が200円（フォールバック値）で表示される場合、以下の確認を行ってください：

**確認すべきポイント**:

1. **XcodeスキームでStoreKit Configurationファイルが設定されているか（最重要！）**
   - Xcodeでプロジェクトを開く（`ios/Runner.xcworkspace`を開く）
   - 上部のスキーム選択から「**Edit Scheme...**」を選択（または「Product」→「Scheme」→「Edit Scheme...」）
   - 「**Run**」タブを選択
   - 「**Options**」タブを開く
   - 「**StoreKit Configuration**」セクションで`Products.storekit`が選択されているか確認
   - 選択されていない場合：
     - ドロップダウンをクリック
     - 「**Products.storekit**」を選択
     - 「**Close**」をクリック
   - **重要**: シミュレーターで実行する場合、この設定が必須です

2. **Products.storekitファイルがXcodeプロジェクトに追加されているか**
   - Xcodeのプロジェクトナビゲーター（左側のファイル一覧）で`ios/Runner/Products.storekit`が表示されているか確認
   - 表示されていない場合：
     - Xcodeで「**File**」→「**Add Files to "Runner"...**」を選択
     - `ios/Runner/Products.storekit`を選択
     - 「**Add**」をクリック
   - **重要**: ファイルがXcodeプロジェクトに追加されていないと、スキームで選択できません

3. **Products.storekitファイルの内容を確認**
   - `ios/Runner/Products.storekit`を開く
   - `indefinite_equation_option_160yen`の`productID`が正しく設定されているか確認
   - `displayPrice`が`"160"`になっているか確認

4. **アプリを再ビルド**
   - Xcodeで「**Product**」→「**Clean Build Folder**」（Shift+Cmd+K）
   - その後、アプリを再ビルド＆実行してください
   - **重要**: スキーム設定を変更した後は、必ず再ビルドしてください

5. **RevenueCatダッシュボードでProductが追加されているか（重要！）**
   - シミュレーターでも、RevenueCat SDKはRevenueCatダッシュボードでProductが登録されている必要があります
   - RevenueCatダッシュボード → 「Products」ページ
   - `indefinite_equation_option_160yen`（App Store）が追加されているか確認
   - 追加されていない場合は、**2.3. Products追加**の手順を実行してください
   - **重要**: 「Store Product IDが見つからない」エラーが出ても、商品は追加できることがあります。エラーを無視して「Add Product」をクリックしてみてください

**⚠️ 実機で商品情報が取得できない場合（200円が表示される）**

実機でアプリを起動して、価格が200円（フォールバック値）で表示される場合、RevenueCatダッシュボードの設定が不完全です。

**確認すべきポイント**:

1. **RevenueCatダッシュボードでProductが追加されているか**
   - RevenueCatダッシュボード → 「Products」ページ
   - `indefinite_equation_option_160yen`（App Store）が追加されているか確認
   - 追加されていない場合は、**2.3. Products追加**の手順を実行してください
   - **重要**: 「Store Product IDが見つからない」エラーが出ても、商品は追加できることがあります。エラーを無視して「Add Product」をクリックしてみてください

2. **EntitlementsにProductが紐付けられているか**
   - RevenueCatダッシュボード → 「Entitlements」ページ
   - `indefinite_equation_option`をクリック
   - 「Products」セクションに`indefinite_equation_option_160yen`（App Store）が追加されているか確認
   - 追加されていない場合は、**2.4. Entitlements作成**の手順を実行してください

3. **OfferingsにPackageが追加されているか**
   - RevenueCatダッシュボード → 「Offerings」ページ
   - 「Default Offering」をクリック
   - 「Packages」タブで、`indefinite_equation_option_package`が追加されているか確認
   - 追加されていない場合は、**2.5. Offerings設定**の手順を実行してください

4. **OfferingsがActiveになっているか**
   - RevenueCatダッシュボード → 「Offerings」ページ
   - 「Default Offering」の「Status」が「Active」になっているか確認
   - 「Inactive」の場合は、「Active」に変更してください

**重要**: 実機ではStoreKit Configurationファイルは使われません。RevenueCatダッシュボードでProduct、Entitlements、Offeringsが正しく設定されている必要があります。

**⚠️ 商品追加後の状態について**

商品を追加した後、以下のようなメッセージが表示されることがあります：
- **「Action is needed from the developer before a product can be made available to users (state: "READY_TO_SUBMIT")」**
- **「必要なメタデータはすべてアップロードされましたが、まだレビューのためにAppleに送信していません。」**
- **「Learn more or Open in App Store Connect」**

これは**正常な状態**です。意味は：
- App Store Connectでアプリ内課金が「**送信準備完了**」状態になっている
- まだ提出されていない（アプリバージョンと一緒に提出する必要がある）
- **この状態でも、RevenueCat SDKで商品情報を取得できるはずです**

**対処方法**:
- このメッセージは無視してOKです
- 次のステップ（Entitlements、Offerings設定）に進んでください
- 最終的にアプリバージョンと一緒に提出すれば、この状態は解消されます

**⚠️ 「送信準備完了」状態でも商品情報が取得できない場合**

「送信準備完了」状態であれば、RevenueCat SDKで商品情報を取得できるはずです。それでも200円（フォールバック値）が表示される場合、以下の確認を行ってください：

1. **RevenueCatダッシュボードでProductが正しく追加されているか**
   - RevenueCatダッシュボード → 「Products」ページ
   - `indefinite_equation_option_160yen`（App Store）が表示されているか確認
   - 商品をクリックして、**Store Product ID**が`indefinite_equation_option_160yen`になっているか確認
   - **重要**: 「Store Product IDが見つからない」エラーが出ていても、商品は追加されていることがあります。商品一覧に表示されていればOKです

2. **シミュレーターの場合: StoreKit Configurationファイルの確認**
   - XcodeスキームでStoreKit Configurationファイルが設定されているか確認（**2.5. Offerings設定**の手順を参照）
   - `ios/Runner/Products.storekit`ファイルがXcodeプロジェクトに追加されているか確認

3. **Offeringsに設定する（推奨）**
   - Offeringsに設定しなくても動作する場合がありますが、設定すると取得が確実になります
   - **2.5. Offerings設定**の手順を実行してください

4. **デバッグログを確認**
   - アプリを実行して、Xcodeのコンソールに以下のようなログが出ているか確認：
     - `RevenueCat: Calling Purchases.getProducts() now...`
     - `RevenueCat: getProducts returned X products`
   - 0件の場合は、RevenueCatダッシュボードでProductが認識されていません

### 2.4. Entitlements作成（RevenueCatダッシュボード → Entitlements画面）

**重要**: EntitlementのIdentifierは、コード内（`revenuecat_service.dart`）で使用する識別子です。自由に決められますが、コードと一致させる必要があります。

**⚠️ 必須**: コードではエンタイトルメント `'indefinite_equation_option'` で購入状態を確認しているため、**EntitlementsにProductを紐付ける必要があります**。紐付けていないと、購入状態が正しく判定されません。

**画面**: RevenueCatダッシュボードの「Entitlements」ページ

1. 左サイドバーで「**Entitlements**」をクリック（Entitlements一覧画面が開く）
2. 右上の「**+ Add**」または「**New Entitlement**」ボタンをクリック（Entitlement追加フォームが開く）
3. フォームに入力：
   - **Identifier**: `indefinite_equation_option`（**コード内で使用する識別子。`revenuecat_service.dart`の`indefinite_equation_option`と一致させる**）
   - **Display Name**: 不定方程式オプション
4. 「**Add Entitlement**」をクリック（Entitlementが作成される）
5. 作成したEntitlement（`indefinite_equation_option`）をクリック（詳細ページが開く）
6. 詳細ページの「**Products**」セクション（または「**Associated Products**」セクション）で「**+ Add Product**」ボタンをクリック
7. ドロップダウンから商品を選択：
   - `indefinite_equation_option_160yen`（App Store）を選択
   - もう一度「**+ Add Product**」をクリックして、`indefinite_equation_option_160yen`（Google Play Store）も選択
8. 「**Save**」ボタンをクリック（変更を保存）

**重要**: EntitlementsにProductを紐付けないと、購入状態が正しく判定されません。必ず紐付けてください。

### 2.5. Offerings設定（RevenueCatダッシュボード → Offerings画面）

**重要**: 
- **OfferingのIdentifier**（`default`）: RevenueCat内での識別子。自由に決められる。App Store Connectとは無関係。
- **PackageのIdentifier**（`indefinite_equation_option_package`）: RevenueCat内での識別子。自由に決められる。App Store Connectとは無関係。
- **App Store Connectと一致させる必要があるのは、Products設定の「Store Product ID」だけです。**

**画面**: RevenueCatダッシュボードの「Offerings」ページ

1. 左サイドバーで「**Offerings**」をクリック
2. 「**Default Offering**」が表示されているか確認
   - **なければ**: 「**+ New Offering**」をクリック
     - **上部の「Identifier」欄**（Offering用）に: `default` を入力（**RevenueCat内での識別子、自由に決められる**）
     - **「Display Name」欄**に: デフォルトオファリング を入力
     - 「**Create Offering**」をクリック
3. 「**Default Offering**」をクリック（詳細ページが開く）
4. タブが「**Packages**」になっていることを確認（なっていなければクリック）
5. 右上の「**+ New Package**」ボタンをクリック（パッケージ追加フォームが開く）

---

## 📝 パッケージ追加フォームの入力方法（画面のどこに何を入力するか）

**注意**: Identifierが2つあります！
- **上部のIdentifier**: Offering用（`default`。RevenueCat内での識別子、自由に決められる）
- **下部のIdentifier**: Package用（`indefinite_equation_option_package`。RevenueCat内での識別子、自由に決められる）

画面に表示されるフォームで、以下のように入力してください：

### ① PackageのIdentifier（必須）欄
- **場所**: パッケージフォーム内（白いカードの中）、「Identifier」というラベルがあるドロップダウン
- **操作**: ドロップダウンをクリック
- **選択内容**: ドロップダウンメニューが開いたら、一番下の「**Custom**」を選択
  - （Monthly、Annual、Six Months、Three Months、Two Months、Weekly、Lifetimeの下に区切り線があり、その下に「Custom」があります）
- **入力内容**: 「Custom」を選択すると入力欄が表示されるので、`indefinite_equation_option_package` と入力
- **注意**: 上部のOffering用Identifierとは別物です

### ② Description（必須）欄
- **場所**: パッケージフォーム内、「Identifier」の下、「Description」というラベルがあるテキスト入力欄
- **入力内容**: `不定方程式利用オプション` と入力
- **注意**: 赤い枠線が表示されている場合は必須入力です

### ③ Productsセクション
- **場所**: パッケージフォーム内、「Description」の下、「Products」というセクション
- **表示内容**: 2つのストアが表示されます

#### ③-1. Test Store（BSアイコン）
- **場所**: Productsセクションの1つ目、「Test Store」と表示されている行
- **操作**: 右側のドロップダウンは「**No product**」のままにしておく（変更不要）

#### ③-2. Apple Store（Appleロゴ）
- **場所**: Productsセクションの2つ目、Appleロゴと「【極】 微積ガチャ!」と表示されている行
- **操作**: 右側のドロップダウンをクリック
- **選択内容**: 「**不定方程式ガチャ利用オプション**」を選択
  - これが`indefinite_equation_option_160yen`の商品です

### ④ Saveボタン
- **場所**: 画面の右下、青色の「**Save**」ボタン
- **操作**: すべて入力したら「**Save**」をクリック

---

6. パッケージが追加されたら、ページ上部の「**Status**」が「**Active**」になっているか確認
   - 「Inactive」になっていれば、「**Active**」に変更

---

## 3. テスト（実機でテスト）

**重要**: 実機でテストしますが、**Sandboxテスターアカウント（テスト用Apple ID）**を使用します。本番環境のApple IDでテストすると、実際に課金が発生してしまいます。

### iOS
1. App Store Connect → 「ユーザーとアクセス」→「Sandboxテスター」でテストアカウント作成
2. **実機に接続してアプリをビルド＆実行**（Xcodeから実機に直接インストール）
3. 不定方程式ガチャをタップ → 購入ダイアログ表示 → **Sandboxアカウントでログインして購入**
   - **注意**: 本番環境のApple IDでは実際に課金が発生します！
4. RevenueCatダッシュボードの「Customers」で購入状態を確認

### Android
1. Google Play Console → 「設定」→「ライセンステスト」でテストアカウント追加
2. **実機に接続してアプリをビルド＆実行**
3. 不定方程式ガチャをタップ → 購入ダイアログ表示 → テストアカウントで購入
4. RevenueCatダッシュボードの「Customers」で購入状態を確認

---

## 4. アプリバージョンと一緒に提出

### iOS
1. App Store Connect → アプリ → 「バージョン」
2. 新しいバージョンを作成（または既存を選択）
3. 「App内課金とサブスクリプション」で`indefinite_equation_option_160yen`を選択
4. バイナリ（.ipa）をアップロード
5. 「審査に提出」

**重要**: 最初のアプリ内課金は、アプリバージョンと一緒に提出が必要。審査通過後は追加のアプリ内課金は直接提出可能。

---

## トラブルシューティング

- **「Store Product IDが見つからない」**: 
  - **最も重要**: アプリ内課金のステータスが「送信準備完了」になっているか確認（「下書き」のままでは認識されません）
  - App Store Connectでアプリ内課金が作成されているか確認
  - 製品IDのタイポがないか確認（コピー＆ペースト推奨）
  - ステータス変更後、数分待ってから再度試してください
  - RevenueCatダッシュボードを再読み込み
- **「Product not found」**: App Store Connectで「送信準備完了」になっているか確認
- **「No offerings available」**: RevenueCatでオファリングが「Active」か確認
- **購入状態が反映されない**: RevenueCatダッシュボードの「Customers」で確認
- **「CONFIGURATION_ERROR: None of the products registered in the RevenueCat dashboard could be fetched from App Store Connect」**: 
  - **シミュレーター/ローカルテストの場合**: StoreKit Configurationファイルが必要です
    - `ios/Runner/Products.storekit`ファイルが作成されています
    - Xcodeでプロジェクトを開き、`Products.storekit`ファイルをプロジェクトに追加してください
    - スキームの「Edit Scheme」→「Run」→「Options」タブで「StoreKit Configuration」に`Products.storekit`を選択してください
  - **実機テストの場合**: App Store Connectでアプリ内課金が正しく設定されているか確認してください

---

## 商品ID一覧

- `indefinite_equation_option_160yen` - 不定方程式オプション（¥160）
- `factorization_double_option_80yen` - 因数分解オプション（¥80、既存）

---

## 📋 設定完了後の流れ

### ステップ1: テスト（実機でテスト）

**目的**: 購入機能が正しく動作するか確認

**重要**: 実機でテストしますが、**Sandboxテスターアカウント（テスト用Apple ID）**を使用します。本番環境のApple IDでテストすると、実際に課金が発生してしまいます。

1. **Sandboxテスターアカウントを作成**
   - App Store Connect → 「ユーザーとアクセス」→「Sandboxテスター」
   - 「+」ボタンで新しいSandboxテスターを作成
   - **メールアドレス**: テスト用のメールアドレス（実在する必要はない、例: `test@example.com`）
   - **パスワード**: 任意のパスワード
   - **名前**: 任意の名前
   - 「作成」をクリック

2. **アプリをビルドして実機で実行**
   - Xcodeで実機に接続
   - ビルド＆実行（実機でアプリが起動する）
   - または、TestFlightで配布してテスト

3. **購入フローをテスト**
   - アプリを起動（実機上）
   - 「おまけガチャ」ページを開く
   - 「不定方程式ガチャ」カードをタップ（ロック中）
   - 購入ダイアログが表示されることを確認
   - **Sandboxアカウントでログイン**（初回のみ）
     - 上記で作成したSandboxテスターアカウントのメールアドレスとパスワードを入力
     - **注意**: 本番環境のApple IDでは実際に課金が発生します！
   - 購入を完了（Sandbox環境では実際の課金は発生しない）
   - 不定方程式ガチャが利用可能になることを確認
   - 不定方程式ガチャ問題一覧も利用可能になることを確認

4. **購入状態の確認**
   - RevenueCatダッシュボード → 「Customers」を開く
   - テストユーザー（Sandboxアカウント）を検索
   - 購入履歴とエンタイトルメントの状態を確認

### ステップ2: アプリバージョンと一緒に提出

**重要**: 最初のアプリ内課金は、アプリバージョンと一緒に提出する必要があります。

1. **App Store Connectでアプリバージョンを作成**
   - App Store Connect → アプリ選択 → 「バージョン」タブ
   - 「+」ボタンで新しいバージョンを作成（例: 1.1.0）

2. **アプリ内課金を紐付け**
   - バージョン詳細ページで「App内課金とサブスクリプション」セクションを探す
   - `indefinite_equation_option_160yen`を選択

3. **バイナリをアップロード**
   - Xcodeからアーカイブしてアップロード
   - または、Fastlaneを使用

4. **App Reviewに提出**
   - すべての情報を入力後、「審査に提出」をクリック
   - 最初のアプリ内課金は、このバージョンと一緒に審査される

### ステップ3: 審査通過後

- アプリがリリースされると、アプリ内課金も利用可能になります
- 追加のアプリ内課金（例: `factorization_double_option_80yen`）は、「App内課金」セクションから直接提出可能（アプリバージョンと一緒に提出する必要はない）

---

## 💰 課金の流れ（ユーザー視点）

### 1. ユーザーがアプリを開く
- アプリを起動
- 「おまけガチャ」ページに移動

### 2. 不定方程式ガチャを発見
- 「不定方程式ガチャ」カードに鍵アイコンが表示されている（ロック中）
- カードをタップ

### 3. 購入ダイアログが表示
- 「不定方程式ガチャ」というタイトルのダイアログが表示される
- 説明: 「不定方程式ガチャを利用するには、オプションの購入が必要です。」
- 価格: ¥160（RevenueCatから取得した価格が表示される）
- 「購入する」ボタンと「キャンセル」ボタン

### 4. 購入を実行
- 「購入する」をタップ
- Apple IDでログイン（初回のみ）
- 購入確認ダイアログが表示される
- 「購入」をタップ

### 5. 購入完了
- 購入が完了すると、「購入が完了しました」というメッセージが表示される
- 不定方程式ガチャが利用可能になる
- 不定方程式ガチャ問題一覧も利用可能になる

### 6. 購入状態の保存
- RevenueCatが購入状態を管理
- アプリを再起動しても、購入状態は保持される
- 別のデバイスで同じApple IDでログインすると、購入を復元できる

---

## 🔄 技術的な流れ（アプリ内部）

### 1. アプリ起動時
```
アプリ起動
  ↓
RevenueCatService.initialize() が呼ばれる
  ↓
RevenueCat SDKが初期化される（APIキーを使用）
```

### 2. ロック状態の確認
```
bonus_gacha_page.dart または gacha_page.dart
  ↓
_checkIndefiniteEquationOptionStatus() が呼ばれる
  ↓
RevenueCatService.isIndefiniteEquationOptionPurchased() が呼ばれる
  ↓
RevenueCat SDKが購入状態を確認
  ↓
エンタイトルメント 'indefinite_equation_option' が有効かチェック
  ↓
ロック状態を決定（有効ならロック解除、無効ならロック表示）
```

### 3. 購入処理
```
ユーザーが「購入する」をタップ
  ↓
_showIndefiniteEquationOptionPurchaseDialog() が呼ばれる
  ↓
購入ダイアログが表示される
  ↓
ユーザーが「購入する」を確認
  ↓
_purchaseIndefiniteEquationOption() が呼ばれる
  ↓
RevenueCatService.purchaseIndefiniteEquationOption() が呼ばれる
  ↓
RevenueCat SDKがApp Storeに購入リクエストを送信
  ↓
Apple IDで認証
  ↓
購入が完了
  ↓
RevenueCatがエンタイトルメント 'indefinite_equation_option' を有効化
  ↓
アプリに購入完了を通知
  ↓
ロックが解除される
```

### 4. 購入状態の確認（毎回）
```
ガチャページを開く
  ↓
gacha_page.dart の _initAsync() が呼ばれる
  ↓
_checkIndefiniteEquationOptionStatus() が呼ばれる
  ↓
RevenueCat SDKが購入状態を確認
  ↓
ロック状態を更新
```

---

## 📌 重要な識別子の整理

### App Store Connect / Google Play Consoleと一致させる必要があるもの
- **Products設定の「Store Product ID」**: `indefinite_equation_option_160yen`
  - これはApp Store Connectで設定した製品IDと完全に一致させる必要があります

### RevenueCat内での識別子（自由に決められる、App Store Connectとは無関係）
- **Products設定の「Identifier」**: `indefinite_equation_option_160yen`（通常はStore Product IDと同じにすることが多い）
- **Entitlements設定の「Identifier」**: `indefinite_equation_option`
  - **重要**: コード内（`revenuecat_service.dart`）で使用している識別子と一致させる必要があります
  - コード内では `'indefinite_equation_option'` という文字列で確認しています
- **Offerings設定の「Identifier」**: `default`（通常は`default`のまま）
- **Packages設定の「Identifier」**: `indefinite_equation_option_package`（自由に決められる）


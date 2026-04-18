# RevenueCat設定ガイド

## 目次
1. [RevenueCatアカウントの作成とアプリ追加](#1-revenuecatアカウントの作成)
2. [APIキーの取得とコード設定](#2-apiキーの取得)
3. [App Store Connect / Google Play Consoleでの設定](#3-app-store-connect--google-play-consoleでの設定)
4. [RevenueCatダッシュボードでの設定](#4-revenuecatダッシュボードでの設定)
5. [テスト](#5-テスト)
6. [アプリバージョンと一緒に提出](#6-アプリバージョンと一緒に提出)

## 設定の流れ

### ステップ1: RevenueCatの設定（アプリ内課金作成後、提出前）

1. **RevenueCatダッシュボードでアプリを追加**
2. **APIキーを取得してコードに設定**
3. **Products、Entitlements、Offeringsを設定**
4. **この時点でテスト可能（Sandbox環境）**

### ステップ2: アプリバージョンと一緒に提出

1. **新しいアプリバージョンを作成**
2. **そのバージョンにアプリ内課金を紐付け**
3. **アプリバージョンをApp Reviewに提出**
4. **最初のアプリ内課金は、このバージョンと一緒に審査される**

### ステップ3: 審査通過後

- **追加のアプリ内課金は「App内課金」セクションから直接提出可能**

---

## 1. RevenueCatアカウントの作成

### 1. RevenueCatアカウントの作成

1. **アカウント作成**
   - [RevenueCat](https://app.revenuecat.com/signup)にアクセス
   - 「Sign up」または「Get started」ボタンをクリック
   - メールアドレスとパスワードを入力してアカウントを作成

2. **プロジェクト作成**
   - ダッシュボードにログイン後、左上の「+ New Project」ボタンをクリック
   - プロジェクト名を入力（例: "JoyMath"）
   - 「Create Project」をクリック

3. **アプリの追加**
   - プロジェクト内で「+ Add App」ボタンをクリック
   - アプリ名を入力（例: "JoyMath"）
  - **iOS設定:**
    - Platform: iOS を選択
    - Bundle ID: `com.joymath`（確認済み：`ios/Runner.xcodeproj/project.pbxproj`で確認）
    - 「Add App」をクリック
  - **Android設定:**
    - Platform: Android を選択
    - Package Name: `com.joymath`（確認済み：`android/app/build.gradle.kts`で確認）
    - 「Add App」をクリック

### 2. APIキーの取得

1. **API Keysページを開く**
   - 左サイドバーの「API Keys」をクリック
   - または、プロジェクト設定から「API Keys」タブを選択

2. **APIキーをコピー**
   - **iOS用:**
     - 「iOS」セクションの「Public API Key」をコピー
     - または「Secret Key」をコピー（本番環境用）
   - **Android用:**
     - 「Android」セクションの「Public API Key」をコピー
     - または「Secret Key」をコピー（本番環境用）

3. **コードに設定**
   - `lib/services/revenuecat_service.dart`を開く
   - 以下の行を探す：
     ```dart
     static const String _iosApiKey = 'YOUR_IOS_API_KEY';
     static const String _androidApiKey = 'YOUR_ANDROID_API_KEY';
     ```
   - `YOUR_IOS_API_KEY`をコピーしたiOS APIキーに置き換え
   - `YOUR_ANDROID_API_KEY`をコピーしたAndroid APIキーに置き換え
   - 例：
     ```dart
     static const String _iosApiKey = 'appl_xxxxxxxxxxxxxxxxxxxxx';
     static const String _androidApiKey = 'goog_xxxxxxxxxxxxxxxxxxxxx';
     ```

### 3. App Store Connect / Google Play Consoleでの設定

**重要**: 最初のアプリ内課金（`indefinite_equation_option_160yen`）は、アプリバージョンと一緒に提出する必要があります。

#### iOS (App Store Connect) - 不定方程式オプション（indefinite_equation_option_160yen）

1. **App Store Connectにログイン**
   - [App Store Connect](https://appstoreconnect.apple.com/)にアクセス
   - Apple IDでログイン

2. **アプリを選択**
   - 「マイApp」をクリック
   - 対象のアプリを選択（例: "JoyMath"）

3. **App内課金ページを開く**
   - 左サイドバーの「機能」をクリック
   - 「App内課金」をクリック
   - または、アプリ詳細ページから「機能」→「App内課金」を選択

4. **新しいApp内課金アイテムを作成**
   - 右上の「+」ボタンをクリック
   - 「App内課金アイテムを作成」をクリック
   - **タイプを選択:**
     - 「非消耗型」を選択（一度購入すると永続的に利用可能）
   - **製品IDを入力:**
     - `indefinite_equation_option_160yen` を入力（このIDはコード内で使用）
   - **価格を設定:**
     - 「価格」をクリック
     - 「¥160」を選択（または「カスタム価格」で160円を設定）
   - **表示名を入力:**
     - 例: "不定方程式オプション"
   - **説明を入力:**
     - 例: "不定方程式ガチャを利用可能にします"
   - 「保存」をクリック

5. **メタデータを入力して「送信準備完了」にする**
   - 作成したアプリ内課金アイテムをクリックして詳細ページを開く
   - 「メタデータが不足」という警告が表示されている場合は、以下の情報を入力：
     - **表示名（ローカライズ）:**
       - 日本語: "不定方程式オプション" または "Indefinite Equation Option"
       - 英語: "Indefinite Equation Option"
     - **説明（ローカライズ）:**
       - 日本語: "不定方程式ガチャを利用可能にします" または "不定方程式ガチャへのアクセスを有効にします"
       - 英語: "Enables access to indefinite equation gacha" または "Unlocks indefinite equation gacha"
     - **価格:**
       - 「価格」セクションで「¥160」を選択（または「カスタム価格」で160円を設定）
     - **レビュー用スクリーンショット（オプション）:**
       - 必要に応じて、アプリ内課金の機能を示すスクリーンショットをアップロード
   - すべての必須情報を入力したら、「送信準備完了」ボタンをクリック
   - ステータスが「送信準備完了」になることを確認

6. **メタデータ入力後、RevenueCatの設定を先に完了**
   - この時点ではまだ提出しない
   - RevenueCatダッシュボードでの設定（ステップ4）を先に完了させる
   - テスト（Sandbox環境）を実施して動作確認

#### 6. アプリバージョンと一緒に提出（重要）

**最初のアプリ内課金をアプリバージョンと一緒に提出**

1. **アプリの「バージョン」ページを開く**
   - App Store Connectで対象アプリを選択
   - 「バージョン」タブをクリック

2. **新しいアプリバージョンを作成**
   - 「+」ボタンで新しいバージョンを作成
   - または既存のバージョンを選択

3. **アプリ内課金を紐付け**
   - 「App内課金とサブスクリプション」セクションを探す
   - 作成したアプリ内課金（`indefinite_equation_option_160yen`）を選択

4. **バイナリのアップロード**
   - アプリのバイナリ（.ipaファイル）をアップロード
   - Xcodeからアーカイブしてアップロード、またはFastlaneを使用

5. **App Reviewに提出**
   - すべての情報を入力後、「審査に提出」をクリック
   - 最初のアプリ内課金は、このバージョンと一緒に審査される

**審査通過後**
- 追加のアプリ内課金（例: `factorization_double_option_80yen`）は「App内課金」セクションから直接提出可能
- アプリバージョンと一緒に提出する必要はない

#### Android (Google Play Console)

1. **Google Play Consoleにログイン**
   - [Google Play Console](https://play.google.com/console/)にアクセス
   - Googleアカウントでログイン

2. **アプリを選択**
   - 対象のアプリを選択（例: "JoyMath"）

3. **アプリ内商品ページを開く**
   - 左サイドバーの「収益化」をクリック
   - 「アプリ内商品」をクリック
   - または、アプリ詳細ページから「収益化」→「アプリ内商品」を選択

4. **新しい商品を作成**
   - 「商品を作成」ボタンをクリック
   - **商品IDを入力:**
     - `indefinite_equation_option_160yen` を入力（このIDはコード内で使用）
   - **商品タイプを選択:**
     - 「管理対象の商品」を選択（非消耗型）
   - 「作成」をクリック

5. **商品情報を入力**
   - **名前:**
     - 例: "不定方程式オプション"
   - **説明:**
     - 例: "不定方程式ガチャを利用可能にします"
   - **価格:**
     - 「価格を設定」をクリック
     - 「¥160」を選択（または「カスタム価格」で160円を設定）
   - 「保存」をクリック

6. **ステータスを有効化**
   - 作成した商品の「ステータス」を確認
   - 「有効」になっていることを確認
   - まだの場合は、「有効にする」ボタンをクリック

### 4. RevenueCatダッシュボードでの設定

#### 4.1. Products（商品）の追加

1. **Productsページを開く**
   - 左サイドバーの「Products」をクリック
   - または、プロジェクト内で「Products」タブを選択

2. **新しい商品を追加**
   - 右上の「+ Add」ボタンをクリック
   - または「New Product」ボタンをクリック

3. **商品情報を入力（不定方程式オプション）**
   - **Identifier:**
     - `indefinite_equation_option_160yen` を入力（App Store Connect / Google Play Consoleで設定した製品IDと同じ）
   - **Store:**
     - 「App Store」を選択（iOS用）
     - または「Google Play Store」を選択（Android用）
   - **Store Product ID:**
     - `indefinite_equation_option_160yen` を入力（App Store Connect / Google Play Consoleで設定した製品IDと同じ）
   - 「Add Product」をクリック

4. **両プラットフォーム用に追加**
   - iOS用とAndroid用でそれぞれ上記の手順を繰り返す
   - 同じIdentifier（`indefinite_equation_option_160yen`）で、Storeを「App Store」と「Google Play Store」で分けて作成

**注意**: 既に`factorization_double_option_80yen`が設定されている場合は、同じ手順で`indefinite_equation_option_160yen`を追加してください。

#### 4.2. Entitlements（エンタイトルメント）の作成

1. **Entitlementsページを開く**
   - 左サイドバーの「Entitlements」をクリック
   - または、プロジェクト内で「Entitlements」タブを選択

2. **新しいエンタイトルメントを作成**
   - 右上の「+ Add」ボタンをクリック
   - または「New Entitlement」ボタンをクリック

3. **エンタイトルメント情報を入力（不定方程式オプション）**
   - **Identifier:**
     - `indefinite_equation_option` を入力（コード内で使用する識別子）
   - **Display Name:**
     - 例: "不定方程式オプション"
   - 「Add Entitlement」をクリック

4. **商品を関連付け**
   - 作成したエンタイトルメントをクリック
   - 「Products」セクションで「+ Add Product」をクリック
   - 上記で作成した商品（`indefinite_equation_option_160yen`）を選択
   - iOS用とAndroid用の両方の商品を追加
   - 「Save」をクリック

**注意**: 既に`factorization_option`が設定されている場合は、同じ手順で`indefinite_equation_option`を追加してください。

#### 4.3. Offerings（オファリング）の作成

1. **Offeringsページを開く**
   - 左サイドバーの「Offerings」をクリック
   - または、プロジェクト内で「Offerings」タブを選択

2. **デフォルトオファリングを確認/作成**
   - 「Default Offering」が既に存在するか確認
   - 存在しない場合は、「+ New Offering」をクリック
   - **Identifier:**
     - `default` を入力（コード内で使用）
   - **Display Name:**
     - 例: "デフォルトオファリング"
   - 「Create Offering」をクリック

3. **パッケージを追加（不定方程式オプション）**
   - 作成したオファリング（または既存の「Default Offering」）をクリック
   - 「Packages」セクションで「+ Add Package」をクリック
   - **Package Identifier:**
     - 例: `indefinite_equation_option_package` を入力
   - **Display Name:**
     - 例: "不定方程式オプション"
   - **Product:**
     - 上記で作成した商品（`indefinite_equation_option_160yen`）を選択
   - 「Add Package」をクリック

**注意**: 既に`factorization_option_package`が設定されている場合は、同じオファリングに`indefinite_equation_option_package`を追加してください。

4. **オファリングを有効化**
   - オファリングの「Status」が「Active」になっていることを確認
   - なっていない場合は、「Active」に設定

### 5. テスト

#### 5.1. Sandbox環境の準備

**iOS (App Store Connect):**
1. App Store Connectで「ユーザーとアクセス」→「Sandboxテスター」を開く
2. 「+」ボタンで新しいSandboxテスターを作成
   - メールアドレス、パスワード、名前を入力
   - 「作成」をクリック

**Android (Google Play Console):**
1. Google Play Consoleで「設定」→「ライセンステスト」を開く
2. 「ライセンステスト」でテスト用のGoogleアカウントを追加
   - または、内部テストトラックでテストアカウントを追加

#### 5.2. アプリでのテスト

1. **アプリをビルド**
   - 開発環境でアプリをビルド
   - 実機またはエミュレータで実行

2. **購入フローをテスト**
   - アプリを起動
   - 「おまけガチャ」ページを開く
   - 「不定方程式ガチャ」カードをタップ（ロック中の場合）
   - 購入ダイアログが表示されることを確認
   - Sandboxアカウントでログイン（初回のみ）
   - 購入を完了
   - 不定方程式ガチャが利用可能になることを確認
   - 不定方程式ガチャ問題一覧も利用可能になることを確認

3. **購入状態の確認**
   - RevenueCatダッシュボードで「Customers」を開く
   - テストユーザーを検索
   - 購入履歴とエンタイトルメントの状態を確認

#### 5.3. 購入復元のテスト

1. **アプリを再インストール**
   - アプリを削除して再インストール
   - または、別のデバイスでインストール

2. **購入を復元**
   - アプリ内の「購入を復元」ボタンをクリック
   - オプション問題が再度利用可能になることを確認

## トラブルシューティング

### よくある問題

1. **「Product not found」エラー**
   - App Store Connect / Google Play Consoleで商品が「送信準備完了」/「有効」になっているか確認
   - 商品ID（`indefinite_equation_option_160yen`）が正しいか確認
   - RevenueCatダッシュボードで商品が正しく設定されているか確認
   - 商品IDがコード内（`revenuecat_service.dart`）と一致しているか確認

2. **「No offerings available」エラー**
   - RevenueCatダッシュボードでオファリングが「Active」になっているか確認
   - オファリングにパッケージが追加されているか確認
   - パッケージに商品が関連付けられているか確認

3. **購入状態が反映されない**
   - RevenueCatダッシュボードの「Customers」で購入履歴を確認
   - エンタイトルメントが正しく設定されているか確認
   - アプリを再起動して状態を再読み込み

4. **APIキーエラー**
   - APIキーが正しく設定されているか確認
   - iOS用とAndroid用のAPIキーが混在していないか確認
   - 本番環境と開発環境で異なるAPIキーを使用している場合、適切なキーを使用しているか確認

## 注意事項

- **APIキーの管理:**
  - APIキーは機密情報のため、Gitにコミットしないでください
  - `.gitignore`に`lib/services/revenuecat_service.dart`を追加するか、環境変数から読み込むように変更することを推奨
  - 本番環境と開発環境で異なるAPIキーを使用することを推奨

- **購入状態の管理:**
  - 購入状態はRevenueCatとSharedPreferencesの両方で管理（冗長性のため）
  - RevenueCatが利用できない場合でも、SharedPreferencesから購入状態を取得可能

- **テスト環境:**
  - 開発中はSandbox環境を使用
  - 本番リリース前に必ずテスト購入を実施
  - 購入復元機能も必ずテスト

- **価格設定:**
  - App Store Connect / Google Play Consoleで設定した価格がRevenueCatに反映されるまで時間がかかる場合がある
  - 価格変更後は数時間待ってから再テスト



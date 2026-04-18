# テスト一覧とテスト内容サマリー

このドキュメントは、joymathプロジェクトに存在する全てのテストファイルと、それぞれが何をテストしているかをまとめたものです。

最終更新日: 2024年

---

## 📋 テストファイル一覧

| ファイル名 | テスト数 | カテゴリ | 説明 |
|-----------|---------|---------|------|
| `simple_data_manager_test.dart` | 22 | データ管理 | ローカルデータストレージとFirebase同期の基本機能 |
| `account_switch_test.dart` | 4 | 認証・アカウント管理 | アカウント切り替え時のデータ保持・削除ロジック |
| `firebase_sync_integration_test.dart` | 3 | Firebase統合 | 実際のFirebase接続を使用した同期テスト |
| `auth_service_test.dart` | 20+ | 認証 | Firebase認証サービスの各種メソッド |
| `auth_diagnostic_test.dart` | 5 | 認証診断 | 認証機能の診断と設定確認 |
| `id_duplicate_test.dart` | 4 | データ整合性 | 問題IDの重複チェック |
| `gacha_problem_display_test.dart` | 12 | ガチャ表示 | 学習履歴の取得と表示ロジック |
| `gacha_filtering_test.dart` | 20+ | ガチャフィルタリング | 学習履歴に基づく問題フィルタリング |
| `gacha_slot_assignment_test.dart` | 15+ | ガチャスロット | 問題のスロット割り当てロジック |
| `exclusion_logic_test.dart` | 3 | 除外ロジック | 解決済み問題の除外ロジック |
| `widget_test.dart` | 1 | UI | 基本的なウィジェットテスト |

---

## 📚 詳細なテスト内容

### 1. SimpleDataManager Tests (`simple_data_manager_test.dart`)

**目的**: ローカルデータストレージ（SharedPreferences）とFirebase同期の基本機能をテスト

#### テストグループ:

- **Initialization Tests (2テスト)**
  - SimpleDataManagerの初期化が成功すること
  - 複数回の初期化が正常に処理されること

- **Gacha Settings Tests (4テスト)**
  - ガチャ設定の保存・取得が正常に動作すること
  - デフォルト設定が正しく返されること
  - 既存設定の更新が正常に動作すること
  - 複数のガチャタイプを独立して管理できること

- **Premium Purchase Tests (2テスト)**
  - **目的**: 有料オプション（例: 因数分解ガチャ）の購入状態管理をテスト
  - **機能**: RevenueCatサービスと連携してプレミアム購入状態を確認・設定
  - **テスト内容**:
    - `isPremiumPurchased()`: RevenueCatから購入状態を取得できること（RevenueCat失敗時はローカルデータを使用）
    - `setPremiumPurchased()`: 購入状態をSharedPreferencesに保存できること
  - **注意**: RevenueCatの状態も確認するため、テスト結果は不定（`isA<bool>()`のみ確認）

- **Data Export Tests (2テスト)**
  - **目的**: デバッグ・データバックアップ用の全データエクスポート機能をテスト
  - **機能**: SharedPreferencesに保存されている全てのアプリデータ（学習履歴、ガチャ設定など）をMap形式でエクスポート
  - **テスト内容**:
    - 学習記録とガチャ設定を含む全データがエクスポートできること
    - データが存在しない場合でも空のMapが返されること（エラーにならないこと）
  - **用途**: デバッグ時のデータ確認、データ移行時のバックアップなど

- **Data Clear Tests (2テスト)**
  - 全データのクリアが正常に動作すること
  - 他のアプリのデータに影響しないこと

- **User Settings Tests (3テスト)**
  - ユーザー設定の保存・取得が正常に動作すること
  - 設定が存在しない場合の処理が正常に動作すること
  - 設定の更新が正常に動作すること

- **Error Handling Tests (3テスト)**
  - 破損したガチャ設定データの処理が正常に動作すること
  - 学習データが存在しない場合の処理が正常に動作すること
  - 保存エラーの処理が正常に動作すること

- **Concurrent Access Tests (1テスト)**
  - 並行アクセス時のデータ整合性が保たれること

- **Firebase Sync Tests (3テスト)**
  - 認証されていない状態でもローカル削除が成功すること
  - 学習履歴の保存時にFirestoreへの同期が行われること（認証時）
  - ガチャ設定の保存時にFirestoreへの同期が行われること（認証時）

---

### 2. Account Switch Tests (`account_switch_test.dart`)

**目的**: アカウント切り替え時のローカルデータの保持・削除ロジックをテスト

#### テストケース:

1. **ローカルデータがログアウト後も保持される**
   - ログイン前に保存したデータ（2ガチャ選択など）がログアウト後も保持されること

2. **アカウント切り替え時にローカルデータが消去される**
   - 異なるアカウントに切り替えた場合、アカウント固有のデータが適切にクリアされること

3. **ログアウト後に同じアカウントで再ログインしてもローカルデータが保持される**
   - 同じアカウントで再ログインした場合、ローカルデータが保持されること

4. **ログアウト時にlastUserIdがクリアされる**
   - ログアウト時に`lastUserId`がクリアされ、次回ログイン時に誤検知されないこと

---

### 3. Firebase Sync Integration Tests (`firebase_sync_integration_test.dart`)

**目的**: 実際のFirebase接続を使用してデータ同期の整合性をテスト

**注意**: このテストは実際のFirebase接続が必要です。認証されていない場合は自動的にスキップされます。

#### テストケース:

1. **学習記録の保存→削除→同期確認**
   - 学習記録を保存し、Firestoreに同期されること
   - 学習記録を削除し、Firestoreからも削除されること
   - ローカルとFirestoreの整合性が保たれること

2. **ガチャ設定の保存→同期確認**
   - ガチャ設定を保存し、Firestoreに同期されること
   - Firestoreから取得した設定が正しいこと

3. **認証されていない状態でもローカル操作は成功する**
   - 認証されていない状態でもローカル保存・削除が成功すること
   - Firebase同期はスキップされるが、エラーにならないこと

---

### 4. FirebaseAuthService Tests (`auth_service_test.dart`)

**目的**: Firebase認証サービスの各種メソッドとプラットフォーム対応をテスト

#### テストグループ:

- **Platform Availability Tests (2テスト)**
  - 現在のプラットフォームが正しく検出されること
  - Firebase初期化状態が確認できること

- **Google Sign-In Availability Tests (2テスト)**
  - Google Sign-Inメソッドが存在すること
  - Google Sign-Inが呼び出せること（UI表示の可能性あり）

- **Apple Sign-In Availability Tests (3テスト)**
  - Apple Sign-Inメソッドが存在すること
  - Apple Sign-Inが呼び出せること（プラットフォーム制限あり）
  - プラットフォーム可用性が確認できること

- **SMS/Phone Authentication Tests (2テスト)**
  - 電話番号認証メソッドが存在すること
  - 無効な電話番号が適切に拒否されること

- **Authentication State Tests (3テスト)**
  - 現在のユーザー情報が取得できること
  - ユーザーIDが取得できること
  - サインアウトが正常に動作すること

- **Linking Tests**
  - リンク機能は匿名ユーザー廃止に伴い削除されました

- **Error Handling Tests (2テスト)**
  - Firebase未初期化時のエラーハンドリングが適切であること
  - nullユーザー時の処理が正常に動作すること

- **Cross-Platform Consistency Tests (2テスト)**
  - 全ての認証メソッドが両プラットフォームで利用可能であること
  - 認証状態の一貫性が保たれること

- **Integration Test - Authentication Flow**
  - 匿名認証の統合テストは匿名ユーザー廃止に伴い削除されました

---

### 5. Authentication Diagnostic Tests (`auth_diagnostic_test.dart`)

**目的**: 認証機能の診断と設定確認（「できたりできなかったり」問題の診断用）

#### テストケース:

1. **Platform Information**
   - OS情報、バージョン、プラットフォーム種別を表示

2. **Firebase Configuration Check**
   - Firebase初期化状態を確認
   - 初期化されたアプリの数を表示

3. **Google Sign-In Diagnostic**
   - Google Sign-Inの動作確認
   - 成功時のユーザー情報を表示

4. **Apple Sign-In Diagnostic**
   - Apple Sign-Inの動作確認（iOS/Androidのみ）
   - プラットフォーム制限の確認

5. **SMS/Phone Authentication Diagnostic**
   - 電話番号認証の動作確認
   - 検証IDの受信確認

6. **Linking Diagnostic**
   - アカウントリンク機能は匿名ユーザー廃止に伴い削除されました

7. **Summary Report**
   - 全ての診断結果のサマリー表示
   - 推奨事項の表示

---

### 6. ID Duplicate Tests (`id_duplicate_test.dart`)

**目的**: 問題IDの重複チェックとデータ整合性の確認

#### テストケース:

1. **全ての問題のIDが一意であること**
   - 全問題（積分、極限、因数分解、不定方程式、数列、三角関数・指数・対数方程式、物理数学ガチャ、単位ガチャ）のIDが重複していないこと
   - 重複が見つかった場合は詳細を出力

2. **全ての問題のID-noペアが一意であること**
   - IDとnoの組み合わせが重複していないこと

3. **全ての問題にIDが設定されていること**
   - IDが空の問題が存在しないこと

4. **統計情報の表示**
   - 全問題数、ユニークなID数の統計を表示
   - ID数が問題数と一致することを確認

---

### 7. Gacha Problem Display Tests (`gacha_problem_display_test.dart`)

**目的**: ガチャ画面での問題表示に必要な学習履歴取得ロジックをテスト

#### テストケース:

1. **未認証時の動作**
   - 未認証時に空のリストが返されること
   - 未認証時に`LearningStatus.none`が返されること

2. **タイムアウト処理**
   - Firestore接続タイムアウト時の処理が正常に動作すること
   - タイムアウト時は空のリストまたは`none`が返されること

3. **ローカルデータのフォールバック**
   - Firestore失敗時にローカルデータが返されること
   - ローカルデータの取得が正常に動作すること

4. **データの順序と整合性**
   - 学習履歴の順序が正しく保持されること
   - 複数問題の独立管理が正常に動作すること

5. **ステータス遷移**
   - ステータスの遷移（none → solved → understood → failed）が正常に動作すること

6. **データマイグレーション**
   - 古い形式のデータが正しく処理されること

7. **新規問題の処理**
   - 新規問題に対して空のリストまたは`none`が返されること

---

### 8. Gacha Filtering Tests (`gacha_filtering_test.dart`)

**目的**: 学習履歴に基づく問題フィルタリングロジックをテスト

#### テストグループ:

- **Learning History Tests (7テスト)**
  - 学習履歴の保存が正常に動作すること
  - 履歴が3スロットまで制限されること
  - 最新ステータスの更新が正常に動作すること
  - `none`ステータスの処理が正常に動作すること
  - 新規問題の処理が正常に動作すること
  - 無効な時間フォーマットの処理が正常に動作すること
  - 時間フィールドが欠落している場合の処理が正常に動作すること

- **Learning Record Tests (5テスト)**
  - 学習記録の保存が正常に動作すること
  - 既存記録の更新が正常に動作すること
  - 履歴の制限が正常に動作すること
  - 新規問題の処理が正常に動作すること
  - 全ステータスタイプの処理が正常に動作すること

- **Multiple Problems Tests (2テスト)**
  - 複数問題の独立管理が正常に動作すること
  - 各問題の履歴が独立して管理されること

- **Data Persistence Tests (3テスト)**
  - 再初期化後もデータが保持されること
  - 学習履歴のクリアが正常に動作すること
  - 他の問題に影響しないこと

- **Edge Cases (4テスト)**
  - 空の履歴リストの処理が正常に動作すること
  - null時間値の処理が正常に動作すること
  - 無効なステータス値の処理が正常に動作すること
  - 破損したJSONデータの処理が正常に動作すること

---

### 9. Gacha Slot Assignment Tests (`gacha_slot_assignment_test.dart`)

**目的**: ガチャスロットへの問題割り当てロジックをテスト

#### テストグループ:

- **Problem Key Tests (2テスト)**
  - 問題IDが正しく取得できること
  - 異なる問題が異なるキーを持つこと

- **Level Filtering Tests (2テスト)**
  - レベルによる問題フィルタリングが正常に動作すること
  - 空のレベルフィルタの処理が正常に動作すること

- **Problem Pool Tests (3テスト)**
  - 問題プールの作成が正常に動作すること
  - 空のプールの処理が正常に動作すること
  - 単一問題のプールの処理が正常に動作すること

- **Reserve Problem Tests (3テスト)**
  - 予備問題の識別が正常に動作すること
  - 非予備問題の識別が正常に動作すること
  - 数値問題番号の処理が正常に動作すること

- **Problem Selection Tests (3テスト)**
  - プールからの問題選択が正常に動作すること
  - プールサイズが選択数より小さい場合の処理が正常に動作すること
  - 空のプール選択の処理が正常に動作すること

- **Problem Uniqueness Tests (2テスト)**
  - 選択された問題が一意であること
  - プール内の重複問題の処理が正常に動作すること

- **Problem Shuffling Tests (2テスト)**
  - 問題のシャッフルが正常に動作すること
  - 単一問題のシャッフルが正常に動作すること

- **Problem Assignment Tests (3テスト)**
  - スロットへの問題割り当てが正常に動作すること
  - 空のスロット候補の処理が正常に動作すること
  - 全てのスロットが空の場合の処理が正常に動作すること

- **Problem Level Distribution Tests (2テスト)**
  - レベル分布が正しく計算されること
  - 単一レベルの分布が正常に動作すること

---

### 10. Exclusion Logic Tests (`exclusion_logic_test.dart`)

**目的**: 解決済み問題の除外ロジックをテスト

#### テストケース:

1. **黄色緑緑 needed=1 の場合**
   - スロット順序: 黄色（最古）→ 緑（中間）→ 緑（最新）
   - 連続緑の数が2個で、needed=1以上なので除外されること
   - 時間によるソートが正常に動作すること

2. **赤緑 needed=1 の場合**
   - スロット順序: 赤（最古）→ 緑（最新）
   - 連続緑の数が1個で、needed=1以上なので除外されること

3. **緑のみ needed=1 の場合**
   - スロット順序: 緑（最新）→ none → none
   - 連続緑の数が1個で、needed=1以上なので除外されること

**テストされる関数**:
- `_sortSlotsByTime`: スロットを時間でソート（最新が先頭）
- `_countConsecutiveSolved`: 最新から連続する解決済み（緑）の数をカウント

---

### 11. Widget Tests (`widget_test.dart`)

**目的**: 基本的なウィジェットテスト（Flutter標準のスモークテスト）

#### テストケース:

1. **Counter increments smoke test**
   - カウンターウィジェットの基本的な動作確認
   - タップによるインクリメントが正常に動作すること

---

## 🎯 テストカバレッジの概要

### カバーされている主要機能

✅ **データ管理**
- ローカルストレージ（SharedPreferences）の基本操作
- Firebase同期（認証時）
- データのエクスポート・クリア
- エラーハンドリング

✅ **認証・アカウント管理**
- Firebase認証（Google、Apple、電話番号、メール/パスワード）
- アカウント切り替え時のデータ処理
- ログアウト時のデータ保持

✅ **学習履歴管理**
- 学習記録の保存・取得・削除
- 学習履歴の管理（3スロット制限）
- ステータス遷移（none → solved → understood → failed）

✅ **ガチャ機能**
- 問題のフィルタリング（解決済み除外など）
- スロットへの問題割り当て
- レベル別フィルタリング

✅ **データ整合性**
- 問題IDの重複チェック
- データの一貫性確認

### テストされていない領域（今後の拡張候補）

⚠️ **UI/UX**
- 画面遷移のテスト
- ユーザーインタラクションのテスト
- エラーメッセージの表示テスト

⚠️ **パフォーマンス**
- 大量データ処理のテスト
- ネットワーク遅延時の動作テスト

⚠️ **セキュリティ**
- 認証トークンの有効期限テスト
- データ暗号化のテスト

---

## 🚀 テストの実行方法

### 全テストの実行
```bash
flutter test
```

### 特定のテストファイルの実行
```bash
flutter test test/simple_data_manager_test.dart
```

### 特定のテストグループの実行
```bash
flutter test --name "SimpleDataManager Tests"
```

### 統合テストの実行（Firebase接続が必要）
```bash
flutter test test/firebase_sync_integration_test.dart
```

**注意**: 統合テストは実際のFirebase接続が必要です。認証されていない場合は自動的にスキップされます。

---

## 📝 テストの追加・更新ガイドライン

1. **新しい機能を追加したら**
   - 対応するユニットテストを追加
   - Firebase同期が必要な場合は統合テストも追加

2. **バグを修正したら**
   - 再発防止のためのテストケースを追加

3. **リファクタリング時**
   - 既存のテストが全て通過することを確認
   - 必要に応じてテストもリファクタリング

4. **テストの命名規則**
   - 日本語でテストケース名を記述（可読性のため）
   - テストグループ名は英語で記述

---

## 🔍 テスト結果の確認

テスト実行後、以下の情報が表示されます：
- 通過したテスト数
- 失敗したテスト数
- スキップされたテスト数
- エラーの詳細（失敗時）

統合テストはFirebase接続が必要なため、環境によってはスキップされることがあります。これは正常な動作です。

---

## 📌 注意事項

1. **Firebase統合テスト**
   - 実際のFirebase接続を使用します
   - テストデータがFirestoreに書き込まれる可能性があります
   - 本番環境では実行しないでください

2. **SharedPreferences**
   - テストでは`SharedPreferences.setMockInitialValues()`を使用してモックデータを設定します
   - 実際のデバイスストレージには影響しません

3. **非同期処理**
   - 多くのテストが非同期処理を含みます
   - `await`を適切に使用してテストの完了を待機します

---

## 📚 関連ドキュメント

- [Flutter Testing Guide](https://docs.flutter.dev/testing)
- [Firebase Testing](https://firebase.google.com/docs/emulator-suite)
- [SharedPreferences Testing](https://pub.dev/packages/shared_preferences#testing)

---

最終更新: 2024年

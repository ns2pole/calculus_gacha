# アカウント切り替え時のデータ削除仕様

## 📋 概要

異なるFirebaseアカウントに切り替えた際に、前のアカウントのローカルデータを削除し、新しいアカウントのFirestoreデータを取得する仕様です。

---

## 🔄 動作フロー

### 1. アカウント切り替えの検知

**メソッド**: `SimpleDataManager.isAccountSwitched()`

**検知条件**:
- `lastUserId`（前回ログインしたユーザーID）が存在する
- `currentUserId`（現在ログインしているユーザーID）が存在する
- `lastUserId ≠ currentUserId`（異なるユーザーID）

**実装箇所**: `lib/services/problems/simple_data_manager.dart:1614-1630`

```dart
static Future<bool> isAccountSwitched() async {
  final lastUserId = await getLastUserId();
  final currentUserId = FirebaseAuthService.userId;
  
  if (lastUserId != null && currentUserId != null && lastUserId != currentUserId) {
    return true;  // アカウント切り替え検知
  }
  return false;
}
```

### 2. アカウント切り替え時の処理

**メソッド**: `SimpleDataManager.syncOnAccountSwitch()`

**処理内容**:
1. アカウント切り替えを検知
2. 前のアカウントのローカルデータをクリア（`clearAccountSpecificData()`）
3. 現在のユーザーIDを`lastUserId`に保存
4. Firestoreから新しいアカウントのデータを取得（`_syncFromFirestore()`）

**呼び出し箇所**: `lib/pages/other/auth_page.dart:440`
- ログイン成功後の`_syncDataInBackground()`内で呼び出される

---

## 🗑️ 削除されるデータ

**メソッド**: `SimpleDataManager.clearAccountSpecificData()`

### 削除パターン（明示的に指定）

以下のパターンで始まるキーが削除されます：

1. **学習記録**: `joymath_simple/learning/`
   - 例: `joymath_simple/learning/problem_1`
   - 例: `joymath_simple/learning/problem_2`

2. **ガチャ設定**: `joymath_simple/gacha/`
   - 例: `joymath_simple/gacha/integral_gacha`
   - 例: `joymath_simple/gacha/limit_gacha`

3. **ユーザー設定**: `joymath_simple/user_settings`
   - テーマ、言語などのユーザー設定

4. **同期完了フラグ**: `joymath_simple/firestore_sync_completed_`
   - 例: `joymath_simple/firestore_sync_completed_user123`

### 削除パターン（その他の名前空間内キー）

`joymath_simple`名前空間内の**全てのキー**が削除対象となります（保持するキーを除く）。

**削除される可能性があるキー例**:
- `joymath_simple/selected_free_gachas`（選択された無料ガチャ）
- `joymath_simple/premium_purchased`（プレミアム購入状態）
- `joymath_simple/premium_purchased_last_updated`
- `joymath_simple/integral_gacha_exclusion_mode`（その他の設定）
- その他、`joymath_simple`で始まる全てのキー

---

## ✅ 保持されるデータ

以下のキーは**削除されません**：

1. **バージョン情報**: `joymath_simple/version`
   - SimpleDataManagerのバージョン情報

2. **最後のユーザーID**: `joymath_simple/last_user_id`
   - 次回のアカウント切り替え検知に使用

---

## ⚠️ 重要な注意事項

### 1. ログアウト時の動作

**ログアウト時**（`FirebaseAuthService.signOut()`）:
- `lastUserId`が**クリア**されます
- ローカルデータは**保持**されます

**理由**: 
- ログアウト後に同じアカウントで再ログインした場合、アカウント切り替えとして誤検知されないようにするため
- ログイン前のローカルデータ（例: 2ガチャ選択）を保持するため

**実装箇所**: `lib/services/auth/firebase_auth_service.dart:signOut()`

```dart
static Future<void> signOut() async {
  await _auth.signOut();
  // ログアウト時にlastUserIdをクリアして、次回ログイン時に
  // アカウント切り替えとして誤検知されないようにする
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('joymath_simple/last_user_id');
}
```

### 2. ログイン前のデータ

**ログイン前に保存したデータ**（例: 2ガチャ選択）:
- ログアウト後も**保持**されます
- アカウント切り替え時は**削除**されます

**シナリオ例**:
1. 2ガチャを選択（ログイン前）
2. アカウント1でログイン → データは保持される
3. ログアウト → データは保持される、`lastUserId`はクリアされる
4. アカウント2でログイン → **データは削除される**（`lastUserId`がnullなので、アカウント切り替えとして検知されないはずだが...）

**注意**: 実際には、ログアウト時に`lastUserId`をクリアしているため、次回ログイン時は「アカウント切り替え」として検知されません。しかし、異なるアカウントでログインした場合、`lastUserId`がnullから新しいユーザーIDに変わるため、通常のログインとして扱われます。

### 3. アカウント切り替えの検知タイミング

**検知される場合**:
- アカウント1でログイン → `lastUserId = account1_id`
- ログアウト**せずに**アカウント2でログイン → `lastUserId = account1_id`, `currentUserId = account2_id` → **検知される**

**検知されない場合**:
- アカウント1でログイン → `lastUserId = account1_id`
- ログアウト → `lastUserId = null`（クリアされる）
- アカウント2でログイン → `lastUserId = null`, `currentUserId = account2_id` → **検知されない**（通常のログインとして扱われる）

---

## 📝 実装詳細

### 削除ロジックの実装

```dart
static Future<bool> clearAccountSpecificData() async {
  final prefs = await SharedPreferences.getInstance();
  final allKeys = prefs.getKeys();
  
  // クリアするキーのパターン
  final patternsToClear = [
    'joymath_simple/learning/',  // 学習記録
    'joymath_simple/gacha/',     // ガチャ設定
    'joymath_simple/user_settings',  // ユーザー設定
    'joymath_simple/firestore_sync_completed_',  // 同期完了フラグ
  ];
  
  // 保持するキー
  final keysToKeep = [
    'joymath_simple/version',
    'joymath_simple/last_user_id',
  ];
  
  for (final key in allKeys) {
    // 保持するキーはスキップ
    if (keysToKeep.contains(key)) {
      continue;
    }
    
    bool shouldClear = false;
    
    // パターンに一致するキーを削除
    for (final pattern in patternsToClear) {
      if (key.startsWith(pattern)) {
        shouldClear = true;
        break;
      }
    }
    
    // その他の名前空間内キーも削除
    if (!shouldClear && key.startsWith('joymath_simple')) {
      if (!keysToKeep.contains(key)) {
        shouldClear = true;
      }
    }
    
    if (shouldClear) {
      await prefs.remove(key);
    }
  }
}
```

---

## 🧪 テストケース

### テストファイル: `test/account_switch_test.dart`

1. **ローカルデータがログアウト後も保持される**
   - ログイン前に保存したデータがログアウト後も保持されることを確認

2. **アカウント切り替え時にローカルデータが消去される**
   - 異なるアカウントに切り替えた場合、アカウント固有のデータが削除されることを確認

3. **ログアウト後に同じアカウントで再ログインしてもローカルデータが保持される**
   - 同じアカウントで再ログインした場合、データが保持されることを確認

4. **ログアウト時にlastUserIdがクリアされる**
   - ログアウト時に`lastUserId`がクリアされ、次回ログイン時に誤検知されないことを確認

---

## 🔍 確認すべきポイント

1. **`selected_free_gachas`の扱い**
   - 現在の実装では、アカウント切り替え時に削除される可能性がある
   - これは意図的な動作か、バグか確認が必要

2. **`premium_purchased`の扱い**
   - RevenueCatで管理されているが、ローカルにも保存されている
   - アカウント切り替え時に削除されるが、RevenueCatから再取得されるため問題ない可能性がある

3. **ログアウト→別アカウントログインの動作**
   - 現在の実装では、ログアウト時に`lastUserId`をクリアしているため、次回ログイン時は「アカウント切り替え」として検知されない
   - これは意図的な動作（ログイン前のデータを保持するため）

---

## 📚 関連ファイル

- `lib/services/problems/simple_data_manager.dart`
  - `isAccountSwitched()`: アカウント切り替え検知
  - `clearAccountSpecificData()`: アカウント固有データの削除
  - `syncOnAccountSwitch()`: アカウント切り替え時の同期処理

- `lib/services/auth/firebase_auth_service.dart`
  - `signOut()`: ログアウト時に`lastUserId`をクリア

- `lib/pages/other/auth_page.dart`
  - `_syncDataInBackground()`: ログイン成功後のバックグラウンド同期

- `test/account_switch_test.dart`
  - アカウント切り替え関連のテスト

---

最終更新: 2024年

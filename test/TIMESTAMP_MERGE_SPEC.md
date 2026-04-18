# タイムスタンプベースマージ仕様

## 概要

現在の実装では、ローカルデータとFirestoreデータを**タイムスタンプ（`lastUpdated`）で比較**し、**新しい方を完全に採用**する方式を採用しています。

## マージ方式

### 基本方針

**「マージ」ではなく「新しい方で完全に上書き」**

- タイムスタンプを比較して、新しい方のデータ全体を採用
- 古い方のデータは破棄される
- 項目ごとの部分的なマージは行わない

## 各データタイプのマージ方法

### 1. 学習記録（Learning Records）

**データ構造**:
```json
{
  "problemId": "problem_1",
  "latestStatus": "solved",
  "history": [
    {"status": "solved", "time": "2024-01-01T00:00:00.000Z"},
    {"status": "understood", "time": "2024-01-02T00:00:00.000Z"}
  ],
  "lastUpdated": "2024-01-02T00:00:00.000Z"
}
```

**マージロジック**:
1. ローカルデータとFirestoreデータの`lastUpdated`を比較
2. **新しい方のデータ全体を採用**（`problemId`, `latestStatus`, `history`全て）
3. 古い方の`history`配列は破棄される

**例**:
- ローカル: `lastUpdated = 2024-01-01`, `history = [A, B]`
- Firestore: `lastUpdated = 2024-01-02`, `history = [C, D]`
- 結果: Firestoreのデータ全体を採用 → `history = [C, D]`（A, Bは失われる）

### 2. ガチャ設定（Gacha Settings）

**データ構造**:
```json
{
  "filterMode": "exclude_solved_ge1",
  "slotLevels": [0, 1, 2],
  "rollCount": 5,
  "lastUpdated": "2024-01-02T00:00:00.000Z"
}
```

**マージロジック**:
1. ローカルデータとFirestoreデータの`lastUpdated`を比較
2. **新しい方の設定全体を採用**（全ての設定項目）
3. 古い方の設定は破棄される

**例**:
- ローカル: `lastUpdated = 2024-01-01`, `filterMode = "random"`
- Firestore: `lastUpdated = 2024-01-02`, `filterMode = "exclude_solved_ge1"`
- 結果: Firestoreの設定全体を採用 → `filterMode = "exclude_solved_ge1"`

### 3. ユーザー設定（User Settings）

**データ構造**:
```json
{
  "theme": "dark",
  "language": "ja",
  "lastUpdated": "2024-01-02T00:00:00.000Z"
}
```

**マージロジック**:
1. ローカルデータとFirestoreデータの`lastUpdated`を比較
2. **新しい方の設定全体を採用**（全ての設定項目）
3. 古い方の設定は破棄される

## タイムスタンプ比較の詳細

### 比較ロジック

```dart
// 1. 両方のタイムスタンプが存在する場合
if (firestoreTime != null && localTime != null) {
  final firestoreDateTime = DateTime.parse(firestoreTime);
  final localDateTime = DateTime.parse(localTime);
  
  if (firestoreDateTime.isAfter(localDateTime)) {
    // Firestoreが新しい → Firestoreを採用
    mergedData = firestoreData;
  } else {
    // ローカルが新しい → ローカルを採用
    mergedData = localData;
  }
}
// 2. Firestoreのみ存在する場合
else if (firestoreTime != null) {
  mergedData = firestoreData;
}
// 3. ローカルのみ存在する場合
else {
  mergedData = localData;
}
```

### エラーハンドリング

1. **タイムスタンプのパースエラー**:
   - パースに成功した方を採用
   - 両方失敗した場合はFirestoreを優先

2. **タイムスタンプが存在しない場合**:
   - Firestoreのみ存在 → Firestoreを採用
   - ローカルのみ存在 → ローカルを採用
   - 両方存在しない → Firestoreを優先（デフォルト）

## 現在の実装の問題点

### 1. 履歴の統合が行われない

**問題**: 学習履歴（`history`配列）が完全に置き換えられるため、以下のような問題が発生する可能性があります：

**シナリオ**:
1. アカウント1でログイン → 問題Aを「solved」に記録（Firestoreに保存）
2. ログアウト
3. ログアウト状態で問題Aを「understood」に記録（ローカルのみ）
4. アカウント2でログイン
5. Firestoreからアカウント2のデータを取得（問題Aの履歴は空または別の履歴）
6. マージ時: アカウント2のFirestoreデータが新しい場合、ローカルの「understood」記録が失われる

**現在の動作**:
- Firestore: `lastUpdated = 2024-01-03`, `history = []`（アカウント2には問題Aの履歴がない）
- ローカル: `lastUpdated = 2024-01-02`, `history = [solved, understood]`
- 結果: Firestoreを採用 → `history = []`（ローカルの履歴が失われる）

### 2. 設定の部分的な更新が失われる

**問題**: ガチャ設定やユーザー設定で、一部の項目だけを更新した場合、他の項目が失われる可能性があります：

**シナリオ**:
1. アカウント1でログイン → `filterMode = "random"`, `slotLevels = [0,1,2]`（Firestoreに保存）
2. ログアウト
3. ログアウト状態で`slotLevels`のみを`[1,2,3]`に変更（ローカルのみ）
4. アカウント2でログイン
5. Firestoreからアカウント2のデータを取得（`filterMode = "exclude_solved_ge1"`）
6. マージ時: Firestoreが新しい場合、ローカルの`slotLevels`変更が失われる

## 改善案

### オプション1: 現在の方式を維持（完全上書き）

**メリット**:
- 実装がシンプル
- タイムスタンプが正確であれば、最新の状態を反映できる

**デメリット**:
- 履歴や設定の一部更新が失われる可能性がある
- ログアウト後の変更が失われる可能性がある

### オプション2: 履歴の統合マージ

**学習履歴の場合**:
- 両方の`history`配列を統合
- タイムスタンプ順にソート
- 重複を除去（同じ時刻の場合は新しい方を優先）

**例**:
```dart
// ローカル: [A(2024-01-01), B(2024-01-02)]
// Firestore: [C(2024-01-03)]
// 結果: [A, B, C]（時系列順）
```

**設定の場合**:
- 項目ごとにタイムスタンプを比較
- 各項目で新しい方を採用

**例**:
```dart
// ローカル: {filterMode: "random"(2024-01-01), slotLevels: [1,2,3](2024-01-02)}
// Firestore: {filterMode: "exclude_solved_ge1"(2024-01-03), slotLevels: [0,1,2](2024-01-01)}
// 結果: {filterMode: "exclude_solved_ge1", slotLevels: [1,2,3]}
```

### オプション3: ハイブリッド方式

**学習履歴**: 履歴を統合（オプション2）
**設定**: 完全上書き（オプション1）

## 推奨事項

ユーザーの要求「更新分をマージ、同期すればいい（データが新しいもので上書き）」を考慮すると：

1. **学習履歴**: 履歴の統合マージ（オプション2）を推奨
   - ログアウト後の変更も保持される
   - 複数デバイスでの学習履歴が統合される

2. **設定**: 現在の方式（完全上書き）を維持
   - 設定は全体として一貫性が重要
   - 部分的な更新よりも全体の状態を優先

## 実装箇所

- `lib/services/problems/simple_data_manager.dart`
  - `_syncFromFirestore()`: 学習記録のマージ（86-155行目）
  - `_syncSettingsFromFirestore()`: ガチャ設定・ユーザー設定のマージ（220-361行目）

## 関連ファイル

- `lib/services/auth/firestore_learning_service.dart`: Firestoreからの学習記録取得
- `lib/services/auth/firestore_settings_service.dart`: Firestoreからの設定取得

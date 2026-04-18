# Firestore Security Rules Configuration

## 問題

ユーザーがFirestoreから設定を読み取る際に、`permission-denied`エラーが発生しています。

### エラーログの例
```
flutter: Local settings sync to Firestore completed
flutter: Error getting reserve problems settings from Firestore: [cloud_firestore/permission-denied] The caller does not have permission to execute the specified operation.
flutter: Error getting user settings from Firestore: [cloud_firestore/permission-denied] The caller does not have permission to execute the specified operation.
flutter: Error getting all other settings from Firestore: [cloud_firestore/permission-denied] The caller does not have permission to execute the specified operation.
flutter: Error getting all gacha settings from Firestore: [cloud_firestore/permission-denied] The caller does not have permission to execute the specified operation.
```

このエラーは、Firestoreのセキュリティルールが適切に設定されていない場合に発生します。

## 必要なFirestore Security Rules

以下のセキュリティルールをFirebase ConsoleのFirestoreセクションで設定してください。

### 基本ルール構造

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    
    // ユーザー認証チェック関数
    function isAuthenticated() {
      return request.auth != null;
    }
    
    // ユーザーが自分のデータにアクセスしているかチェック
    function isOwner(userId) {
      return isAuthenticated() && request.auth.uid == userId;
    }
    
    // ============================================================
    // ユーザー設定へのアクセス
    // ============================================================
    match /users/{userId} {
      // ユーザーは自分のドキュメントを読み書きできる
      allow read, write: if isOwner(userId);
      
      // ============================================================
      // 設定コレクション
      // ============================================================
      match /settings/{settingDoc} {
        // ユーザーは自分の設定ドキュメントを読み書きできる
        // settingDocには以下が含まれる:
        // - user_settings
        // - premium_purchased
        // - gacha_settings (サブコレクションの親)
        // - other_settings (サブコレクションの親)
        allow read, write: if isOwner(userId);
        
        // ============================================================
        // ガチャ設定サブコレクション
        // ============================================================
        // パス: users/{userId}/settings/gacha_settings/gacha_types/{gachaType}
        match /gacha_settings/{gachaSettingsDoc} {
          match /gacha_types/{gachaType} {
            allow read, write: if isOwner(userId);
          }
        }
        
        // ============================================================
        // その他の設定サブコレクション
        // ============================================================
        // パス: users/{userId}/settings/other_settings/keys/{key}
        match /other_settings/{otherSettingsDoc} {
          match /keys/{key} {
            allow read, write: if isOwner(userId);
          }
        }
      }
      
      // ============================================================
      // 学習記録コレクション
      // ============================================================
      // パス: users/{userId}/learning_records/{problemId}
      match /learning_records/{problemId} {
        allow read, write: if isOwner(userId);
      }
    }
  }
}
```

## 設定手順

1. Firebase Consoleにアクセス
2. プロジェクトを選択
3. Firestore Database → Rules タブを開く
4. 上記のルールをコピー＆ペースト
5. 「公開」ボタンをクリック

## トラブルシューティング

### 特定のユーザーがアクセスできない場合

1. **ユーザーIDを確認**: エラーログに表示されるユーザーIDを確認
2. **認証状態を確認**: ユーザーが正しく認証されているか確認
3. **ルールの構文を確認**: Firebase Consoleでルールの構文エラーがないか確認

### ログで確認できる情報

アプリのログに以下のような形式でエラーが表示されます：
```
Error getting reserve problems settings from Firestore for user: jtsa1JpsgCQJbGTkEDwlNo7McXC2 - [cloud_firestore/permission-denied] The caller does not have permission to execute the specified operation.
```

このログから、どのユーザーがどの操作でエラーが発生しているかを特定できます。

## 注意事項

- セキュリティルールは即座に反映されますが、最大1分程度かかる場合があります
- テストモードでは、開発中はすべての読み書きが許可されますが、本番環境では必ず適切なルールを設定してください
- 匿名認証ユーザーも `request.auth.uid` で識別できます


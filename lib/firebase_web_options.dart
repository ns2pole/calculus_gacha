import 'package:firebase_core/firebase_core.dart';

/// Firebase Web 用（クライアント設定は公開リポジトリにコミットしないこと）。
/// 実値は Firebase Console の Web アプリ `firebaseConfig` からローカルで埋める。
///
/// 1. FlutterFire: `flutterfire configure` → 生成 `firebase_options.dart` の web ブロックを反映
/// 2. 手入力: プロジェクト設定 → マイアプリ → Web の `firebaseConfig`
///
/// Authentication を Web で使う場合は **承認済みドメイン** に `localhost` と本番ホストを追加。
abstract final class FirebaseWebOptions {
  static const FirebaseOptions current = FirebaseOptions(
    apiKey: 'REPLACE_WITH_WEB_API_KEY',
    appId: 'REPLACE_WITH_WEB_APP_ID',
    messagingSenderId: 'REPLACE_WITH_MESSAGING_SENDER_ID',
    projectId: 'REPLACE_WITH_PROJECT_ID',
    authDomain: 'REPLACE_WITH_PROJECT_ID.firebaseapp.com',
    storageBucket: 'REPLACE_WITH_PROJECT_ID.firebasestorage.app',
    measurementId: 'REPLACE_WITH_MEASUREMENT_ID_OPTIONAL',
  );

  static bool get isConfigured =>
      current.apiKey != 'REPLACE_WITH_WEB_API_KEY' &&
      current.appId != 'REPLACE_WITH_WEB_APP_ID';
}

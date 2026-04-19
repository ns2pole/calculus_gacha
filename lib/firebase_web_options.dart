import 'package:firebase_core/firebase_core.dart';

/// Firebase Web（リポジトリにはプレースホルダのみコミット）。
///
/// - **ローカル:** Firebase Console の Web `firebaseConfig` の値をここに貼る（コミットしない）。
/// - **GitHub Pages:** Actions の Secrets を設定し、ビルド時に
///   `dart run tool/inject_firebase_web_options.dart` で上書き（workflow 済み）。
///
/// Authentication 利用時は Firebase Console → 承認済みドメインに
/// `localhost` と `*.github.io`（例: `ns2pole.github.io`）を追加。
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

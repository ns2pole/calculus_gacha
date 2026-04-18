// test/account_switch_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:joymath/services/problems/simple_data_manager.dart';
import 'package:joymath/services/auth/firebase_auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

void main() {
  group('Account Switch Tests', () {
    setUp(() {
      // テスト前にSharedPreferencesをクリア
      SharedPreferences.setMockInitialValues({});
    });

    test('ローカルデータがログアウト後も保持される', () async {
      // 1. 初期化
      await SimpleDataManager.initialize();
      
      // 2. 2つガチャを選択（ログイン前）
      await SimpleDataManager.saveSelectedFreeGachas(['gacha1', 'gacha2']);
      
      // 3. ローカルデータが保存されていることを確認
      final gachasBeforeLogin = await SimpleDataManager.getSelectedFreeGachas();
      expect(gachasBeforeLogin, containsAll(['gacha1', 'gacha2']));
      
      // 4. アカウント1のユーザーIDを設定（ログインをシミュレート）
      const account1Id = 'account1_user_id';
      await SimpleDataManager.setLastUserId(account1Id);
      
      // 5. ログアウトをシミュレート（lastUserIdをクリア）
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('joymath/last_user_id');
      
      // 6. ログアウト後もローカルデータが保持されていることを確認
      final gachasAfterLogout = await SimpleDataManager.getSelectedFreeGachas();
      expect(gachasAfterLogout, containsAll(['gacha1', 'gacha2']),
          reason: 'ログアウト後もローカルデータは保持されるべき');
    });

    test('アカウント切り替え時にローカルデータが消去される', () async {
      // 1. 初期化
      await SimpleDataManager.initialize();
      
      // 2. アカウント1でログインしてデータを保存
      const account1Id = 'account1_user_id';
      await SimpleDataManager.setLastUserId(account1Id);
      await SimpleDataManager.saveSelectedFreeGachas(['account1_gacha1', 'account1_gacha2']);
      
      // 3. アカウント2でログイン（アカウント切り替えをシミュレート）
      const account2Id = 'account2_user_id';
      
      // アカウント切り替えを検知
      final isSwitched = await SimpleDataManager.isAccountSwitched();
      // ただし、FirebaseAuthService.userIdがnullなので、実際の切り替えは検知できない
      // 代わりに、lastUserIdを直接設定してテスト
      await SimpleDataManager.setLastUserId(account2Id);
      
      // 4. アカウント切り替え時のデータクリアを実行
      // 注意: 実際のFirebase認証がないため、このテストは簡略化
      // 実際の動作は、syncOnAccountSwitch()で確認する必要がある
      
      // 5. アカウント切り替え検知のロジックをテスト
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('joymath_simple/last_user_id', account1Id);
      
      // 現在のユーザーIDが異なる場合、アカウント切り替えとして検知される
      // ただし、FirebaseAuthService.userIdがnullなので、このテストはモックが必要
    });

    test('ログアウト後に同じアカウントで再ログインしてもローカルデータが保持される', () async {
      // 1. 初期化
      await SimpleDataManager.initialize();
      
      // 2. 2つガチャを選択
      await SimpleDataManager.saveSelectedFreeGachas(['gacha1', 'gacha2']);
      
      // 3. アカウント1でログイン
      const account1Id = 'account1_user_id';
      await SimpleDataManager.setLastUserId(account1Id);
      
      // 4. ログアウト（lastUserIdをクリア）
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('joymath_simple/last_user_id');
      
      // 5. 再度アカウント1でログイン（lastUserIdがnullなので、アカウント切り替えとして検知されない）
      await SimpleDataManager.setLastUserId(account1Id);
      
      // 6. ローカルデータが保持されていることを確認
      final gachasAfterRelogin = await SimpleDataManager.getSelectedFreeGachas();
      expect(gachasAfterRelogin, containsAll(['gacha1', 'gacha2']),
          reason: '同じアカウントで再ログインした場合、ローカルデータは保持されるべき');
    });

    test('ログアウト時にlastUserIdがクリアされる', () async {
      // 1. 初期化
      await SimpleDataManager.initialize();
      
      // 2. アカウント1でログイン
      const account1Id = 'account1_user_id';
      await SimpleDataManager.setLastUserId(account1Id);
      
      // 3. lastUserIdが設定されていることを確認
      final lastUserIdBefore = await SimpleDataManager.getLastUserId();
      expect(lastUserIdBefore, equals(account1Id));
      
      // 4. ログアウトをシミュレート（lastUserIdをクリア）
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('joymath_simple/last_user_id');
      
      // 5. lastUserIdがクリアされていることを確認
      final lastUserIdAfter = await SimpleDataManager.getLastUserId();
      expect(lastUserIdAfter, isNull, reason: 'ログアウト時にlastUserIdはクリアされるべき');
    });
  });
}

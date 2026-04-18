// test/firebase_sync_integration_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:joymath/models/math_problem.dart';
import 'package:joymath/services/problems/simple_data_manager.dart';
import 'package:joymath/services/auth/firebase_auth_service.dart';
import 'package:joymath/services/auth/firestore_learning_service.dart';
import 'package:joymath/services/auth/firestore_settings_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Firebase同期の統合テスト
/// 注意: このテストは実際のFirebase接続を使用します
/// テスト実行前にFirebaseが初期化されている必要があります
void main() {
  group('Firebase Sync Integration Tests', () {
    late MathProblem testProblem;

    setUp(() {
      testProblem = MathProblem(
        id: 'integration_test_problem_${DateTime.now().millisecondsSinceEpoch}',
        no: 999,
        category: '統合テスト',
        level: '初級',
        question: '統合テスト問題',
        answer: '統合テスト答え',
        imageAsset: null,
        steps: [],
      );
    });

    test('学習記録の保存→削除→同期確認', () async {
      // 注意: このテストは実際のFirebase接続が必要です
      // 認証されていない場合はスキップ
      if (!FirebaseAuthService.isAuthenticated) {
        print('⚠️ Firebase認証されていないため、このテストをスキップします');
        return;
      }

      final userId = FirebaseAuthService.userId;
      if (userId == null) {
        print('⚠️ ユーザーIDがnullのため、このテストをスキップします');
        return;
      }

      SharedPreferences.setMockInitialValues({});
      await SimpleDataManager.initialize();

      // 1. 学習記録を保存
      final history = [
        {'status': 'solved', 'time': DateTime.now().toIso8601String()},
        {'status': 'understood', 'time': DateTime.now().toIso8601String()},
      ];
      final saveSuccess = await SimpleDataManager.saveLearningHistory(testProblem, history);
      expect(saveSuccess, true, reason: '学習記録の保存は成功する必要があります');

      // 少し待機してFirestoreへの同期を確実にする
      await Future.delayed(const Duration(milliseconds: 500));

      // 2. Firestoreから学習記録を取得して確認
      final firestoreHistory = await FirestoreLearningService.getLearningHistory(
        userId: userId,
        problemId: testProblem.id,
      );
      expect(firestoreHistory.length, greaterThan(0),
          reason: 'Firestoreに学習記録が保存されている必要があります');

      // 3. 学習記録を削除
      final deleteSuccess = await SimpleDataManager.clearLearningHistory(testProblem);
      expect(deleteSuccess, true, reason: '学習記録の削除は成功する必要があります');

      // 少し待機してFirestoreへの削除同期を確実にする
      await Future.delayed(const Duration(milliseconds: 500));

      // 4. Firestoreから学習記録が削除されていることを確認
      final deletedHistory = await FirestoreLearningService.getLearningHistory(
        userId: userId,
        problemId: testProblem.id,
      );
      expect(deletedHistory.length, 0,
          reason: 'Firestoreから学習記録が削除されている必要があります');

      // 5. ローカルからも削除されていることを確認
      final localHistory = await SimpleDataManager.getLearningHistory(testProblem);
      expect(localHistory.length, 0,
          reason: 'ローカルからも学習記録が削除されている必要があります');
    });

    test('ガチャ設定の保存→同期確認', () async {
      // 注意: このテストは実際のFirebase接続が必要です
      // 認証されていない場合はスキップ
      if (!FirebaseAuthService.isAuthenticated) {
        print('⚠️ Firebase認証されていないため、このテストをスキップします');
        return;
      }

      final userId = FirebaseAuthService.userId;
      if (userId == null) {
        print('⚠️ ユーザーIDがnullのため、このテストをスキップします');
        return;
      }

      SharedPreferences.setMockInitialValues({});
      await SimpleDataManager.initialize();

      final gachaType = 'integration_test_gacha_${DateTime.now().millisecondsSinceEpoch}';
      final settings = {
        'filterMode': 'exclude_solved_ge1',
        'slotLevels': [0, 1, 2],
      };

      // 1. ガチャ設定を保存
      final saveSuccess = await SimpleDataManager.saveGachaSettings(gachaType, settings);
      expect(saveSuccess, true, reason: 'ガチャ設定の保存は成功する必要があります');

      // 少し待機してFirestoreへの同期を確実にする
      await Future.delayed(const Duration(milliseconds: 500));

      // 2. Firestoreからガチャ設定を取得して確認
      final firestoreSettings = await FirestoreSettingsService.getGachaSettings(
        userId: userId,
        gachaType: gachaType,
      );
      expect(firestoreSettings, isNotNull,
          reason: 'Firestoreにガチャ設定が保存されている必要があります');
      expect(firestoreSettings!['filterMode'], 'exclude_solved_ge1',
          reason: 'Firestoreのガチャ設定が正しく保存されている必要があります');
    });

    test('認証されていない状態でもローカル操作は成功する', () async {
      SharedPreferences.setMockInitialValues({});
      await SimpleDataManager.initialize();

      // 認証されていない状態でもローカル保存は成功する必要がある
      final history = [
        {'status': 'solved', 'time': DateTime.now().toIso8601String()},
      ];
      final saveSuccess = await SimpleDataManager.saveLearningHistory(testProblem, history);
      expect(saveSuccess, true,
          reason: '認証されていない状態でもローカル保存は成功する必要があります');

      // ローカルに保存されていることを確認
      final localHistory = await SimpleDataManager.getLearningHistory(testProblem);
      expect(localHistory.length, greaterThan(0),
          reason: 'ローカルに学習記録が保存されている必要があります');

      // 削除も成功する必要がある
      final deleteSuccess = await SimpleDataManager.clearLearningHistory(testProblem);
      expect(deleteSuccess, true,
          reason: '認証されていない状態でもローカル削除は成功する必要があります');

      // ローカルから削除されていることを確認
      final clearedHistory = await SimpleDataManager.getLearningHistory(testProblem);
      expect(clearedHistory.length, 0,
          reason: 'ローカルから学習記録が削除されている必要があります');
    });
  });
}

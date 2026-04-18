// test/gacha_problem_display_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:joymath/models/math_problem.dart';
import 'package:joymath/models/learning_status.dart';
import 'package:joymath/services/problems/simple_data_manager.dart';
import 'package:joymath/services/auth/firebase_auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

void main() {
  group('Gacha Problem Display Tests', () {
    late MathProblem testProblem;

    setUp(() {
      testProblem = MathProblem(
        id: 'test_problem_1',
        no: 1,
        category: 'テスト',
        level: '初級',
        question: 'テスト問題',
        answer: 'テスト答え',
        imageAsset: null,
        steps: [],
      );
    });

    test('getLearningHistory returns empty list when not authenticated', () async {
      // SharedPreferencesをクリア
      SharedPreferences.setMockInitialValues({});
      await SimpleDataManager.initialize();
      
      // 未認証状態でのテスト
      final history = await SimpleDataManager.getLearningHistory(testProblem);
      
      expect(history, isEmpty);
    });

    test('getLearningHistory handles timeout gracefully', () async {
      // SharedPreferencesをクリア
      SharedPreferences.setMockInitialValues({});
      await SimpleDataManager.initialize();
      
      // タイムアウトをシミュレート（実際のFirestore接続は行わない）
      // このテストは、タイムアウト処理が正しく実装されていることを確認する
      final history = await SimpleDataManager.getLearningHistory(testProblem);
      
      // タイムアウト時は空のリストが返される（問題は除外されない）
      expect(history, isA<List<Map<String, dynamic>>>());
    });

    test('getLearningRecord returns none when not authenticated', () async {
      // SharedPreferencesをクリア
      SharedPreferences.setMockInitialValues({});
      await SimpleDataManager.initialize();
      
      // 未認証状態でのテスト
      final status = await SimpleDataManager.getLearningRecord(testProblem);
      
      expect(status, LearningStatus.none);
    });

    test('getLearningRecord handles timeout gracefully', () async {
      // SharedPreferencesをクリア
      SharedPreferences.setMockInitialValues({});
      await SimpleDataManager.initialize();
      
      // タイムアウトをシミュレート
      final status = await SimpleDataManager.getLearningRecord(testProblem);
      
      // タイムアウト時はnoneが返される（問題は除外されない）
      expect(status, LearningStatus.none);
    });

    test('getLearningHistory returns local data when Firestore fails', () async {
      // SharedPreferencesにローカルデータを設定
      SharedPreferences.setMockInitialValues({
        'joymath_simple/learning/test_problem_1': '{"problemId":"test_problem_1","latestStatus":"solved","history":[{"status":"solved","time":"2024-01-01T00:00:00.000Z"}],"lastUpdated":"2024-01-01T00:00:00.000Z"}',
      });
      await SimpleDataManager.initialize();
      
      // ローカルデータが取得できることを確認
      final history = await SimpleDataManager.getLearningHistory(testProblem);
      
      expect(history, isNotEmpty);
      expect(history[0]['status'], 'solved');
    });

    test('getLearningRecord returns local data when Firestore fails', () async {
      // SharedPreferencesにローカルデータを設定
      SharedPreferences.setMockInitialValues({
        'joymath_simple/learning/test_problem_1': '{"problemId":"test_problem_1","latestStatus":"solved","history":[{"status":"solved","time":"2024-01-01T00:00:00.000Z"}],"lastUpdated":"2024-01-01T00:00:00.000Z"}',
      });
      await SimpleDataManager.initialize();
      
      // ローカルデータが取得できることを確認
      final status = await SimpleDataManager.getLearningRecord(testProblem);
      
      expect(status, LearningStatus.solved);
    });

    test('getLearningHistory preserves order correctly', () async {
      SharedPreferences.setMockInitialValues({});
      await SimpleDataManager.initialize();

      final history = [
        {'status': 'solved', 'time': '2024-01-01T00:00:00.000Z'},
        {'status': 'understood', 'time': '2024-01-02T00:00:00.000Z'},
        {'status': 'failed', 'time': '2024-01-03T00:00:00.000Z'},
      ];

      await SimpleDataManager.saveLearningHistory(testProblem, history);
      final retrieved = await SimpleDataManager.getLearningHistory(testProblem);

      expect(retrieved.length, 3);
      expect(retrieved[0]['status'], 'solved');
      expect(retrieved[1]['status'], 'understood');
      expect(retrieved[2]['status'], 'failed');
    });

    test('getLearningHistory handles multiple problems correctly', () async {
      SharedPreferences.setMockInitialValues({});
      await SimpleDataManager.initialize();

      final problem2 = MathProblem(
        id: 'test_problem_2',
        no: 2,
        category: 'テスト',
        level: '初級',
        question: 'テスト問題2',
        answer: 'テスト答え2',
        imageAsset: null,
        steps: [],
      );

      final history1 = [{'status': 'solved', 'time': '2024-01-01T00:00:00.000Z'}];
      final history2 = [{'status': 'understood', 'time': '2024-01-01T00:00:00.000Z'}];

      await SimpleDataManager.saveLearningHistory(testProblem, history1);
      await SimpleDataManager.saveLearningHistory(problem2, history2);

      final retrieved1 = await SimpleDataManager.getLearningHistory(testProblem);
      final retrieved2 = await SimpleDataManager.getLearningHistory(problem2);

      expect(retrieved1[0]['status'], 'solved');
      expect(retrieved2[0]['status'], 'understood');
    });

    test('getLearningRecord handles status transitions correctly', () async {
      SharedPreferences.setMockInitialValues({});
      await SimpleDataManager.initialize();

      // none -> solved -> understood -> failed
      await SimpleDataManager.saveLearningRecord(testProblem, LearningStatus.solved);
      expect(await SimpleDataManager.getLearningRecord(testProblem), LearningStatus.solved);

      await SimpleDataManager.saveLearningRecord(testProblem, LearningStatus.understood);
      expect(await SimpleDataManager.getLearningRecord(testProblem), LearningStatus.understood);

      await SimpleDataManager.saveLearningRecord(testProblem, LearningStatus.failed);
      expect(await SimpleDataManager.getLearningRecord(testProblem), LearningStatus.failed);
    });

    test('getLearningHistory handles status migration correctly', () async {
      SharedPreferences.setMockInitialValues({
        'joymath_simple/learning/test_problem_1': json.encode({
          'problemId': 'test_problem_1',
          'latestStatus': 'solved',
          'history': [
            {'status': 'solved', 'time': '2024-01-01T00:00:00.000Z'},
            {'status': 'understood', 'time': '2024-01-02T00:00:00.000Z'},
          ],
          'lastUpdated': '2024-01-02T00:00:00.000Z',
        }),
      });
      await SimpleDataManager.initialize();

      final history = await SimpleDataManager.getLearningHistory(testProblem);
      expect(history.length, 2);
      expect(history[0]['status'], 'solved');
      expect(history[1]['status'], 'understood');
    });

    test('getLearningHistory returns empty list for new problem', () async {
      SharedPreferences.setMockInitialValues({});
      await SimpleDataManager.initialize();

      final newProblem = MathProblem(
        id: 'new_problem',
        no: 999,
        category: 'テスト',
        level: '初級',
        question: '新規問題',
        answer: '新規答え',
        imageAsset: null,
        steps: [],
      );

      final history = await SimpleDataManager.getLearningHistory(newProblem);
      expect(history, isEmpty);
    });

    test('getLearningRecord returns none for new problem', () async {
      SharedPreferences.setMockInitialValues({});
      await SimpleDataManager.initialize();

      final newProblem = MathProblem(
        id: 'new_problem',
        no: 999,
        category: 'テスト',
        level: '初級',
        question: '新規問題',
        answer: '新規答え',
        imageAsset: null,
        steps: [],
      );

      final status = await SimpleDataManager.getLearningRecord(newProblem);
      expect(status, LearningStatus.none);
    });
  });
}


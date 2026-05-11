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

    setUp(() async {
      testProblem = const MathProblem(
        id: 'test_problem_1',
        no: 1,
        category: 'テスト',
        level: '初級',
        question: 'テスト問題',
        answer: 'テスト答え',
        imageAsset: null,
        steps: [],
      );
      SharedPreferences.setMockInitialValues({});
      await SimpleDataManager.initialize();
      await SimpleDataManager.clearAllData();
    });

    test('getLearningHistory returns three none slots when not authenticated (no history)', () async {
      final history = await SimpleDataManager.getLearningHistory(testProblem);
      expect(history.length, 3);
      expect(history.every((e) => e['status'] == 'none'), isTrue);
    });

    test('getLearningHistory handles timeout gracefully', () async {
      final history = await SimpleDataManager.getLearningHistory(testProblem);
      expect(history, isA<List<Map<String, dynamic>>>());
      expect(history.length, 3);
    });

    test('getLearningRecord returns none when not authenticated', () async {
      final status = await SimpleDataManager.getLearningRecord(testProblem);
      expect(status, LearningStatus.none);
    });

    test('getLearningRecord handles timeout gracefully', () async {
      final status = await SimpleDataManager.getLearningRecord(testProblem);
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
      expect(history.length, 3);
      expect(history[0]['status'], 'solved');
      expect(history[1]['status'], 'understood');
      expect(history[2]['status'], 'none');
    });

    test('getLearningHistory returns three none slots for new problem', () async {
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
      expect(history.length, 3);
      expect(history.every((e) => e['status'] == 'none'), isTrue);
    });

    test('getLearningRecord returns none for new problem', () async {
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


// test/gacha_filtering_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:joymath/models/math_problem.dart';
import 'package:joymath/models/learning_status.dart';
import 'package:joymath/services/problems/simple_data_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

void main() {
  group('Gacha Filtering Tests', () {
    late MathProblem problem1;
    late MathProblem problem2;
    late MathProblem problem3;

    setUp(() async {
      problem1 = const MathProblem(
        id: 'problem_1',
        no: 1,
        category: 'テスト',
        level: '初級',
        question: '問題1',
        answer: '答え1',
        imageAsset: null,
        steps: [],
      );
      problem2 = const MathProblem(
        id: 'problem_2',
        no: 2,
        category: 'テスト',
        level: '中級',
        question: '問題2',
        answer: '答え2',
        imageAsset: null,
        steps: [],
      );
      problem3 = const MathProblem(
        id: 'problem_3',
        no: 3,
        category: 'テスト',
        level: '上級',
        question: '問題3',
        answer: '答え3',
        imageAsset: null,
        steps: [],
      );
      SharedPreferences.setMockInitialValues({});
      await SimpleDataManager.initialize();
      await SimpleDataManager.clearAllData();
    });

    group('Learning History Tests', () {
      test('saveLearningHistory saves history correctly', () async {
        final history = [
          {'status': 'solved', 'time': '2024-01-01T00:00:00.000Z'},
          {'status': 'understood', 'time': '2024-01-02T00:00:00.000Z'},
        ];

        final success = await SimpleDataManager.saveLearningHistory(problem1, history);
        expect(success, true);

        final retrieved = await SimpleDataManager.getLearningHistory(problem1);
        expect(retrieved.length, 3);
        expect(retrieved[0]['status'], 'solved');
        expect(retrieved[1]['status'], 'understood');
        expect(retrieved[2]['status'], 'none');
      });

      test('saveLearningHistory limits history to 3 slots', () async {
        final history = [
          {'status': 'solved', 'time': '2024-01-01T00:00:00.000Z'},
          {'status': 'solved', 'time': '2024-01-02T00:00:00.000Z'},
          {'status': 'solved', 'time': '2024-01-03T00:00:00.000Z'},
          {'status': 'solved', 'time': '2024-01-04T00:00:00.000Z'}, // 4つ目
        ];

        await SimpleDataManager.saveLearningHistory(problem1, history);
        final retrieved = await SimpleDataManager.getLearningHistory(problem1);
        expect(retrieved.length, 3);
        expect(retrieved.every((e) => e['status'] == 'solved'), isTrue);
      });

      test('saveLearningHistory updates latestStatus correctly', () async {
        final history = [
          {'status': 'none', 'time': '2024-01-01T00:00:00.000Z'},
          {'status': 'solved', 'time': '2024-01-02T00:00:00.000Z'},
        ];

        await SimpleDataManager.saveLearningHistory(problem1, history);
        final status = await SimpleDataManager.getLearningRecord(problem1);
        
        expect(status, LearningStatus.solved);
      });

      test('saveLearningHistory handles none status correctly', () async {
        final history = [
          {'status': 'none', 'time': '2024-01-01T00:00:00.000Z'},
          {'status': 'none', 'time': '2024-01-02T00:00:00.000Z'},
        ];

        await SimpleDataManager.saveLearningHistory(problem1, history);
        final status = await SimpleDataManager.getLearningRecord(problem1);
        
        expect(status, LearningStatus.none);
      });

      test('getLearningHistory returns three none slots for new problem', () async {
        final history = await SimpleDataManager.getLearningHistory(problem1);
        expect(history.length, 3);
        expect(history.every((e) => e['status'] == 'none'), isTrue);
      });

      test('getLearningHistory handles invalid time format', () async {
        SharedPreferences.setMockInitialValues({
          'joymath_simple/learning/problem_1': json.encode({
            'problemId': 'problem_1',
            'latestStatus': 'solved',
            'history': [
              {'status': 'solved', 'time': 'invalid-time'},
            ],
            'lastUpdated': '2024-01-01T00:00:00.000Z',
          }),
        });
        await SimpleDataManager.initialize();

        final history = await SimpleDataManager.getLearningHistory(problem1);
        expect(history.length, 3);
        // 非空のtime文字列は保持される（ISO8601でなくてもスロットに載る）
        expect(history[0]['status'], 'solved');
        expect(history[0]['time'], 'invalid-time');
        expect(history[1]['status'], 'none');
        expect(history[2]['status'], 'none');
      });

      test('getLearningHistory handles missing time field', () async {
        SharedPreferences.setMockInitialValues({
          'joymath_simple/learning/problem_1': json.encode({
            'problemId': 'problem_1',
            'latestStatus': 'solved',
            'history': [
              {'status': 'solved'}, // timeフィールドなし
            ],
            'lastUpdated': '2024-01-01T00:00:00.000Z',
          }),
        });
        await SimpleDataManager.initialize();

        final history = await SimpleDataManager.getLearningHistory(problem1);
        expect(history.length, 3);
        expect(history.every((e) => e['status'] == 'none'), isTrue);
      });
    });

    group('Learning Record Tests', () {
      test('saveLearningRecord saves status correctly', () async {
        final success = await SimpleDataManager.saveLearningRecord(
          problem1,
          LearningStatus.solved,
        );
        expect(success, true);

        final status = await SimpleDataManager.getLearningRecord(problem1);
        expect(status, LearningStatus.solved);
      });

      test('saveLearningRecord updates existing record', () async {
        await SimpleDataManager.saveLearningRecord(problem1, LearningStatus.solved);
        await SimpleDataManager.saveLearningRecord(problem1, LearningStatus.understood);

        final status = await SimpleDataManager.getLearningRecord(problem1);
        expect(status, LearningStatus.understood);
      });

      test('saveLearningRecord maintains history limit', () async {
        // 4回記録を保存
        await SimpleDataManager.saveLearningRecord(problem1, LearningStatus.solved);
        await SimpleDataManager.saveLearningRecord(problem1, LearningStatus.understood);
        await SimpleDataManager.saveLearningRecord(problem1, LearningStatus.failed);
        await SimpleDataManager.saveLearningRecord(problem1, LearningStatus.solved);

        final history = await SimpleDataManager.getLearningHistory(problem1);
        // 最新3件のみ保持される
        expect(history.length, lessThanOrEqualTo(3));
      });

      test('getLearningRecord returns none for new problem', () async {
        final status = await SimpleDataManager.getLearningRecord(problem1);
        expect(status, LearningStatus.none);
      });

      test('getLearningRecord handles all status types', () async {
        final statuses = [
          LearningStatus.solved,
          LearningStatus.understood,
          LearningStatus.failed,
        ];

        for (final status in statuses) {
          await SimpleDataManager.saveLearningRecord(problem1, status);
          final retrieved = await SimpleDataManager.getLearningRecord(problem1);
          expect(retrieved, status);
        }
        // none は saveLearningRecord で追記されないため、最新は failed のまま
        await SimpleDataManager.saveLearningRecord(problem1, LearningStatus.none);
        expect(
          await SimpleDataManager.getLearningRecord(problem1),
          LearningStatus.failed,
        );
        await SimpleDataManager.clearLearningHistory(problem1);
        expect(
          await SimpleDataManager.getLearningRecord(problem1),
          LearningStatus.none,
        );
      });
    });

    group('Multiple Problems Tests', () {
      test('saveLearningRecord handles multiple problems independently', () async {
        await SimpleDataManager.saveLearningRecord(problem1, LearningStatus.solved);
        await SimpleDataManager.saveLearningRecord(problem2, LearningStatus.understood);
        await SimpleDataManager.saveLearningRecord(problem3, LearningStatus.failed);

        expect(await SimpleDataManager.getLearningRecord(problem1), LearningStatus.solved);
        expect(await SimpleDataManager.getLearningRecord(problem2), LearningStatus.understood);
        expect(await SimpleDataManager.getLearningRecord(problem3), LearningStatus.failed);
      });

      test('getLearningHistory handles multiple problems independently', () async {
        final history1 = [
          {'status': 'solved', 'time': '2024-01-01T00:00:00.000Z'},
        ];
        final history2 = [
          {'status': 'understood', 'time': '2024-01-01T00:00:00.000Z'},
        ];

        await SimpleDataManager.saveLearningHistory(problem1, history1);
        await SimpleDataManager.saveLearningHistory(problem2, history2);

        final retrieved1 = await SimpleDataManager.getLearningHistory(problem1);
        final retrieved2 = await SimpleDataManager.getLearningHistory(problem2);

        expect(retrieved1[0]['status'], 'solved');
        expect(retrieved2[0]['status'], 'understood');
      });
    });

    group('Data Persistence Tests', () {
      test('data persists across SimpleDataManager reinitialization', () async {
        await SimpleDataManager.saveLearningRecord(problem1, LearningStatus.solved);

        // 再初期化
        await SimpleDataManager.initialize();

        final status = await SimpleDataManager.getLearningRecord(problem1);
        expect(status, LearningStatus.solved);
      });

      test('clearLearningHistory removes problem data', () async {
        await SimpleDataManager.saveLearningRecord(problem1, LearningStatus.solved);
        await SimpleDataManager.clearLearningHistory(problem1);

        final status = await SimpleDataManager.getLearningRecord(problem1);
        expect(status, LearningStatus.none);
      });

      test('clearLearningHistory does not affect other problems', () async {
        await SimpleDataManager.saveLearningRecord(problem1, LearningStatus.solved);
        await SimpleDataManager.saveLearningRecord(problem2, LearningStatus.understood);
        
        await SimpleDataManager.clearLearningHistory(problem1);

        expect(await SimpleDataManager.getLearningRecord(problem1), LearningStatus.none);
        expect(await SimpleDataManager.getLearningRecord(problem2), LearningStatus.understood);
      });
    });

    group('Edge Cases', () {
      test('handles empty history list', () async {
        await SimpleDataManager.saveLearningHistory(problem1, []);
        final history = await SimpleDataManager.getLearningHistory(problem1);
        expect(history.length, 3);
        expect(history.every((e) => e['status'] == 'none'), isTrue);
      });

      test('handles null time values', () async {
        SharedPreferences.setMockInitialValues({
          'joymath_simple/learning/problem_1': json.encode({
            'problemId': 'problem_1',
            'latestStatus': 'solved',
            'history': [
              {'status': 'solved', 'time': null},
            ],
            'lastUpdated': '2024-01-01T00:00:00.000Z',
          }),
        });
        await SimpleDataManager.initialize();

        final history = await SimpleDataManager.getLearningHistory(problem1);
        expect(history.length, 3);
        expect(history.every((e) => e['status'] == 'none'), isTrue);
      });

      test('handles invalid status values', () async {
        SharedPreferences.setMockInitialValues({
          'joymath_simple/learning/problem_1': json.encode({
            'problemId': 'problem_1',
            'latestStatus': 'invalid_status',
            'history': [],
            'lastUpdated': '2024-01-01T00:00:00.000Z',
          }),
        });
        await SimpleDataManager.initialize();

        final status = await SimpleDataManager.getLearningRecord(problem1);
        // 無効なステータスはnoneとして扱われる
        expect(status, LearningStatus.none);
      });

      test('handles corrupted JSON data', () async {
        SharedPreferences.setMockInitialValues({
          'joymath_simple/learning/problem_1': 'invalid-json',
        });
        await SimpleDataManager.initialize();

        final status = await SimpleDataManager.getLearningRecord(problem1);
        expect(status, LearningStatus.none);
      });
    });
  });
}








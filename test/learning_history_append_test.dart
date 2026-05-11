import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:joymath/models/math_problem.dart';
import 'package:joymath/pages/common/problem_status.dart';
import 'package:joymath/services/problems/learning_history_slots.dart';
import 'package:joymath/services/problems/simple_data_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('appendLearningHistorySlot', () {
    const problem = MathProblem(
      id: 'append_test_1',
      no: 1,
      category: 'test',
      level: '初級',
      question: 'q',
      answer: 'a',
      steps: [],
    );

    setUp(() async {
      TestWidgetsFlutterBinding.ensureInitialized();
      SharedPreferences.setMockInitialValues({});
      await SimpleDataManager.initialize();
      await SimpleDataManager.clearAllData();
    });

    test('first save writes slot 0', () async {
      final ok = await appendLearningHistorySlot(problem, ProblemStatus.solved);
      expect(ok, isTrue);

      final history = await SimpleDataManager.getLearningHistory(problem);
      expect(history.length, 3);
      expect(history[0]['status'], 'solved');
      expect(history[1]['status'], 'none');
      expect(history[2]['status'], 'none');
    });

    test('none returns false without persisting', () async {
      final ok = await appendLearningHistorySlot(problem, ProblemStatus.none);
      expect(ok, isFalse);

      final history = await SimpleDataManager.getLearningHistory(problem);
      expect(history.every((e) => e['status'] == 'none'), isTrue);
    });

    test('third save fills slot 2', () async {
      await appendLearningHistorySlot(problem, ProblemStatus.solved);
      await Future<void>.delayed(const Duration(milliseconds: 5));
      await appendLearningHistorySlot(problem, ProblemStatus.understood);
      await Future<void>.delayed(const Duration(milliseconds: 5));
      await appendLearningHistorySlot(problem, ProblemStatus.failed);

      final history = await SimpleDataManager.getLearningHistory(problem);
      expect(history[0]['status'], 'solved');
      expect(history[1]['status'], 'understood');
      expect(history[2]['status'], 'failed');
    });

    test('full slots: overwrites index 0 and clears rest', () async {
      await appendLearningHistorySlot(problem, ProblemStatus.solved);
      await Future<void>.delayed(const Duration(milliseconds: 5));
      await appendLearningHistorySlot(problem, ProblemStatus.understood);
      await Future<void>.delayed(const Duration(milliseconds: 5));
      await appendLearningHistorySlot(problem, ProblemStatus.failed);
      await Future<void>.delayed(const Duration(milliseconds: 5));
      await appendLearningHistorySlot(problem, ProblemStatus.solved);

      final history = await SimpleDataManager.getLearningHistory(problem);
      expect(history[0]['status'], 'solved');
      expect(history[1]['status'], 'none');
      expect(history[2]['status'], 'none');
    });

    test('persists status string for common ProblemStatus', () async {
      await appendLearningHistorySlot(problem, ProblemStatus.understood);
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString('joymath_simple/learning/append_test_1');
      expect(raw, isNotNull);
      final map = json.decode(raw!) as Map<String, dynamic>;
      final hist = map['history'] as List<dynamic>?;
      expect((hist![0] as Map)['status'], 'understood');
    });
  });
}

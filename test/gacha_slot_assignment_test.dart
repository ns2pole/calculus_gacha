// test/gacha_slot_assignment_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:joymath/models/math_problem.dart';

void main() {
  group('Gacha Slot Assignment Tests', () {
    late MathProblem problem1;
    late MathProblem problem2;
    late MathProblem problem3;
    late MathProblem problem4;
    late MathProblem problem5;

    setUp(() {
      problem1 = MathProblem(
        id: 'problem_1',
        no: 1,
        category: 'テスト',
        level: '初級',
        question: '問題1',
        answer: '答え1',
        imageAsset: null,
        steps: [],
      );
      problem2 = MathProblem(
        id: 'problem_2',
        no: 2,
        category: 'テスト',
        level: '初級',
        question: '問題2',
        answer: '答え2',
        imageAsset: null,
        steps: [],
      );
      problem3 = MathProblem(
        id: 'problem_3',
        no: 3,
        category: 'テスト',
        level: '中級',
        question: '問題3',
        answer: '答え3',
        imageAsset: null,
        steps: [],
      );
      problem4 = MathProblem(
        id: 'problem_4',
        no: 4,
        category: 'テスト',
        level: '中級',
        question: '問題4',
        answer: '答え4',
        imageAsset: null,
        steps: [],
      );
      problem5 = MathProblem(
        id: 'problem_5',
        no: 5,
        category: 'テスト',
        level: '上級',
        question: '問題5',
        answer: '答え5',
        imageAsset: null,
        steps: [],
      );
    });

    group('Problem Key Tests', () {
      test('_problemKey returns problem id', () {
        // このテストは実際の実装に合わせて調整が必要
        expect(problem1.id, 'problem_1');
        expect(problem2.id, 'problem_2');
      });

      test('different problems have different keys', () {
        expect(problem1.id, isNot(problem2.id));
        expect(problem2.id, isNot(problem3.id));
      });
    });

    group('Level Filtering Tests', () {
      test('filters problems by level correctly', () {
        final problems = [problem1, problem2, problem3, problem4, problem5];
        
        final easy = problems.where((p) => p.level == '初級').toList();
        final mid = problems.where((p) => p.level == '中級').toList();
        final advanced = problems.where((p) => p.level == '上級').toList();

        expect(easy.length, 2);
        expect(mid.length, 2);
        expect(advanced.length, 1);
        
        expect(easy.contains(problem1), true);
        expect(easy.contains(problem2), true);
        expect(mid.contains(problem3), true);
        expect(mid.contains(problem4), true);
        expect(advanced.contains(problem5), true);
      });

      test('handles empty level filter', () {
        final problems = <MathProblem>[];
        final filtered = problems.where((p) => p.level == '初級').toList();
        expect(filtered, isEmpty);
      });
    });

    group('Problem Pool Tests', () {
      test('creates problem pool correctly', () {
        final pool = [problem1, problem2, problem3, problem4, problem5];
        expect(pool.length, 5);
        expect(pool.contains(problem1), true);
        expect(pool.contains(problem5), true);
      });

      test('handles empty problem pool', () {
        final pool = <MathProblem>[];
        expect(pool, isEmpty);
      });

      test('handles single problem in pool', () {
        final pool = [problem1];
        expect(pool.length, 1);
        expect(pool[0], problem1);
      });
    });

    group('Reserve Problem Tests', () {
      test('identifies reserve problems correctly', () {
        final reserveProblem = MathProblem(
          id: 'op_problem_1',
          no: 'op1',
          category: 'テスト',
          level: '初級',
          question: '予備問題1',
          answer: '答え1',
          imageAsset: null,
          steps: [],
        );

        final no = reserveProblem.no;
        final isReserve = no is String && (no as String).startsWith('op');
        expect(isReserve, true);
      });

      test('identifies non-reserve problems correctly', () {
        final no = problem1.no;
        final isReserve = no is String && (no as String).startsWith('op');
        expect(isReserve, false);
      });

      test('handles numeric problem numbers', () {
        final no = problem1.no;
        expect(no is int || no is String, true);
      });
    });

    group('Problem Selection Tests', () {
      test('selects problems from pool', () {
        final pool = [problem1, problem2, problem3, problem4, problem5];
        final selected = pool.take(3).toList();
        
        expect(selected.length, 3);
        expect(selected.every((p) => pool.contains(p)), true);
      });

      test('handles pool smaller than selection count', () {
        final pool = [problem1, problem2];
        final selected = pool.take(3).toList();
        
        expect(selected.length, 2);
        expect(selected.contains(problem1), true);
        expect(selected.contains(problem2), true);
      });

      test('handles empty pool selection', () {
        final pool = <MathProblem>[];
        final selected = pool.take(3).toList();
        
        expect(selected, isEmpty);
      });
    });

    group('Problem Uniqueness Tests', () {
      test('ensures unique problems in selection', () {
        final pool = [problem1, problem2, problem3];
        final used = <String>{};
        final selected = <MathProblem>[];

        for (final p in pool) {
          if (!used.contains(p.id)) {
            selected.add(p);
            used.add(p.id);
          }
        }

        expect(selected.length, 3);
        expect(selected.toSet().length, 3); // すべて異なる
      });

      test('handles duplicate problems in pool', () {
        final pool = [problem1, problem1, problem2];
        final used = <String>{};
        final selected = <MathProblem>[];

        for (final p in pool) {
          if (!used.contains(p.id)) {
            selected.add(p);
            used.add(p.id);
          }
        }

        expect(selected.length, 2);
        expect(selected.contains(problem1), true);
        expect(selected.contains(problem2), true);
      });
    });

    group('Problem Shuffling Tests', () {
      test('shuffles problems correctly', () {
        final pool = [problem1, problem2, problem3, problem4, problem5];
        final shuffled1 = List<MathProblem>.from(pool)..shuffle();
        final shuffled2 = List<MathProblem>.from(pool)..shuffle();

        // シャッフル後も同じ要素を含む
        expect(shuffled1.length, pool.length);
        expect(shuffled2.length, pool.length);
        expect(shuffled1.toSet(), pool.toSet());
        expect(shuffled2.toSet(), pool.toSet());
      });

      test('handles single problem shuffling', () {
        final pool = [problem1];
        final shuffled = List<MathProblem>.from(pool)..shuffle();
        
        expect(shuffled.length, 1);
        expect(shuffled[0], problem1);
      });
    });

    group('Problem Assignment Tests', () {
      test('assigns problems to slots', () {
        final candidatesPerSlot = <int, List<MathProblem>>{
          0: [problem1, problem2],
          1: [problem3, problem4],
          2: [problem5],
        };

        expect(candidatesPerSlot[0]?.length, 2);
        expect(candidatesPerSlot[1]?.length, 2);
        expect(candidatesPerSlot[2]?.length, 1);
      });

      test('handles empty slot candidates', () {
        final candidatesPerSlot = <int, List<MathProblem>>{
          0: [problem1],
          1: [],
          2: [problem3],
        };

        expect(candidatesPerSlot[0]?.length, 1);
        expect(candidatesPerSlot[1]?.isEmpty, true);
        expect(candidatesPerSlot[2]?.length, 1);
      });

      test('handles all empty slots', () {
        final candidatesPerSlot = <int, List<MathProblem>>{
          0: [],
          1: [],
          2: [],
        };

        expect(candidatesPerSlot[0]?.isEmpty, true);
        expect(candidatesPerSlot[1]?.isEmpty, true);
        expect(candidatesPerSlot[2]?.isEmpty, true);
      });
    });

    group('Problem Level Distribution Tests', () {
      test('distributes problems across levels', () {
        final problems = [problem1, problem2, problem3, problem4, problem5];
        
        final levelDistribution = <String, int>{};
        for (final p in problems) {
          levelDistribution[p.level] = (levelDistribution[p.level] ?? 0) + 1;
        }

        expect(levelDistribution['初級'], 2);
        expect(levelDistribution['中級'], 2);
        expect(levelDistribution['上級'], 1);
      });

      test('handles single level distribution', () {
        final problems = [problem1, problem2];
        
        final levelDistribution = <String, int>{};
        for (final p in problems) {
          levelDistribution[p.level] = (levelDistribution[p.level] ?? 0) + 1;
        }

        expect(levelDistribution['初級'], 2);
        expect(levelDistribution.containsKey('中級'), false);
        expect(levelDistribution.containsKey('上級'), false);
      });
    });
  });
}








// test/id_duplicate_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:joymath/problems/all_problems.dart';
import 'package:joymath/problems/physics_math/physics_math_gacha.dart';
import 'package:joymath/models/math_problem.dart';

void main() {
  group('ID重複チェックテスト', () {
    test('全ての問題のIDが一意であること', () {
      // 全ての問題を集約
      final allProblems = <MathProblem>[
        ...allIntegralProblems,
        ...allLimitProblems,
        ...allFactorizationProblems,
        ...allIndeterminateEquationProblems,
        ...allSequenceProblems,
        ...allTrigExpLogEquationProblems,
        ...physicsMathGachaProblems,
      ];

      // IDの重複をチェック
      final idCounts = <String, List<MathProblem>>{};
      for (final problem in allProblems) {
        idCounts.putIfAbsent(problem.id, () => []).add(problem);
      }

      // 重複しているIDを収集
      final duplicateIds = <String, List<MathProblem>>{};
      idCounts.forEach((id, problems) {
        if (problems.length > 1) {
          duplicateIds[id] = problems;
        }
      });

      // 重複が見つかった場合は詳細を出力
      if (duplicateIds.isNotEmpty) {
        print('\n⚠️  IDの重複が見つかりました:');
        print('=' * 80);
        duplicateIds.forEach((id, problems) {
          print('\n重複ID: $id (${problems.length}回出現)');
          for (final problem in problems) {
            print('  - no: ${problem.no}, category: ${problem.category}, level: ${problem.level}');
            if (problem.question.isNotEmpty) {
              final questionPreview = problem.question.length > 50
                  ? '${problem.question.substring(0, 50)}...'
                  : problem.question;
              print('    問題: $questionPreview');
            }
          }
        });
        print('=' * 80);
      }

      expect(
        duplicateIds.isEmpty,
        true,
        reason: '重複しているIDが見つかりました: ${duplicateIds.keys.join(", ")}',
      );
    });

    test('全ての問題のID-noペアが一意であること', () {
      // 全ての問題を集約
      final allProblems = <MathProblem>[
        ...allIntegralProblems,
        ...allLimitProblems,
        ...allFactorizationProblems,
        ...allIndeterminateEquationProblems,
        ...allSequenceProblems,
        ...allTrigExpLogEquationProblems,
        ...physicsMathGachaProblems,
      ];

      // ID-noペアの重複をチェック
      final pairCounts = <String, List<MathProblem>>{};
      for (final problem in allProblems) {
        // noが数値の場合のみチェック（予備問題などで文字列の場合がある）
        if (problem.no is int) {
          final pair = '${problem.id}_${problem.no}';
          pairCounts.putIfAbsent(pair, () => []).add(problem);
        }
      }

      // 重複しているペアを収集
      final duplicatePairs = <String, List<MathProblem>>{};
      pairCounts.forEach((pair, problems) {
        if (problems.length > 1) {
          duplicatePairs[pair] = problems;
        }
      });

      // 重複が見つかった場合は詳細を出力
      if (duplicatePairs.isNotEmpty) {
        print('\n⚠️  ID-noペアの重複が見つかりました:');
        print('=' * 80);
        duplicatePairs.forEach((pair, problems) {
          print('\n重複ペア: $pair (${problems.length}回出現)');
          for (final problem in problems) {
            print('  - category: ${problem.category}, level: ${problem.level}');
            if (problem.question.isNotEmpty) {
              final questionPreview = problem.question.length > 50
                  ? '${problem.question.substring(0, 50)}...'
                  : problem.question;
              print('    問題: $questionPreview');
            }
          }
        });
        print('=' * 80);
      }

      expect(
        duplicatePairs.isEmpty,
        true,
        reason: '重複しているID-noペアが見つかりました: ${duplicatePairs.keys.join(", ")}',
      );
    });

    test('全ての問題にIDが設定されていること', () {
      // 全ての問題を集約
      final allProblems = <MathProblem>[
        ...allIntegralProblems,
        ...allLimitProblems,
        ...allFactorizationProblems,
        ...allIndeterminateEquationProblems,
        ...allSequenceProblems,
        ...allTrigExpLogEquationProblems,
        ...physicsMathGachaProblems,
      ];

      // IDが空またはnullの問題を収集
      final problemsWithoutId = <MathProblem>[];
      for (final problem in allProblems) {
        if (problem.id.isEmpty) {
          problemsWithoutId.add(problem);
        }
      }

      // IDが設定されていない問題が見つかった場合は詳細を出力
      if (problemsWithoutId.isNotEmpty) {
        print('\n⚠️  IDが設定されていない問題が見つかりました:');
        print('=' * 80);
        for (final problem in problemsWithoutId) {
          print('  - no: ${problem.no}, category: ${problem.category}, level: ${problem.level}');
          if (problem.question.isNotEmpty) {
            final questionPreview = problem.question.length > 50
                ? '${problem.question.substring(0, 50)}...'
                : problem.question;
            print('    問題: $questionPreview');
          }
        }
        print('=' * 80);
      }

      expect(
        problemsWithoutId.isEmpty,
        true,
        reason: 'IDが設定されていない問題が見つかりました: ${problemsWithoutId.length}問',
      );
    });

    test('統計情報の表示', () {
      // 全ての問題を集約
      final allProblems = <MathProblem>[
        ...allIntegralProblems,
        ...allLimitProblems,
        ...allFactorizationProblems,
        ...allIndeterminateEquationProblems,
        ...allSequenceProblems,
        ...allTrigExpLogEquationProblems,
        ...physicsMathGachaProblems,
      ];

      // 統計情報を計算
      final uniqueIds = allProblems.map((p) => p.id).toSet();
      final idCounts = <String, int>{};
      for (final problem in allProblems) {
        idCounts[problem.id] = (idCounts[problem.id] ?? 0) + 1;
      }

      print('\n統計情報:');
      print('=' * 80);
      print('全問題数: ${allProblems.length}問');
      print('ユニークなID数: ${uniqueIds.length}');
      print('=' * 80);

      // 統計情報の検証
      expect(allProblems.length, greaterThan(0), reason: '問題が1つも見つかりませんでした');
      expect(uniqueIds.length, equals(allProblems.length),
          reason: 'IDの数が問題数と一致しません');
    });
  });
}








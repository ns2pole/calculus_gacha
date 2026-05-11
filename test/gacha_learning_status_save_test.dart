// ガチャ3問：学習記録（スロット状態）の保存は SimpleDataManager.saveLearningHistory 経由。
// 別ライブラリで同名 enum を二重定義すると Dart では別型のため、_statusKeyFromValue で
// `status is ProblemStatus` が常に偽となり、すべて 'none' として保存されて壊れる。
// gacha_page は pages/common/problem_status.dart の ProblemStatus のみ使うこと。

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:joymath/models/math_problem.dart';
import 'package:joymath/pages/common/problem_status.dart' as common;
import 'package:joymath/services/problems/simple_data_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'support/duplicate_problem_status_stub.dart';

void main() {
  group('Gacha / learning history save (ProblemStatus type identity)', () {
    test('common ProblemStatus.solved is persisted as solved (not none)', () async {
      TestWidgetsFlutterBinding.ensureInitialized();
      SharedPreferences.setMockInitialValues({});

      const problem = MathProblem(
        id: 'gacha_save_solved_1',
        no: 1,
        category: 'test',
        level: '初級',
        question: 'q',
        answer: 'a',
        steps: [],
      );

      final ok = await SimpleDataManager.saveLearningHistory(
        problem,
        [
          {
            'status': common.ProblemStatus.solved,
            'time': '2020-01-15T12:00:00.000Z',
          },
        ],
      );
      expect(ok, isTrue);

      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString('joymath_simple/learning/gacha_save_solved_1');
      expect(raw, isNotNull);
      final map = json.decode(raw!) as Map<String, dynamic>;
      final hist = map['history'] as List<dynamic>?;
      expect(hist, isNotEmpty);
      expect(hist![0] is Map, isTrue);
      expect((hist[0] as Map)['status'], 'solved');
    });

    test('regression: duplicate enum (another library) is NOT ProblemStatus and saves as none', () async {
      // 旧 gacha_page 内の重複 enum と同パターン。SimpleDataManager は型一致しない enum を
      // 正規化して 'none' になる。ガチャに別定義の ProblemStatus を戻さないこと。

      TestWidgetsFlutterBinding.ensureInitialized();
      SharedPreferences.setMockInitialValues({});

      const problem = MathProblem(
        id: 'gacha_save_wrong_enum_1',
        no: 1,
        category: 'test',
        level: '初級',
        question: 'q',
        answer: 'a',
        steps: [],
      );

      final ok = await SimpleDataManager.saveLearningHistory(
        problem,
        [
          {
            'status': OtherProblemStatus.solved, // 別 enum — SimpleDataManager の ProblemStatus ではない
            'time': '2020-01-16T12:00:00.000Z',
          },
        ],
      );
      expect(ok, isTrue);

      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString('joymath_simple/learning/gacha_save_wrong_enum_1')!;
      final map = json.decode(raw) as Map<String, dynamic>;
      final hist = map['history'] as List<dynamic>?;
      expect(hist, isNotEmpty);
      // 誤型の場合、保存される status は 'none' になる
      expect((hist![0] as Map)['status'], 'none');
    });
  });
}

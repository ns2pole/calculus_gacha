import 'package:flutter_test/flutter_test.dart';

import 'package:joymath/models/math_problem.dart';
import 'package:joymath/problems/all_problems.dart';
import 'package:joymath/problems/physics_math/physics_math_gacha.dart';
import 'package:joymath/services/problems/translation_manager.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('EN steps are not shorter than JP steps (only checks translation.steps != null)', () {
    final allProblems = <MathProblem>[
      ...allIntegralProblems,
      ...allLimitProblems,
      ...allFactorizationProblems,
      ...allIndeterminateEquationProblems,
      ...allSequenceProblems,
      ...allTrigExpLogEquationProblems,
      ...physicsMathGachaProblems,
    ];

    // De-dup by id (some pools may overlap).
    final byId = <String, MathProblem>{};
    for (final p in allProblems) {
      byId[p.id] = p;
    }

    final shortages = <String, ({int jpLen, int enLen, String category, String level})>{};
    int longerCount = 0;
    int missingTranslationStepsCount = 0;

    for (final p in byId.values) {
      final jpLen = p.steps.length;
      final t = TranslationManager.getTranslation('en', p.id);
      final enSteps = t?.steps;
      if (enSteps == null) {
        missingTranslationStepsCount++;
        continue; // “unknown / left as-is” per spec
      }
      final enLen = enSteps.length;
      if (enLen < jpLen) {
        shortages[p.id] = (jpLen: jpLen, enLen: enLen, category: p.category, level: p.level);
      } else if (enLen > jpLen) {
        longerCount++;
      }
    }

    if (shortages.isNotEmpty) {
      final ids = shortages.keys.toList()..sort();
      final b = StringBuffer()
        ..writeln('Found ${shortages.length} problems where EN steps are shorter than JP steps.')
        ..writeln('These will now fall back to JP due to strict length-match rules, so please fill in the missing EN translations.')
        ..writeln('');
      for (final id in ids) {
        final s = shortages[id]!;
        b.writeln('- $id (jp=${s.jpLen}, en=${s.enLen}) [${s.level}] ${s.category}');
      }
      b
        ..writeln('')
        ..writeln('Notes:')
        ..writeln('- translation.steps == null (count=$missingTranslationStepsCount) is ignored by design.')
        ..writeln('- translation.steps longer than JP (count=$longerCount) is also ignored by design.');

      fail(b.toString());
    }
  });
}




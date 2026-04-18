import 'package:joymath/models/math_problem.dart';
import 'package:joymath/problems/all_problems.dart';
import 'package:joymath/problems/physics_math/physics_math_problems.dart';
import 'package:joymath/problems/translations/en/congruence_equations_en.dart';
import 'package:joymath/problems/translations/en/factorization_en.dart';
import 'package:joymath/problems/translations/en/indeterminate_equations_en.dart';
import 'package:joymath/problems/translations/en/integrals_en.dart';
import 'package:joymath/problems/translations/en/limits_en.dart';
import 'package:joymath/problems/translations/en/physics_math_en.dart';
import 'package:joymath/problems/translations/en/sequences_en.dart';
import 'package:joymath/problems/translations/en/trig_exp_log_equations_en.dart';
import 'package:joymath/services/problems/translation_manager.dart';

void main(List<String> args) {
  final physicsMathProblemsWithoutUniversity = generalProblems
      .where((problem) => !problem.keywords.contains('大学'))
      .toList(growable: false);

  final allProblems = <MathProblem>[
    ...allIntegralProblems,
    ...allLimitProblems,
    ...allFactorizationProblems,
    ...allIndeterminateEquationProblems,
    ...allSequenceProblems,
    ...allTrigExpLogEquationProblems,
    ...physicsMathProblemsWithoutUniversity,
  ];

  final byId = <String, MathProblem>{};
  for (final p in allProblems) {
    byId[p.id] = p;
  }

  // IMPORTANT: order matches TranslationManager's spread order.
  // If an ID exists in multiple maps, the later map overrides the earlier one.
  final mapsByName = <String, Map<String, dynamic>>{
    'integrals_en': integralsTranslationsEn,
    'limits_en': limitsTranslationsEn,
    'factorization_en': factorizationTranslationsEn,
    'indeterminate_equations_en': indeterminateEquationsTranslationsEn,
    'sequences_en': sequencesTranslationsEn,
    'trig_exp_log_equations_en': trigExpLogEquationsTranslationsEn,
    'physics_math_en': physicsMathTranslationsEn,
    'congruence_equations_en': congruenceEquationsTranslationsEn,
  };

  final shortageIds = <String>[];
  for (final p in byId.values) {
    final jpLen = p.steps.length;
    final t = TranslationManager.getTranslation('en', p.id);
    final enSteps = t?.steps;
    if (enSteps == null) continue;
    if (enSteps.length < jpLen) {
      shortageIds.add(p.id);
    }
  }
  shortageIds.sort();

  final counts = <String, int>{};
  final unknown = <String>[];
  final effectiveMapById = <String, String>{};
  for (final id in shortageIds) {
    // Pick the LAST matching map to reflect override behavior.
    String? found;
    for (final entry in mapsByName.entries) {
      if (entry.value.containsKey(id)) {
        found = entry.key;
      }
    }
    if (found == null) {
      unknown.add(id);
      continue;
    }
    effectiveMapById[id] = found;
    counts[found] = (counts[found] ?? 0) + 1;
  }

  print('Total shortages: ${shortageIds.length}');
  for (final name in counts.keys.toList()..sort()) {
    print('- $name: ${counts[name]}');
  }
  if (unknown.isNotEmpty) {
    print('Unknown map for ${unknown.length} ids (should be 0):');
    for (final id in unknown) {
      print('- $id');
    }
  }

  if (args.isEmpty) return;
  final target = args.first;
  final targetMap = mapsByName[target];
  if (targetMap == null) {
    print('Unknown target map: $target');
    print('Known maps: ${mapsByName.keys.join(', ')}');
    return;
  }

  print('');
  print('--- Shortages in $target ---');
  for (final id in shortageIds) {
    if (effectiveMapById[id] != target) continue;
    final p = byId[id]!;
    final jpLen = p.steps.length;
    final enLen = TranslationManager.getTranslation('en', id)!.steps!.length;
    print('- $id (jp=$jpLen, en=$enLen) [${p.level}] ${p.category}');
  }
}



import 'dart:io';

import '../lib/models/math_problem.dart';
import '../lib/problems/all_problems.dart';
import '../lib/problems/congruence_equations/congruence_equations.dart';
import '../lib/problems/physics_math/physics_math_problems.dart';
import '../lib/services/problems/translation_manager.dart';

bool _isNonEmpty(String? s) => s != null && s.trim().isNotEmpty;

String _snippet(String? s, {int max = 80}) {
  if (s == null) return '';
  final oneLine = s.replaceAll(RegExp(r'\s+'), ' ').trim();
  if (oneLine.length <= max) return oneLine;
  return '${oneLine.substring(0, max)}...';
}

class _MissingItem {
  final String poolKey;
  final String id;
  final int? no;
  final String field; // "hint" or "shortExplanation"
  final String jpSnippet;
  final bool hasEnEntry;

  const _MissingItem({
    required this.poolKey,
    required this.id,
    required this.no,
    required this.field,
    required this.jpSnippet,
    required this.hasEnEntry,
  });
}

List<_MissingItem> _scanMathProblems({
  required String poolKey,
  required List<MathProblem> problems,
}) {
  final missing = <_MissingItem>[];

  for (final p in problems) {
    if (!_isNonEmpty(p.hint)) continue; // only care when JP hint exists

    final en = TranslationManager.getTranslation('en', p.id);
    final enHint = en?.hint;
    final ok = _isNonEmpty(enHint);
    if (ok) continue;

    missing.add(
      _MissingItem(
        poolKey: poolKey,
        id: p.id,
        no: p.no,
        field: 'hint',
        jpSnippet: _snippet(p.hint),
        hasEnEntry: en != null,
      ),
    );
  }

  return missing;
}

List<_MissingItem> _scanCongruenceProblems() {
  // Congruence gacha uses `shortExplanation` as the “hint” UI.
  final missing = <_MissingItem>[];

  for (final cp in congruenceGachaProblems) {
    if (!_isNonEmpty(cp.shortExplanation)) continue; // only care when JP shortExplanation exists

    final en = TranslationManager.getTranslation('en', cp.id);
    final enShort = en?.shortExplanation;
    final ok = _isNonEmpty(enShort);
    if (ok) continue;

    missing.add(
      _MissingItem(
        poolKey: 'congruence',
        id: cp.id,
        no: cp.no,
        field: 'shortExplanation',
        jpSnippet: _snippet(cp.shortExplanation),
        hasEnEntry: en != null,
      ),
    );
  }

  return missing;
}

Map<String, List<MathProblem>> _mathProblemPools() {
  // These are the pools actually used by gacha pages / screens.
  return {
    'integral': allIntegralProblems,
    'limit': allLimitProblems,
    'factorization': allFactorizationProblems,
    'indeterminate_equation': allIndeterminateEquationProblems,
    'sequence': allSequenceProblems,
    'trig_exp_log_equation': allTrigExpLogEquationProblems,
    // physics_math_gacha.dart filters out problems with keyword '大学' for the gacha pool.
    'physics_math': generalProblems.where((p) => !p.keywords.contains('大学')).toList(),
  };
}

Future<void> main() async {
  final pools = _mathProblemPools();

  final allMissing = <_MissingItem>[];
  final totalWithHintByPool = <String, int>{};

  for (final entry in pools.entries) {
    final poolKey = entry.key;
    final problems = entry.value;

    final withHint = problems.where((p) => _isNonEmpty(p.hint)).length;
    totalWithHintByPool[poolKey] = withHint;

    allMissing.addAll(_scanMathProblems(poolKey: poolKey, problems: problems));
  }

  // Congruence is not MathProblem-based in its source list.
  final congruenceWithHint = congruenceGachaProblems.where((p) => _isNonEmpty(p.shortExplanation)).length;
  totalWithHintByPool['congruence'] = congruenceWithHint;
  allMissing.addAll(_scanCongruenceProblems());

  // Group by pool
  final byPool = <String, List<_MissingItem>>{};
  for (final item in allMissing) {
    byPool.putIfAbsent(item.poolKey, () => []).add(item);
  }

  // Sort output (stable)
  for (final list in byPool.values) {
    list.sort((a, b) {
      final an = a.no ?? 1 << 30;
      final bn = b.no ?? 1 << 30;
      if (an != bn) return an.compareTo(bn);
      return a.id.compareTo(b.id);
    });
  }

  final report = StringBuffer();
  report.writeln('# Missing EN hint translations report');
  report.writeln();
  report.writeln('- Generated: ${DateTime.now().toIso8601String()}');
  report.writeln('- Criteria: JP hint exists, but EN translation for that hint field is missing/empty');
  report.writeln();

  final poolKeys = [
    ...pools.keys,
    'congruence',
  ];

  int totalWithHint = 0;
  int totalMissing = 0;
  for (final k in poolKeys) {
    totalWithHint += totalWithHintByPool[k] ?? 0;
    totalMissing += (byPool[k]?.length ?? 0);
  }

  report.writeln('## Summary');
  report.writeln();
  report.writeln('- Total problems with a JP hint: **$totalWithHint**');
  report.writeln('- Total missing EN hint translations: **$totalMissing**');
  report.writeln();
  report.writeln('## By pool');
  report.writeln();

  for (final poolKey in poolKeys) {
    final withHint = totalWithHintByPool[poolKey] ?? 0;
    final missing = byPool[poolKey] ?? const <_MissingItem>[];
    report.writeln('### $poolKey');
    report.writeln();
    report.writeln('- JP hints present: **$withHint**');
    report.writeln('- Missing EN: **${missing.length}**');
    report.writeln();

    if (missing.isEmpty) {
      report.writeln('_No missing items._');
      report.writeln();
      continue;
    }

    report.writeln('| no | id | field | has EN entry? | JP snippet |');
    report.writeln('|---:|---|---|:---:|---|');
    for (final m in missing) {
      final noStr = m.no?.toString() ?? '';
      final hasEn = m.hasEnEntry ? 'yes' : 'no';
      report.writeln('| $noStr | `${m.id}` | `${m.field}` | $hasEn | ${m.jpSnippet.replaceAll('|', r'\|')} |');
    }
    report.writeln();
  }

  final outPath = 'missing_en_hint_translations_report.md';
  await File(outPath).writeAsString(report.toString());

  // Console summary (for quick feedback)
  stdout.writeln('Wrote $outPath');
  stdout.writeln('Total problems with JP hint: $totalWithHint');
  stdout.writeln('Total missing EN hint translations: $totalMissing');
  for (final poolKey in poolKeys) {
    stdout.writeln(' - $poolKey: missing ${byPool[poolKey]?.length ?? 0} / withHint ${totalWithHintByPool[poolKey] ?? 0}');
  }
}



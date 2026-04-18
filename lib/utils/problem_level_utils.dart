import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';

enum ProblemLevel {
  easy,
  mid,
  advanced,
  expert,
}

ProblemLevel? parseProblemLevel(String raw) {
  final s = raw.trim();
  if (s.isEmpty) return null;

  // Japanese
  switch (s) {
    case '初級':
      return ProblemLevel.easy;
    case '中級':
      return ProblemLevel.mid;
    case '上級':
      return ProblemLevel.advanced;
    case '発展':
      return ProblemLevel.expert;
  }

  // English (case-insensitive)
  final lower = s.toLowerCase();
  switch (lower) {
    case 'easy':
      return ProblemLevel.easy;
    case 'mid':
      return ProblemLevel.mid;
    case 'advanced':
      return ProblemLevel.advanced;
    case 'expert':
      return ProblemLevel.expert;
  }

  return null;
}

String problemLevelLabel(BuildContext context, ProblemLevel level) {
  final l10n = AppLocalizations.of(context)!;
  switch (level) {
    case ProblemLevel.easy:
      return l10n.easy;
    case ProblemLevel.mid:
      return l10n.mid;
    case ProblemLevel.advanced:
      return l10n.advanced;
    case ProblemLevel.expert:
      return l10n.expert;
  }
}

Color problemLevelColor(ProblemLevel level) {
  switch (level) {
    case ProblemLevel.easy:
      return Colors.green;
    case ProblemLevel.mid:
      return Colors.orange;
    case ProblemLevel.advanced:
      return Colors.red;
    case ProblemLevel.expert:
      return Colors.purple;
  }
}

int problemLevelRank(ProblemLevel level) {
  switch (level) {
    case ProblemLevel.easy:
      return 0;
    case ProblemLevel.mid:
      return 1;
    case ProblemLevel.advanced:
      return 2;
    case ProblemLevel.expert:
      return 3;
  }
}







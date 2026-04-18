// lib/utils/navigation_utils.dart
// ナビゲーション関連の共通ユーティリティ関数

import 'package:flutter/material.dart';
import '../models/math_problem.dart';
import '../pages/problem/problem_list_page.dart';
import '../pages/problem/physics_math_problem_list_page.dart';
import '../pages/problem/problem_detail_page.dart';
import '../pages/common/problem_status.dart';

/// 問題一覧ページに遷移する
Future<void> navigateToProblemList({
  required BuildContext context,
  required List<MathProblem> problemPool,
  required String prefsPrefix,
}) async {
  if (prefsPrefix == 'physics_math') {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PhysicsMathProblemListPage(
          problemPool: problemPool,
          prefsPrefix: prefsPrefix,
        ),
      ),
    );
  } else {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProblemListPage(
          problemPool: problemPool,
          prefsPrefix: prefsPrefix,
        ),
      ),
    );
  }
}

/// 問題詳細ページに遷移する
Future<void> navigateToProblemDetail({
  required BuildContext context,
  required MathProblem problem,
  required String prefsPrefix,
  List<Map<String, dynamic>>? initialHistory,
  int? displayNo,
  required void Function(int idx, ProblemStatus status) onAddSlot,
  required VoidCallback onClear,
}) async {
  // 学習履歴のディープコピーを作成
  final deepCopy = initialHistory != null
      ? List<Map<String, dynamic>>.from(initialHistory)
      : <Map<String, dynamic>>[];

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => ProblemDetailPage(
        problem: problem,
        displayNo: displayNo,
        initialHistory: deepCopy,
        onAddSlot: onAddSlot,
        onClear: onClear,
        prefsPrefix: prefsPrefix,
      ),
    ),
  );
}


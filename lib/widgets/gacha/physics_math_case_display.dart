// physics_math_case_display.dart
// 微分方程式ガチャ専用のCASE形式表示ウィジェット

import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

/// 物理数学の問題をCASE形式で表示するウィジェット
/// 微分方程式と初期条件を2行程度でコンパクトに表示
class PhysicsMathCaseDisplay extends StatefulWidget {
  final String equation;
  final String conditions;
  final String? constants;
  final double? fontSize;

  const PhysicsMathCaseDisplay({
    Key? key,
    required this.equation,
    required this.conditions,
    this.constants,
    this.fontSize,
  }) : super(key: key);

  @override
  State<PhysicsMathCaseDisplay> createState() => _PhysicsMathCaseDisplayState();
}

class _PhysicsMathCaseDisplayState extends State<PhysicsMathCaseDisplay> {
  @override
  Widget build(BuildContext context) {
    // conditionsが空の場合はcases形式を使わない
    if (widget.conditions.trim().isEmpty) {
      return RepaintBoundary(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const ClampingScrollPhysics(),
          child: Math.tex(
            widget.equation,
            textStyle: TextStyle(fontSize: widget.fontSize ?? 16),
          ),
        ),
      );
    }

    // ✅ ここがポイント：
    // 「行区切り」は TeX の改行 \\（バックスラッシュ2個）
    // \pmod などのコマンドの \ で割らないようにする
    final conditionLines =
        widget.conditions.split(RegExp(r'\\\\\s*(?!\[)')); // ← 修正

    final trimmedLines = conditionLines
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .toList();

    // 各行を \\[4pt]で結合（最後の行には不要）
    final normalizedConditions = trimmedLines.join(r' \\[4pt] ');

    // cases形式のTeX文字列を構築
    String casesTex;
    if (widget.constants != null && widget.constants!.trim().isNotEmpty) {
      casesTex = r"""
\begin{cases}
$equation \\[4pt]
$conditions \\[4pt]
$constants
\end{cases}
"""
          .replaceAll('\$equation', widget.equation)
          .replaceAll('\$conditions', normalizedConditions)
          .replaceAll('\$constants', widget.constants!);
    } else {
      casesTex = r"""
\begin{cases}
$equation \\[4pt]
$conditions
\end{cases}
"""
          .replaceAll('\$equation', widget.equation)
          .replaceAll('\$conditions', normalizedConditions);
    }

    return RepaintBoundary(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const ClampingScrollPhysics(),
        child: Math.tex(
          casesTex,
          textStyle: TextStyle(fontSize: widget.fontSize ?? 16),
        ),
      ),
    );
  }
}
// physics_math_gacha.dart
// 微分方程式ガチャ

import 'package:flutter/material.dart';

import '../../models/math_problem.dart';
import 'physics_math_problems.dart';

// 微分方程式ガチャの問題リスト
// '大学'キーワードを持つ問題を除外（一時的に非表示）
final physicsMathGachaProblems = <MathProblem>[
  ...generalProblems.where((problem) => !problem.keywords.contains('大学')),
];

// 微分方程式ガチャの設定
final physicsMathGachaConfig = {
  'name': '微分方程式ガチャ',
  'description': '微分方程式と物理数学の問題を解こう！',
  'icon': Icons.science,
  'color': Colors.purple,
  'problems': physicsMathGachaProblems,
};

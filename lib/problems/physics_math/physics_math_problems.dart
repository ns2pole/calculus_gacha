// lib/data/physics_math/physics_math_problems.dart
// 物理数学問題集 - メインファイル
// 各カテゴリのファイルから問題をインポートして統合

import '../../models/math_problem.dart';

// 各カテゴリの問題ファイルからインポート
import 'uniform_acceleration_problems.dart';
import 'simple_harmonic_motion_problems.dart';
import 'first_order_exponential_problems.dart';
import 'second_order_no_damping_problems.dart';
import 'rlc_series_discharge_problems.dart';
import 'rlc_series_voltage_critical_problems.dart';
import 'rlc_series_voltage_overdamped_problems.dart';
import 'rlc_series_voltage_underdamped_problems.dart';

// 全問題を統合
const generalProblems = <MathProblem>[
  ...uniform_accelerationProblems,
  ...simple_harmonicProblems,
  ...first_order_expProblems,
  ...second_order_no_dampingProblems,
  ...rlcSeriesDischargeProblems,
  ...rlcSeriesVoltageCriticalProblems,
  ...rlcSeriesVoltageOverdampedProblems,
  ...rlcSeriesVoltageUnderdampedProblems,
];

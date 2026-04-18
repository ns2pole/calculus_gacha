// 各問題にグラフ画像（アセット）を追加した完全版（解説の一番最初に画像表示）

import '../models/math_problem.dart';


// データソース - 積分問題
import 'integrals/problems_abs_definite.dart';
import 'integrals/problems_abs_definite_reserve.dart';
import 'integrals/problems_basic_formula.dart';
import 'integrals/problems_beta_function.dart';
import 'integrals/problems_exponential_fraction.dart';
import 'integrals/problems_exponential_fraction_reserve.dart';
import 'integrals/problems_integration_by_parts.dart';
import 'integrals/problems_linear_radical.dart';
import 'integrals/problems_linear_radical_reserve.dart';
import 'integrals/problems_others.dart';
import 'integrals/problems_polynomial_fraction.dart';
import 'integrals/problems_quadratic_radical.dart';
// import 'integrals/problems_recurrence_integrals.dart';
import 'integrals/problems_substitution.dart';
import 'integrals/problems_substitution_reserve.dart';
import 'integrals/problems_trig_polynomial.dart';
import 'integrals/problems_trig_polynomial_reserve.dart';
import 'integrals/problems_trig_fraction.dart';
import 'integrals/problems_curves.dart';
import 'integrals/problems_curves_reserve.dart';

// データソース - 極限問題
import 'limits/basic_limits.dart';
import 'limits/rationalization_limits.dart';
import 'limits/trigonometric_limits.dart';
import 'limits/exponential_limits.dart';
import 'limits/squeeze_limits.dart';
import 'limits/riemann_limits.dart';
import 'limits/advanced_limits.dart';
import 'limits/famous_limits.dart';
import 'limits/problems_e_limit_variations.dart';
import 'limits/log_limits.dart';
import 'limits/mean_value_theorem_limits.dart';

// データソース - 因数分解問題
import 'factorization/basic_factorization.dart';
import 'factorization/basic_factorization_reserve.dart';
import 'factorization/mid_factorization.dart';
import 'factorization/mid_factorization_reserve.dart';
import 'factorization/advanced_factorization.dart';
import 'factorization/advanced_factorization_reserve.dart';

// データソース - 不定方程式問題
import 'indeterminate_equations/indeterminate_equations.dart';

// データソース - 漸化式問題
import 'sequences/sequences.dart';

// データソース - 三角指数対数問題
import 'trig_exp_log_equations/trig_exp_log_equations.dart';

/// モデル定義（プロジェクト既存の models を使う場合は合わせてください）

/// 問題番号を1から連番で再割り当てする関数
List<MathProblem> _renumberProblems(List<MathProblem> problems) {
  return problems.asMap().entries.map((entry) {
    final index = entry.key;
    final problem = entry.value;
    return MathProblem(
      id: problem.id,
      no: index + 1, // 1から始まる連番
      category: problem.category,
      level: problem.level,
      question: problem.question,
      answer: problem.answer,
      steps: problem.steps,
      imageAsset: problem.imageAsset,
      hint: problem.hint,
      shortExplanation: problem.shortExplanation,
      detailedExplanation: problem.detailedExplanation,
      equation: problem.equation,
      conditions: problem.conditions,
      constants: problem.constants,
      keywords: problem.keywords,
    );
  }).toList();
}

// 積分問題を集約して問題番号を再割り当て
final List<MathProblem> allIntegralProblems = _renumberProblems([
    ...absDefiniteProblems, //OK
    ...absDefiniteReserveProblems, // 予備問題（コメントアウトを外すと追加されます）
     ...basicFormulaProblems, //OK
    ...exponentialFractionProblems, // OK
    ...exponentialFractionReserveProblems, // 予備問題（コメントアウトを外すと追加されます）
    ...polynomialFractionProblems, // 1問コメントアウト
    ...linearRadicalProblems, // OK
    ...linearRadicalReserveProblems, // 予備問題（コメントアウトを外すと追加されます）
    ...othersProblems, //1問コメントアウト
    ...betaFunctionProblems, //1問コメントアウト
    ...substitutionProblems, //OK
    ...substitutionReserveProblems, // 予備問題（コメントアウトを外すと追加されます）
    ...trigPolynomialProblems,
    ...trigPolynomialReserveProblems, // 予備問題（コメントアウトを外すと追加されます）
    ...trigFractionProblems,
    ...quadraticRadicalProblems,
    ...integrationByPartsProblems,
    ...curvesProblems,
    ...curvesReserveProblems, // 予備問題（コメントアウトを外すと追加されます）
    // // ...recurrenceIntegralProblems,
]);

// 極限問題を集約して問題番号を再割り当て
final List<MathProblem> allLimitProblems = _renumberProblems([
    ...basic_limits,
    ...rationalization_limits,
    ...trigonometric_limits,
    ...exponential_limits,
    ...squeeze_limits,
    ...riemann_limits,
    ...advanced_limits,
    ...famous_limits,
    ...problems_e_limit_variations,
    ...log_limits,
    ...mean_value_theorem_limit
]);

const List<MathProblem> allFactorizationProblems = [
    ...basicFactorizationProblems,
    ...basicFactorizationReserveProblems,
    ...midFactorizationProblems,
    ...midFactorizationReserveProblems,
    ...advancedFactorizationProblems,
    ...advancedFactorizationReserveProblems,
];

const List<MathProblem> allIndeterminateEquationProblems = [
    ...indeterminateEquationProblems,
];

const List<MathProblem> allSequenceProblems = [
    ...sequenceProblems,
];

const List<MathProblem> allTrigExpLogEquationProblems = [
    ...trigExpLogEquationProblems,
];
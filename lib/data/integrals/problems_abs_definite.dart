// abs_definite_problems_full.dart
// 各問題にグラフ画像（アセット）を追加した完全版（解説の一番最初に画像表示）

import '../../models/math_problem.dart';
import '../../models/step_item.dart';
/// モデル定義（プロジェクト既存の models を使う場合は合わせてください）

/// ============================================================================
/// 絶対値付きの定積分 4題（完全版：画像を解説の先頭に表示）
/// ============================================================================

const absDefiniteProblems = <MathProblem>[
  // 予備問題は problems_abs_definite_reserve.dart に移動しました
  // コメントアウトを外すと問題リストに追加されます

  /// No.3 中級 | ∫_{-1}^{1} |x^2 - 1/4| dx
  MathProblem(
    id: "9477B6DC-F0A3-4B53-8891-212FED0C5886",
    no: 3,
    category: '絶対値付きの定積分',
    level: '初級',
    question: r"""\displaystyle \int_{-1}^{1}\left|x^2-\displaystyle \frac{1}{4}\right|\,dx""",
    answer: r"""\displaystyle \frac{1}{2}""",
    imageAsset: 'assets/graphs/integral/problems_abs_definite/problem_3.png',
    hint: r"""\text{零点} x=\pm \displaystyle \frac{1}{2}\text{ で区間を}
        \left[-1,-\displaystyle \frac{1}{2}\right],\left[-\displaystyle \frac{1}{2},\displaystyle \frac{1}{2}\right],\left[\displaystyle \frac{1}{2},1\right]\text{ に分割して計算する。}""",
    steps: [
      StepItem(
        tex: r"""\textbf{【方針】}""",
      ),
      StepItem(
        tex: r"""\text{零点} x=\pm \displaystyle \frac{1}{2}\text{ で区間を}
        \left[-1,-\displaystyle \frac{1}{2}\right],\left[-\displaystyle \frac{1}{2},\displaystyle \frac{1}{2}\right],\left[\displaystyle \frac{1}{2},1\right]\text{ に分割して計算する。}""",
      ),
      StepItem(
        tex: r"""\textbf{【ポイント】}""",
      ),
      StepItem(
        tex: r"""\cdot\  x^2-\displaystyle \frac{1}{4}=0 \Leftrightarrow x=\pm\displaystyle \frac{1}{2}
        \text{で符号が変わる。}""",
      ),
      StepItem(
        tex: r"""\cdot \text{中央区間では }\displaystyle \frac{1}{4}-x^2\text{，外側区間では }x^2-\displaystyle \frac{1}{4}\text{を積分する。}""",
      ),
      StepItem(
        tex: r"""\cdot \text{偶関数なので積分区間を}\displaystyle 0 \rightarrow 1 \text{に変換すると楽。}""",
      ),
      StepItem(
        tex: r"""\textbf{【解説】}""",
      ),
      StepItem(
        tex: r"""\begin{aligned}
\displaystyle \int_{-1}^{1}\left|x^2-\displaystyle \frac{1}{4}\right|\,dx
&= 2\displaystyle \int_{0}^{1}\left|x^2-\displaystyle \frac{1}{4}\right|\,dx\\
&= 2\left(\displaystyle \int_{0}^{ \frac{1}{2}}\left(\displaystyle \frac{1}{4}-x^2\right)dx
    + \displaystyle \int_{ \frac{1}{2}}^{1}\left(x^2-\displaystyle \frac{1}{4}\right)dx\right)\\
&= 2\left(\left[\displaystyle \frac{x}{4}-\displaystyle \frac{x^3}{3}\right]_{0}^{ \frac{1}{2}}
    + \left[\displaystyle \frac{x^3}{3}-\displaystyle \frac{x}{4}\right]_{ \frac{1}{2}}^{1}\right)\\
&= 2\left(\left(\displaystyle \frac{1}{8}-\displaystyle \frac{1}{24}\right)-0
    + \left(\left(\displaystyle \frac{1}{3}-\displaystyle \frac{1}{4}\right)-\left(\displaystyle \frac{1}{24}-\displaystyle \frac{1}{8}\right)\right)\right)\\
&= 2\left(\displaystyle \frac{1}{8}-\displaystyle \frac{1}{24} + \displaystyle \frac{1}{3}-\displaystyle \frac{1}{4} -\displaystyle \frac{1}{24} +\displaystyle \frac{1}{8}\right)\\
&= 2\left(\displaystyle \frac{1}{8}+\displaystyle \frac{1}{8} -\displaystyle \frac{1}{24}-\displaystyle \frac{1}{24} +\displaystyle \frac{1}{3}-\displaystyle \frac{1}{4}\right)\\
&= 2\left(\displaystyle \frac{2}{8} -\displaystyle \frac{2}{24} +\displaystyle \frac{1}{12}\right)\\
&= 2\left(\displaystyle \frac{1}{4} -\displaystyle \frac{1}{12} +\displaystyle \frac{1}{12}\right)\\
&= 2\left(\displaystyle \frac{1}{4}\right)\\
&= \displaystyle \frac{1}{2}
\end{aligned}
""",
      ),
    ],
  ),
];

// ----------------- 注意・使い方 -----------------
// - pubspec.yaml に flutter_math_fork を追加してください。
// - 上記 imageAsset のファイルを assets に置き、pubspec.yaml の assets: に登録してください。
//   例:
//     assets:
//       - assets/graphs/abs_definite_integral_areas/problem_1.png
//       - assets/graphs/abs_definite_integral_areas/problem_2.png
//       - assets/graphs/abs_definite_integral_areas/problem_3.png
//       - assets/graphs/abs_definite_integral_areas/problem_4.png
//
// - MathProblem 型が既にプロジェクトで定義済みなら、その定義に合わせて上のモデル部分を削除または調整してください。
// -------------------------------------------------------------------

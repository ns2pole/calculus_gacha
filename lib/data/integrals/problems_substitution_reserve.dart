import '../../models/math_problem.dart';

/// ============================================================================
/// 置換積分 予備問題
/// ============================================================================
/// 
/// このファイルに保存されている問題は、コメントアウトを外すと
/// problems_substitution.dart の substitutionProblems リストに追加されます。

/// 予備問題リスト
/// コメントアウトを外すと問題リストに追加されます
const substitutionReserveProblems = <MathProblem>[
//   3) ∫₀^(3/2) dx / √(9 - x²)
//   コメントアウトを外すと問題が追加されます
//   MathProblem(
//     id: "FB4AEC30-C024-417C-BEA7-96DB6B5BEE43",
//     no: 3,
//     category: '置換積分',
//     level: '初級',
//     question: r"\displaystyle \int_{0}^{\frac{3}{2}} \displaystyle \frac{dx}{\sqrt{9 - x^{2}}}",
//     answer: r"\displaystyle \frac{\pi}{6}",
//     imageAsset: 'assets/graphs/integral/problems_substitution/problem_3.png',
//     hint: r"""\; x=3\sin\theta \textbf{ と置く。}""",
//     steps: [
//       StepItem(tex: r"""\textbf{【方針】}"""),
//       StepItem(tex: r"""\; x=3\sin\theta \textbf{ と置く。}"""
//       ),
//       StepItem(tex: r"""\textbf{【解説】}"""),
//       StepItem(tex: r"""x = 0 \rightarrow \displaystyle \frac{3}{2}\text{の時、} 0=3\sin\theta \Leftrightarrow \sin\theta=0 \text{より } \theta=0 \text{であり、} \displaystyle \frac{3}{2}=3\sin\theta \Leftrightarrow \sin\theta=\displaystyle \frac{1}{2} \text{より } \theta=\displaystyle \frac{\pi}{6}\text{である。}"""),
//       StepItem(tex: r""" 9-x^{2}=9-9\sin^{2}\theta=9(1-\sin^{2}\theta)=9\cos^{2}\theta,\ dx = \displaystyle \frac{dx}{d\theta} d\theta =3\cos \theta d\theta """),
//       StepItem(tex: r"""\text{なので、}"""),
//       StepItem(tex: r"""\begin{aligned}
//   \displaystyle \int_{0}^{\frac{3}{2}} \displaystyle \frac{dx}{\sqrt{9-x^{2}}}
//   =&\displaystyle \int_{0}^{ \frac{\pi}{6}}\displaystyle \frac{3\cos\theta\,d\theta}{\sqrt{9-9\sin^{2}\theta}}\\
//   =&\displaystyle \int_{0}^{ \frac{\pi}{6}}\displaystyle \frac{3\cos\theta\,d\theta}{\sqrt{9\cos^{2}\theta}}\\
//   =&\displaystyle \int_{0}^{ \frac{\pi}{6}}\displaystyle \frac{3\cos\theta\,d\theta}{3|\cos\theta|}\\
//   =&\displaystyle \int_{0}^{ \frac{\pi}{6}}\displaystyle \frac{3\cos\theta\,d\theta}{3\cos\theta}\\
//   =&\displaystyle \int_{0}^{ \frac{\pi}{6}}1\ d\theta\\
//   =&\displaystyle \frac{\pi}{6}
//   \end{aligned}"""
//       ),
//       StepItem(tex: r"""\textbf{【補足】}"""),
//       StepItem(tex: r"""\text{逆正弦関数 } \arcsin x \text{を用いると早い。 }\arcsin x \text{の定義域は } [-1, 1] \text{、値域は } \left[-\displaystyle \frac{\pi}{2}, \displaystyle \frac{\pi}{2}\right] \text{ である。}"""),
//       StepItem(tex: r"""\text{公式 } \displaystyle \int \displaystyle \frac{dx}{\sqrt{a^{2}-x^{2}}} =\arcsin\displaystyle \frac{x}{a} + C \text{ を用いる。ここで、} a=3 \text{ である。}"""),
//       StepItem(tex: r"""\text{まず不定積分を求める。}"""),
//       StepItem(tex: r"""\begin{aligned}
//   \displaystyle \int \displaystyle \frac{dx}{\sqrt{9-x^{2}}}
//   &= \displaystyle \int \displaystyle \frac{dx}{\sqrt{3^{2}-x^{2}}}\\
//   &= \arcsin\displaystyle \frac{x}{3} + C
//   \end{aligned}
//   """),
//       StepItem(tex: r"""\text{したがって、定積分は、}"""),
//       StepItem(tex: r"""\begin{aligned}
//   \displaystyle \int_{0}^{\frac{3}{2}} \displaystyle \frac{dx}{\sqrt{9-x^{2}}}
//   &= \left[\arcsin\displaystyle \frac{x}{3}\right]_{0}^{\frac{3}{2}}\\
//   &= \arcsin\displaystyle \frac{3/2}{3} - \arcsin\displaystyle \frac{0}{3}\\
//   &= \arcsin\displaystyle \frac{1}{2} - \arcsin 0\\
//   &= \displaystyle \frac{\pi}{6} - 0\\
//   &= \displaystyle \frac{\pi}{6}
//   \end{aligned}
//   """),
//     ],
//   ),
];


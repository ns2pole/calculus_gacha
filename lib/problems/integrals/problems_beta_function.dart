// ignore_for_file: unused_import

import '../../models/math_problem.dart';
import '../../models/step_item.dart';

/// ============================================================================
/// β関数系統の定積分 3題

/// β関数（多項式型・具体計算）に基づく定積分の練習問題集（改訂版・詳細解説つき）
const betaFunctionProblems = <MathProblem>[
  // 1. 具体計算
  MathProblem(
    id: "A056E0E4-7F5B-4EC7-ACC2-F91C38585F7E",
    no: 1,
    category: '多項式型（具体計算）',    level: '初級',    question: r"""\displaystyle \int_{2}^{5}(x-2)(5-x)\,dx
""",
    answer: r""" 
\displaystyle \frac{9}{2}
""",
    imageAsset: 'assets/graphs/integral/problems_beta_function/problem_2.png',
    hint: r"""\text{「 } \displaystyle \frac 1 {6} \text{ 公式」} \displaystyle \int_{\alpha}^{\beta}(x-\alpha)(\beta-x)\,dx  = \displaystyle \frac{(\beta-\alpha)^3}{6} \text{を使う。}""",    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{「 } \displaystyle \frac 1 {6} \text{ 公式」} \displaystyle \int_{\alpha}^{\beta}(x-\alpha)(\beta-x)\,dx  = \displaystyle \frac{(\beta-\alpha)^3}{6} \text{を使う。}""",),
      StepItem(tex: r"""\textbf{【公式による計算】}""",),
      StepItem(tex: r"""\begin{aligned}
      &\displaystyle \int_{2}^{5}(x-2)(5-x)\,dx\\
      =&(5-2)^3\cdot\displaystyle \frac{1}{6}\\
      =&3^3\cdot\displaystyle \frac{1}{6}\\
      =&\displaystyle \frac{27}{6}=\displaystyle \frac{9}{2}
\end{aligned}
"""),
      StepItem(tex: r"""\textbf{【命題】}""",),
      StepItem(tex: r"""\displaystyle \int_{\alpha}^{\beta}(x-\alpha)(\beta-x)\,dx = \displaystyle \frac{(\beta-\alpha)^3}{6}"""),
      StepItem(tex: r"""\textbf{【証明1：部分積分による証明】}""",),
      StepItem(tex: r"""\begin{aligned}
&\displaystyle \int_{\alpha}^{\beta}(x-\alpha)(\beta-x)\,dx\\
=&\displaystyle \int_{\alpha}^{\beta}\left(\displaystyle \frac{(x-\alpha)^2}{2}\right)'(\beta-x)\,dx\\
=& \left[\displaystyle \frac{(x-\alpha)^2}{2}(\beta-x)\right]_{\alpha}^{\beta}
-\displaystyle \int_{\alpha}^{\beta}\displaystyle \frac{(x-\alpha)^2}{2}\,(-1)\,dx\\
=& \displaystyle \frac{1}{2}\displaystyle \int_{\alpha}^{\beta}(x-\alpha)^2\,dx\\
=& \displaystyle \frac{1}{2}\left[\displaystyle \frac{(x-\alpha)^3}{3}\right]_{\alpha}^{\beta}\\
=& \displaystyle \frac{(\beta-\alpha)^3}{6}
\end{aligned}
"""),
      StepItem(tex: r"""\textbf{【証明2：普通に展開して計算する証明】}""",),
      StepItem(tex: r"""\begin{aligned}
&\displaystyle \int_{\alpha}^{\beta}(x-\alpha)(\beta-x)\,dx\\
=&\displaystyle \int_{\alpha}^{\beta}\left((x-\alpha)\beta-(x-\alpha)x\right)\,dx\\
=&\displaystyle \int_{\alpha}^{\beta}\left(\beta(x-\alpha)-x(x-\alpha)\right)\,dx\\
=&\displaystyle \int_{\alpha}^{\beta}\left(\beta(x-\alpha)-x^2+\alpha x\right)\,dx\\
=&\displaystyle \int_{\alpha}^{\beta}\left(\beta x-\alpha\beta-x^2+\alpha x\right)\,dx\\
=&\displaystyle \int_{\alpha}^{\beta}\left((\beta+\alpha)x-\alpha\beta-x^2\right)\,dx\\
=&\left[\displaystyle \frac{(\beta+\alpha)x^2}{2}-\alpha\beta x-\displaystyle \frac{x^3}{3}\right]_{\alpha}^{\beta}\\
=&\displaystyle \frac{(\beta+\alpha)\beta^2}{2}-\alpha\beta^2-\displaystyle \frac{\beta^3}{3}-\displaystyle \frac{(\beta+\alpha)\alpha^2}{2}+\alpha^2\beta+\displaystyle \frac{\alpha^3}{3}\\
=&\displaystyle \frac{(\beta+\alpha)(\beta^2-\alpha^2)}{2}-\alpha\beta(\beta-\alpha)-\displaystyle \frac{\beta^3-\alpha^3}{3}\\
=&\displaystyle \frac{(\beta+\alpha)(\beta-\alpha)(\beta+\alpha)}{2}-\alpha\beta(\beta-\alpha)-\displaystyle \frac{(\beta-\alpha)(\beta^2+\alpha\beta+\alpha^2)}{3}\\
=&(\beta-\alpha)\left[\displaystyle \frac{(\beta+\alpha)^2}{2}-\alpha\beta-\displaystyle \frac{\beta^2+\alpha\beta+\alpha^2}{3}\right]\\
=&(\beta-\alpha)\left[\displaystyle \frac{3(\beta+\alpha)^2-6\alpha\beta-2(\beta^2+\alpha\beta+\alpha^2)}{6}\right]\\
=&(\beta-\alpha)\left[\displaystyle \frac{3\beta^2+6\alpha\beta+3\alpha^2-6\alpha\beta-2\beta^2-2\alpha\beta-2\alpha^2}{6}\right]\\
=&(\beta-\alpha)\left[\displaystyle \frac{\beta^2-2\alpha\beta+\alpha^2}{6}\right]\\
=&(\beta-\alpha)\left[\displaystyle \frac{(\beta-\alpha)^2}{6}\right]\\
=&\displaystyle \frac{(\beta-\alpha)^3}{6}
\end{aligned}
"""),
    ],
  ),

  // 2. べきが一般的な場合（具体）
  MathProblem(
    id: "6705BE2F-10DF-484F-8E32-768EE0F07E15",
    no: 2,
    category: '多項式型（具体計算）',    level: '中級',    question: r"""\displaystyle \int_{ \frac12}^{ \frac32}\left(x-\displaystyle \frac12\right)\left(\displaystyle \frac32-x\right)^2\,dx
""",
    answer: r""" 
\displaystyle \frac{1}{12}
""",
    imageAsset: 'assets/graphs/integral/problems_beta_function/problem_3.png',
    hint: r"""\text{「 }\displaystyle \frac 1 {12} \text{ 公式」} \displaystyle \int_{\alpha}^{\beta}(x-\alpha)(\beta-x)^2\,dx  = \displaystyle \frac{(\beta-\alpha)^4}{12} \text{を使う。}""",    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{「 }\displaystyle \frac 1 {12} \text{ 公式」} \displaystyle \int_{\alpha}^{\beta}(x-\alpha)(\beta-x)^2\,dx  = \displaystyle \frac{(\beta-\alpha)^4}{12} \text{を使う。}""",),
      StepItem(tex: r""" 【公式による計算】
     """,), 
      StepItem(tex: r""" \begin{aligned}
            &\displaystyle \int_{ \frac 1 2}^{ \frac 3 2}\left(x-\displaystyle \frac 1 2\right)\left(\displaystyle \frac 3 2-x\right)^2\,dx\\
            =&\left(\displaystyle \frac 3 2 - \displaystyle \frac 1 2\right)^4\cdot\displaystyle \frac{1}{12}\\
            =&\displaystyle \frac{1}{12}
      \end{aligned}
"""),
      StepItem(tex: r"""\textbf{【命題】}""",),
      StepItem(tex: r"""\displaystyle \int_{\alpha}^{\beta}(x-\alpha)(\beta-x)^2\,dx = \displaystyle \frac{(\beta-\alpha)^4}{12}"""),
      StepItem(tex: r"""\textbf{【証明】}""",),
      StepItem(tex: r"""\begin{aligned}
&\displaystyle \int_{\alpha}^{\beta}(x-\alpha)(\beta-x)^2\,dx\\
=&\displaystyle \int_{\alpha}^{\beta} (x-\alpha) \left(-\displaystyle \frac{(\beta-x)^3}{3}\right)'\,dx\\
=& \left[-\displaystyle \frac{(\beta-x)^3}{3}(x-\alpha)\right]_{\alpha}^{\beta}
-\displaystyle \int_{\alpha}^{\beta} 1 \cdot \left(-\displaystyle \frac{(\beta-x)^3}{3}\right)\,dx\\
\end{aligned}
"""),
      StepItem(tex: r"""\text{（境界項は両端で0なので、以下の計算のみ。）}""",),
      StepItem(tex: r"""\begin{aligned}
=& \displaystyle \frac{1}{3}\displaystyle \int_{\alpha}^{\beta}(\beta-x)^3\,dx\\
=& \displaystyle \frac{1}{3}\left[-\displaystyle \frac{(\beta-x)^4}{4}\right]_{\alpha}^{\beta}\\
=& \displaystyle \frac{(\beta-\alpha)^4}{12}
\end{aligned}
"""),
    ],
  ),

  // 3. 具体例（2次×2次）
  MathProblem(
    id: "48B05BE5-7632-4228-BF46-F8476E23E0CF",
    no: 3,
    category: '多項式型（具体計算）',    level: '上級',    question: r"""\displaystyle \int_{2}^{5}(x-2)^2(5-x)^2\,dx
""",
    answer: r""" 
\displaystyle \frac{81}{10}
""",
    imageAsset: 'assets/graphs/integral/problems_beta_function/problem_8.png',
    hint: r"""\text{「 } \displaystyle \frac 1 {30} \text{ 公式」} \displaystyle \int_{\alpha}^{\beta}(x-\alpha)^2(\beta-x)^2\,dx  = \displaystyle \frac{(\beta-\alpha)^5}{30} \text{を使う。}""",    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{「 } \displaystyle \frac 1 {30} \text{ 公式」} \displaystyle \int_{\alpha}^{\beta}(x-\alpha)^2(\beta-x)^2\,dx  = \displaystyle \frac{(\beta-\alpha)^5}{30} \text{を使う。}""",),
      StepItem(tex: r"""\textbf{【公式による計算】}""",),
      StepItem(tex: r""" \begin{aligned}
      &\displaystyle \int_{2}^{5}(x-2)^2(5-x)^2\,dx\\=&3^5\cdot\displaystyle \frac{1}{30}\\
      =&243\cdot\displaystyle \frac{1}{30}\\
      =&\displaystyle \frac{243}{30}\\
      =&\displaystyle \frac{81}{10}
      \end{aligned}
"""),
      StepItem(tex: r"""\textbf{【命題】}""",),
      StepItem(tex: r"""\displaystyle \int_{\alpha}^{\beta}(x-\alpha)^2(\beta-x)^2\,dx = \displaystyle \frac{(\beta-\alpha)^5}{30}"""),
      StepItem(tex: r"""\textbf{【証明】}""",),
      StepItem(tex: r"""\begin{aligned}
&\displaystyle \int_{\alpha}^{\beta}(x-\alpha)^2(\beta-x)^2\,dx\\
=&\displaystyle \int_{\alpha}^{\beta}(x-\alpha)^2\left(-\displaystyle \frac{(\beta-x)^3}{3}\right)'\,dx\\
=& \left[(x-\alpha)^2\left(-\displaystyle \frac{(\beta-x)^3}{3}\right)\right]_{\alpha}^{\beta}
-\displaystyle \int_{\alpha}^{\beta} 2(x-\alpha)\cdot \left(-\displaystyle \frac{(\beta-x)^3}{3}\right)\,dx\\
&\text{（境界項は両端で0）}\\
\end{aligned}""",),
      StepItem(tex: r"""\begin{aligned}
=& \displaystyle \frac{2}{3}\displaystyle \int_{\alpha}^{\beta}(x-\alpha)(\beta-x)^3\,dx\\
=& \displaystyle \frac{2}{3}\displaystyle \int_{\alpha}^{\beta}(x-\alpha)\left(-\displaystyle \frac{(\beta-x)^4}{4}\right)'\,dx\\
=& \displaystyle \frac{2}{3}\left(\left[(x-\alpha)\left(-\displaystyle \frac{(\beta-x)^4}{4}\right)\right]_{\alpha}^{\beta}
-\displaystyle \int_{\alpha}^{\beta}\left(-1 \cdot \displaystyle \frac{(\beta-x)^4}{4}\right)\,dx\right)\\
&\text{（内側の境界項も0）}\\
\end{aligned}""",),
      StepItem(tex: r"""\begin{aligned}
=& \displaystyle \frac{2}{3}\cdot\displaystyle \frac{1}{4}\displaystyle \int_{\alpha}^{\beta}(\beta-x)^4\,dx\\
=& \displaystyle \frac{2}{3}\cdot\displaystyle \frac{1}{4}\left[-\displaystyle \frac{(\beta-x)^4}{4}\right]_{\alpha}^{\beta}\\
=& \displaystyle \frac{(\beta-\alpha)^5}{30}
\end{aligned}
""",),
    ],
  ),
];

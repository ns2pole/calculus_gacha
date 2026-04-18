import '../../models/math_problem.dart';
import '../../models/step_item.dart';

/// ============================================================================
/// 三角指数対数問題
/// ============================================================================

const trigExpLogEquationProblems = <MathProblem>[
  // ────────────────────────────────
  // 問題 1: 三角方程式（初級）
  // ────────────────────────────────
  MathProblem(
    id: "TRIG-EXP-LOG-001",
    no: 1,
    category: '三角指数対数',
    level: '初級',
    question: r"""\sin x = \displaystyle\frac{1}{2} \quad (0 \leq x < 2\pi)""",
    equation: r"""\sin x = \displaystyle\frac{1}{2}""",
    conditions: r"""0 \leq x < 2\pi""",
    answer: r"""x = \displaystyle\frac{\pi}{6}, \displaystyle\frac{5\pi}{6}""",
    imageAsset: 'assets/graphs/trig_exp_log_equations/problem_1.png',
    steps: [
      StepItem(tex: r"""\textbf{【解説】}"""),
      StepItem(tex: r"""\sin x = \displaystyle\frac{1}{2} \text{ より、}"""),
      StepItem(tex: r"""\begin{aligned}
\begin{cases}
x = \displaystyle\frac{\pi}{6} + 2n\pi \quad (n \text{ は整数}) \\[8pt]
x = \displaystyle\frac{5\pi}{6} + 2n\pi \quad (n \text{ は整数})
\end{cases}
\end{aligned}"""),
      StepItem(tex: r"""0 \leq x < 2\pi \text{ の範囲では、}"""),
      StepItem(tex: r"""x = \displaystyle\frac{\pi}{6}, \displaystyle\frac{5\pi}{6}"""),
    ],
  ),

  // ────────────────────────────────
  // 問題 2: 指数方程式（初級）
  // ────────────────────────────────
  MathProblem(
    id: "TRIG-EXP-LOG-002",
    no: 2,
    category: '三角指数対数',
    level: '初級',
    question: r"""2^{x+1} - 2^{x-1} = 3""",
    answer: r"""x = 1""",
    imageAsset: 'assets/graphs/trig_exp_log_equations/problem_2.png',
    steps: [
      StepItem(tex: r"""\textbf{【途中式変形】}"""),
      StepItem(tex: r"""\begin{aligned}
&\ \ \ \ \ 2^{x+1} - 2^{x-1} = 3 \\
&\Leftrightarrow 2 \cdot 2^x - \displaystyle\frac{1}{2} \cdot 2^x = 3 \\
&\Leftrightarrow \displaystyle\frac{3}{2} \cdot 2^x = 3 \\
&\Leftrightarrow 2^x = 2 \\
&\Leftrightarrow x = 1
\end{aligned}"""),
    ],
  ),

  // ────────────────────────────────
  // 問題 3: 対数方程式（中級）
  // ────────────────────────────────
  MathProblem(
    id: "TRIG-EXP-LOG-003",
    no: 3,
    category: '三角指数対数',
    level: '中級',
    question: r"""\log_2(x+1) + \log_2(x-1) = 3""",
    answer: r"""x = 3""",
    imageAsset: 'assets/graphs/trig_exp_log_equations/problem_3.png',
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{対数の性質 } \log a + \log b = \log ab \text{ を用いて左辺を1つの対数にまとめる。真数条件に注意する。}"""),
      StepItem(tex: r"""\textbf{【真数条件】}"""),
      StepItem(tex: r"""\begin{aligned}
x + 1 > 0 \quad &\Leftrightarrow \quad x > -1 \\
x - 1 > 0 \quad &\Leftrightarrow \quad x > 1
\end{aligned}"""),
      StepItem(tex: r"""\text{よって、} x > 1 \text{ が必要。}"""),
      StepItem(tex: r"""\textbf{【途中式変形】}"""),
      StepItem(tex: r"""\begin{aligned}
&\ \ \ \ \ \log_2(x+1) + \log_2(x-1) &= 3 \\
&\Leftrightarrow \log_2((x+1)(x-1)) = 3 \\
&\Leftrightarrow \log_2(x^2 - 1) = 3 \\
&\Leftrightarrow x^2 - 1 = 2^3 \\
&\Leftrightarrow x^2 - 1 = 8 \\
&\Leftrightarrow x^2 = 9 \\
&\Leftrightarrow x = \pm 3
\end{aligned}"""),
      StepItem(tex: r"""\text{真数条件 } x > 1 \text{ より、} x = 3"""),
    ],
  ),

  // ────────────────────────────────
  // 問題 4: 三角関数の合成
  // ────────────────────────────────
  MathProblem(
    id: "487CBF1E-4AAB-490D-BFF5-86DF2F9F075C",
    no: 4,
    category: '三角指数対数',
    level: '中級',
    question: r"""\sqrt{3}\sin x + \cos x = 1 \quad (0 \leq x < 2\pi)""",
    equation: r"""\sqrt{3}\sin x + \cos x = 1""",
    conditions: r"""0 \leq x < 2\pi""",
    answer: r"""x = 0, \displaystyle\frac{2\pi}{3}""",
    imageAsset: 'assets/graphs/trig_exp_log_equations/problem_4.png',
    steps: [
      StepItem(tex: r"""\textbf{【解説】}"""),
      StepItem(tex: r"""\text{三角関数の合成により、}"""),
      StepItem(tex: r"""\begin{aligned}
&\sqrt{3}\sin x + \cos x \\
= &2\left(\displaystyle\frac{\sqrt{3}}{2}\sin x + \displaystyle\frac{1}{2}\cos x\right) \\
= &2\sin\left(x + \displaystyle\frac{\pi}{6}\right)
\end{aligned}"""),
      StepItem(tex: r"""\text{元の方程式は、}"""),
      StepItem(tex: r"""\begin{aligned}
&\ \ \ \ \ 2\sin\left(x + \displaystyle\frac{\pi}{6}\right) = 1 \\
&\Leftrightarrow \sin\left(x + \displaystyle\frac{\pi}{6}\right) = \displaystyle\frac{1}{2}
\end{aligned}"""),
      StepItem(tex: r"""\text{ここで、} \theta = x + \displaystyle\frac{\pi}{6} \text{ とおくと、}"""),
      StepItem(tex: r"""\begin{aligned}
&\ \ \ \ \ \sin\theta = \displaystyle\frac{1}{2} \\
&\Leftrightarrow \begin{cases}
\theta = \displaystyle\frac{\pi}{6} + 2n\pi \quad (n \text{ は整数}) \\[8pt]
\theta = \displaystyle\frac{5\pi}{6} + 2n\pi \quad (n \text{ は整数})
\end{cases}
\end{aligned}"""),
      StepItem(tex: r"""\text{すなわち、}"""),
      StepItem(tex: r"""\begin{aligned}
&\ \ \ \ \ x + \displaystyle\frac{\pi}{6} = \begin{cases}
\displaystyle\frac{\pi}{6} + 2n\pi \\[8pt]
\displaystyle\frac{5\pi}{6} + 2n\pi
\end{cases} \quad (n \text{ は整数}) \\
&\Leftrightarrow \begin{cases}
x = 2n\pi \\[8pt]
x = \displaystyle\frac{2\pi}{3} + 2n\pi
\end{cases} \quad (n \text{ は整数})
\end{aligned}"""),
      StepItem(tex: r"""0 \leq x < 2\pi \text{ の範囲では、}"""),
      StepItem(tex: r"""x = 0, \displaystyle\frac{2\pi}{3}"""),
      StepItem(tex: r"""\textbf{【補足】}"""),
      StepItem(tex: r"""\text{三角関数の合成は、加法定理の逆の操作である。加法定理 } \sin(x+\alpha) = \sin x\cos\alpha + \cos x\sin\alpha \text{ より、}"""),
      StepItem(tex: r"""\begin{aligned}
& 2\sin\left(x + \displaystyle\frac{\pi}{6}\right)\\
= & 2\left(\sin x\cos\displaystyle\frac{\pi}{6} + \cos x\sin\displaystyle\frac{\pi}{6}\right) \\
= & 2\left(\sin x \cdot \displaystyle\frac{\sqrt{3}}{2} + \cos x \cdot \displaystyle\frac{1}{2}\right) \\
= & \sqrt{3}\sin x + \cos x
\end{aligned}"""),
    ],
  ),

  // ────────────────────────────────
  // 問題 5: 和積の公式2つの項
  // ────────────────────────────────
  MathProblem(
    id: "D1528690-D756-47FC-8647-0A11E4E5AC4A",
    no: 5,
    category: '三角指数対数',
    level: '中級',
    question: r"""\sin 3x + \sin x = 0 \quad (0 \leq x < 2\pi)""",
    equation: r"""\sin 3x + \sin x = 0""",
    conditions: r"""0 \leq x < 2\pi""",
    answer: r"""x = 0, \displaystyle\frac{\pi}{2}, \pi, \displaystyle\frac{3\pi}{2}""",
    imageAsset: 'assets/graphs/trig_exp_log_equations/problem_5.png',
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{和積の公式を用いて、} \sin A + \sin B \text{ を積の形に変形する。}"""),
      StepItem(tex: r"""\textbf{【ポイント】}"""),
      StepItem(tex: r"""\begin{aligned}
\sin A + \sin B &= 2\sin\displaystyle\frac{A+B}{2}\cos\displaystyle\frac{A-B}{2} \\
\sin A - \sin B &= 2\cos\displaystyle\frac{A+B}{2}\sin\displaystyle\frac{A-B}{2}
\end{aligned}"""),
      StepItem(tex: r"""\textbf{【解説】}"""),
      StepItem(tex: r"""\text{和積の公式より、}"""),
      StepItem(tex: r"""\begin{aligned}
\sin 3x + \sin x &= 2\sin\displaystyle\frac{3x+x}{2}\cos\displaystyle\frac{3x-x}{2} \\
&= 2\sin 2x \cos x
\end{aligned}"""),
      StepItem(tex: r"""\text{したがって、元の方程式は、}"""),
      StepItem(tex: r"""\begin{aligned}
&\ \ \ \ \ 2\sin 2x \cos x = 0 \\
&\Leftrightarrow \sin 2x \cos x = 0 \\
&\Leftrightarrow \sin 2x = 0 \text{ または } \cos x = 0
\end{aligned}"""),
      StepItem(tex: r"""\textbf{【場合分け】}"""),
      StepItem(tex: r"""\text{（1）} \sin 2x = 0 \text{ の場合}"""),
      StepItem(tex: r"""\begin{aligned}
&\ \ \ \ \ \sin 2x = 0 \\
&\Leftrightarrow 2x = n\pi \quad (n \text{ は整数}) \\
&\Leftrightarrow x = \displaystyle\frac{n\pi}{2}
\end{aligned}"""),
      StepItem(tex: r"""0 \leq x < 2\pi \text{ より、} \textcolor{green}{x = 0, \displaystyle\frac{\pi}{2}, \pi, \displaystyle\frac{3\pi}{2}}"""),
      StepItem(tex: r"""\text{（2）} \cos x = 0 \text{ の場合}"""),
      StepItem(tex: r"""\begin{aligned}
&\ \ \ \ \ \cos x = 0 \\
&\Leftrightarrow x = \displaystyle\frac{\pi}{2} + n\pi \quad (n \text{ は整数})
\end{aligned}"""),
      StepItem(tex: r"""0 \leq x < 2\pi \text{ より、} \textcolor{green}{x = \displaystyle\frac{\pi}{2}, \displaystyle\frac{3\pi}{2}}"""),
      StepItem(tex: r"""\text{（1）と（2）を合わせて、}"""),
      StepItem(tex: r"""x = 0, \displaystyle\frac{\pi}{2}, \pi, \displaystyle\frac{3\pi}{2}"""),
    ],
  ),

  // ────────────────────────────────
  // 問題 6: 和積の公式3つの項
  // ────────────────────────────────
  MathProblem(
    id: "3A11C85E-F61C-49FA-BAA5-2BD036093B07",
    no: 6,
    category: '三角指数対数',
    level: '上級',
    question: r"""\sin x + \sin 2x + \sin 3x = 0 \quad (0 \leq x < 2\pi)""",
    equation: r"""\sin x + \sin 2x + \sin 3x = 0""",
    conditions: r"""0 \leq x < 2\pi""",
    answer: r"""x = 0, \displaystyle\frac{\pi}{2}, \displaystyle\frac{2\pi}{3}, \pi, \displaystyle\frac{4\pi}{3}, \displaystyle\frac{3\pi}{2}""",
    imageAsset: 'assets/graphs/trig_exp_log_equations/problem_6.png',
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{まず、} \sin x + \sin 3x \text{ に和積の公式を適用し、その後 } \sin 2x \text{ と組み合わせる。}"""),
      StepItem(tex: r"""\textbf{【ポイント】}"""),
      StepItem(tex: r"""\begin{aligned}
\sin A + \sin B &= 2\sin\displaystyle\frac{A+B}{2}\cos\displaystyle\frac{A-B}{2}
\end{aligned}"""),
      StepItem(tex: r"""\textbf{【解説】}"""),
      StepItem(tex: r"""\text{まず、} \sin x + \sin 3x \text{ に和積の公式を適用すると、}"""),
      StepItem(tex: r"""\begin{aligned}
&\sin x + \sin 3x \\
= &2\sin\displaystyle\frac{x+3x}{2}\cos\displaystyle\frac{x-3x}{2} \\
= &2\sin 2x \cos(-x) \\
= &2\sin 2x \cos x
\end{aligned}"""),
      StepItem(tex: r"""\text{したがって、元の方程式は、}"""),
      StepItem(tex: r"""\begin{aligned}
&\ \ \ \ \ \sin x + \sin 2x + \sin 3x = 0 \\
&\Leftrightarrow 2\sin 2x \cos x + \sin 2x = 0 \\
&\Leftrightarrow \sin 2x(2\cos x + 1) = 0 \\
&\Leftrightarrow \sin 2x = 0 \text{ または } 2\cos x + 1 = 0
\end{aligned}"""),
      StepItem(tex: r"""\textbf{【場合分け】}"""),
      StepItem(tex: r"""\text{（1）} \sin 2x = 0 \text{ の場合}"""),
      StepItem(tex: r"""\begin{aligned}
&\ \ \ \ \ \sin 2x = 0 \\
&\Leftrightarrow 2x = n\pi \quad (n \text{ は整数}) \\
&\Leftrightarrow x = \displaystyle\frac{n\pi}{2}
\end{aligned}"""),
      StepItem(tex: r"""0 \leq x < 2\pi \text{ より、} \textcolor{green}{x = 0, \displaystyle\frac{\pi}{2}, \pi, \displaystyle\frac{3\pi}{2}}"""),
      StepItem(tex: r"""\text{（2）} 2\cos x + 1 = 0 \text{ の場合}"""),
      StepItem(tex: r"""\begin{aligned}
&\ \ \ \ \ 2\cos x + 1 = 0 \\
&\Leftrightarrow \cos x = -\displaystyle\frac{1}{2} \\
&\Leftrightarrow \begin{cases}
x = \displaystyle\frac{2\pi}{3} + 2n\pi \quad (n \text{ は整数}) \\[8pt]
x = \displaystyle\frac{4\pi}{3} + 2n\pi \quad (n \text{ は整数})
\end{cases}
\end{aligned}"""),
      StepItem(tex: r"""0 \leq x < 2\pi \text{ より、} \textcolor{green}{x = \displaystyle\frac{2\pi}{3}, \displaystyle\frac{4\pi}{3}}"""),
      StepItem(tex: r"""\text{（1）と（2）を合わせて、}"""),
      StepItem(tex: r"""x = 0, \displaystyle\frac{\pi}{2}, \displaystyle\frac{2\pi}{3}, \pi, \displaystyle\frac{4\pi}{3}, \displaystyle\frac{3\pi}{2}"""),
    ],
  ),

  // ────────────────────────────────
  // 問題 7: 2次方程式に帰着させる三角方程式
  // ────────────────────────────────
  MathProblem(
    id: "C286F6A2-9859-42E0-9719-C29CE61F82AC",
    no: 7,
    category: '三角指数対数',
    level: '中級',
    question: r"""2\sin^2 x - \sin x - 1 = 0 \quad (0 \leq x < 2\pi)""",
    equation: r"""2\sin^2 x - \sin x - 1 = 0""",
    conditions: r"""0 \leq x < 2\pi""",
    answer: r"""x = \displaystyle\frac{\pi}{2}, \displaystyle\frac{7\pi}{6}, \displaystyle\frac{11\pi}{6}""",
    imageAsset: 'assets/graphs/trig_exp_log_equations/problem_7.png',
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\sin x = t \text{ とおいて、2次方程式に帰着させる。ただし、} -1 \leq t \leq 1 \text{ の範囲に注意する。}"""),
      StepItem(tex: r"""\textbf{【解説】}"""),
      StepItem(tex: r"""\sin x = t \text{ とおくと、元の方程式は、}"""),
      StepItem(tex: r"""\begin{aligned}
&\ \ \ \ \ 2t^2 - t - 1 = 0 \\
&\Leftrightarrow (2t + 1)(t - 1) = 0 \\
&\Leftrightarrow t = -\displaystyle\frac{1}{2} \text{ または } t = 1
\end{aligned}"""),
      StepItem(tex: r"""\text{ここで、} -1 \leq t \leq 1 \text{ なので、両方とも有効な解である。}"""),
      StepItem(tex: r"""\textbf{【場合分け】}"""),
      StepItem(tex: r"""\text{（1）} \sin x = 1 \text{ の場合}"""),
      StepItem(tex: r"""\begin{aligned}
&\ \ \ \ \ \sin x = 1 \\
&\Leftrightarrow x = \displaystyle\frac{\pi}{2} + 2n\pi \quad (n \text{ は整数})
\end{aligned}"""),
      StepItem(tex: r"""0 \leq x < 2\pi \text{ より、} \textcolor{green}{x = \displaystyle\frac{\pi}{2}}"""),
      StepItem(tex: r"""\text{（2）} \sin x = -\displaystyle\frac{1}{2} \text{ の場合}"""),
      StepItem(tex: r"""\begin{aligned}
&\ \ \ \ \ \sin x = -\displaystyle\frac{1}{2} \\[7pt]
&\Leftrightarrow \begin{cases}
x = \displaystyle\frac{7\pi}{6} + 2n\pi \quad (n \text{ は整数}) \\[8pt]
x = \displaystyle\frac{11\pi}{6} + 2n\pi \quad (n \text{ は整数})
\end{cases}
\end{aligned}"""),
      StepItem(tex: r"""0 \leq x < 2\pi \text{ より、} \textcolor{green}{x = \displaystyle\frac{7\pi}{6}, \displaystyle\frac{11\pi}{6}}"""),
      StepItem(tex: r"""\text{（1）と（2）を合わせて、}"""),
      StepItem(tex: r"""x = \displaystyle\frac{\pi}{2}, \displaystyle\frac{7\pi}{6}, \displaystyle\frac{11\pi}{6}"""),
    ],
  ),

  // ────────────────────────────────
  // 問題 9: 差を商に直して1次分数関数の方程式に帰着させる対数方程式
  // ────────────────────────────────
  MathProblem(
    id: "C07C6DF1-7283-4797-936F-1DFD8D597680",
    no: 9,
    category: '三角指数対数',
    level: '中級',
    question: r"""\log_3(x+1) - \log_3(x-1) = 1""",
    answer: r"""x = 2""",
    imageAsset: 'assets/graphs/trig_exp_log_equations/problem_9.png',
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{対数の性質 } \log a - \log b = \log \displaystyle\frac{a}{b} \text{ を用いて差を商に直し、その後1次分数関数の方程式に帰着させる。真数条件に注意する。}"""),
      StepItem(tex: r"""\textbf{【真数条件】}"""),
      StepItem(tex: r"""\begin{aligned}
x + 1 > 0 \quad &\Leftrightarrow \quad x > -1 \\
x - 1 > 0 \quad &\Leftrightarrow \quad x > 1
\end{aligned}"""),
      StepItem(tex: r"""\text{よって、} x > 1 \text{ が必要。}"""),
      StepItem(tex: r"""\textbf{【解説】}"""),
      StepItem(tex: r"""\text{対数の性質より、}"""),
      StepItem(tex: r"""\begin{aligned}
\log_3(x+1) - \log_3(x-1) &= \log_3\displaystyle\frac{x+1}{x-1}
\end{aligned}"""),
      StepItem(tex: r"""\text{したがって、元の方程式は、}"""),
      StepItem(tex: r"""\begin{aligned}
&\ \ \ \ \ \log_3\displaystyle\frac{x+1}{x-1} = 1 \\
&\Leftrightarrow \displaystyle\frac{x+1}{x-1} = 3^1 \\
&\Leftrightarrow \displaystyle\frac{x+1}{x-1} = 3 \\
&\Leftrightarrow x + 1 = 3(x - 1) \\
&\Leftrightarrow x + 1 = 3x - 3 \\
&\Leftrightarrow 1 + 3 = 3x - x \\
&\Leftrightarrow 4 = 2x \\
&\Leftrightarrow x = 2
\end{aligned}"""),
      StepItem(tex: r"""\text{真数条件 } x > 1 \text{ を満たすので、} x = 2 \text{ が解である。}"""),
    ],
  ),

  // ────────────────────────────────
  // 問題 10: 3と9のべきで2次方程式に帰着させる指数方程式
  // ────────────────────────────────
  MathProblem(
    id: "A029A6D1-EB0C-4D46-9DDE-51ED580623C7",
    no: 10,
    category: '三角指数対数',
    level: '中級',
    question: r"""3^x + 3^{x+1} = 9^x""",
    answer: r"""x = \log_3 4 \text{ または } 2\log_3 2""",
    imageAsset: 'assets/graphs/trig_exp_log_equations/problem_10.png',
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{すべての項を } 3^x \text{ で表し、} 3^x = t \text{ とおいて2次方程式に帰着させる。}"""),
      StepItem(tex: r"""\textbf{【ポイント】}"""),
      StepItem(tex: r"""\begin{aligned}
3^{x+1} &= 3 \cdot 3^x \\
9^x &= (3^2)^x = 3^{2x} = (3^x)^2
\end{aligned}"""),
      StepItem(tex: r"""\textbf{【解説】}"""),
      StepItem(tex: r"""\text{まず、各項を } 3^x \text{ で表すと、}"""),
      StepItem(tex: r"""\begin{aligned}
3^x + 3^{x+1} &= 3^x + 3 \cdot 3^x \\
&= 3^x(1 + 3) \\
&= 4 \cdot 3^x
\end{aligned}"""),
      StepItem(tex: r"""\text{また、}"""),
      StepItem(tex: r"""\begin{aligned}
9^x = (3^2)^x = 3^{2x} = (3^x)^2
\end{aligned}"""),
      StepItem(tex: r"""\text{したがって、元の方程式は、} 3^x = t\text{とおくと、} """),
      StepItem(tex: r"""\begin{aligned}
&\ \ \ \ \ 3^x + 3^{x+1} = 9^x\\
&\Leftrightarrow 4 \cdot 3^x = (3^x)^2 \\
&\Leftrightarrow 4t = t^2 \quad\\
&\Leftrightarrow t^2 - 4t = 0 \\
&\Leftrightarrow t(t - 4) = 0 \\
&\Leftrightarrow t = 0 \text{ または } t = 4
\end{aligned}"""),
      StepItem(tex: r"""\text{ここで、} t = 3^x > 0 \text{ なので、} t = 4 \text{ である。}"""),
      StepItem(tex: r"""\text{したがって、}"""),
      StepItem(tex: r"""\begin{aligned}
&\ \ \ \ \ t = 4 \\
&\Leftrightarrow 3^x = 4 \\
&\Leftrightarrow x = \log_3 4
\end{aligned}"""),
      StepItem(tex: r"""\text{さらに変形すると、}"""),
      StepItem(tex: r"""\begin{aligned}
x &= \log_3 4 \\
&= \log_3 2^2 \\
&= 2\log_3 2
\end{aligned}"""),
    ],
  ),

  // ────────────────────────────────
  // 問題 11: 指数法則を使った指数方程式
  // ────────────────────────────────
  MathProblem(
    id: "EBEA916F-13BA-4F47-8827-8D2546F80AA0",
    no: 11,
    category: '三角指数対数',
    level: '中級',
    question: r"""2^{2x+1} - 2^{x+2} = 2^x - 2""",
    answer: r"""x = -1, 1""",
    imageAsset: 'assets/graphs/trig_exp_log_equations/problem_11.png',
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{すべての項を } 2^x \text{ で表し、} 2^x = t \text{ とおいて2次方程式に帰着させる。}"""),
      StepItem(tex: r"""\textbf{【解説】}"""),
      StepItem(tex: r"""\text{各項を } 2^x \text{ で表すと、}"""),
      StepItem(tex: r"""\begin{aligned}
2^{2x+1} &= 2 \cdot 2^{2x} \\
&= 2 \cdot (2^x)^2 \\
2^{x+2} &= 2^2 \cdot 2^x \\
&= 4 \cdot 2^x
\end{aligned}"""),
      StepItem(tex: r"""\text{したがって、元の方程式は、}"""),
      StepItem(tex: r"""\begin{aligned}
&\ \ \ \ \ 2 \cdot (2^x)^2 - 4 \cdot 2^x = 2^x - 2 \\
&\Leftrightarrow 2 \cdot (2^x)^2 - 4 \cdot 2^x - 2^x + 2 = 0 \\
&\Leftrightarrow 2 \cdot (2^x)^2 - 5 \cdot 2^x + 2 = 0
\end{aligned}"""),
      StepItem(tex: r"""\text{ここで、} 2^x = t \text{ とおくと、} t > 0 \text{ であり、}"""),
      StepItem(tex: r"""\begin{aligned}
&\ \ \ \ \ 2t^2 - 5t + 2 = 0 \\
&\Leftrightarrow (2t - 1)(t - 2) = 0 \\
&\Leftrightarrow t = \displaystyle\frac{1}{2} \text{ または } t = 2
\end{aligned}"""),
      StepItem(tex: r"""\textbf{【場合分け】}"""),
      StepItem(tex: r"""\text{（1）} 2^x = \displaystyle\frac{1}{2} \text{ の場合}"""),
      StepItem(tex: r"""\begin{aligned}
&\ \ \ \ \ 2^x = \displaystyle\frac{1}{2} \\
&\Leftrightarrow 2^x = 2^{-1} \\
&\Leftrightarrow x = -1
\end{aligned}"""),
      StepItem(tex: r"""\text{（2）} 2^x = 2 \text{ の場合}"""),
      StepItem(tex: r"""\begin{aligned}
&\ \ \ \ \ 2^x = 2 \\
&\Leftrightarrow 2^x = 2^1 \\
&\Leftrightarrow x = 1
\end{aligned}"""),
      StepItem(tex: r"""\text{（1）と（2）より、} x = -1, 1"""),
    ],
  ),

  // ────────────────────────────────
  // 問題 12: 双曲線関数 sinh = 5
  // ────────────────────────────────
  MathProblem(
    id: "205667D9-8B8F-43B6-A590-037AAE61339F",
    no: 12,
    category: '三角指数対数',
    level: '上級',
    question: r"""\displaystyle\frac{3^x - 3^{-x}}{2} = 5""",
    answer: r"""x = \log_3(5 + \sqrt{26})""",
    imageAsset: 'assets/graphs/trig_exp_log_equations/problem_12.png',
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{両辺に } 2 \cdot 3^x \text{ をかけて整理し、} 3^x = t \text{ とおいて2次方程式に帰着させる。}"""),
      StepItem(tex: r"""\textbf{【解説】}"""),
      StepItem(tex: r"""\text{元の方程式の両辺に } 2 \cdot 3^x \text{ をかけると、}"""),
      StepItem(tex: r"""\begin{aligned}
&\ \ \ \ \ \displaystyle\frac{3^x - 3^{-x}}{2} = 5 \\
&\Leftrightarrow 3^x - 3^{-x} = 10 \\
&\Leftrightarrow 3^x - \displaystyle\frac{1}{3^x} = 10 \\
&\Leftrightarrow (3^x)^2 - 1 = 10 \cdot 3^x \\
&\Leftrightarrow (3^x)^2 - 10 \cdot 3^x - 1 = 0
\end{aligned}"""),
      StepItem(tex: r"""\text{ここで、} 3^x = t \text{ とおくと、} t > 0 \text{ であり、}"""),
      StepItem(tex: r"""\begin{aligned}
&\ \ \ \ \ t^2 - 10t - 1 = 0
\end{aligned}"""),
      StepItem(tex: r"""\text{2次方程式の解の公式より、}"""),
      StepItem(tex: r"""\begin{aligned}
t &= \displaystyle\frac{10 \pm \sqrt{10^2 - 4 \cdot 1 \cdot (-1)}}{2 \cdot 1} \\
&= \displaystyle\frac{10 \pm \sqrt{100 + 4}}{2} \\
&= \displaystyle\frac{10 \pm \sqrt{104}}{2} \\
&= \displaystyle\frac{10 \pm 2\sqrt{26}}{2} \\
&= 5 \pm \sqrt{26}
\end{aligned}"""),
      StepItem(tex: r"""\text{ここで、} t = 3^x > 0 \text{ なので、} t = 5 + \sqrt{26} \text{ である。}"""),
      StepItem(tex: r"""\text{したがって、}"""),
      StepItem(tex: r"""\begin{aligned}
&\ \ \ \ \ t = 5 + \sqrt{26} \\
&\Leftrightarrow 3^x = 5 + \sqrt{26} \\
&\Leftrightarrow x = \log_3(5 + \sqrt{26})
\end{aligned}"""),
      StepItem(tex: r"""\textbf{【補足】}"""),
      StepItem(tex: r"""\text{この問題は、底 } 3 \text{ を自然対数の底 } e = 2.718\ldots \text{ に変えると、双曲線関数 } \sinh x = \displaystyle\frac{e^x - e^{-x}}{2} \text{ に対する方程式となる。}"""),
      StepItem(tex: r"""\text{また、} \sinh x \text{ は } \displaystyle\int \frac{1}{\sqrt{x^2+1}} dx \text{ などの置換積分に関連して登場する関数である。}"""),
    ],
  ),

  // ────────────────────────────────
  // 問題 13: 双曲線関数 cosh = 5
  // ────────────────────────────────
  MathProblem(
    id: "D7300A7C-4D0A-4F2D-B723-48757CD78ED0",
    no: 13,
    category: '三角指数対数',
    level: '上級',
    question: r"""\displaystyle\frac{3^x + 3^{-x}}{2} = 5""",
    answer: r"""x = \pm \log_3(5 + 2\sqrt{6})""",
    imageAsset: 'assets/graphs/trig_exp_log_equations/problem_13.png',
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{両辺に } 2 \cdot 3^x \text{ をかけて整理し、} 3^x = t \text{ とおいて2次方程式に帰着させる。}"""),
      StepItem(tex: r"""\textbf{【解説】}"""),
      StepItem(tex: r"""\text{元の方程式の両辺に } 2 \cdot 3^x \text{ をかけると、}"""),
      StepItem(tex: r"""\begin{aligned}
&\ \ \ \ \ \displaystyle\frac{3^x + 3^{-x}}{2} = 5 \\
&\Leftrightarrow 3^x + 3^{-x} = 10 \\
&\Leftrightarrow 3^x + \displaystyle\frac{1}{3^x} = 10 \\
&\Leftrightarrow (3^x)^2 + 1 = 10 \cdot 3^x \\
&\Leftrightarrow (3^x)^2 - 10 \cdot 3^x + 1 = 0
\end{aligned}"""),
      StepItem(tex: r"""\text{ここで、} 3^x = t \text{ とおくと、} t > 0 \text{ であり、}"""),
      StepItem(tex: r"""\begin{aligned}
&\ \ \ \ \ t^2 - 10t + 1 = 0
\end{aligned}"""),
      StepItem(tex: r"""\text{2次方程式の解の公式より、}"""),
      StepItem(tex: r"""\begin{aligned}
t &= \displaystyle\frac{10 \pm \sqrt{10^2 - 4 \cdot 1 \cdot 1}}{2 \cdot 1} \\
&= \displaystyle\frac{10 \pm \sqrt{100 - 4}}{2} \\
&= \displaystyle\frac{10 \pm \sqrt{96}}{2} \\
&= \displaystyle\frac{10 \pm 4\sqrt{6}}{2} \\
&= 5 \pm 2\sqrt{6}
\end{aligned}"""),
      StepItem(tex: r"""\text{ここで、} t = 3^x > 0 \text{ なので、} t = 5 + 2\sqrt{6} \text{ または } t = 5 - 2\sqrt{6} \text{ である。}"""),
      StepItem(tex: r"""\text{（1）} 3^x = 5 + 2\sqrt{6} \text{ の場合}"""),
      StepItem(tex: r"""\begin{aligned}
&\ \ \ \ \ 3^x = 5 + 2\sqrt{6} \\
&\Leftrightarrow x = \log_3(5 + 2\sqrt{6})
\end{aligned}"""),
      StepItem(tex: r"""\text{（2）} 3^x = 5 - 2\sqrt{6} \text{ の場合}"""),
      StepItem(tex: r"""\text{ここで、共役同士を掛け算すると、}"""),
      StepItem(tex: r"""\begin{aligned}
&(5 + 2\sqrt{6})(5 - 2\sqrt{6}) \\
= & 5^2 - (2\sqrt{6})^2 \\
= & 25 - 24 = 1
\end{aligned}"""),
      StepItem(tex: r"""\text{したがって、} 5 - 2\sqrt{6} = \displaystyle\frac{1}{5 + 2\sqrt{6}} \text{ である。}"""),
      StepItem(tex: r"""\begin{aligned}
&\ \ \ \ \ x = \log_3(5 - 2\sqrt{6}) \\
&\Leftrightarrow x = \log_3\displaystyle\frac{1}{5 + 2\sqrt{6}} \\
&\Leftrightarrow x = -\log_3(5 + 2\sqrt{6})
\end{aligned}"""),
      StepItem(tex: r"""\text{したがって、} x = \pm \log_3(5 + 2\sqrt{6}) \text{ が解である。}"""),
      StepItem(tex: r"""\textbf{【補足】}"""),
      StepItem(tex: r"""\text{この問題は、底 } 3 \text{ を自然対数の底 } e = 2.718\ldots \text{ に変えると、双曲線関数 } \cosh x = \displaystyle\frac{e^x + e^{-x}}{2} \text{ に対する方程式となる。}"""),
      StepItem(tex: r"""\text{また、} \cosh x \text{ は } \displaystyle\int \sqrt{x^2+1} dx \text{ などの置換積分に関連して登場する関数である。}"""),
    ],
  ),

  // ────────────────────────────────
  // 問題 14: 双曲線関数 tanh = 1/5
  // ────────────────────────────────
  MathProblem(
    id: "54B8A495-B84C-4CFE-8B99-9C45B22E2CE0",
    no: 14,
    category: '三角指数対数',
    level: '上級',
    question: r"""\displaystyle\frac{3^x - 3^{-x}}{3^x + 3^{-x}} = \displaystyle\frac{1}{5}""",
    answer: r"""x = \displaystyle\frac{1}{2}\log_3\displaystyle\frac{3}{2} \text{ または } \displaystyle\frac{1}{2}\left(1-\log_3 2\right)""",
    imageAsset: 'assets/graphs/trig_exp_log_equations/problem_14.png',
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{分母分子に } 3^x \text{ をかけて整理し、方程式を解く。}"""),
      StepItem(tex: r"""\textbf{【解説】}"""),
      StepItem(tex: r"""\text{元の方程式の分母分子に } 3^x \text{ をかけると、}"""),
      StepItem(tex: r"""\begin{aligned}
&\ \ \ \ \ \displaystyle\frac{3^x - 3^{-x}}{3^x + 3^{-x}} = \displaystyle\frac{1}{5} \\
&\Leftrightarrow \displaystyle\frac{3^x \cdot 3^x - 3^x \cdot 3^{-x}}{3^x \cdot 3^x + 3^x \cdot 3^{-x}} = \displaystyle\frac{1}{5} \\
&\Leftrightarrow \displaystyle\frac{(3^x)^2 - 1}{(3^x)^2 + 1} = \displaystyle\frac{1}{5} \\
&\Leftrightarrow 5((3^x)^2 - 1) = (3^x)^2 + 1 \\
&\Leftrightarrow 5(3^x)^2 - 5 = (3^x)^2 + 1 \\
&\Leftrightarrow 5(3^x)^2 - (3^x)^2 = 1 + 5 \\
&\Leftrightarrow 4(3^x)^2 = 6 \\
&\Leftrightarrow (3^x)^2 = \displaystyle\frac{3}{2} \\
&\Leftrightarrow 3^x = \sqrt{\displaystyle\frac{3}{2}} \\
&\Leftrightarrow x = \log_3\sqrt{\displaystyle\frac{3}{2}} = \displaystyle\frac{1}{2}\log_3\displaystyle\frac{3}{2}
\end{aligned}"""),
      StepItem(tex: r"""\text{さらに変形すると、}"""),
      StepItem(tex: r"""\begin{aligned}
x &= \displaystyle\frac{1}{2}\log_3\displaystyle\frac{3}{2} \\
&= \displaystyle\frac{1}{2}\left(\log_3 3 - \log_3 2\right) \\
&= \displaystyle\frac{1}{2}\left(1 - \log_3 2\right)
\end{aligned}"""),
      StepItem(tex: r"""\textbf{【補足】}"""),
      StepItem(tex: r"""\text{この問題は、底 } 3 \text{ を自然対数の底 } e = 2.718\ldots \text{ に変えると、双曲線関数 } \tanh x = \displaystyle\frac{e^x - e^{-x}}{e^x + e^{-x}} \text{ に対する方程式となる。}"""),
      StepItem(tex: r"""\text{また、} \tanh x \text{ は } \sinh x, \cosh x \text{ と同様に、} \sqrt{x^2+1} \text{ や } \displaystyle\frac{1}{\sqrt{x^2+1}} \text{ などの置換積分に関連して登場する関数である。}"""),
    ],
  ),

  // ────────────────────────────────
  // 問題 15: 正五角形の三角方程式
  // ────────────────────────────────
  MathProblem(
    id: "66847D9E-40D3-437C-9499-BF4A62B783B7",
    no: 15,
    category: '三角指数対数',
    level: '上級',
    question: r"""\cos 5x = 0 \quad (0 \leq x < 2\pi)""",
    equation: r"""\cos 5x = 0""",
    conditions: r"""0 \leq x < 2\pi""",
    answer: r"""x = \displaystyle\frac{\pi}{10}, \displaystyle\frac{3\pi}{10}, \displaystyle\frac{\pi}{2}, \displaystyle\frac{7\pi}{10}, \displaystyle\frac{9\pi}{10}, \displaystyle\frac{11\pi}{10}, \displaystyle\frac{13\pi}{10}, \displaystyle\frac{3\pi}{2}, \displaystyle\frac{17\pi}{10}, \displaystyle\frac{19\pi}{10}""",
    imageAsset: 'assets/graphs/trig_exp_log_equations/problem_15.png',
    steps: [
      StepItem(tex: r"""\textbf{【解説】}"""),
      StepItem(tex: r"""\cos 5x = 0 \text{ より、}"""),
      StepItem(tex: r"""\begin{aligned}
&\ \ \ \ \ \cos 5x = 0 \\
&\Leftrightarrow 5x = \displaystyle\frac{\pi}{2} + n\pi \quad (n \text{ は整数}) \\
&\Leftrightarrow x = \displaystyle\frac{\pi}{10} + \displaystyle\frac{n\pi}{5}
\end{aligned}"""),
      StepItem(tex: r"""\text{ここで、} 0 \leq x < 2\pi \text{ より、}"""),
      StepItem(tex: r"""\begin{aligned}
&\ \ \ \ \ 0 \leq \displaystyle\frac{\pi}{10} + \displaystyle\frac{n\pi}{5} < 2\pi \\
&\Leftrightarrow 0 \leq \displaystyle\frac{\pi + 2n\pi}{10} < 2\pi \\
&\Leftrightarrow 0 \leq \pi(1 + 2n) < 20\pi \\
&\Leftrightarrow 0 \leq 1 + 2n < 20 \\
&\Leftrightarrow -1 \leq 2n < 19 \\
&\Leftrightarrow -\displaystyle\frac{1}{2} \leq n < \displaystyle\frac{19}{2}
\end{aligned}"""),
      StepItem(tex: r"""\text{よって、} n = 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 \text{の10通りが解となる。すなわち、}"""),
      StepItem(tex: r"""\begin{aligned}
x &= \displaystyle\frac{\pi}{10}, \displaystyle\frac{3\pi}{10}, \displaystyle\frac{\pi}{2}, \displaystyle\frac{7\pi}{10}, \displaystyle\frac{9\pi}{10}, \\
&\quad \displaystyle\frac{11\pi}{10}, \displaystyle\frac{13\pi}{10}, \displaystyle\frac{3\pi}{2}, \displaystyle\frac{17\pi}{10}, \displaystyle\frac{19\pi}{10}
\end{aligned}"""),
    ],
  ),

  // ────────────────────────────────
  // 問題 16: sin x cos x + √2(sin x + cos x) = 1/2
  // ────────────────────────────────
  MathProblem(
    id: "F8A3B2C1-9D4E-5F6A-7B8C-9D0E1F2A3B4C",
    no: 16,
    category: '三角指数対数',
    level: '中級',
    question: r"""\sin x \cos x + \sqrt{2}(\sin x + \cos x) = \displaystyle\frac{1}{2} \quad (0 \leq x < 2\pi)""",
    equation: r"""\sin x \cos x + \sqrt{2}(\sin x + \cos x) = \displaystyle\frac{1}{2}""",
    conditions: r"""0 \leq x < 2\pi""",
    answer: r"""x = \arcsin(\sqrt{2} - 1) - \displaystyle\frac{\pi}{4} + 2n\pi, \pi - \arcsin(\sqrt{2} - 1) - \displaystyle\frac{\pi}{4} + 2n\pi \quad (n \text{ は整数})""",
    imageAsset: 'assets/graphs/trig_exp_log_equations/problem_16.png',
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\sin x + \cos x = t \text{ とおいて、} \sin x \cos x \text{ を } t \text{ で表し、2次方程式に帰着させる。}"""),
      StepItem(tex: r"""\textbf{【ポイント】}"""),
      StepItem(tex: r"""\begin{aligned}
(\sin x + \cos x)^2 &= \sin^2 x + 2\sin x \cos x + \cos^2 x \\
&= 1 + 2\sin x \cos x
\end{aligned}"""),
      StepItem(tex: r"""\text{よって、} \sin x \cos x = \displaystyle\frac{t^2 - 1}{2} \text{ である。}"""),
      StepItem(tex: r"""\textbf{【解説】}"""),
      StepItem(tex: r"""\sin x + \cos x = t \text{ とおくと、}"""),
      StepItem(tex: r"""\begin{aligned}
\sin x \cos x &= \displaystyle\frac{(\sin x + \cos x)^2 - 1}{2} \\
&= \displaystyle\frac{t^2 - 1}{2}
\end{aligned}"""),
      StepItem(tex: r"""\text{元の方程式は、}"""),
      StepItem(tex: r"""\begin{aligned}
&\ \ \ \ \ \sin x \cos x + \sqrt{2}(\sin x + \cos x) = \displaystyle\frac{1}{2} \\
&\Leftrightarrow \displaystyle\frac{t^2 - 1}{2} + \sqrt{2}t = \displaystyle\frac{1}{2} \\
&\Leftrightarrow t^2 - 1 + 2\sqrt{2}t = 1 \\
&\Leftrightarrow t^2 + 2\sqrt{2}t - 2 = 0
\end{aligned}"""),
      StepItem(tex: r"""\text{2次方程式の解の公式より、}"""),
      StepItem(tex: r"""\begin{aligned}
t &= \displaystyle\frac{-2\sqrt{2} \pm \sqrt{(2\sqrt{2})^2 - 4 \cdot 1 \cdot (-2)}}{2 \cdot 1} \\
&= \displaystyle\frac{-2\sqrt{2} \pm \sqrt{8 + 8}}{2} \\
&= \displaystyle\frac{-2\sqrt{2} \pm \sqrt{16}}{2} \\
&= \displaystyle\frac{-2\sqrt{2} \pm 4}{2} \\
&= -\sqrt{2} \pm 2
\end{aligned}"""),
      StepItem(tex: r"""\text{すなわち、} t = 2 - \sqrt{2} \text{ または } t = -2 - \sqrt{2}"""),
      StepItem(tex: r"""\textbf{【範囲の確認】}"""),
      StepItem(tex: r"""\text{三角関数の合成より、}"""),
      StepItem(tex: r"""\begin{aligned}
\sin x + \cos x &= \sqrt{2}\sin\left(x + \displaystyle\frac{\pi}{4}\right)
\end{aligned}"""),
      StepItem(tex: r"""\text{よって、} |\sin x + \cos x| = |t| \leq \sqrt{2} \text{ である。}"""),
      StepItem(tex: r"""\text{ここで、}"""),
      StepItem(tex: r"""\begin{aligned}
|2 - \sqrt{2}| &\approx |2 - 1.414| = 0.586 < \sqrt{2} \\
|-2 - \sqrt{2}| &\approx |-2 - 1.414| = 3.414 > \sqrt{2}
\end{aligned}"""),
      StepItem(tex: r"""\text{したがって、} t = 2 - \sqrt{2} \text{ のみが有効である。}"""),
      StepItem(tex: r"""\textbf{【解の導出】}"""),
      StepItem(tex: r"""\text{三角関数の合成より、}"""),
      StepItem(tex: r"""\begin{aligned}
&\ \ \ \ \ \sin x + \cos x = 2 - \sqrt{2} \\
&\Leftrightarrow \sqrt{2}\sin\left(x + \displaystyle\frac{\pi}{4}\right) = 2 - \sqrt{2} \\
&\Leftrightarrow \sin\left(x + \displaystyle\frac{\pi}{4}\right) = \displaystyle\frac{2 - \sqrt{2}}{\sqrt{2}} = \sqrt{2} - 1
\end{aligned}"""),
      StepItem(tex: r"""\text{ここで、} \theta = x + \displaystyle\frac{\pi}{4} \text{ とおくと、}"""),
      StepItem(tex: r"""\begin{aligned}
&\ \ \ \ \ \sin\theta = \sqrt{2} - 1 \\
&\Leftrightarrow \begin{cases}
\theta = \arcsin(\sqrt{2} - 1) + 2n\pi \quad (n \text{ は整数}) \\[8pt]
\theta = \pi - \arcsin(\sqrt{2} - 1) + 2n\pi \quad (n \text{ は整数})
\end{cases}
\end{aligned}"""),
      StepItem(tex: r"""\text{すなわち、}"""),
      StepItem(tex: r"""\begin{aligned}
&\ \ \ \ \ x + \displaystyle\frac{\pi}{4} = \begin{cases}
\arcsin(\sqrt{2} - 1) + 2n\pi \\[8pt]
\pi - \arcsin(\sqrt{2} - 1) + 2n\pi
\end{cases} \quad (n \text{ は整数}) \\
&\Leftrightarrow \begin{cases}
x = \arcsin(\sqrt{2} - 1) - \displaystyle\frac{\pi}{4} + 2n\pi \\[8pt]
x = \pi - \arcsin(\sqrt{2} - 1) - \displaystyle\frac{\pi}{4} + 2n\pi
\end{cases} \quad (n \text{ は整数})
\end{aligned}"""),
      StepItem(tex: r"""0 \leq x < 2\pi \text{ の範囲では、適切な } n \text{ を選んで、}"""),
      StepItem(tex: r"""\text{解が得られる。}"""),
    ],
  ),

  // ────────────────────────────────
  // 問題 17: 3^x + 3^{-x} と 9^x + 9^{-x} を含む方程式
  // ────────────────────────────────
  MathProblem(
    id: "A1B2C3D4-E5F6-A7B8-C9D0-E1F2A3B4C5D6",
    no: 17,
    category: '三角指数対数',
    level: '上級',
    question: r"""3^x + 3^{-x} + 9^x + 9^{-x} = 4""",
    answer: r"""x = 0""",
    imageAsset: 'assets/graphs/trig_exp_log_equations/problem_17.png',
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""3^x + 3^{-x} = t \text{ とおいて、} 9^x + 9^{-x} \text{ を } t \text{ で表し、2次方程式に帰着させる。}"""),
      StepItem(tex: r"""\textbf{【ポイント】}"""),
      StepItem(tex: r"""\begin{aligned}
(3^x + 3^{-x})^2 &= 9^x + 2 \cdot 3^x \cdot 3^{-x} + 9^{-x} \\
&= 9^x + 2 + 9^{-x}
\end{aligned}"""),
      StepItem(tex: r"""\text{よって、} 9^x + 9^{-x} = (3^x + 3^{-x})^2 - 2 = t^2 - 2 \text{ である。}"""),
      StepItem(tex: r"""\textbf{【解説】}"""),
      StepItem(tex: r"""3^x + 3^{-x} = t \text{ とおくと、} t > 0 \text{ であり、}"""),
      StepItem(tex: r"""\begin{aligned}
9^x + 9^{-x} &= (3^x)^2 + (3^{-x})^2 \\
&= (3^x + 3^{-x})^2 - 2 \cdot 3^x \cdot 3^{-x} \\
&= t^2 - 2
\end{aligned}"""),
      StepItem(tex: r"""\text{元の方程式は、}"""),
      StepItem(tex: r"""\begin{aligned}
&\ \ \ \ \ 3^x + 3^{-x} + 9^x + 9^{-x} = 4 \\
&\Leftrightarrow t + (t^2 - 2) = 4 \\
&\Leftrightarrow t^2 + t - 6 = 0 \\
&\Leftrightarrow (t + 3)(t - 2) = 0 \\
&\Leftrightarrow t = -3 \text{ または } t = 2
\end{aligned}"""),
      StepItem(tex: r"""\text{ここで、} t = 3^x + 3^{-x} > 0 \text{ なので、} t = 2 \text{ である。}"""),
      StepItem(tex: r"""\text{したがって、}"""),
      StepItem(tex: r"""\begin{aligned}
&\ \ \ \ \ 3^x + 3^{-x} = 2 \\
&\Leftrightarrow 3^x + \displaystyle\frac{1}{3^x} = 2 \\
&\Leftrightarrow (3^x)^2 + 1 = 2 \cdot 3^x \\
&\Leftrightarrow (3^x)^2 - 2 \cdot 3^x + 1 = 0 \\
&\Leftrightarrow (3^x - 1)^2 = 0 \\
&\Leftrightarrow 3^x = 1 \\
&\Leftrightarrow x = 0
\end{aligned}"""),
    ],
  ),

  // ────────────────────────────────
  // 問題 18: 連立三角方程式
  // ────────────────────────────────
  MathProblem(
    id: "B2C3D4E5-F6A7-B8C9-D0E1-F2A3B4C5D6E7",
    no: 18,
    category: '三角指数対数',
    level: '上級',
    question: r"""\begin{cases}
\sin x + \cos y = 1 \\[8pt]
\cos x + \sin y = \sqrt{3}
\end{cases}""",
    equation: r"""\begin{cases}
\sin x + \cos y = 1 \\[8pt]
\cos x + \sin y = \sqrt{3}
\end{cases}""",
    conditions: r"""0 \leq x < 2\pi, \quad 0 \leq y < 2\pi""",
    answer: r"""x = \displaystyle\frac{\pi}{6}, \quad y = \displaystyle\frac{\pi}{3}""",
    imageAsset: 'assets/graphs/trig_exp_log_equations/problem_18.png',
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{2つの方程式を加減して、} \sin(x + y) \text{ や } \cos(x - y) \text{ の形を作る。}"""),
      StepItem(tex: r"""\textbf{【解説】}"""),
      StepItem(tex: r"""\text{2つの方程式を加えると、}"""),
      StepItem(tex: r"""\begin{aligned}
&\ \ \ \ \ (\sin x + \cos y) + (\cos x + \sin y) = 1 + \sqrt{3} \\
&\Leftrightarrow (\sin x + \cos x) + (\sin y + \cos y) = 1 + \sqrt{3}
\end{aligned}"""),
      StepItem(tex: r"""\text{三角関数の合成より、}"""),
      StepItem(tex: r"""\begin{aligned}
\sin x + \cos x &= \sqrt{2}\sin\left(x + \displaystyle\frac{\pi}{4}\right) \\
\sin y + \cos y &= \sqrt{2}\sin\left(y + \displaystyle\frac{\pi}{4}\right)
\end{aligned}"""),
      StepItem(tex: r"""\text{したがって、}"""),
      StepItem(tex: r"""\begin{aligned}
&\ \ \ \ \ \sqrt{2}\sin\left(x + \displaystyle\frac{\pi}{4}\right) + \sqrt{2}\sin\left(y + \displaystyle\frac{\pi}{4}\right) = 1 + \sqrt{3} \\
&\Leftrightarrow \sin\left(x + \displaystyle\frac{\pi}{4}\right) + \sin\left(y + \displaystyle\frac{\pi}{4}\right) = \displaystyle\frac{1 + \sqrt{3}}{\sqrt{2}}
\end{aligned}"""),
      StepItem(tex: r"""\textbf{【別解：加法定理を直接使う方法】}"""),
      StepItem(tex: r"""\text{2つの方程式を加えると、}"""),
      StepItem(tex: r"""\begin{aligned}
&\ \ \ \ \ (\sin x + \cos y) + (\cos x + \sin y) = 1 + \sqrt{3} \\
&\Leftrightarrow \sin x + \cos x + \sin y + \cos y = 1 + \sqrt{3}
\end{aligned}"""),
      StepItem(tex: r"""\text{ここで、} \sin x + \cos x = \sqrt{2}\sin\left(x + \displaystyle\frac{\pi}{4}\right) \text{ より、}"""),
      StepItem(tex: r"""\begin{aligned}
&\ \ \ \ \ \sqrt{2}\sin\left(x + \displaystyle\frac{\pi}{4}\right) + \sqrt{2}\sin\left(y + \displaystyle\frac{\pi}{4}\right) = 1 + \sqrt{3} \\
&\Leftrightarrow \sin\left(x + \displaystyle\frac{\pi}{4}\right) + \sin\left(y + \displaystyle\frac{\pi}{4}\right) = \displaystyle\frac{1 + \sqrt{3}}{\sqrt{2}}
\end{aligned}"""),
      StepItem(tex: r"""\text{2つの方程式を引くと、}"""),
      StepItem(tex: r"""\begin{aligned}
&\ \ \ \ \ (\sin x + \cos y) - (\cos x + \sin y) = 1 - \sqrt{3} \\
&\Leftrightarrow \sin x - \sin y + \cos y - \cos x = 1 - \sqrt{3} \\
&\Leftrightarrow 2\cos\displaystyle\frac{x+y}{2}\sin\displaystyle\frac{x-y}{2} - 2\sin\displaystyle\frac{x+y}{2}\sin\displaystyle\frac{y-x}{2} = 1 - \sqrt{3}
\end{aligned}"""),
      StepItem(tex: r"""\textbf{【具体的な解の導出】}"""),
      StepItem(tex: r"""\text{試行錯誤により、} x = \displaystyle\frac{\pi}{6}, \quad y = \displaystyle\frac{\pi}{3} \text{ が解であることを確認する。}"""),
      StepItem(tex: r"""\begin{aligned}
\sin\displaystyle\frac{\pi}{6} + \cos\displaystyle\frac{\pi}{3} &= \displaystyle\frac{1}{2} + \displaystyle\frac{1}{2} = 1 \quad \checkmark \\
\cos\displaystyle\frac{\pi}{6} + \sin\displaystyle\frac{\pi}{3} &= \displaystyle\frac{\sqrt{3}}{2} + \displaystyle\frac{\sqrt{3}}{2} = \sqrt{3} \quad \checkmark
\end{aligned}"""),
      StepItem(tex: r"""\text{したがって、} x = \displaystyle\frac{\pi}{6}, \quad y = \displaystyle\frac{\pi}{3} \text{ が解である。}"""),
    ],
  ),

  // ────────────────────────────────
  // 問題 19: cos 2x + cos 3x = 0（正五角形と関連）
  // ────────────────────────────────
  MathProblem(
    id: "C3D4E5F6-A7B8-C9D0-E1F2-A3B4C5D6E7F8",
    no: 19,
    category: '三角指数対数',
    level: '上級',
    question: r"""\cos 2x + \cos 3x = 0 \quad (0 \leq x < 2\pi)""",
    equation: r"""\cos 2x + \cos 3x = 0""",
    conditions: r"""0 \leq x < 2\pi""",
    answer: r"""x = \displaystyle\frac{\pi}{5}, \displaystyle\frac{3\pi}{5}, \pi, \displaystyle\frac{7\pi}{5}, \displaystyle\frac{9\pi}{5}""",
    imageAsset: 'assets/graphs/trig_exp_log_equations/problem_19.png',
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{和積の公式を用いて、} \cos A + \cos B \text{ を積の形に変形する。}"""),
      StepItem(tex: r"""\textbf{【ポイント】}"""),
      StepItem(tex: r"""\begin{aligned}
\cos A + \cos B &= 2\cos\displaystyle\frac{A+B}{2}\cos\displaystyle\frac{A-B}{2}
\end{aligned}"""),
      StepItem(tex: r"""\textbf{【解説】}"""),
      StepItem(tex: r"""\text{和積の公式より、}"""),
      StepItem(tex: r"""\begin{aligned}
\cos 2x + \cos 3x &= 2\cos\displaystyle\frac{2x+3x}{2}\cos\displaystyle\frac{2x-3x}{2} \\
&= 2\cos\displaystyle\frac{5x}{2}\cos\left(-\displaystyle\frac{x}{2}\right) \\
&= 2\cos\displaystyle\frac{5x}{2}\cos\displaystyle\frac{x}{2}
\end{aligned}"""),
      StepItem(tex: r"""\text{したがって、元の方程式は、}"""),
      StepItem(tex: r"""\begin{aligned}
&\ \ \ \ \ 2\cos\displaystyle\frac{5x}{2}\cos\displaystyle\frac{x}{2} = 0 \\
&\Leftrightarrow \cos\displaystyle\frac{5x}{2} = 0 \text{ または } \cos\displaystyle\frac{x}{2} = 0
\end{aligned}"""),
      StepItem(tex: r"""\textbf{【場合分け】}"""),
      StepItem(tex: r"""\text{（1）} \cos\displaystyle\frac{5x}{2} = 0 \text{ の場合}"""),
      StepItem(tex: r"""\begin{aligned}
&\ \ \ \ \ \cos\displaystyle\frac{5x}{2} = 0 \\
&\Leftrightarrow \displaystyle\frac{5x}{2} = \displaystyle\frac{\pi}{2} + n\pi \quad (n \text{ は整数}) \\
&\Leftrightarrow 5x = \pi + 2n\pi \\
&\Leftrightarrow x = \displaystyle\frac{\pi}{5} + \displaystyle\frac{2n\pi}{5}
\end{aligned}"""),
      StepItem(tex: r"""0 \leq x < 2\pi \text{ より、} n = 0, 1, 2, 3, 4 \text{ のとき、}"""),
      StepItem(tex: r"""\textcolor{green}{x = \displaystyle\frac{\pi}{5}, \displaystyle\frac{3\pi}{5}, \pi, \displaystyle\frac{7\pi}{5}, \displaystyle\frac{9\pi}{5}}"""),
      StepItem(tex: r"""\text{（2）} \cos\displaystyle\frac{x}{2} = 0 \text{ の場合}"""),
      StepItem(tex: r"""\begin{aligned}
&\ \ \ \ \ \cos\displaystyle\frac{x}{2} = 0 \\
&\Leftrightarrow \displaystyle\frac{x}{2} = \displaystyle\frac{\pi}{2} + n\pi \quad (n \text{ は整数}) \\
&\Leftrightarrow x = \pi + 2n\pi
\end{aligned}"""),
      StepItem(tex: r"""0 \leq x < 2\pi \text{ より、} \textcolor{green}{x = \pi}"""),
      StepItem(tex: r"""\text{（1）と（2）を合わせて、}"""),
      StepItem(tex: r"""x = \displaystyle\frac{\pi}{5}, \displaystyle\frac{3\pi}{5}, \pi, \displaystyle\frac{7\pi}{5}, \displaystyle\frac{9\pi}{5}"""),
      StepItem(tex: r"""\textbf{【正五角形との関連】}"""),
      StepItem(tex: r"""\text{正五角形の中心角は } \displaystyle\frac{2\pi}{5} \text{ である。}"""),
      StepItem(tex: r"""\text{解 } x = \displaystyle\frac{\pi}{5}, \displaystyle\frac{3\pi}{5}, \pi, \displaystyle\frac{7\pi}{5}, \displaystyle\frac{9\pi}{5} \text{ は、}"""),
      StepItem(tex: r"""\text{正五角形の中心角 } \displaystyle\frac{2\pi}{5} \text{ の倍数（またはその半分）に対応している。}"""),
      StepItem(tex: r"""\text{特に、} \cos\displaystyle\frac{5x}{2} = 0 \text{ の解は、正五角形の頂点の位置に関連する角度を表している。}"""),
      StepItem(tex: r"""\text{また、} \cos 2x + \cos 3x = 0 \text{ は、正五角形の対称性を反映した方程式である。}"""),
    ],
  ),
];


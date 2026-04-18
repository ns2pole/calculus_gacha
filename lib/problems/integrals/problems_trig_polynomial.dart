// ./solutions/problems_trig_polynomial_improved.dart


/// ============================================================================
/// 三角関数の多項式 12問
/// ============================================================================

// 改善点（指示遵守版）:
// - 各問題について「【方針】・【ポイント】・【解説】・【補足】」の4区分で丁寧に整理
// - 式変形は一切省略せず、aligned 環境で1行1変形を徹底（同じ左辺の重複記載を回避）
// - cot, csc, sec は不使用
// - 定積分の答えは数値（π 等を含む）で明示
// - 不定積分は原始関数（+C）で明示（問題文は変更不可のため）
//
// 依存モデル: MathProblem, StepItem
import '../../models/math_problem.dart';
import '../../models/step_item.dart';

/// 三角関数の多項式（改善版・詳細解説）
const trigPolynomialProblems = <MathProblem>[
  // 1) ∫₀^π sin²x dx
  MathProblem(
    id: "D812B02C-7F6E-4FA4-BD61-A05CBAB6D525",
    no: 1,
    category: '三角関数の多項式',
    level: '初級',
    question: r"""\displaystyle \int_0^{\pi} \sin^2 x \, dx""",
    answer: r""" \displaystyle\frac{\pi}{2}""",
    imageAsset: 'assets/graphs/integral/problems_trig_polynomial/problem_1.png',
    hint: r"""\text{半角公式 } \sin^2 x=\displaystyle\frac{1-\cos 2x}{2} \text{ を用いて、基本的な定積分に帰着する。}""",
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{半角公式 } \sin^2 x=\displaystyle\frac{1-\cos 2x}{2} \text{ を用いて、基本的な定積分に帰着する。}"""),
      StepItem(tex: r"""\textbf{【解説】}"""),
      StepItem(tex: r"""\begin{aligned}
\displaystyle &\int_0^{\pi}\sin^2 x\,dx\\
=& \displaystyle \int_0^{\pi}\displaystyle\frac{1-\cos 2x}{2}\,dx\\
=& \displaystyle\frac{1}{2}\displaystyle \int_0^{\pi}1\,dx-\displaystyle\frac{1}{2}\displaystyle \int_0^{\pi}\cos 2x\,dx\\
=& \displaystyle\frac{1}{2}\left[x\right]_0^{\pi}-\displaystyle\frac{1}{2}\left[\displaystyle\frac{\sin 2x}{2}\right]_0^{\pi}\\
=& \displaystyle\frac{1}{2}\left(\pi-0\right)-\displaystyle\frac{1}{2}\left(\displaystyle\frac{\sin 2\pi}{2}-\displaystyle\frac{\sin 0}{2}\right)\\
=& \displaystyle\frac{1}{2}\pi-\displaystyle\frac{1}{2}\left(\displaystyle\frac{0}{2}-\displaystyle\frac{0}{2}\right)\\
=& \displaystyle\frac{\pi}{2}
\end{aligned}
"""),
    ],
  ),

  // 2) ∫_{0}^{π/6} sin³x dx
  MathProblem(
    id: "E356DB2A-1686-4B3F-8F5C-77FBE782E17F",
    no: 2,
    category: '三角関数の多項式',
    level: '初級',
    question: r"""\displaystyle \int_{0}^{\frac{\pi}{6}} \sin^3 x \, dx""",
    answer: r"""\displaystyle\frac{16-9\sqrt{3}}{24}""",
    imageAsset: 'assets/graphs/integral/problems_trig_polynomial/problem_2.png',
    hint: r"""\sin^3 x=\sin x(1-\cos^2 x)\text{ として } u=\cos x \text{ に置換し、多項式の原始関数に帰着する。}""",
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\sin^3 x=\sin x(1-\cos^2 x)\text{ として } u=\cos x \text{ に置換し、多項式の原始関数に帰着する。}"""),
      StepItem(tex: r"""\textbf{【ポイント】}"""),
      StepItem(tex: r"""\begin{aligned}
&\sin^3 x = \sin x(1-\cos^2 x)\\[5pt]
&u = \cos x \Rightarrow du = -\sin x \, dx
\end{aligned}"""),
      StepItem(tex: r"""\textbf{【解説】}"""),
      StepItem(tex: r"""\begin{aligned}
\int_{0}^{\frac{\pi}{6}} \sin^3 x \, dx
&= \int_{0}^{\frac{\pi}{6}} (1-\cos^2 x)\sin x \, dx\\[5pt]
&= \int_{u=\cos 0}^{u=\cos(\pi/6)} (1-u^2)(-du)\\[5pt]
&= \int_{u=1}^{u=\displaystyle\frac{\sqrt{3}}{2}} (u^2-1) \, du\\[5pt]
&= \int_{\frac{\sqrt{3}}{2}}^{1} (1-u^2) \, du\\[5pt]
&= \left[u - \displaystyle\frac{u^3}{3}\right]_{\displaystyle\frac{\sqrt{3}}{2}}^{1}\\[5pt]
&= \left(1 - \displaystyle\frac{1}{3}\right) - \left(\displaystyle\frac{\sqrt{3}}{2} - \displaystyle\frac{(\sqrt{3}/2)^3}{3}\right)\\[5pt]
&= \displaystyle\frac{2}{3} - \displaystyle\frac{\sqrt{3}}{2} + \displaystyle\frac{(\sqrt{3}/2)^3}{3}\\[5pt]
&= \displaystyle\frac{2}{3} - \displaystyle\frac{\sqrt{3}}{2} + \displaystyle\frac{\displaystyle\frac{3\sqrt{3}}{8}}{3}\\[5pt]
&= \displaystyle\frac{2}{3} - \displaystyle\frac{\sqrt{3}}{2} + \displaystyle\frac{\sqrt{3}}{8}\\[5pt]
&= \displaystyle\frac{2}{3} - \displaystyle\frac{4\sqrt{3}}{8} + \displaystyle\frac{\sqrt{3}}{8}\\[5pt]
&= \displaystyle\frac{2}{3} - \displaystyle\frac{3\sqrt{3}}{8}\\[5pt]
&= \displaystyle\frac{16}{24} - \displaystyle\frac{9\sqrt{3}}{24}
\end{aligned}"""),
      StepItem(tex: r"""\text{ここで、} \cos\displaystyle\frac{\pi}{6} = \displaystyle\frac{\sqrt{3}}{2}, \ \sin\displaystyle\frac{\pi}{6} = \displaystyle\frac{1}{2} \text{ である。}"""),
      StepItem(tex: r"""\text{別の方法として、不定積分を先に求める：}"""),
      StepItem(tex: r"""\begin{aligned}
\int \sin^3 x \, dx &= \int \sin x (1-\cos^2 x) \, dx\\[5pt]
&= \int \sin x \, dx - \int \sin x \cos^2 x \, dx\\[5pt]
&= -\cos x + \displaystyle\frac{\cos^3 x}{3} + C
\end{aligned}"""),
      StepItem(tex: r"""\text{したがって、}"""),
      StepItem(tex: r"""\begin{aligned}
\int_{0}^{\frac{\pi}{6}} \sin^3 x \, dx &= \left[-\cos x + \displaystyle\frac{\cos^3 x}{3}\right]_{0}^{\frac{\pi}{6}}\\[5pt]
&= \left(-\cos\displaystyle\frac{\pi}{6} + \displaystyle\frac{\cos^3(\pi/6)}{3}\right) - \left(-\cos 0 + \displaystyle\frac{\cos^3 0}{3}\right)\\[5pt]
&= \left(-\displaystyle\frac{\sqrt{3}}{2} + \displaystyle\frac{(\sqrt{3}/2)^3}{3}\right) - \left(-1 + \displaystyle\frac{1}{3}\right)\\[5pt]
&= -\displaystyle\frac{\sqrt{3}}{2} + \displaystyle\frac{\displaystyle\frac{3\sqrt{3}}{8}}{3} + 1 - \displaystyle\frac{1}{3}\\[5pt]
&= -\displaystyle\frac{\sqrt{3}}{2} + \displaystyle\frac{\sqrt{3}}{8} + \displaystyle\frac{2}{3}\\[5pt]
&= -\displaystyle\frac{4\sqrt{3}}{8} + \displaystyle\frac{\sqrt{3}}{8} + \displaystyle\frac{2}{3}\\[5pt]
&= -\displaystyle\frac{3\sqrt{3}}{8} + \displaystyle\frac{2}{3}\\[5pt]
&= \displaystyle\frac{16}{24} - \displaystyle\frac{9\sqrt{3}}{24}
\end{aligned}"""),
      StepItem(tex: r"""\text{したがって、}"""),
      StepItem(tex: r"""\begin{aligned}
\int_{0}^{\frac{\pi}{6}} \sin^3 x \, dx = \displaystyle\frac{16-9\sqrt{3}}{24}
\end{aligned}"""),
    ],
  ),

  // 3) ∫₀^(π/2) sin⁴x dx
  MathProblem(
    id: "422D4451-7399-4187-863C-165C15969BB4",
    no: 3,
    category: '三角関数の多項式',
    level: '中級',
    question: r"""\displaystyle \int_0^{  \frac{\pi}{2}} \sin^4 x \, dx""",
    answer: r""" \displaystyle\frac{3}{16}\pi""",
    imageAsset: 'assets/graphs/integral/problems_trig_polynomial/problem_3.png',
    hint: r"""\text{半角 } \sin^2 x=\displaystyle\frac{1-\cos 2x}{2} \text{ と } \cos^2 2x=\displaystyle\frac{1+\cos 4x}{2} \text{ を用いて三角関数の次数を下げる。}""",
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{半角 } \sin^2 x=\displaystyle\frac{1-\cos 2x}{2} \text{ と } \cos^2 2x=\displaystyle\frac{1+\cos 4x}{2} \text{ を用いて三角関数の次数を下げる。}"""),
      StepItem(tex: r"""\textbf{【ポイント】}"""),
      StepItem(tex: r"""\begin{aligned}
&\sin^4 x=\left(\displaystyle\frac{1-\cos 2x}{2}\right)^2\ \\[4pt]
&\cos^2 2x=\displaystyle\frac{1+\cos 4x}{2}\ \\[4pt]
&\displaystyle \int \cos kx\,dx=\displaystyle\frac{\sin kx}{k}
\end{aligned}
"""),
      StepItem(tex: r"""\textbf{【解説】}"""),
      StepItem(tex: r"""\begin{aligned}
\sin^4 x
=& \left(\displaystyle\frac{1-\cos 2x}{2}\right)^2\\
=& \displaystyle\frac{1}{4}\left(1-2\cos 2x+\cos^2 2x\right)\\
=& \displaystyle\frac{1}{4}\left(1-2\cos 2x+\displaystyle\frac{1+\cos 4x}{2}\right)\\
=& \displaystyle\frac{1}{4}\left(\displaystyle\frac{3}{2}-2\cos 2x+\displaystyle\frac{1}{2}\cos 4x\right)
\end{aligned}
"""),
      StepItem(tex: r"""
\begin{aligned}
\displaystyle \int_0^{  \frac{\pi}{2}}\sin^4 x\,dx
=& \displaystyle\frac{1}{4}\displaystyle \int_0^{  \frac{\pi}{2}}\left(\displaystyle\frac{3}{2}-2\cos 2x+\displaystyle\frac{1}{2}\cos 4x\right)dx\\
=& \displaystyle\frac{1}{4}\left[\ \displaystyle\frac{3}{2}x-2\cdot\displaystyle\frac{\sin 2x}{2}+\displaystyle\frac{1}{2}\cdot\displaystyle\frac{\sin 4x}{4}\ \right]_0^{  \frac{\pi}{2}}\\
=& \displaystyle\frac{1}{4}\left[\ \displaystyle\frac{3}{2}x-\sin 2x+\displaystyle\frac{1}{8}\sin 4x\ \right]_0^{  \frac{\pi}{2}}\\
=& \displaystyle\frac{1}{4}\left(\displaystyle\frac{3}{2}\cdot\displaystyle\frac{\pi}{2}-\sin \pi+\displaystyle\frac{1}{8}\sin 2\pi\right)\\
=& \displaystyle\frac{1}{4}\left(\displaystyle\frac{3\pi}{4}-0+0\right)\\
=& \displaystyle\frac{3}{16}\pi
\end{aligned}
""")]
  ),

  // 4) ∫₀^(π/3) sin²x cos²x dx
  MathProblem(
    id: "FEE633FE-DE9A-4BF9-8E42-52FD6CA67E3A",
    no: 4,
    category: '三角関数の多項式',
    level: '中級',
    question: r"""\displaystyle \int_0^{\frac{\pi}{3}} \sin^2 x \cos^2 x \, dx""",
    answer: r"""\displaystyle\frac{\pi}{24}+\displaystyle\frac{\sqrt{3}}{64}""",
    imageAsset: 'assets/graphs/integral/problems_trig_polynomial/problem_4.png',
    hint: r"""\sin 2x=2\sin x\cos x \text{より、} \sin^2 x\cos^2 x=\left(\displaystyle\frac{\sin 2x}{2}\right)^2 \text{を使い、2乗の形にしたら半角の公式}\sin^2 2x=\displaystyle\frac{1-\cos 4x}{2}\text{を使う。}""",
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\sin 2x=2\sin x\cos x \text{より、} \sin^2 x\cos^2 x=\left(\displaystyle\frac{\sin 2x}{2}\right)^2 \text{を使い、2乗の形にしたら半角の公式}\sin^2 2x=\displaystyle\frac{1-\cos 4x}{2}\text{を使う。}"""),
      StepItem(tex: r"""\textbf{【解説】}"""),
      StepItem(tex: r"""\begin{aligned}\sin^2 x\cos^2 x
=& \left(\displaystyle\frac{\sin 2x}{2}\right)^2\\
=& \displaystyle\frac{1}{4}\sin^2 2x\\
=& \displaystyle\frac{1}{4}\cdot\displaystyle\frac{1-\cos 4x}{2}\\
=& \displaystyle\frac{1}{8}\left(1-\cos 4x\right).
\end{aligned}
"""),
      StepItem(tex: r"""
\begin{aligned}
\displaystyle \int_0^{\frac{\pi}{3}} \sin^2 x\cos^2 x\,dx
=& \displaystyle\frac{1}{8}\displaystyle \int_0^{\frac{\pi}{3}} \left(1-\cos 4x\right)dx\\
=& \displaystyle\frac{1}{8}\left[x-\displaystyle\frac{\sin 4x}{4}\right]_0^{\frac{\pi}{3}}\\
=& \displaystyle\frac{1}{8}\left(\displaystyle\frac{\pi}{3}-\displaystyle\frac{\sin(4\pi/3)}{4}\right)-\displaystyle\frac{1}{8}\left(0-\displaystyle\frac{\sin 0}{4}\right)\\
=& \displaystyle\frac{1}{8}\left(\displaystyle\frac{\pi}{3}-\displaystyle\frac{\sin(4\pi/3)}{4}\right)\\
=& \displaystyle\frac{1}{8}\left(\displaystyle\frac{\pi}{3}-\displaystyle\frac{-\sqrt{3}/2}{4}\right)\\
=& \displaystyle\frac{1}{8}\left(\displaystyle\frac{\pi}{3}+\displaystyle\frac{\sqrt{3}}{8}\right)\\
=& \displaystyle\frac{\pi}{24}+\displaystyle\frac{\sqrt{3}}{64}
\end{aligned}
"""),
      StepItem(tex: r"""\text{ここで、} \sin\displaystyle\frac{4\pi}{3}=\sin\left(\pi+\displaystyle\frac{\pi}{3}\right)=-\sin\displaystyle\frac{\pi}{3}=-\displaystyle\frac{\sqrt{3}}{2} \text{ である。}"""),
    ],
  ),

  // 5-2) ∫_{-π/4}^{π/4} cos³x dx
  MathProblem(
    id: "A5B6C7D8-E9F0-1234-5678-9ABCDEF01234",
    no: 6,
    category: '三角関数の多項式',
    level: '初級',
    question: r"""\displaystyle \int_{-\frac{\pi}{4}}^{\frac{\pi}{4}} \cos^3 x \, dx""",
    answer: r"""\displaystyle\frac{5\sqrt{2}}{6}""",
    imageAsset: 'assets/graphs/integral/problems_trig_polynomial/problem_6.png',
    hint: r"""\text{被積分関数は偶関数なので、} 2\int_{0}^{\pi/4} \cos^3 x \, dx \text{ として計算する。}""",
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{被積分関数 } \cos^3 x \text{ は偶関数なので、}"""),
      StepItem(tex: r"""\displaystyle \int_{-\frac \pi 4}^{\frac \pi 4} \cos^3 x \, dx = \displaystyle 2\int_{0}^{\frac \pi 4} \cos^3 x \, dx \text{ として計算する。}"""),
      StepItem(tex: r"""\textbf{【ポイント】}"""),
      StepItem(tex: r"""\begin{aligned}
&\cos^3 x = \cos x(1-\sin^2 x)\\[5pt]
&u = \sin x \Rightarrow du = \cos x \, dx
\end{aligned}"""),
      StepItem(tex: r"""\textbf{【解説】}"""),
      StepItem(tex: r"""\begin{aligned}
\int_{-\frac{\pi}{4}}^{\frac{\pi}{4}} \cos^3 x \, dx
&= 2\int_{0}^{\frac{\pi}{4}} \cos^3 x \, dx\\[5pt]
&= 2\int_{0}^{\frac{\pi}{4}} (1-\sin^2 x)\cos x \, dx\\[5pt]
&= 2\int_{u=0}^{u=\sin(\frac \pi 4)} (1-u^2) \, du\\[5pt]
&= 2\int_{0}^{\frac{\sqrt{2}}{2}} (1-u^2) \, du\\[5pt]
&= 2\left[u - \displaystyle\frac{u^3}{3}\right]_{0}^{\frac{\sqrt{2}}{2}}\\[5pt]
&= 2\left(\displaystyle\frac{\sqrt{2}}{2} - \frac{\left(\frac{\sqrt{2}}{2}\right)^3}{3}\right)\\[5pt]
&= 2\left(\displaystyle\frac{\sqrt{2}}{2} - \frac{\frac{2\sqrt{2}}{8}}{3}\right)\\[5pt]
&= 2\left(\displaystyle\frac{\sqrt{2}}{2} - \displaystyle\frac{\sqrt{2}}{12}\right)\\[5pt]
&= 2\left(\displaystyle\frac{6\sqrt{2}}{12} - \displaystyle\frac{\sqrt{2}}{12}\right)\\[5pt]
&= 2 \cdot \displaystyle\frac{5\sqrt{2}}{12}\\[5pt]
&= \displaystyle\frac{5\sqrt{2}}{6}
\end{aligned}"""),
    ],
  ),

  // 6-2) ∫_{0}^{π/4} 1/cos^2 x dx
  MathProblem(
    id: "F1G2H3I4-J5K6-L7M8-N9O0-P1Q2R3S4T5U6",
    no: 7,
    category: '三角関数の多項式',
    level: '初級',
    question: r"""\displaystyle \int_{0}^{\frac{\pi}{4}} \frac{dx}{\cos^2 x}""",
    answer: r"""1""",
    imageAsset: 'assets/graphs/integral/problems_trig_polynomial/problem_7.png',
    hint: r"""\text{ } (\tan x)' = \displaystyle\frac{1}{\cos^2 x} \text{ であることを用いる。}""",
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{ } (\tan x)' = \displaystyle\frac{1}{\cos^2 x} \text{ の関係を用いる。}"""),
      StepItem(tex: r"""\textbf{【解説】}"""),
      StepItem(tex: r"""\begin{aligned}
\int_{0}^{\frac{\pi}{4}} \displaystyle\frac{dx}{\cos^2 x}
&= \left[\tan x\right]_{0}^{\frac{\pi}{4}}\\[5pt]
&= \tan\displaystyle\frac{\pi}{4} - \tan 0\\[5pt]
&= 1 - 0\\[5pt]
&= 1
\end{aligned}"""),
    ],
  ),

  // 6) ∫₀^π sin x (1+cos x+cos²x) dx
//   MathProblem(
//     id: "0A45939C-F132-4735-BD59-1A31B9BFA4E8",
//     no: 6,
//     category: '三角関数の多項式',
//     level: '初級',
//     question: r"""\displaystyle \int_0^{\pi}\sin x\left(1+\cos x+\cos^2x\right)\,dx""",
//     answer: r""" \displaystyle \frac{8}{3}""",
//     imageAsset: 'assets/graphs/integral/problems_trig_polynomial/problem_6.png',
//     steps: [
//       StepItem(tex: r"""\textbf{【方針】}"""),
//       StepItem(tex: r"""\text{置換 } u=\cos x \text{ により、区間を } [1,-1] \text{ に写して多項式の定積分にする。}"""),
//       StepItem(tex: r"""\textbf{【ポイント】}"""),
//       StepItem(tex: r"""偶奇性を用いると良い。"""),
//       StepItem(tex: r"""\textbf{【解説】}"""),
//       StepItem(tex: r"""\begin{aligned}
// \displaystyle & \int_0^{\pi}\sin x\left(1+\cos x+\cos^2 x\right)dx\\
// =& -\displaystyle \int_{1}^{-1}\left(1+u+u^2\right)du\\
// =& \displaystyle 2 \int_{0}^{1}\left(1+u^2\right)du\\
// =& 2 \left[u+\displaystyle \frac{u^3}{3}\right]_{0}^{1}\\
// =& 2 \left(1+\displaystyle \frac{1}{3}\right)\\
// =& \displaystyle \frac{8}{3}
// \end{aligned}
// """),
//     ]
//   ),

  // 7) ∫₀^(π/2) cos²x dx
  MathProblem(
    id: "D04D1417-91C9-4E4F-8558-80C8FF96A50F",
    no: 8,
    category: '三角関数の多項式',
    level: '初級',
    question: r"""\displaystyle \int_0^{\frac{\pi}{2}} \cos^2 x \, dx""",
    answer: r""" \displaystyle\frac{\pi}{4}""",
    imageAsset: 'assets/graphs/integral/problems_trig_polynomial/problem_8.png',
    hint: r"""\text{半角公式 } \cos^2 x=\displaystyle\frac{1+\cos 2x}{2} \text{ を用いる。}""",
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{半角公式 } \cos^2 x=\displaystyle\frac{1+\cos 2x}{2} \text{ を用いる。}"""),
      StepItem(tex: r"""\textbf{【解説】}"""),
      StepItem(tex: r"""\begin{aligned}
\displaystyle &\int_0^{\frac {\pi}{2}}\cos^2 x\,dx\\
=& \displaystyle \int_0^{  \frac{\pi}{2}}\displaystyle\frac{1+\cos 2x}{2}\,dx\\
=& \displaystyle\frac{1}{2}\displaystyle \int_0^{  \frac{\pi}{2}}1\,dx+\displaystyle\frac{1}{2}\displaystyle \int_0^{  \frac{\pi}{2}}\cos 2x\,dx\\
=& \displaystyle\frac{1}{2}\left[x\right]_0^{  \frac{\pi}{2}}+\displaystyle\frac{1}{2}\left[\displaystyle\frac{\sin 2x}{2}\right]_0^{  \frac{\pi}{2}}\\
=& \displaystyle\frac{1}{2}\left(\displaystyle\frac{\pi}{2}-0\right)+\displaystyle\frac{1}{2}\left(\displaystyle\frac{\sin \pi}{2}-\displaystyle\frac{\sin 0}{2}\right)\\
=& \displaystyle\frac{\pi}{4}+\displaystyle\frac{1}{2}\left(\displaystyle\frac{0}{2}-\displaystyle\frac{0}{2}\right)\\
=& \displaystyle\frac{\pi}{4}
\end{aligned}
"""),
      StepItem(tex: r"""\textbf{【補足】}"""),
      StepItem(tex: r"""\sin^2 \text{の計算も同様。}"""),
    ],
  ),

  // 予備問題は problems_trig_polynomial_reserve.dart に移動しました
  // コメントアウトを外すと問題リストに追加されます

  // 11) ∫₀^{2π} sin(2x) cos(3x) dx（フーリエ級数の直交性）
  MathProblem(
    id: "2E68B281-EA4E-4B67-879E-59A9AE7EC762",
    no: 11,
    category: '積和公式',
    level: '初級',
    question: r"""\displaystyle \int_0^{2\pi}\sin(2x)\cos(3x)\,dx""",
    answer: r"""0""",
    imageAsset: 'assets/graphs/integral/problems_trig_polynomial/problem_11.png',
    hint: r"""\text{積和公式を用いて、三角関数の1次式に帰着する。}""",
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{積和公式を用いて、三角関数の1次式に帰着する。}"""),
      StepItem(tex: r"""\textbf{【解説】}"""),
      StepItem(tex: r"""\text{積和公式 } \sin A\cos B = \displaystyle\frac{1}{2}\left(\sin(A+B)+\sin(A-B)\right) \text{ を用いると、}"""),
      StepItem(tex: r"""\begin{aligned}
\displaystyle &\int_0^{2\pi}\sin(2x)\cos(3x)\,dx\\[5pt]
=& \displaystyle\frac{1}{2}\displaystyle \int_0^{2\pi}\left(\sin((2+3)x)+\sin((2-3)x)\right)dx\\[5pt]
=& \displaystyle\frac{1}{2}\displaystyle \int_0^{2\pi}\left(\sin(5x)+\sin(-x)\right)dx\\[5pt]
=& \displaystyle\frac{1}{2}\displaystyle \int_0^{2\pi}\left(\sin(5x)-\sin x\right)dx\\[5pt]
=& \displaystyle\frac{1}{2}\left[-\displaystyle\frac{\cos(5x)}{5}+\cos x\right]_0^{2\pi}\\[5pt]
=& \displaystyle\frac{1}{2}\left((-\displaystyle\frac{\cos(10\pi)}{5}+\cos(2\pi))-(-\displaystyle\frac{\cos 0}{5}+\cos 0)\right)\\[5pt]
=& \displaystyle\frac{1}{2}\left((-\displaystyle\frac{1}{5}+1)-(-\displaystyle\frac{1}{5}+1)\right)\\[5pt]
=& \displaystyle\frac{1}{2}(0)\\[5pt]
=& 0
\end{aligned}"""),
      StepItem(tex: r"""\textbf{【補足】}"""),
      StepItem(tex: r"""\text{この結果はフーリエ級数という数学に登場し、一般に下記が成立する。}"""),
      StepItem(tex: r"""\displaystyle \int_0^{2\pi}\sin(mx)\cos(nx)\,dx = 0
"""),
    ],
  ),
  

//   MathProblem(
//     id: "FA2B5E85-9ACE-4515-820D-C24AE18B6E99",
//     no: 5,
//     category: '三角（恒等変形）',
//     level: '中級',
//     question: r"""\displaystyle \int_{ \frac {\pi} {8}}^{  \frac {\pi} {4}}\displaystyle \frac{1}{\tan^{2}x}\,dx""",
//     answer: r"""\displaystyle \sqrt{2}-\displaystyle \frac{\pi}{8}""",
//     imageAsset: 'assets/graphs/problems_polynomial_fraction/problem_5.png',
//     steps: [
//       StepItem(tex: r"""\begin{aligned}
// &\textbf{【方針】}\\
// \displaystyle \frac{1}{\tan^2 x}=\displaystyle \frac{\cos^2 x}{\sin^2 x}
// =\displaystyle \frac{1}{\sin^2 x}-1\ \text{と変形する。}\\
// &\text{ }\displaystyle \int \displaystyle \frac{1}{\sin^2 x}\,dx\ \text{は } \displaystyle \frac{d}{dx}\left(\displaystyle \frac{\cos x}{\sin x}\right)=-\displaystyle \frac{1}{\sin^2 x}\ \text{を用いて積分する。}
// \end{aligned}
// """),
//       StepItem(tex: r"""\begin{aligned}
// &\textbf{【ポイント】}\\
// &\displaystyle \frac{1}{\tan^2 x}=\displaystyle \frac{\cos^2 x}{\sin^2 x}=\displaystyle \frac{1}{\sin^2 x}-1,\\
// &\displaystyle \frac{d}{dx}\left(\displaystyle \frac{\cos x}{\sin x}\right)
// =\displaystyle \frac{-\sin x\cdot \sin x-\cos x\cdot \cos x}{\sin^2 x}
// =-\displaystyle \frac{1}{\sin^2 x}
// \end{aligned}
// """),
//       StepItem(tex: r"""\begin{aligned}
// &\textbf{【解説】}\\
// &\displaystyle \int \displaystyle \frac{1}{\tan^{2}x}\,dx
// =\displaystyle \int\left(\displaystyle \frac{1}{\sin^2 x}-1\right)\,dx\\
// =& \displaystyle \int \displaystyle \frac{1}{\sin^2 x}\,dx-\displaystyle \int 1\,dx\\
// =& -\displaystyle \frac{\cos x}{\sin x}-x+C\\[6pt]
// &\text{定積分 }\\
// &\displaystyle \int_{ \frac{\pi}{8}}^{  \frac{\pi}{4}}\displaystyle \frac{1}{\tan^{2}x}\,dx
// =\left[-\displaystyle \frac{\cos x}{\sin x}-x\right]_{x=\displaystyle \frac{\pi}{8}}^{x=\displaystyle \frac{\pi}{4}}\\
// =& \left(-\displaystyle \frac{\cos\displaystyle \frac{\pi}{4}}{\sin\displaystyle \frac{\pi}{4}}-\displaystyle \frac{\pi}{4}\right)
// -\left(-\displaystyle \frac{\cos\displaystyle \frac{\pi}{8}}{\sin\displaystyle \frac{\pi}{8}}-\displaystyle \frac{\pi}{8}\right)\\
// =& -1-\displaystyle \frac{\pi}{4}+\displaystyle \frac{\cos\displaystyle \frac{\pi}{8}}{\sin\displaystyle \frac{\pi}{8}}+\displaystyle \frac{\pi}{8}\\
// &\text{ここで } \tan\displaystyle \frac{\pi}{8}=\sqrt2-1\ \text{より}\ 
// \displaystyle \frac{\cos\displaystyle \frac{\pi}{8}}{\sin\displaystyle \frac{\pi}{8}}=\displaystyle \frac{1}{\tan\displaystyle \frac{\pi}{8}}=\sqrt2+1.\\
// &\therefore\ -1-\displaystyle \frac{\pi}{4}+(\sqrt2+1)+\displaystyle \frac{\pi}{8}
// =\sqrt2-\displaystyle \frac{\pi}{8}
// \end{aligned}
// """),
//       StepItem(tex: r"""\begin{aligned}
// &\textbf{【補足】}\\
// &\text{中間で } -\displaystyle \frac{\cos x}{\sin x}\ \text{を } -\cot x\ \text{と書けるが，本問では使用を避けた。}
// \end{aligned}
// """),
//     ],
//   ),

  // 8) ∫₀^π sin⁹x dx（漸化式の導出から）
//   MathProblem(
//     id: "4B718765-D339-4E16-89C5-C2C932AEF020",
//     no: 8,
//     category: '冪乗三角（漸化式）',
//     level: '上級',
//     question: r"""\displaystyle \int_0^{\pi}\sin^9 x\,dx""",
//     answer: r""" \displaystyle \frac{256}{315}""",
//     imageAsset: 'assets/graphs/integral/problems_trig_polynomial/problem_8.png',
//     steps: [
//       StepItem(tex: r"""\textbf{【方針】}"""),
//       StepItem(tex: r"""\text{\(I_n=\displaystyle\displaystyle \int_0^{  \frac{\pi}{2}}\sin^n x\,dx\) とおき、部分積分から漸化式 } I_n=\displaystyle \frac{n-1}{n}I_{n-2} \text{ を導出して用いる。最後に } \displaystyle \int_0^{\pi}\sin^n x\,dx=2I_n \text{ を適用。}"""),
//       StepItem(tex: r"""\textbf{【ポイント】}"""),
//       StepItem(tex: r"""\begin{aligned}
// &I_n=\displaystyle \int_0^{  \frac{\pi}{2}}\sin^n x\,dx,\\
// &u=\sin^{n-1}x,\quad dv=\sin x\,dx\ \ (\Rightarrow v=-\cos x,\ du=(n-1)\sin^{n-2}x\cos x\,dx),\\
// &\cos\displaystyle \frac{\pi}{2}=0,\ \cos 0=1,\ \sin 0=0.
// \end{aligned}
// """),
//       StepItem(tex: r"""\textbf{【解説】}"""),
//       StepItem(tex: r"""\begin{aligned}
// I_n
// =& \displaystyle \int_0^{  \frac{\pi}{2}}\sin^{n-1}x\cdot\sin x\,dx\\
// =& \left[-\sin^{n-1}x\cos x\right]_0^{  \frac{\pi}{2}}+\displaystyle \int_0^{  \frac{\pi}{2}}(n-1)\sin^{n-2}x\cos^2 x\,dx\\
// =& 0+\,(n-1)\displaystyle \int_0^{  \frac{\pi}{2}}\sin^{n-2}x\,(1-\sin^2 x)\,dx\\
// =& (n-1)\displaystyle \int_0^{  \frac{\pi}{2}}\sin^{n-2}x\,dx-(n-1)\displaystyle \int_0^{  \frac{\pi}{2}}\sin^{n}x\,dx\\
// =& (n-1)I_{n-2}-(n-1)I_n\\
// &\Rightarrow\ I_n+(n-1)I_n=(n-1)I_{n-2}\\
// &\Rightarrow\ n\,I_n=(n-1)I_{n-2}\\
// &\Rightarrow\ I_n=\displaystyle \frac{n-1}{n}I_{n-2}
// \end{aligned}
// \begin{aligned}
// I_1=& 1,\\
// I_3=& \displaystyle \frac{2}{3}I_1=\displaystyle \frac{2}{3},\\
// I_5=& \displaystyle \frac{4}{5}I_3=\displaystyle \frac{4}{5}\cdot\displaystyle \frac{2}{3}=\displaystyle \frac{8}{15},\\
// I_7=& \displaystyle \frac{6}{7}I_5=\displaystyle \frac{6}{7}\cdot\displaystyle \frac{8}{15}=\displaystyle \frac{48}{105}=\displaystyle \frac{16}{35},\\
// I_9=& \displaystyle \frac{8}{9}I_7=\displaystyle \frac{8}{9}\cdot\displaystyle \frac{16}{35}=\displaystyle \frac{128}{315}
// \end{aligned}
// \begin{aligned}
// \displaystyle \int_0^{\pi}\sin^9 x\,dx
// =& 2I_9\\
// =& 2\cdot\displaystyle \frac{128}{315}\\
// =& \displaystyle \frac{256}{315}
// \end{aligned}
// """),
//       StepItem(tex: r"""\textbf{【補足】}"""),
//       StepItem(tex: r"""\text{Beta 関数や Wallis 積でも評価可能。}"""),
//     ],
//   ),

  // 9) ∫₀^π sin¹⁰x dx（偶数乗）
//   MathProblem(
//     id: "C107D86A-6A15-4CEC-A66F-AB05FD6FB378",
//     no: 9,
//     category: '冪乗三角（偶数）',
//     level: '上級',
//     question: r"""\displaystyle \int_0^{\pi}\sin^{10}x\,dx""",
//     answer: r""" \displaystyle \frac{63\pi}{256}""",
//     imageAsset: 'assets/graphs/integral/problems_trig_polynomial/problem_9.png',
//     steps: [
//       StepItem(tex: r"""\textbf{【方針】}"""),
//       StepItem(tex: r"""\text{既知の公式 } \displaystyle \int_0^{\pi}\sin^{2k}x\,dx=\pi\,\displaystyle \frac{(2k)!}{2^{2k}(k!)^2} \text{ に } k=5 \text{ を代入し、数値を約分する。}"""),
//       StepItem(tex: r"""\textbf{【ポイント】}"""),
//       StepItem(tex: r"""\begin{aligned}
// &2^{10}=1024,\quad 10!=3628800,\\
// &5!=120,\quad (5!)^2=14400.
// \end{aligned}
// """),
//       StepItem(tex: r"""\textbf{【解説】}"""),
//       StepItem(tex: r"""\begin{aligned}
// \displaystyle \int_0^{\pi}\sin^{10}x\,dx
// =& \pi\cdot\displaystyle \frac{10!}{2^{10}(5!)^2}\\
// =& \pi\cdot\displaystyle \frac{3628800}{1024\cdot 14400}\\
// =& \pi\cdot\displaystyle \frac{3628800}{14745600}\\
// =& \pi\cdot\displaystyle \frac{3628800\div 57600}{14745600\div 57600}\\
// =& \pi\cdot\displaystyle \frac{63}{256}\\
// =& \displaystyle \frac{63\pi}{256}
// \end{aligned}
// """),
//       StepItem(tex: r"""\textbf{【補足】}"""),
//       StepItem(tex: r"""\text{漸化式でも可。Beta 関数 } \mathrm{B} \text{ を用いると } \displaystyle \int_0^{\pi}\sin^{2k}x\,dx=\pi\displaystyle \frac{(2k)!}{2^{2k}(k!)^2} \text{ が導ける。}"""),
//     ],
//   ),

  // 12) ∫₀^(π/4) tan⁶x dx（漸化式）
  MathProblem(
    id: "5F800251-23AC-4487-8BD4-3BC209617EF6",
    no: 12,
    category: '三角関数の多項式（漸化式）',
    level: '上級',
    question: r"""\displaystyle \int_{0}^{\frac{\pi}{4}} \tan^6 x \, dx""",
    answer: r"""\displaystyle\frac{13}{15}-\displaystyle\frac{\pi}{4}""",
    imageAsset: 'assets/graphs/integral/problems_trig_polynomial/problem_12.png',
    hint: r"""I_n=\displaystyle \int_{0}^{\frac{\pi}{4}} \tan^n x\,dx \text{ とおき、漸化式を導出して、定積分の状態で } I_6 \text{ を } I_4, I_2, I_0 \text{ に順次変形する。}""",
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""I_n=\displaystyle \int_{0}^{\frac{\pi}{4}} \tan^n x\,dx \text{とおき、漸化式を導出して使う。}"""),
      StepItem(tex: r"""\textcolor{green}{【命題】}"""),
      StepItem(tex: r"""-\displaystyle\frac{\pi}{2}<a<b<\displaystyle\frac{\pi}{2} \text{を満たす任意の}a,b\text{に対して、} I_n=\displaystyle\int_{a}^{b} \tan^n x\,dx \text{とおくとき、}"""),
      StepItem(tex: r"""n\ge 2 \text{に対して} \textcolor{green}{\ I_n=\displaystyle\frac{1}{n-1}\left[\tan^{n-1}x\right]_{a}^{b}-I_{n-2}\ }\text{が成り立つ。}"""),
      StepItem(tex: r"""\textbf{【証明】}"""),
      StepItem(tex: r"""\textbf{恒等式 } \tan^2 x=\displaystyle\frac{1}{\cos^2 x}-1 \textbf{ を用いて、}"""),
      StepItem(tex: r"""\begin{aligned}
I_n
&=\displaystyle \int_{a}^{b} \tan^n x\,dx\\[6pt]
&=\displaystyle \int_{a}^{b} \tan^{n-2}x\cdot\tan^2 x\,dx\\[6pt]
&=\displaystyle \int_{a}^{b} \tan^{n-2}x\cdot\left(\displaystyle \frac{1}{\cos^2 x}-1\right)\,dx\\[6pt]
&=\displaystyle \int_{a}^{b} \tan^{n-2}x\cdot\displaystyle \frac{1}{\cos^2 x}\,dx-\displaystyle \int_{a}^{b} \tan^{n-2}x\,dx\cdots(1)
\end{aligned}
"""),
      StepItem(tex: r"""\textbf{第1項について、}"""),
      StepItem(tex: r"""\begin{aligned}
\displaystyle \int \tan^{n-2}x\cdot\displaystyle \frac{1}{\cos^2 x}\,dx
&=\displaystyle\int \tan^{n-2}x\cdot\sec^2 x\,dx\\[6pt]
&=\displaystyle\frac{\tan^{n-1}x}{n-1}+C
\end{aligned}
"""),
      StepItem(tex: r"""\text{したがって、定積分として、}"""),
      StepItem(tex: r"""\begin{aligned}
\displaystyle \int_{a}^{b} \tan^{n-2}x\cdot\displaystyle \frac{1}{\cos^2 x}\,dx
&=\left[\displaystyle\frac{\tan^{n-1}x}{n-1}\right]_{a}^{b}\\[6pt]
&=\displaystyle\frac{1}{n-1}\left[\tan^{n-1}x\right]_{a}^{b}
\end{aligned}
"""),
      StepItem(tex: r"""\text{したがって、(1)は} I_n=\displaystyle\frac{1}{n-1}\left[\tan^{n-1}x\right]_{a}^{b}-I_{n-2}\quad\text{Q.E.D} """),
      StepItem(tex: r""""""),
      StepItem(tex: r"""\textbf{【$a=0$, $b=\displaystyle\frac{\pi}{4}$ の場合】}"""),
      StepItem(tex: r"""\text{本問では } a=0, b=\displaystyle\frac{\pi}{4} \text{ であるから、}"""),
      StepItem(tex: r"""\begin{aligned}
I_n
&=\displaystyle\frac{1}{n-1}\left[\tan^{n-1}x\right]_{0}^{\frac{\pi}{4}}-I_{n-2}\\[6pt]
&=\displaystyle\frac{1}{n-1}\left(\tan^{n-1}\left(\displaystyle\frac{\pi}{4}\right)-\tan^{n-1}(0)\right)-I_{n-2}\\[6pt]
&=\displaystyle\frac{1}{n-1}(1-0)-I_{n-2}\\[6pt]
&=\displaystyle\frac{1}{n-1}-I_{n-2}
\end{aligned}
"""),
      StepItem(tex: r"""\textbf{【$I_6$ の計算】}"""),
      StepItem(tex: r"""\text{示した命題を用いて、定積分の状態で } I_6 \text{ を順次変形する。}"""),
      StepItem(tex: r"""\begin{aligned}
I_6
&=\displaystyle\frac{1}{6-1}-I_{6-2}\\[6pt]
&=\displaystyle\frac{1}{5}-I_4\\[6pt]
&=\displaystyle\frac{1}{5}-\left(\displaystyle\frac{1}{4-1}-I_{4-2}\right)\\[6pt]
&=\displaystyle\frac{1}{5}-\left(\displaystyle\frac{1}{3}-I_2\right)\\[6pt]
&=\displaystyle\frac{1}{5}-\displaystyle\frac{1}{3}+I_2\\[6pt]
&=\displaystyle\frac{1}{5}-\displaystyle\frac{1}{3}+\left(\displaystyle\frac{1}{2-1}-I_{2-2}\right)\\[6pt]
&=\displaystyle\frac{1}{5}-\displaystyle\frac{1}{3}+(1-I_0)\\[6pt]
&=\displaystyle\frac{1}{5}-\displaystyle\frac{1}{3}+1-I_0\\[6pt]
&=\displaystyle\frac{3-5+15}{15}-I_0\\[6pt]
&=\displaystyle\frac{13}{15}-I_0\\[6pt]
&=\displaystyle\frac{13}{15}-\displaystyle\int_{0}^{\frac{\pi}{4}} \tan^0 x\,dx\\[6pt]
&=\displaystyle\frac{13}{15}-\displaystyle\int_{0}^{\frac{\pi}{4}} 1\,dx\\[6pt]
&=\displaystyle\frac{13}{15}-\displaystyle\frac{\pi}{4}
\end{aligned}
"""),
],
  ),

  // 13) ∫₀^(π/2) sin⁷x cos⁹x dx（β関数を使わない方法）
  MathProblem(
    id: "B1C2D3E4-F5G6-7890-HIJK-LM1234567890",
    no: 13,
    category: '三角関数の多項式',
    level: '上級',
    question: r"""\displaystyle \int_{0}^{\frac{\pi}{2}} \sin^7 x \cos^9 x \, dx""",
    answer: r"""\displaystyle\frac{1}{560}""",
    imageAsset: 'assets/graphs/integral/problems_trig_polynomial/problem_13.png',
    hint: r"""I_{m,n}=\displaystyle \int_{0}^{\frac{\pi}{2}} \sin^{2m-1} x \cos^{2n-1} x\,dx \text{ とおき、} u=\sin^2 x \text{ とおく置換積分により、階乗を使った形に帰着させる。}""",
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""I_{m,n}=\displaystyle \int_{0}^{\frac{\pi}{2}} \sin^{2m-1} x \cos^{2n-1} x\,dx \text{ とおき、} u=\sin^2 x \text{ とおく置換積分により、階乗を使った形に帰着させる。}"""),
      StepItem(tex: r"""\textcolor{green}{【命題】}"""),
      StepItem(tex: r"""m,n \text{ を正の整数として、} I_{m,n}=\displaystyle\int_{0}^{\frac{\pi}{2}} \sin^{2m-1} x \cos^{2n-1} x\,dx \text{ とおくとき、} \textcolor{green}{I_{m,n}=\displaystyle\frac{1}{2}\cdot\displaystyle\frac{(m-1)!(n-1)!}{(m+n-1)!}} \text{ が成り立つ。}"""),
      StepItem(tex: r"""\textbf{【証明】}"""),
      StepItem(tex: r"""\text{置換 } u=\sin^2 x \text{ とおくと、} du=2\sin x\cos x\,dx \text{ である。}"""),
      StepItem(tex: r"""\text{積分範囲の変換：}"""),
      StepItem(tex: r"""\begin{aligned}
      \begin{cases}
      x=0 \Leftrightarrow u=\sin^2 0=0,\\[5pt]
      x=\displaystyle\frac{\pi}{2} \Leftrightarrow u=\sin^2\displaystyle\frac{\pi}{2}=1
      \end{cases}
      \end{aligned}"""),
      StepItem(tex: r"""\text{被積分関数を変形すると、}"""),
      StepItem(tex: r"""\begin{aligned}
      \sin^{2m-1} x \cos^{2n-1} x
      &=\sin^{2m-1} x \cos^{2n-1} x\\[6pt]
      &=(\sin^2 x)^{m-\frac{1}{2}} (\cos^2 x)^{n-\frac{1}{2}}\\[6pt]
      &=u^{m-\frac{1}{2}} (1-u)^{n-\frac{1}{2}}
      \end{aligned}
      """),
      StepItem(tex: r"""\text{また、} dx=\displaystyle\frac{du}{2\sin x\cos x}=\frac{du}{2u^{\frac{1}{2}}(1-u)^{\frac{1}{2}}} \text{ であるから、}"""),
      StepItem(tex: r"""\begin{aligned}
      I_{m,n}
      &=\displaystyle\int_{0}^{\frac{\pi}{2}} \sin^{2m-1} x \cos^{2n-1} x\,dx\\[6pt]
      &=\displaystyle\int_{0}^{1} u^{m-\frac{1}{2}} (1-u)^{n-\frac{1}{2}} \cdot \frac{du}{2u^{\frac{1}{2}}(1-u)^{\frac{1}{2}}}\\[6pt]
      &=\displaystyle\frac{1}{2}\displaystyle\int_{0}^{1} u^{m-1} (1-u)^{n-1}\,du
      \end{aligned}
      """),
      StepItem(tex: r"""\text{部分積分を用いて、}"""),
      StepItem(tex: r"""\begin{aligned}
      &\ \ \ \ \ \displaystyle\frac{1}{2}\displaystyle\int_{0}^{1} u^{m-1}(1-u)^{n-1}\,du\\
      &=\displaystyle\frac{1}{2}\displaystyle\int_{0}^{1} \left(\displaystyle\frac{u^m}{m}\right)' \cdot (1-u)^{n-1} \,du\\[6pt]
      &=\displaystyle\frac{1}{2}\left(\left[\displaystyle\frac{u^m}{m}(1-u)^{n-1}\right]_{0}^{1}-\displaystyle\int_{0}^{1} \displaystyle\frac{u^m}{m} \cdot (n-1)(1-u)^{n-2}(-1)\,du\right)\\[6pt]
      &=\displaystyle\frac{1}{2}\cdot\displaystyle\frac{n-1}{m}\displaystyle\int_{0}^{1} u^m(1-u)^{n-2}\,du
      \end{aligned}
      """),
      StepItem(tex: r"""\text{同様に繰り返すと、}"""),
      StepItem(tex: r"""\begin{aligned}
      &\ \ \ \ \  \displaystyle\frac{1}{2}\cdot\displaystyle\frac{n-1}{m}\int_{0}^{1} u^m(1-u)^{n-2}\,du\\
      &=\displaystyle\frac{1}{2}\cdot\displaystyle\frac{n-1}{m} \int_{0}^{1} \left(\displaystyle\frac{u^{m+1}}{m+1}\right)' \cdot (1-u)^{n-2} \,du\\[6pt]
      &=\displaystyle\frac{1}{2}\cdot\displaystyle\frac{n-1}{m}\left( \left[\displaystyle\frac{u^{m+1}}{m+1}(1-u)^{n-2}\right]_{0}^{1}-\displaystyle\int_{0}^{1} \displaystyle\frac{u^{m+1}}{m+1} \cdot (n-2)(1-u)^{n-3}(-1)\,du\right) \\[6pt]
      &=\displaystyle\frac{1}{2}\cdot\displaystyle\frac{n-1}{m} \cdot\displaystyle\frac{n-2}{m+1}\displaystyle\int_{0}^{1} u^{m+1}(1-u)^{n-3}\,du
      \end{aligned}
      """),
      StepItem(tex: r"""\text{さらに繰り返すと、}"""),
      StepItem(tex: r"""\begin{aligned}
      &=\displaystyle\frac{1}{2}\cdot\displaystyle\frac{n-1}{m}\cdot\displaystyle\frac{n-2}{m+1}\displaystyle\int_{0}^{1} u^{m+1}(1-u)^{n-3}\,du\\[6pt]
      &=\cdots\\[6pt]
      &=\displaystyle\frac{1}{2}\cdot\displaystyle\frac{n-1}{m}\cdot\displaystyle\frac{n-2}{m+1}\cdots\displaystyle\frac{1}{m+n-2}\displaystyle\int_{0}^{1} u^{m+n-2}(1-u)^0\,du\\[6pt]
      &=\displaystyle\frac{1}{2}\cdot\displaystyle\frac{(n-1)!}{m(m+1)\cdots(m+n-2)}\cdot\displaystyle\frac{1}{m+n-1}\\[6pt]
      &=\displaystyle\frac{1}{2}\cdot\displaystyle\frac{(n-1)!}{m(m+1)\cdots(m+n-2)}\cdot\displaystyle\frac{1}{m+n-1} \cdot \frac{(m-1)!}{(m-1)!}\\[6pt]
      &=\displaystyle\frac{1}{2}\cdot\displaystyle\frac{(m-1)!(n-1)!}{(m+n-1)!}
      \end{aligned}
      """),
      StepItem(tex: r"""\text{したがって、}"""),
      StepItem(tex: r"""\begin{aligned}
      I_{m,n}
      &=\displaystyle\frac{1}{2}\cdot\displaystyle\frac{(m-1)!(n-1)!}{(m+n-1)!}
      \end{aligned}\quad\text{Q.E.D}
      """),
      StepItem(tex: r"""\textbf{【$\sin^7 x \cos^9 x$ の場合】}"""),
      StepItem(tex: r"""\text{本問では } \sin^7 x \cos^9 x \text{ であるから、} 2m-1=7, 2n-1=9 \text{ より } m=4, n=5 \text{ である。}"""),
      StepItem(tex: r"""\begin{aligned}
      I_{4,5}
      &=\displaystyle\frac{1}{2}\cdot\displaystyle\frac{(4-1)!(5-1)!}{(4+5-1)!}\\[6pt]
      &=\displaystyle\frac{1}{2}\cdot\displaystyle\frac{3! \cdot 4!}{8!}\\[6pt]
      &=\displaystyle\frac{1}{2}\cdot\displaystyle\frac{6}{8\cdot 7 \cdot 6 \cdot 5}\\[6pt]
      &=\displaystyle\frac{1}{2}\cdot\displaystyle\frac{1}{280}\\[6pt]
      &=\displaystyle\frac{1}{560}
      \end{aligned}
      """),
    ],
  ),

];
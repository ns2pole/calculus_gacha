import '../../models/math_problem.dart';

/// ============================================================================
/// 曲線の面積 予備問題
/// ============================================================================
/// 
/// このファイルに保存されている問題は、コメントアウトを外すと
/// all_problems.dart の allIntegralProblems リストに追加されます。

/// 予備問題リスト
/// コメントアウトを外すと問題リストに追加されます
const curvesReserveProblems = <MathProblem>[
  // 問題 3: サイクロイドの面積計算で現れる積分
  // コメントアウトを外すと問題が追加されます
  // MathProblem(
  //   id: "5A1DA9C1-D8A7-489A-8AE1-DE6642D44272",
  //   no: 3,
  //   category: '曲線の面積',
  //   level: '初級',
  //   question: r"""\displaystyle \int_0^{2\pi} (1-\cos x)^2 \, dx""",
  //   answer: r"""3\pi""",
  //   imageAsset: 'assets/graphs/integral/problems_curves/problem_3.png',
  //   steps: [
  //     StepItem(tex: r"""\textbf{【背景】}"""),
  //     StepItem(tex: r"""\text{この積分は、サイクロイドの面積を求める過程で現れる。}"""),
  //     StepItem(tex: r"""\text{サイクロイド } x = t - \sin t, \; y = 1 - \cos t \text{ の面積は、}"""),
  //     StepItem(tex: '', imageAsset: 'assets/graphs/integral/problems_curves/problem_3_curve.png'),
  //     StepItem(tex: r"""\begin{aligned}
  // x'(t) &= 1 - \cos t
  // \end{aligned}"""),
  //     StepItem(tex: r"""\begin{aligned}
  // A &= \displaystyle \int_0^{2\pi} y x'(t) \, dt\\
  // &= \displaystyle \int_0^{2\pi} (1-\cos t)(1-\cos t) \, dt\\
  // &= \textcolor{red}{\displaystyle \int_0^{2\pi} (1-\cos x)^2\, dx}
  // \end{aligned}"""),
  //     StepItem(tex: r"""\textbf{【計算】}"""),
  //     StepItem(tex: r"""\begin{aligned}
  // \displaystyle \int_0^{2\pi} (1-\cos x)^2 \, dx &= \displaystyle \int_0^{2\pi} (1 - 2\cos x + \cos^2 x) \, dx
  // \end{aligned}"""),
  //     StepItem(tex: r"""\text{倍角の公式 } \cos^2 x = \dfrac{1+\cos 2x}{2} \text{ を用いて、}"""),
  //     StepItem(tex: r"""\begin{aligned}
  // &\ \ \ \ \ \displaystyle \int_0^{2\pi} (1 - 2\cos x + \cos^2 x) \, dx \\
  // &= \displaystyle \int_0^{2\pi} \left(1 - 2\cos x + \dfrac{1+\cos 2x}{2}\right) \, dx\\
  // &= \displaystyle \int_0^{2\pi} \left(\dfrac{3}{2} - 2\cos x + \dfrac{\cos 2x}{2}\right) \, dx\\
  // &= \left[\dfrac{3x}{2} - 2\sin x + \dfrac{\sin 2x}{4}\right]_0^{2\pi}\\
  // &= \dfrac{3 \cdot 2\pi}{2}\\
  // &= 3\pi
  // \end{aligned}"""),
  //   ],
  // ),

  // 問題 10: サイクロイドのX軸回転体積
  // コメントアウトを外すと問題が追加されます
  // MathProblem(
  //   id: "36867962-7B2A-4DF5-B176-CE3E388C0F4D",
  //   no: 10,
  //   category: '回転体の積分問題',
  //   level: '中級',
  //   question: r"""\displaystyle \int_0^{2\pi} (1-\cos x)^3 \, dx""",
  //   answer: r"""5\pi""",
  //   imageAsset: 'assets/graphs/integral/problems_curves/problem_10.png',
  //   steps: [
  //     StepItem(tex: r"""\textbf{【背景】}"""),
  //     StepItem(tex: r"""\text{サイクロイド } x = t - \sin t, \; y = 1 - \cos t \text{ のX軸回転体積を求める過程で現れる積分。}"""),
  //     StepItem(tex: '', imageAsset: 'assets/graphs/integral/problems_curves/problem_10_curve.png'),
  //     StepItem(tex: '', imageAsset: 'assets/graphs/integral/problems_curves/problem_10_volume.png'),
  //     StepItem(tex: r"""\textbf{【導出】}"""),
  //     StepItem(tex: r"""\begin{aligned}
  //           V_x &= \pi \displaystyle \int_0^{2\pi} y^2 \, dx \\
  //           &= \pi \displaystyle \int_0^{2\pi} (1-\cos t)^2 x'(t) \, dt \\
  //           &= \pi \displaystyle \int_0^{2\pi} (1-\cos t)^2 (1-\cos t) \, dt\\
  //           &= \pi \textcolor{red}{\displaystyle \int_0^{2\pi} (1-\cos t)^3 \, dt}
  //           \end{aligned}"""),
  //     StepItem(tex: r"""\textbf{【計算】}"""),
  //     StepItem(tex: r"""\text{まず、} (1-\cos x)^3 \text{ を展開すると、}"""),
  //     StepItem(tex: r"""\begin{aligned}
  //           (1-\cos x)^3 &= 1 - 3\cos x + 3\cos^2 x - \cos^3 x
  //     \end{aligned}"""),
  //     StepItem(tex: r"""\text{したがって積分は各項に分けて計算する。}"""),
  //     StepItem(tex: r"""\begin{aligned}
  //     &\ \ \ \ \ \ \displaystyle \int_0^{2\pi}(1-\cos x)^3\,dx \\
  //     &= \textcolor{red}{\displaystyle \int_0^{2\pi}1\,dx} -3\textcolor{green}{\displaystyle \int_0^{2\pi}\cos x\,dx} +3\textcolor{blue}{\displaystyle \int_0^{2\pi}\cos^2 x\,dx} -\textcolor{orange}{\displaystyle \int_0^{2\pi}\cos^3 x\,dx}
  //     \end{aligned}"""),
  //     StepItem(tex: r"""\text{ここで } \textcolor{red}{\displaystyle \int_0^{2\pi}1\,dx = 2\pi},\quad \textcolor{green}{\displaystyle \int_0^{2\pi}\cos x\,dx = 0}"""),
  //     StepItem(tex: r"""\text{さらに } \cos^2 x = \dfrac{1+\cos 2x}{2} \text{ なので } \textcolor{blue}{\displaystyle \int_0^{2\pi}\cos^2 x\,dx = \displaystyle \int_0^{2\pi}\dfrac{1+\cos 2x}{2}\,dx = \pi}"""),
  //     StepItem(tex: r"""\text{また } \cos^3 x = \dfrac{3\cos x + \cos 3x}{4} \text{ で、} \textcolor{orange}{\displaystyle \int_0^{2\pi}\cos^3 x\,dx = 0} \text{（同様に各余弦項の積分は 0）}"""),
  //     StepItem(tex: r"""\text{以上より、}"""),
  //     StepItem(tex: r"""\begin{aligned}
  //     \displaystyle \int_0^{2\pi}(1-\cos x)^3\,dx &= \textcolor{red}{2\pi} - 3\cdot \textcolor{green}{0} + 3\cdot \textcolor{blue}{\pi} - \textcolor{orange}{0}\\
  //     &= \textcolor{red}{2\pi} + \textcolor{blue}{3\pi} = 5\pi
  //     \end{aligned}"""),
  //   ],
  // ),

  // 問題 6: アステロイドの弧長計算で現れる積分
  // コメントアウトを外すと問題が追加されます
  // MathProblem(
  //   id: "8D9E0F3B-4C5D-5E6F-7A8B-9C0D1E2F3B4C",
  //   no: 6,
  //   category: '曲線の弧長',
  //   level: '中級',
  //   question: r"""\displaystyle \int_0^{2\pi} |\sin x \cos x| \, dx""",
  //   answer: r"""2""",
  //   imageAsset: 'assets/graphs/integral/problems_curves/problem_6.png',
  //   steps: [
  //     StepItem(tex: r"""\textbf{【背景】}"""),
  //     StepItem(tex: r"""\text{この積分は、アステロイド（星形曲線）の弧長を求める過程で現れる。}"""),
  //     StepItem(tex: r"""\text{アステロイド } x = \cos^3 t, \; y = \sin^3 t \text{ の弧長は、}"""),
  //     StepItem(tex: '', imageAsset: 'assets/graphs/integral/problems_curves/problem_6_curve.png'),
  //     StepItem(tex: r"""\begin{aligned}
  // x'(t) &= -3 \cos^2 t \sin t\\
  // y'(t) &= 3 \sin^2 t \cos t
  // \end{aligned}"""),
  //     StepItem(tex: r"""\begin{aligned}
  // L &= \displaystyle \int_0^{2\pi} \sqrt{(x'(t))^2 + (y'(t))^2} \, dt\\
  // &= \displaystyle \int_0^{2\pi} \sqrt{9\cos^4 t \sin^2 t + 9\sin^4 t \cos^2 t} \, dt\\
  // &= \displaystyle \int_0^{2\pi} \sqrt{9(\cos^4 t \sin^2 t + \sin^4 t \cos^2 t)} \, dt\\
  // &= 3 \displaystyle \int_0^{2\pi} \sqrt{\cos^4 t \sin^2 t + \sin^4 t \cos^2 t} \, dt\\
  // &= 3 \displaystyle \int_0^{2\pi} \sqrt{\cos^2 t \sin^2 t (\cos^2 t + \sin^2 t)} \, dt\\
  // &= 3 \displaystyle \int_0^{2\pi} \sqrt{\cos^2 t \sin^2 t} \, dt\\
  // &= 3 \textcolor{red}{\displaystyle \int_0^{2\pi} |\sin t \cos t| \, dt}
  // \end{aligned}"""),
  //     StepItem(tex: r"""\textbf{【計算】}"""),
  //     StepItem(tex: r"""\text{対称性より } 0 \le x \le \frac{\pi}{2} \text{ の範囲で } \sin x \cos x \ge 0 \text{ であるから、この範囲で積分して4倍すると、}"""),
  //     StepItem(tex: r"""\begin{aligned}
  // \displaystyle \int_0^{2\pi} |\sin x \cos x| \, dx &= 4 \displaystyle \int_0^{\frac{\pi}{2}} \sin x \cos x \, dx\\
  // &= 4 \cdot \left[\dfrac{\sin^2 x}{2}\right]_0^{\frac{\pi}{2}}\\
  // &= 4 \cdot \dfrac{1}{2}\\
  // &= 2
  // \end{aligned}"""),
  //   ],
  // ),
];


import '../../models/math_problem.dart';
import '../../models/step_item.dart';

/// ============================================================================
/// 曲線の弧長・面積の問題 13問
/// ============================================================================

const curvesProblems = <MathProblem>[

  // ────────────────────────────────
  // 問題 2: サイクロイドの弧長計算で現れる積分
  // ────────────────────────────────
  MathProblem(
    id: "9E0F1A2B-3C4D-5E6F-7A8B-9C0D1E2F3C4D",
    no: 2,
    category: '曲線の弧長',
    level: '上級',
    question: r"""\displaystyle \int_0^{2\pi} \sqrt{2 - 2\cos x} \, dx""",
    answer: r"""8""",
    imageAsset: 'assets/graphs/integral/problems_curves/problem_2.png',
    steps: [
      StepItem(tex: r"""\textbf{【背景】}"""),
      StepItem(tex: r"""\text{この積分は、サイクロイドの弧長を求める過程で現れる。}"""),
      StepItem(tex: r"""\text{サイクロイド } x = t - \sin t, \; y = 1 - \cos t \text{ の弧長は、}"""),
      StepItem(tex: '', imageAsset: 'assets/graphs/integral/problems_curves/problem_2_curve.png'),
      StepItem(tex: r"""\begin{aligned}
x'(t) &= 1 - \cos t\\
y'(t) &= \sin t
\end{aligned}"""),
      StepItem(tex: r"""\begin{aligned}
L &= \displaystyle \int_0^{2\pi} \sqrt{(x'(t))^2 + (y'(t))^2} \, dt\\
&= \displaystyle \int_0^{2\pi} \sqrt{(1-\cos t)^2 + (\sin t)^2} \, dt\\
&= \displaystyle \int_0^{2\pi} \sqrt{1 - 2\cos t + \cos^2 t + \sin^2 t} \, dt\\
&= \textcolor{red}{\displaystyle \int_0^{2\pi} \sqrt{2 - 2\cos t} \, dt}
\end{aligned}"""),
      StepItem(tex: r"""\textbf{【計算】}"""),
      StepItem(tex: r"""\text{半角の公式 } \sin^2 \dfrac{x}{2} = \dfrac{1 - \cos x}{2} \text{ より、} 1 - \cos x = 2\sin^2 \dfrac{x}{2} \text{ であるから、}"""),
      StepItem(tex: r"""\begin{aligned}
\displaystyle \int_0^{2\pi} \sqrt{2 - 2\cos x} \, dx &= \displaystyle \int_0^{2\pi} \sqrt{2 \cdot 2\sin^2 \dfrac{x}{2}} \, dx\\
&= \displaystyle \int_0^{2\pi} \sqrt{4\sin^2 \dfrac{x}{2}} \, dx\\
&= \displaystyle \int_0^{2\pi} 2\left|\sin \dfrac{x}{2}\right| \, dx
\end{aligned}"""),
      StepItem(tex: r"""\text{ここで、} 0 \le x \le 2\pi \text{ のとき } 0 \le \dfrac{x}{2} \le \pi \text{ であるから、} \sin \dfrac{x}{2} \ge 0 \text{ である。}"""),
      StepItem(tex: r"""\begin{aligned}
\displaystyle \int_0^{2\pi} 2\left|\sin \dfrac{x}{2}\right| \, dx &= 2 \displaystyle \int_0^{2\pi} \sin \dfrac{x}{2} \, dx\\
&= 2 \cdot \left[-2\cos \dfrac{x}{2}\right]_0^{2\pi}\\
&= -4(\cos \pi - \cos 0)\\
&= -4(-1 - 1)\\
&= 8
\end{aligned}"""),
    ],
  ),

  // 予備問題は problems_curves_reserve.dart に移動しました
  // 予備問題は problems_curves_reserve.dart に移動しました
  // コメントアウトを外すと問題リストに追加されます

// ────────────────────────────────// ────────────────────────────────
// 問題：0〜π/2 の sin^n x の積分 と アステロイドへの応用
// ────────────────────────────────
MathProblem(
  id: "C7312AD1-233C-42E9-94E7-BF9A59591EE1",
  no: 1,
  category: '三角関数の積分（漸化式）＋応用',
  level: '上級',
  question: r"""\displaystyle \int_0^{ \frac{\pi}{2}} \sin^9 x \, dx""",
  answer: r"""
\frac{128}{315}
""",
  imageAsset: 'assets/graphs/integral/problems_curves/problem_1_sin9.png',
  steps: [
    StepItem(tex: r"""\textbf{【解法】}"""),
    StepItem(tex: r"""\text{部分積分を用いて、一般のnについての漸化式及び計算結果を導出する。 }"""),
    StepItem(tex: r"""\textcolor{green}{一般に下記が成立する事を示す。}"""),
    StepItem(tex: r"""
    \textcolor{green}{
    \begin{aligned}
    \begin{cases}
      & nが0の時: \displaystyle I_0=\frac{\pi}{2} \\
      & nが偶数の時: I_n =\displaystyle \frac{(n-1) \cdot (n-3) \cdot \cdots \cdot 3 \cdot 1}{n \cdot (n-2) \cdot \cdots \cdot 4 \cdot 2}\cdot\frac{\pi}{2}\\
      & nが奇数の時: I_n = \displaystyle \frac{(n-1) \cdot (n-3) \cdot \cdots \cdot 4 \cdot 2}{n \cdot (n-2) \cdot \cdots \cdot 3 \cdot 1} \quad 
      \end{cases}
      \end{aligned}
    }
      """),


    StepItem(tex: r"""\begin{aligned}
I_n&=\displaystyle \int_0^{\frac{\pi}{2}}\sin^{n-1}x\cdot\sin x\,dx \\
& = \displaystyle \int_0^{\frac{\pi}{2}}\sin^{n-1}x\cdot(-\cos x)'\,dx \\
& = \displaystyle \int_0^{\frac{\pi}{2}}- \sin^{n-1}x\cdot(\cos x)'\,dx \\
&= \left[-\sin^{n-1}x\cos x\right]_0^{\frac{\pi}{2}} + (n-1)\displaystyle \int_0^{\frac{\pi}{2}}\sin^{n-2}x\cos^2 x\,dx \\
&= (n-1)\displaystyle \int_0^{\frac{\pi}{2}}\sin^{n-2}x\cos^2 x\,dx \\
&= (n-1)\displaystyle \int_0^{\frac{\pi}{2}}\sin^{n-2}x(1-\sin^2 x)\,dx \\
&= (n-1)\displaystyle \int_0^{\frac{\pi}{2}}\sin^{n-2}x\,dx - (n-1)\displaystyle \int_0^{\frac{\pi}{2}}\sin^n x\,dx \\
&= (n-1)\left(I_{n-2}-I_n\right)
\end{aligned}"""),
    StepItem(tex: r"""\text{これより漸化式 }\displaystyle I_n=\frac{n-1}{n}I_{n-2}\text{ を得る。}"""),

    // 基底
    StepItem(tex: r"""\displaystyle I_0,\ I_1\text{ は簡単に計算できる。}"""),
    StepItem(tex: r"""\begin{aligned}
\displaystyle I_0&=\int_0^{\frac{\pi}{2}}1\,dx=\frac{\pi}{2} \\
\displaystyle I_1&=\int_0^{\frac{\pi}{2}}\sin x\,dx=1
\end{aligned}"""),

    // 閉形式（I_n の形で表現）
    StepItem(tex: r"""\text{漸化式を繰り返すと偶奇で場合分けでき、下記を得る：}"""),
    StepItem(tex: r"""\begin{aligned}
    \textcolor{green}{
\displaystyle I_n =
\begin{cases}
\displaystyle \frac{(n-1) \cdot (n-3) \cdot \cdots \cdot 3 \cdot 1}{n \cdot (n-2) \cdot \cdots \cdot 4 \cdot 2}\cdot\frac{\pi}{2} & (n\ \text{:偶数})\\[6pt]
\displaystyle \frac{(n-1) \cdot (n-3) \cdot \cdots \cdot 4 \cdot 2}{n \cdot (n-2) \cdot \cdots \cdot 3 \cdot 1} & (n\ \text{:奇数})
\end{cases}}
\end{aligned}"""),
StepItem(tex: r"""\text{問題の}I_9 = \displaystyle \int_0^{\frac{\pi}{2}} \sin^9 x \, dx \text{は下記のように計算できる。}"""),
    StepItem(tex: r"""\textbf{【計算】}"""),
    StepItem(tex: r"""\begin{aligned}
    \displaystyle I_9 &= \frac{8 \cdot 6 \cdot 4 \cdot 2}{9 \cdot 7 \cdot 5 \cdot 3 \cdot 1} \\
    &= \frac{384}{945} \\
    &= \frac{128}{315}
    \end{aligned}"""),

    // 面積の導出（符号を明示）
    StepItem(tex: r"""\textcolor{blue}{【応用1：アステロイドの面積】}"""),
    StepItem(tex: '', imageAsset: 'assets/graphs/integral/problems_curves/astroid_area.png'),
    StepItem(tex: r"""\text{アステロイド }x=\cos^3 t,\ y=\sin^3 t\text{ （}0\le t\le2\pi\text{）は4つの対称ローブを持つ。第1象限は }0< t<\displaystyle \frac{\pi}{2}\text{ に対応する。}"""),
    StepItem(tex: r"""\text{第1象限の面積を }x\text{-方向で表すと } \displaystyle \int_{x=0}^{1} y\,dx \text{ となる。パラメータ変換 }x=x(t)\text{ を使うと、上下限が }\displaystyle t=\frac{\pi}{2}\to0\text{ になる点に注意する。}"""),
    StepItem(tex: r"""\begin{aligned}
&\ \ \ \ \ \text{第1象限の面積}\\
&= \displaystyle \int_{x=0}^{1} Y(x)\,dx \\
&= \displaystyle \int_{t=\frac{\pi}{2}}^{0} y(t)\,x'(t)\,dt \\
&= -\displaystyle \int_{0}^{\frac{\pi}{2}} y(t)\,x'(t)\,dt
\end{aligned}"""),
    StepItem(tex: r"""\text{ここで }x'(t)=-3\cos^2 t\sin t,\ y(t)=\sin^3 t\text{ なので、第1象限の寄与は}"""),
    StepItem(tex: r"""\begin{aligned}
&\ \ \ \ \ \text{第1象限の面積} \\
&= -\displaystyle \int_0^{\frac{\pi}{2}} \sin^3 t \cdot (-3\cos^2 t\sin t)\,dt \\
&= \displaystyle \int_0^{\frac{\pi}{2}} 3\sin^4 t\cos^2 t\,dt \\
&= 3\displaystyle \int_0^{\frac{\pi}{2}}\sin^4 t(1-\sin^2 t)\,dt \\
&= 3\left(I_4 - I_6\right)
\end{aligned}"""),
    StepItem(tex: r"""\text{全体は4対称なので4倍して }"""),
    StepItem(tex: r"""\begin{aligned}
&\ \ \ \ \ \text{囲まれた面積} \\
&= 12\left(I_4 - I_6\right) \\
  &= 12\left(\frac{3 \cdot 1}{4 \cdot 2} \cdot \frac{\pi}{2} - \frac{5 \cdot 3 \cdot 1}{6 \cdot 4 \cdot 2} \cdot \frac{\pi}{2}\right) \\
  &= 12\left(\frac{3\pi}{16}-\frac{5\pi}{32}\right) \\
  &= 12\cdot\frac{\pi}{32} \\
  &= \textcolor{green}{ \frac{3\pi}{8} }
\end{aligned}"""),
    // 回転体積の導出（左右対称性と符号を明示）
    StepItem(tex: r"""\textcolor{blue}{【応用2：アステロイドのX軸回転体積】}"""),
    StepItem(tex: r"""V_x=\pi\displaystyle \int_{x=-1}^{1}Y(x)^2\,dx\text{。左右対称なので}"""),
    StepItem(tex: r"""V_x=2\pi\displaystyle \int_0^1 Y(x)^2\,dx\text{ と書ける。 }"""),
    StepItem(tex: r"""\text{ここで}x:0\to1\text{ と変化するので、}x=t\text{ と置換すると、}t:\frac{\pi}{2}\to0\text{ と変化する。}"""),
    StepItem(tex: r"""y^2=\sin^6 t,\ x'=-3\cos^2 t\sin t\text{ だから、}"""),
    StepItem(tex: r"""\begin{aligned}
    V_x&=2\pi\displaystyle \int_0^1 Y(x)^2\,dx\\
    &=2\pi\displaystyle \int_{t=\frac{\pi}{2}}^{0} y(t)^2\,x'(t)\,dt\\
    &=-6\pi\displaystyle \int_{t=\frac{\pi}{2}}^{0} \sin^7 t\cos^2 t\,dt\\
    &=6\pi\displaystyle \int_{t=0}^{\frac{\pi}{2}} \sin^7 t(1-\sin^2 t)\,dt\\
    &= 6\pi\displaystyle \int_0^{\frac{\pi}{2}}(\sin^7 t-\sin^9 t)\,dt \\
    &= 6\pi\bigl(I_7 - I_9\bigr) \\
    &= 6\pi\left(\frac{6 \cdot 4 \cdot 2}{7 \cdot 5 \cdot 3 \cdot 1} - \frac{8 \cdot 6 \cdot 4 \cdot 2}{9 \cdot 7 \cdot 5 \cdot 3 \cdot 1}\right) \\
    &= 6\pi\left(\frac{48}{105} - \frac{384}{945}\right) \\
    &= 6\pi\left(\frac{144}{315} - \frac{128}{315}\right) \\
    &= 6\pi\cdot\frac{16}{315} \\
    &= \textcolor{green}{ \frac{32\pi}{105} }
\end{aligned}"""),
    // 補足：Greenの公式（短く）
    StepItem(tex: r"""\textbf{【補足：Green の公式による確認】}"""),
    StepItem(tex: r"""\text{（補足）面積は Green の公式 }A=\oint x\,dy\text{ を用いても求められる。}"""),
  ],
),




  // ────────────────────────────────
  // 問題 5: 放物線の弧長計算で現れる積分
  // ────────────────────────────────
  MathProblem(
    id: "A1B2C3D4-E5F6-7890-ABCD-EF1234567890",
    no: 5,
    category: '曲線の弧長',
    level: '上級',
    question: r"""\displaystyle \int_0^1 \sqrt{1 + 4x^2} \, dx""",
    answer: r"""\dfrac{\sqrt{5}}{2} + \dfrac{1}{4} \log(2+\sqrt{5})""",
    imageAsset: 'assets/graphs/integral/problems_curves/problem_5.png',
    steps: [
      StepItem(tex: r"""\textbf{【背景】}"""),
      StepItem(tex: r"""\text{この積分は、放物線の弧長を求める過程で現れる。}"""),
      StepItem(tex: '', imageAsset: 'assets/graphs/integral/problems_curves/problem_5_curve.png'),
      StepItem(tex: r"""\text{放物線 } y = 1 + x^2 \text{ の弧長は、}"""),
      StepItem(tex: r"""\begin{aligned}
L &= \displaystyle \int_0^1 \sqrt{1 + (y')^2} \, dx\\
&= \displaystyle \int_0^1 \sqrt{1 + (2x)^2} \, dx\\
&= \textcolor{red}{\displaystyle \int_0^1 \sqrt{1 + 4x^2} \, dx}
\end{aligned}"""),
      StepItem(tex: r"""\textbf{【計算】}"""),
      StepItem(tex: r"""\text{双曲線関数 } \sinh t = \dfrac{e^t - e^{-t}}{2}, \; \cosh t = \dfrac{e^t + e^{-t}}{2} \text{ を用いて置換する。}"""),
      StepItem(tex: r"""\text{ここで、} 2x = \sinh t \text{ と双曲線関数で置換すると、} x =\displaystyle  \frac{\sinh t}{2}, \; dx = \displaystyle \frac{\cosh t}{2} \, dt \text{ であり、} x = 0 \rightarrow t = 0, \; x = 1 \rightarrow t = t_0 \text{ である。（ただし、} t_0 \text{ は } \sinh t_0 = 2 \text{ を満たす数とする。）}"""),
      StepItem(tex: r"""\textcolor{blue}{双曲線関数の恒等式 } \textcolor{blue}{\cosh^2 t - \sinh^2 t = 1} \text{ より、} \sqrt{1 + \sinh^2 t} = \cosh t \text{ であるから、}"""),
      StepItem(tex: r"""\begin{aligned}
L &= \displaystyle \int_0^{t_0} \sqrt{1 + \sinh^2 t} \cdot \frac{\cosh t}{2} \, dt \\
&= \displaystyle \int_0^{t_0} \cosh t \cdot \frac{\cosh t}{2} \, dt \\
&= \frac{1}{2} \displaystyle \int_0^{t_0} \cosh^2 t \, dt
\end{aligned}"""),
      StepItem(tex: r"""\textcolor{blue}{倍角の公式 } \textcolor{blue}{\cosh 2t = 2\cosh^2 t - 1} \text{ より、} \cosh^2 t = \frac{1 + \cosh 2t}{2} \text{ であるから、}"""),
      StepItem(tex: r"""\begin{aligned}
L &= \frac{1}{2} \displaystyle \int_0^{t_0} \frac{1 + \cosh 2t}{2} \, dt \\
&= \frac{1}{4} \displaystyle \int_0^{t_0} (1 + \cosh 2t) \, dt \\
&= \frac{1}{4} \left[t + \frac{\sinh 2t}{2}\right]_0^{t_0}
\end{aligned}"""),
      StepItem(tex: r"""\text{ここで、} t = t_0 \text{ のとき、} \sinh t_0 = 2 \text{ より } \cosh t_0 = \sqrt{1 + \sinh^2 t_0} = \sqrt{1 + 4} = \sqrt{5} \text{ である。}"""),
      StepItem(tex: r"""\text{また、} \textcolor{blue}{倍角の公式を用いて、}"""),
      StepItem(tex: r"""\textcolor{blue}{\sinh 2t_0 = 2\sinh t_0 \cosh t_0} = 2 \cdot 2 \cdot \sqrt{5} = 4\sqrt{5} \text{ であるから、}"""),
      StepItem(tex: r"""\begin{aligned}
L &= \frac{1}{4} \left[t_0 + \frac{4\sqrt{5}}{2} - \left(0 + \frac{0}{2}\right)\right] \\
&= \frac{1}{4} \left[t_0 + 2\sqrt{5}\right] \\
&= \frac{\sqrt{5}}{2} + \frac{t_0}{4}
\end{aligned}"""),
      StepItem(tex: r"""\text{ここで、} t_0 \text{を具体的に求めると、} t_0 \text{は、} \sinh t_0 = 2 \text{ を満たす数であるから、} \frac {e^{t_0}-e^{-t_0}}{2}=2 \text{ を解く。}"""),
      StepItem(tex: r"""\begin{aligned}
      \frac {e^{t_0}-e^{-t_0}}{2}=2 \\
      e^{t_0}-e^{-t_0}=4 \\
      e^{2t_0}-1=4e^{t_0} \\
      e^{2t_0}-4e^{t_0}-1=0 \\
      e^{t_0}=2+\sqrt{5} \\
      t_0=\log(2+\sqrt{5})
      \end{aligned}"""),
      StepItem(tex: r"""\text{したがって、}"""),
      StepItem(tex: r"""\begin{aligned}
L &= \frac{\sqrt{5}}{2} + \frac{1}{4} \log(2+\sqrt{5}) = 1.4789\cdots > \sqrt 2 = 1.4142\cdots
\end{aligned}"""),
      StepItem(tex: r"""\textcolor{blue}{【補足：双曲線関数の公式の証明】}"""),
      StepItem(tex: r"""\text{【1】} \cosh^2 t - \sinh^2 t = 1 \text{ の証明：}"""),
      StepItem(tex: r"""\begin{aligned}
\cosh^2 t - \sinh^2 t &= \left(\frac{e^t + e^{-t}}{2}\right)^2 - \left(\frac{e^t - e^{-t}}{2}\right)^2 \\
&= \frac{e^{2t} + 2 + e^{-2t}}{4} - \frac{e^{2t} - 2 + e^{-2t}}{4} \\
&= \frac{4}{4} = 1
\end{aligned}"""),
      StepItem(tex: r"""\text{【2】} \cosh 2t = 2\cosh^2 t - 1 \text{ の証明：}"""),
      StepItem(tex: r"""\begin{aligned}
\cosh 2t &= \frac{e^{2t} + e^{-2t}}{2} = \frac{(e^t)^2 + (e^{-t})^2}{2} \\
&= \frac{(e^t + e^{-t})^2 - 2}{2} = \frac{(e^t + e^{-t})^2}{2} - 1 \\
&= 2\left(\frac{e^t + e^{-t}}{2}\right)^2 - 1 = 2\cosh^2 t - 1
\end{aligned}"""),
      StepItem(tex: r"""\text{【3】} \sinh 2t = 2\sinh t \cosh t \text{ の証明：}"""),
      StepItem(tex: r"""\begin{aligned}
\sinh 2t &= \frac{e^{2t} - e^{-2t}}{2} = \frac{(e^t)^2 - (e^{-t})^2}{2} \\
&= \frac{(e^t - e^{-t})(e^t + e^{-t})}{2} \\
&= 2 \cdot \frac{e^t - e^{-t}}{2} \cdot \frac{e^t + e^{-t}}{2} = 2\sinh t \cosh t
\end{aligned}"""),
    ],
  ),
//   MathProblem(
//       id: "A1F2C8B3-12D4-4A77-9C22-AC19B2C11D90",
//       no: 1,
//       category: '面積・グリーンの定理',
//       level: '上級',
//       question: r"""
//       0 \le x \le 2 において次を求めよ。

//       (1)\ \displaystyle I=\int_0^2 x\sqrt{4-x^2}\,dx

//       (2)\ x=2\sin\theta,\ y=2\sin2\theta\ (0\le\theta\le\pi)
//       で囲まれる右側ループの面積 A を、グリーンの定理を用いて求めよ。
//       """,
//       answer: r"""
//       I=\displaystyle \frac{8}{3},\qquad
//       A=\displaystyle \frac{16}{3}
//       """,
//       imageAsset: 'assets/graphs/integral/problems_curves/problem_astroid.png',
//       steps: [
//       StepItem(tex: r"""\textbf{【(1) 定積分の計算】}"""),
//       StepItem(tex: r"""\text{置換 } u=4-x^2 \text{ を用いる。}"""),
//       StepItem(tex: r"""\begin{aligned}
//       I&=\displaystyle \int_0^2 x\sqrt{4-x^2}\,dx
//       =\displaystyle \int_{u=4}^{0} \sqrt{u}\left(-\frac12\right)du \\
//       &=\frac12\displaystyle \int_0^{4} u^{1/2}\,du
//       = \frac12 \cdot \frac{2}{3}u^{3/2}\Big|_0^{4} \\
//       &= \frac13 \cdot 4^{3/2}
//       = \frac{8}{3}.
//       \end{aligned}"""),

//       StepItem(tex: r"""\textbf{【(2) グリーンの定理で面積を求める】}"""),
//       StepItem(tex: r"""\text{右側ループは } 0\le\theta\le\pi \text{ でひと回りする。}"""),
//       StepItem(tex: r"""\text{グリーンの定理より、} 
//       A=\frac12\displaystyle \int_0^\pi (x y' - y x')\,d\theta. """),

//       StepItem(tex: r"""\text{まず } x=2\sin\theta,\ y=2\sin2\theta=4\sin\theta\cos\theta. """),
//       StepItem(tex: r"""\text{微分は } x'=2\cos\theta,\ \ y'=4\cos2\theta. """),

//       StepItem(tex: r"""\begin{aligned}
//       x y' - y x'
//       &= (2\sin\theta)(4\cos2\theta)
//       - (4\sin\theta\cos\theta)(2\cos\theta)\\
//       &= 8\sin\theta(\cos2\theta - \cos^2\theta) \\
//       &= -8\sin^3\theta.
//       \end{aligned}"""),

//       StepItem(tex: r"""\text{よって、}"""),

//       StepItem(tex: r"""\begin{aligned}
//       A
//       &=\frac12\displaystyle \int_0^\pi -8\sin^3\theta \, d\theta \\
//       &= -4\displaystyle \int_0^\pi \sin^3\theta\,d\theta.
//       \end{aligned}"""),

//       StepItem(tex: r"""\text{（向きの都合で符号が負になるので絶対値をとる。）}"""),

//       StepItem(tex: r"""\begin{aligned}
//       \displaystyle \int_0^\pi \sin^3\theta\,d\theta
//       &= 2\displaystyle \int_0^{\pi/2}\sin^3\theta\,d\theta
//       = 2\cdot \frac{2}{3}
//       = \frac{4}{3}.
//       \end{aligned}"""),

//       StepItem(tex: r"""\text{したがって、}"""),

//       StepItem(tex: r"""\begin{aligned}
//       |A|
//       &= 4\cdot \frac{4}{3}
//       = \frac{16}{3}.
//       \end{aligned}"""),

//       StepItem(tex: r"""\textbf{結論： } I=\frac{8}{3},\quad A=\frac{16}{3}. """),
//       ],
//       )


 
];


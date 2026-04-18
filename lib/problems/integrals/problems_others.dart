import '../../models/math_problem.dart';
import '../../models/step_item.dart';


/// ============================================================================
/// その他の問題3問
/// ============================================================================

const othersProblems = <MathProblem>[
    


  // ────────────────────────────────
  // 問題 1: 奇関数の対称性による定積分
  // ∫[-2→2] x^4 sin^5 x dx
  // ────────────────────────────────
  MathProblem(
      id: "AC0C8F06-65FE-4FDD-8DB8-04252764D3CB",
    no: 1,
    category: '奇関数',    level: '中級',    question: r""" \displaystyle \int_{-2}^{2} x^4 \sin^5 x \, dx""",
    answer: r""" 0""",
    imageAsset: 'assets/graphs/integral/problems_others/problem_1.png',
    steps: [
      StepItem(tex: r"""\textbf{【解説】}""",),
      StepItem(
        tex: r"""x^4 \text{ は偶関数，} \sin^5 x \text{ は奇関数。また、偶} \times \text{奇} = \text{奇関数なので、} x^4 \sin^5 x \text{ は奇関数。}""",      ),
      StepItem(
        tex: r"""\text{したがって、対称区間 }[-2,2] \text{ での積分は、奇関数が原点対称なグラフであることから、}""",      ),
      StepItem(tex: r"""\begin{aligned}
      \displaystyle \int_{-2}^{2} x^4 \sin^5 x \, dx = 0
      \end{aligned}
"""),
      StepItem(tex: r"""\textbf{【補足】}""",),
      StepItem(tex: r"""\text{偶関数と奇関数の積分公式：}""",),
      StepItem(tex: r"""\begin{aligned}
      &\text{（1）偶関数：} f(-x)=f(x) \text{ のとき、} \displaystyle \int_{-a}^{a} f(x)\,dx = 2\displaystyle \int_{0}^{a} f(x)\,dx\\[6pt]
      &\text{（2）奇関数：} f(-x)=-f(x) \text{ のとき、} \displaystyle \int_{-a}^{a} f(x)\,dx = 0
      \end{aligned}
""",),
      StepItem(tex: r"""\text{【証明】（1）偶関数の場合：}""",),
      StepItem(tex: r"""\begin{aligned}
      \displaystyle \int_{-a}^{a} f(x)\,dx
      &=\textcolor{red}{\displaystyle \int_{-a}^{0} f(x)\,dx} + \displaystyle \int_{0}^{a} f(x)\,dx
      \end{aligned}
"""),
      StepItem(
        tex: r"""\text{第一項で } t=-x \text{ と置換すると、} x=-t,\; dx=-dt,\; x:-a\to 0 \;\Rightarrow\; t:a\to 0 \text{ より、}""",      ),
      StepItem(tex: r"""\begin{aligned}
      \textcolor{red}{\displaystyle \int_{-a}^{0} f(x)\,dx}
      &=\displaystyle \int_{a}^{0} f(-t)(-dt)\\
      &=\displaystyle \int_{0}^{a} f(-t)\,dt
      \end{aligned}
"""),
      StepItem(tex: r"""\text{偶関数なので } f(-t)=f(t) \text{ より、}""",),
      StepItem(tex: r"""\begin{aligned}
      &=\displaystyle \int_{0}^{a} f(t)\,dt\\
      &=\textcolor{red}{\displaystyle \int_{0}^{a} f(x)\,dx}
      \end{aligned}
"""),
      StepItem(tex: r"""\text{したがって、}""",),
      StepItem(tex: r"""\begin{aligned}
      \displaystyle \int_{-a}^{a} f(x)\,dx
      &=\textcolor{red}{\displaystyle \int_{0}^{a} f(x)\,dx} + \displaystyle \int_{0}^{a} f(x)\,dx\\
      &=2\displaystyle \int_{0}^{a} f(x)\,dx
      \end{aligned}
"""),
      StepItem(tex: r"""\text{（2）奇関数の場合：}""",),
      StepItem(tex: r"""\begin{aligned}
      \displaystyle \int_{-a}^{a} f(x)\,dx
      &=\textcolor{red}{\displaystyle \int_{-a}^{0} f(x)\,dx} + \displaystyle \int_{0}^{a} f(x)\,dx
      \end{aligned}
"""),
      StepItem(
        tex: r"""\text{第一項で } t=-x \text{ と置換すると、} x=-t,\; dx=-dt,\; x:-a\to 0 \;\Rightarrow\; t:a\to 0 \text{ より、}""",      ),
      StepItem(tex: r"""\begin{aligned}
      \textcolor{red}{\displaystyle \int_{-a}^{0} f(x)\,dx}
      &=\displaystyle \int_{a}^{0} f(-t)(-dt)\\
      &=\displaystyle \int_{0}^{a} f(-t)\,dt
      \end{aligned}
"""),
      StepItem(tex: r"""\text{奇関数なので } f(-t)=-f(t) \text{ より、}""",),
      StepItem(tex: r"""\begin{aligned}
      &=\displaystyle \int_{0}^{a} (-f(t))\,dt\\
      &=-\displaystyle \int_{0}^{a} f(t)\,dt\\
      &=\textcolor{red}{- \displaystyle \int_{0}^{a} f(x)\,dx}
      \end{aligned}
"""),
      StepItem(tex: r"""\text{したがって、}""",),
      StepItem(tex: r"""\begin{aligned}
      \displaystyle \int_{-a}^{a} f(x)\,dx
      &=\textcolor{red}{- \displaystyle \int_{0}^{a} f(x)\,dx} + \displaystyle \int_{0}^{a} f(x)\,dx\\
      &=0
      \end{aligned}
"""),
    ],
  ),
MathProblem(
    id: "9BC1C756-BFC5-41C7-8751-D78DF6430084",
    no: 2,
    category: 'その他 平方根（符号処理）',    level: '上級',    question: r"""\displaystyle \int_{ \frac {\pi} {2}}^{ \frac {5} {2}\pi}\sqrt{1+\sin x}\ dx""",
    answer: r""" 
\begin{aligned}
4\sqrt{2}
\end{aligned}
""",
    imageAsset: 'assets/graphs/integral/problems_others/problem_2.png',
    hint: r"""\text{半角公式を用いて }\sqrt{1+\sin x}\text{ を }\cos\text{ の形に変形し，} \text{絶対値の符号で区間分割して原始関数で評価する。}
""",    steps: [
      StepItem(tex: r"""\textbf{【方針】}""",),
      StepItem(
        tex: r"""\text{半角公式を用いて }\sqrt{1+\sin x}\text{ を }\cos\text{ の形に変形し，} \text{絶対値の符号で区間分割して原始関数で評価する。}
""",      ),
      StepItem(tex: r"""\begin{aligned}
1+\sin x &= 1 + \cos\left(\displaystyle\frac{\pi}{2} - x\right)\\[5pt]
&= 2\cos^2\displaystyle\frac{\frac{\pi}{2} - x}{2}\\[5pt]
&= 2\cos^2\left(\displaystyle\frac{\pi}{4} - \displaystyle\frac{x}{2}\right)\\[5pt]
&= 2\cos^2\left(\displaystyle\frac{x}{2} - \displaystyle\frac{\pi}{4}\right)
\end{aligned}
"""),
      StepItem(tex: r"""\text{したがって、}""",),
      StepItem(tex: r"""\begin{aligned}
\sqrt{1+\sin x} &= \sqrt{2\cos^2\left(\displaystyle\frac{x}{2}-\displaystyle\frac{\pi}{4}\right)}\\[5pt]
&= \sqrt{2}\left|\cos\left(\displaystyle\frac{x}{2}-\displaystyle\frac{\pi}{4}\right)\right|
\end{aligned}
"""),
      StepItem(tex: r"""\text{次に、絶対値での折り返し区間を求める。}""",),
      StepItem(tex: r"""\begin{aligned}
&\cos\!\left(\displaystyle \frac{x}{2}-\displaystyle \frac{\pi}{4}\right)=0
\iff x=\displaystyle \frac{3\pi}{2}+2k\pi
\end{aligned}
"""),
StepItem(
  tex: r"""\text{積分区間 } \left[\displaystyle \frac{\pi}{2},\displaystyle \frac{5}{2}\pi\right] \text{ 内には零点 } x=\displaystyle \frac{3\pi}{2} \text{ が一つある。前後の関数の正負を考えると、}""",),
      StepItem(tex: r"""
      \begin{aligned}
      \begin{cases}
      \left[\displaystyle \frac{\pi}{2},\displaystyle \frac{3\pi}{2}\right]\text{ では } \cos\!\left(\displaystyle \frac{x}{2}-\displaystyle \frac{\pi}{4}\right) > 0\\
      \left[\displaystyle \frac{3\pi}{2},\displaystyle \frac{5}{2}\pi\right]\text{ では } \cos\!\left(\displaystyle \frac{x}{2}-\displaystyle \frac{\pi}{4}\right) < 0
      \end{cases}
      \end{aligned}
""",),
      StepItem(tex: r"""\text{したがって、}""",),
      StepItem(tex: r"""\begin{aligned}
      \displaystyle  
      &\ \ \ \int_{ \frac{\pi}{2}}^{ \frac{5}{2}\pi}\sqrt{1+\sin x}\,dx\\[5pt]
      &= \sqrt2\displaystyle \int_{ \frac{\pi}{2}}^{ \frac{3\pi}{2}}\cos\!\left(\displaystyle \frac{x}{2}-\displaystyle \frac{\pi}{4}\right)\,dx 
-\sqrt2\displaystyle \int_{ \frac{3\pi}{2}}^{ \frac{5}{2}\pi}\cos\!\left(\displaystyle \frac{x}{2}-\displaystyle \frac{\pi}{4}\right)\,dx\\[5pt]
      &= \sqrt2 \cdot 2\left[\sin\!\left(\displaystyle \frac{x}{2}-\displaystyle \frac{\pi}{4}\right)\right]_{ \frac{\pi}{2}}^{ \frac{3\pi}{2}} 
-\sqrt2 \cdot 2\left[\sin\!\left(\displaystyle \frac{x}{2}-\displaystyle \frac{\pi}{4}\right)\right]_{ \frac{3\pi}{2}}^{ \frac{5}{2}\pi}\\[5pt]
      &=2\sqrt2\left(\textcolor{red}{\sin\!\left(\displaystyle \frac{3\pi}{2}\cdot\displaystyle \frac{1}{2}-\displaystyle \frac{\pi}{4}\right)} - \textcolor{green}{\sin\!\left(\displaystyle \frac{\pi}{2}\cdot\displaystyle \frac{1}{2}-\displaystyle \frac{\pi}{4}\right)}\right.\\[5pt]
      &\quad \left.-\textcolor{blue}{\sin\!\left(\displaystyle \frac{5}{2}\pi\cdot\displaystyle \frac{1}{2}-\displaystyle \frac{\pi}{4}\right)} + \textcolor{orange}{\sin\!\left(\displaystyle \frac{3\pi}{2}\cdot\displaystyle \frac{1}{2}-\displaystyle \frac{\pi}{4}\right)}\right) \cdots (\star)
\end{aligned}
"""),
      StepItem(tex: r"""\text{ここで、各項の値を計算すると、}""",),
      StepItem(tex: r"""\begin{aligned}
\textcolor{red}{\sin\!\left(\displaystyle \frac{3\pi}{2}\cdot\displaystyle \frac{1}{2}-\displaystyle \frac{\pi}{4}\right)} &= \sin\!\left(\displaystyle \frac{3\pi}{4}-\displaystyle \frac{\pi}{4}\right) = \sin\displaystyle \frac{\pi}{2} = \textcolor{red}{1}\\[4pt]
\textcolor{green}{\sin\!\left(\displaystyle \frac{\pi}{2}\cdot\displaystyle \frac{1}{2}-\displaystyle \frac{\pi}{4}\right)} &= \sin\!\left(\displaystyle \frac{\pi}{4}-\displaystyle \frac{\pi}{4}\right) = \sin 0 = \textcolor{green}{0}\\[4pt]
\textcolor{blue}{\sin\!\left(\displaystyle \frac{5}{2}\pi\cdot\displaystyle \frac{1}{2}-\displaystyle \frac{\pi}{4}\right)} &= \sin\!\left(\displaystyle \frac{5\pi}{4}-\displaystyle \frac{\pi}{4}\right) = \sin\pi = \textcolor{blue}{0}\\[4pt]
\textcolor{orange}{\sin\!\left(\displaystyle \frac{3\pi}{2}\cdot\displaystyle \frac{1}{2}-\displaystyle \frac{\pi}{4}\right)} &= \sin\!\left(\displaystyle \frac{3\pi}{4}-\displaystyle \frac{\pi}{4}\right) = \sin\displaystyle \frac{\pi}{2} = \textcolor{orange}{1}
\end{aligned}
"""),
      StepItem(tex: r"""\text{したがって、}(\star) \text{式より}""",),
      StepItem(tex: r"""\begin{aligned}
&=2\sqrt2\left(\textcolor{red}{1} - \textcolor{green}{0} - \textcolor{blue}{0} + \textcolor{orange}{1}\right)\\
&=4\sqrt2
\end{aligned}
"""),
      StepItem(tex: r"""\textbf{【補足】}""",),
      StepItem(tex: r"""\text{テクニカルだが}""",),
      StepItem(tex: r"""\begin{aligned}
1+\sin x
=&\sin^2\displaystyle \frac{x}{2}+\cos^2\displaystyle \frac{x}{2}+2\sin\displaystyle \frac{x}{2}\cos\displaystyle \frac{x}{2}\\
=&\left(\sin\displaystyle \frac{x}{2}+\cos\displaystyle \frac{x}{2}\right)^2
\end{aligned}"""),
      StepItem(tex: r"""\text{なので、下記のように根号を外してもOK}""",),
      StepItem(tex: r"""\begin{aligned}
\sqrt{1+\sin x}=&\left|\sin\displaystyle \frac{x}{2}+\cos\displaystyle \frac{x}{2}\right|
=&\sqrt2\left|\sin\!\left(\displaystyle \frac{x}{2}+\displaystyle \frac{\pi}{4}\right)\right|
\end{aligned}
"""),
    ],
  ),
//   MathProblem(
//       id: "3E2C0C8F-7AEC-4667-8AAE-665B8D47CD40",
//     no: 3,
//     category: 'その他 合成関数（対称性）',
//     level: '上級',
//     question: r"""// \begin{aligned}
// \displaystyle \int_{0}^{\pi}\displaystyle \frac{x\sin x}{3+\sin x}\,dx
// \end{aligned}
// """,
//     answer: r""" 
// \begin{aligned}
// \displaystyle \frac{\pi^2}{2}\;-\;\displaystyle \frac{3\sqrt{2}\,\pi}{4}\left(\displaystyle \frac{\pi}{2}-\arctan\displaystyle \frac{1}{2\sqrt{2}}\right)
// \end{aligned}
// """,
//     imageAsset: 'assets/graphs/integral/problems_others/problem_3.png',
//     steps: [
//       StepItem(tex: r"""\textbf{【方針】}"""),
//       StepItem(tex: r"""// \begin{aligned}
// &\text{対称性 } x\mapsto \pi-x \text{ を用いて，}x\text{ を消去し，}
// \displaystyle \int_0^\pi \displaystyle \frac{\sin x}{3+\sin x}\,dx \text{ に帰着する。}
// \end{aligned}
// """),
//       StepItem(tex: r"""\textbf{【ポイント】}"""),
//       StepItem(tex: r"""// \begin{aligned}
// &I=\displaystyle \int_0^\pi \displaystyle \frac{x\sin x}{3+\sin x}\,dx,\quad
// u=\pi-x \Rightarrow I=\displaystyle \int_0^\pi \displaystyle \frac{(\pi-u)\sin u}{3+\sin u}\,du,\\
// &\Rightarrow\; 2I=\pi\displaystyle \int_0^\pi \displaystyle \frac{\sin x}{3+\sin x}\,dx
// \;(:= \pi J),\\
// &\displaystyle \frac{\sin x}{3+\sin x}=1-\displaystyle \frac{3}{3+\sin x}
// \;\Rightarrow\;
// J=\pi-3K,\quad
// K=\displaystyle \int_0^\pi \displaystyle \frac{dx}{3+\sin x}.
// \end{aligned}
// """),
//       StepItem(tex: r"""\textbf{【解説】}"""),
//       StepItem(tex: r"""// \begin{aligned}
// I
// &=\displaystyle \int_0^\pi \displaystyle \frac{x\sin x}{3+\sin x}\,dx\\
// &=\displaystyle \frac{\pi}{2}\displaystyle \int_0^\pi \displaystyle \frac{\sin x}{3+\sin x}\,dx\\
// &=\displaystyle \frac{\pi}{2}\left(\pi-3K\right).
// \end{aligned}
// """),
//       StepItem(tex: r"""// \begin{aligned}
// &\text{以降 }K\text{ を評価する。半角置換 } t=\tan\displaystyle \frac{x}{2}\;(x\in[0,\pi])\text{ を用いる。}\\
// &\sin x=\displaystyle \frac{2t}{1+t^2},\quad dx=\displaystyle \frac{2\,dt}{1+t^2},\quad
// x:0\to\pi \;\Rightarrow\; t:0\to\infty.
// \end{aligned}
// """),
//       StepItem(tex: r"""// \begin{aligned}
// K
// &=\displaystyle \int_{0}^{\pi}\displaystyle \frac{dx}{3+\sin x}\\
// &=\displaystyle \int_{0}^{\infty}\displaystyle \frac{1}{3+\displaystyle \frac{2t}{1+t^2}}\cdot\displaystyle \frac{2\,dt}{1+t^2}\\
// &=\displaystyle \int_{0}^{\infty}\displaystyle \frac{2\,dt}{3(1+t^2)+2t}\\
// &=\displaystyle \int_{0}^{\infty}\displaystyle \frac{2\,dt}{3t^2+2t+3}.
// \end{aligned}
// """),
//       StepItem(tex: r"""// \begin{aligned}
// &\text{平方完成して標準形に帰着する。}\\
// 3t^2+2t+3
// &=3\left[\left(t+\displaystyle \frac{1}{3}\right)^2+\displaystyle \frac{8}{9}\right]\\
// &=3\left[\left(t+\displaystyle \frac{1}{3}\right)^2+\left(\displaystyle \frac{2\sqrt2}{3}\right)^2\right].
// \end{aligned}
// """),
//       StepItem(tex: r"""// \begin{aligned}
// K
// &=\displaystyle \frac{2}{3}\displaystyle \int_0^\infty\displaystyle \frac{dt}{\left(t+\displaystyle \frac{1}{3}\right)^2+\left(\displaystyle \frac{2\sqrt2}{3}\right)^2}\\
// &=\displaystyle \frac{\sqrt2}{2}\displaystyle \int_{\,\frac{1}{2\sqrt2}}^{\,\infty}\displaystyle \frac{du}{1+u^2}
// \quad\left(u=\displaystyle \frac{3\left(t+\displaystyle \frac{1}{3}\right)}{2\sqrt2}\right).
// \end{aligned}
// """),
//       StepItem(tex: r"""// \begin{aligned}
// &\text{したがって } 
// J=\pi-3K
// =\pi-\displaystyle \frac{3\sqrt2}{2}\displaystyle \int_{\,\frac{1}{2\sqrt2}}^{\,\infty}\displaystyle \frac{du}{1+u^2},\\
// &I=\displaystyle \frac{\pi}{2}J
// =\displaystyle \frac{\pi}{2}\left(\pi-\displaystyle \frac{3\sqrt2}{2}\displaystyle \int_{\,\frac{1}{2\sqrt2}}^{\,\infty}\displaystyle \frac{du}{1+u^2}\right).
// \end{aligned}
// """),
//       StepItem(tex: r"""// \begin{aligned}
// &\text{定積分 } \displaystyle \int \displaystyle \frac{du}{1+u^2} \text{ の評価（区間端の代入）により，}\\
// &I=\displaystyle \frac{\pi^2}{2}-\displaystyle \frac{3\sqrt2\,\pi}{4}\left(\displaystyle \frac{\pi}{2}-\arctan\displaystyle \frac{1}{2\sqrt2}\right)
// \;\text{ を得る。}
// \end{aligned}
// """),
//       StepItem(tex: r"""\textbf{【補足】}"""),
//       StepItem(tex: r"""// \begin{aligned}
// &\text{本解では最後に } \displaystyle \int \displaystyle \frac{du}{1+u^2}=\arctan u + C \text{ を用いた。}\\
// &\text{逆三角関数を避ける流儀として，既知値 } 
// \displaystyle \int_0^\infty \displaystyle \frac{du}{1+u^2}=\displaystyle \frac{\pi}{2} \text{ を用い，}\\
// &\displaystyle \int_{ \frac{1}{2\sqrt2}}^\infty \displaystyle \frac{du}{1+u^2}
// =\displaystyle \int_{0}^\infty \displaystyle \frac{du}{1+u^2}-\displaystyle \int_{0}^{ \frac{1}{2\sqrt2}} \displaystyle \frac{du}{1+u^2}
// =\displaystyle \frac{\pi}{2}-\arctan\displaystyle \frac{1}{2\sqrt2}
// \text{ としても同じ結果に至る。}\\
// &\text{なお，}\arctan y=\displaystyle \frac{1}{2i}\log\displaystyle \frac{1+iy}{1-iy}\text{ と書けば，対数のみでも表現可能。}
// \end{aligned}
// """),
//     ],
//   ),

];
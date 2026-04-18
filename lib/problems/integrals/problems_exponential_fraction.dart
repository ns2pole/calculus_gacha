import '../../models/math_problem.dart';
import '../../models/step_item.dart';

/// ============================================================================
/// 指数関数の分数式の積分問題 (全3問, 改訂版)
/// ============================================================================


/// ・各問で「【方針】」「【ポイント】」「【解説】」「【結論】」「【補足】」を整理
/// ・TeX を \begin{aligned} ... \end{aligned} で整形し，式変形を一歩ずつ丁寧に記載

const exponentialFractionProblems = <MathProblem>[

// ----------------------------------------------------------------------------
// No.1 (初級) - 定積分
// ∫_{0}^{ln 2} e^{2x} / (1 + e^x)^2 dx
// ----------------------------------------------------------------------------
MathProblem(
      id: "6FD0F698-5284-4008-A239-84083F7520B2",
  no: 1,
  category: '指数関数の分数式',
  level: '初級',
  question: r"""\displaystyle \int_{0}^{\log 2} \displaystyle \frac{e^{2x}}{(1+e^x)^2}\,dx""",
  answer: r"""\log\!\displaystyle \frac{3}{2} - \displaystyle \frac{1}{6}
""",
  imageAsset: 'assets/graphs/integral/problems_exponential_fraction/problem_1.png',
  hint: r"""\text{置換 } u=e^x \text{ により有理式(多項式の分数関数)に帰着させ，さらに } 1+u=w \text{ とおいて積分を評価する．}
""",
  steps: [
    StepItem(tex: r"""\textbf{【方針】}"""),
    StepItem(tex: r"""\text{置換 } u=e^x \text{ により有理式(多項式の分数関数)に帰着させ，さらに } 1+u=w \text{ とおいて積分を評価する．}
"""),
    StepItem(tex: r"""\textbf{【解説】}"""),
    StepItem(tex: r"""\text{まず不定積分を求める。} u=e^x \text{ とおくと、} du=e^x\,dx \text{ より、}"""),
    StepItem(tex: r"""\begin{aligned}
\displaystyle \int \displaystyle \frac{e^{2x}}{(1+e^x)^2}\,dx
&= \displaystyle \int \displaystyle \frac{e^x \cdot e^x}{(1+e^x)^2}\,dx\\
&= \displaystyle \int \displaystyle \frac{u}{(1+u)^2}\,du
\end{aligned}
"""),
    StepItem(tex: r"""\text{ここでさらに } w=1+u \ (dw=du)\text{ とおくと，} u=w-1 \text{ より、}"""),
    StepItem(tex: r"""\begin{aligned}
\displaystyle \int \displaystyle \frac{u}{(1+u)^2}\,du
&= \displaystyle \int \displaystyle \frac{w-1}{w^2}\,dw\\
&= \displaystyle \int \left(\displaystyle \frac{1}{w} - \displaystyle \frac{1}{w^2}\right)\,dw\\
&= \log w + \displaystyle \frac{1}{w} + C\\
&= \log(1+u) + \displaystyle \frac{1}{1+u} + C\\
&= \log(1+e^x) + \displaystyle \frac{1}{1+e^x} + C
\end{aligned}
"""),
    StepItem(tex: r"""\text{したがって、定積分は、}"""),
    StepItem(tex: r"""\begin{aligned}
&\ \ \ \displaystyle \int_{0}^{\log 2} \displaystyle \frac{e^{2x}}{(1+e^x)^2}\,dx \\ 
&= \left[\log(1+e^x) + \displaystyle \frac{1}{1+e^x}\right]_{0}^{\log 2}\\
&= \left(\log(1+e^{\log 2}) + \displaystyle \frac{1}{1+e^{\log 2}}\right) - \left(\log(1+e^0) + \displaystyle \frac{1}{1+e^0}\right)\\
&= \left(\log(1+2) + \displaystyle \frac{1}{1+2}\right) - \left(\log(1+1) + \displaystyle \frac{1}{1+1}\right)\\
&= \left(\log 3 + \displaystyle \frac{1}{3}\right) - \left(\log 2 + \displaystyle \frac{1}{2}\right)\\
&= \log\!\displaystyle \frac{3}{2} + \left(\displaystyle \frac{1}{3} - \displaystyle \frac{1}{2}\right)\\
&= \log\!\displaystyle \frac{3}{2} - \displaystyle \frac{1}{6}
\end{aligned}
"""),
    
  ],
),


  // 予備問題は problems_exponential_fraction_reserve.dart に移動しました
  // コメントアウトを外すと問題リストに追加されます

  // ----------------------------------------------------------------------------
  // No.3 (中級)
  // ∫ dx / (e^x + e^{-x})
  // ----------------------------------------------------------------------------
  // ----------------------------------------------------------------------------
// No.3 (中級)
// 定積分: \displaystyle \int_{0}^{ \frac{\log 3}{2}} dx / (e^x + e^{-x})
// ----------------------------------------------------------------------------
MathProblem(
      id: "A370BF54-FFB7-4B23-BFA7-522C277250B8",
  no: 3,
  category: '指数関数の分数式',
  level: '中級',
  question: r"""\displaystyle \int_{0}^{ \frac{\log 3}{2}} \displaystyle \frac{2}{e^x+e^{-x}}dx""",
  answer: r"""\displaystyle \frac{\pi}{6}
""",
  imageAsset: 'assets/graphs/integral/problems_exponential_fraction/problem_3.png',
  hint: r"""\text{分母分子に}e^x\text{を掛けて} \dfrac{e^x}{1+e^{2x}} \text{とし，置換}u=e^x \text{を行う。}""",
  steps: [
    StepItem(tex: r"""\textbf{【方針】}"""),
    StepItem(tex: r"""\text{分母分子に}e^x\text{を掛けて} \dfrac{e^x}{1+e^{2x}} \text{とし，置換}u=e^x \text{を行う。}"""),
    StepItem(tex: r"""\textbf{【解説】}"""),
    StepItem(tex: r"""\begin{aligned}
\displaystyle \int_{0}^{ \frac{\log 3}{2}} \displaystyle \frac{2\,dx}{e^x+e^{-x}}
&= 2\displaystyle \int_{0}^{ \frac{\log 3}{2}} \displaystyle \frac{dx}{e^x+e^{-x}}\\
&= 2\displaystyle \int_{0}^{ \frac{\log 3}{2}} \displaystyle \frac{e^x}{1+e^{2x}}\,dx \\
\end{aligned}
"""),
    StepItem(tex: r"""\text{ここで、} u=e^x \text{とおくと、} du=e^x dx \text{より、積分範囲は} x=0\rightarrow  \displaystyle \frac{\log 3}{2} \text{の時、} u=1\rightarrow \sqrt{3} \text{となるので、}"""),
    StepItem(tex: r"""\begin{aligned}
&= 2\displaystyle \int_{1}^{\sqrt{3}} \displaystyle \frac{1}{1+u^2}\,du
\end{aligned}
"""),
    StepItem(tex: r"""\text{ここで、} u= \tan \theta \text{とおくと、} du= \displaystyle \frac{1}{\cos^2 \theta} d\theta \text{より、積分範囲は} u=1\rightarrow \sqrt{3} \text{の時、} \tan\theta=1\rightarrow \sqrt{3} \text{より、} \theta=\displaystyle \frac{\pi}{4}\rightarrow \displaystyle \frac{\pi}{3} \text{と対応させる。}"""),
    StepItem(tex: r"""\begin{aligned}
&= 2\displaystyle \int_{\frac{\pi}{4}}^{\frac{\pi}{3}} \displaystyle \frac{1}{1+\tan^2\theta}\cdot \displaystyle \frac{1}{\cos^2\theta}\,d\theta\\
&= 2\displaystyle \int_{\frac{\pi}{4}}^{\frac{\pi}{3}} \displaystyle \frac{1}{\frac{1}{\cos^2\theta}}\cdot \displaystyle \frac{1}{\cos^2\theta}\,d\theta\\
&= 2\displaystyle \int_{\frac{\pi}{4}}^{\frac{\pi}{3}} \cos^2\theta\cdot \displaystyle \frac{1}{\cos^2\theta}\,d\theta\\
&= 2\displaystyle \int_{\frac{\pi}{4}}^{\frac{\pi}{3}} d\theta\\
&= 2\left[\theta\right]_{\frac{\pi}{4}}^{\frac{\pi}{3}}\\
&= 2\left(\displaystyle \frac{\pi}{3}-\displaystyle \frac{\pi}{4}\right)\\
&= 2 \cdot \displaystyle \frac{\pi}{12}\\
&= \displaystyle \frac{\pi}{6}
\end{aligned}
"""),
    StepItem(tex: r"""\textbf{【補足】}"""),
    StepItem(tex: r"""\text{双曲線関数を使うと下記のような流れになる。}"""),
    StepItem(tex: r"""\cosh x = \displaystyle \frac{e^x+e^{-x}}{2} \text{が、双曲線余弦関数の定義である。この定義より、} e^x+e^{-x}=2\cosh x \text{なので、}"""),
    StepItem(tex: r"""\begin{aligned}
\displaystyle \int \displaystyle \frac{2\,dx}{e^x+e^{-x}}
&= 2\displaystyle \int \displaystyle \frac{dx}{e^x+e^{-x}}\\
&= 2\displaystyle \int \displaystyle \frac{dx}{2\cosh x}\\
&= \displaystyle \int \displaystyle \frac{dx}{\cosh x}
\end{aligned}
"""),
    StepItem(tex: r"""\text{ここで、} u=e^x \text{とおいて、さらに} u=\tan\theta \text{とおくと、本解説の計算から} """),
    StepItem(tex: r"""\begin{aligned}
&= \displaystyle \int 2\,d\theta\\
&= 2\theta + C\\
&= 2\arctan(u) + C\\
&= 2\arctan(e^x) + C
\end{aligned}
"""),
    StepItem(tex: r"""\text{したがって、}"""),
    StepItem(tex: r"""\begin{aligned}
\displaystyle \int \displaystyle \frac{2\,dx}{e^x+e^{-x}}
&= 2\arctan(e^x) + C
\end{aligned}
"""),
//     StepItem(tex: r"""// \text{(3) 複素対数表示}"""),
//     StepItem(tex: r"""// \arctan u=\displaystyle \frac{1}{2i}\log\!\left(\displaystyle \frac{1+i u}{1-i u}\right)+\text{const.}
// """),
//     StepItem(tex: r"""\text{(1)(2)(3)より別の不定積分表示として下記がある。 }
// """),
// StepItem(tex: r"""// \displaystyle \int \displaystyle \frac{dx}{e^x+e^{-x}}=\displaystyle \int \displaystyle \frac{1}{2 \cosh x}\,dx
// =\arctan\!\left(\tanh\displaystyle \frac{x}{2}\right)+C
// """),
  ],
)
];
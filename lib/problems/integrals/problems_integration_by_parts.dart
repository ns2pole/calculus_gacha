import '../../models/math_problem.dart';
import '../../models/step_item.dart';


/// ============================================================================
/// 部分積分と関連の問題10問
/// ============================================================================

/// 部分積分と関連する積分問題の【解答】集（改訂版）
/// 指示に従い、各問題の解答は数式のみで明記し、
/// 手順は【方針】【ポイント】【解説】【補足】に分け、式変形を一歩ずつ記載しています。

const integrationByPartsProblems = <MathProblem>[

  /// 問題1: ∫ x cos x dx （初級）
  MathProblem(
      id: "01AB7A0C-4FD8-4E11-B537-50DFBEF48965",
    no: 1,
    category: '部分積分',
    level: '初級',
    question: r""" \displaystyle \int_0^{\pi} x\cos x \,dx""",
    answer: r"""\  -2""",
      imageAsset: 'assets/graphs/integral/problems_integration_by_parts/problem_1.png',
    steps: [
      StepItem(tex: r"""\textbf{【解法】}"""),
      StepItem(tex: r"""\text{部分積分を用いる。}"""),
      StepItem(tex: r"""\begin{aligned}
\int_0^{\pi} x \cos x \, dx &= \int_0^{\pi} x \cdot (\sin x)' \, dx \\
&= \left[x \sin x\right]_0^{\pi} - \int_0^{\pi} \sin x \, dx \\
&= \pi \cdot 0 - 0 - \left[-\cos x\right]_0^{\pi} \\
&= 0 - (-\cos \pi + \cos 0) \\
&= -(1 + 1) \\
&= -2
\end{aligned}"""),
    ],
  ),

//   /// 問題2: ∫ x^2 e^x dx （初級）
//   MathProblem(
//       id: "24269DC8-C26B-4A60-A238-1D3A9CB0D57D",
//     no: 2,
//     category: '部分積分',
//     level: '初級',
//     question: r""" \displaystyle \int x^2 e^x \,dx""",
//     answer: r"""(x^2 - 2x + 2)e^x + C""",
//         imageAsset: 'assets/graphs/integral/problems_integration_by_parts/problem_2.png',
//     steps: [
//       StepItem(tex: r""" \textbf{【方針】}"""),
//       StepItem(tex: r""" \text{多項式}\times\text{指数関数は、多項式を }u,\ \ e^x\,dx\ \text{を }dv\ \text{として部分積分を2回行う。}"""),
//       StepItem(tex: r""" \textbf{【ポイント】}"""),
//       StepItem(tex: r""" \text{1回目で次数を1つ下げ、2回目で定数項まで下げ切る。積分定数は最後にまとめる。}"""),
//       StepItem(tex: r""" \textbf{【解説】}"""),
//       StepItem(tex: r"""\begin{aligned}
// u =& x^2, \\
// du =& 2x\,dx, \\
// dv =& e^x\,dx, \\
// v =& e^x, \\[4pt]
// \displaystyle \int x^2 e^x\,dx =& uv - \displaystyle \int v\,du, \\
// =& x^2 e^x - \displaystyle \int e^x \cdot 2x\,dx. 
// \end{aligned}
// """),
//       StepItem(tex: r"""\begin{aligned}
// \displaystyle \int 2x e^x\,dx =& \displaystyle \int \left(2x\right)\,e^x\,dx, \\
// u_1 =& 2x, \\
// du_1 =& 2\,dx, \\
// dv_1 =& e^x\,dx, \\
// v_1 =& e^x, \\[4pt]
// \displaystyle \int 2x e^x\,dx =& u_1 v_1 - \displaystyle \int v_1\,du_1, \\
// =& 2x e^x - \displaystyle \int e^x \cdot 2\,dx, \\
// =& 2x e^x - 2 e^x + C.
// \end{aligned}
// """),
//       StepItem(tex: r"""\begin{aligned}
// \displaystyle \int x^2 e^x\,dx =& x^2 e^x - \left(2x e^x - 2 e^x\right) + C, \\
// =& (x^2 - 2x + 2)e^x + C.
// \end{aligned}
// """),
//       StepItem(tex: r""" \textbf{【補足】}"""),
//       StepItem(tex: r""" \text{一般に } \displaystyle \int P_n(x)e^x\,dx = e^x Q_n(x) + C \ \text{となる（微分作用素 }(D-1)\text{の逆演算の観点）。}"""),
//     ],
//   ),

  /// 問題3: ∫₀^π x sin x dx （初級／定積分）
//   MathProblem(
//       id: "9D78C6AC-6B30-40DF-B1C2-C494A4E2D8A1",
//     no: 3,
//     category: '部分積分',
//     level: '初級',
//     question: r""" \displaystyle \int_{0}^{\pi} x\sin x \,dx""",
//     answer: r""" \pi""",
//         imageAsset: 'assets/graphs/integral/problems_integration_by_parts/problem_3.png',
//     steps: [
//       StepItem(tex: r""" \textbf{【方針】}"""),
//       StepItem(tex: r""" \text{部分積分を定積分の形で用いる。 }u=x,\ dv=\sin x\,dx\ \text{とする。}"""),
//       StepItem(tex: r""" \textbf{【ポイント】}"""),
//       StepItem(tex: r""" \text{定積分の部分積分 } \displaystyle \int_a^b u\,dv = [uv]_a^b - \displaystyle \int_a^b v\,du \ \text{をそのまま使う。境界値に注意。}"""),
//       StepItem(tex: r""" \textbf{【解説】}"""),
//       StepItem(tex: r"""\begin{aligned}
// u =& x, \\
// du =& dx, \\
// dv =& \sin x\,dx, \\
// v =& -\cos x, \\[4pt]
// \displaystyle \int_{0}^{\pi} x\sin x\,dx =& [uv]_{0}^{\pi} - \displaystyle \int_{0}^{\pi} v\,du, \\
// =& \left[-x\cos x\right]_{0}^{\pi} - \displaystyle \int_{0}^{\pi}(-\cos x)\,dx, \\
// =& \left[-x\cos x\right]_{0}^{\pi} + \displaystyle \int_{0}^{\pi}\cos x\,dx, \\
// =& \left(-\pi\cos\pi - 0\cdot\cos0\right) + \left[\sin x\right]_{0}^{\pi}, \\
// =& \left(-\pi(-1) - 0\right) + \left(\sin\pi - \sin0\right), \\
// =& \pi + (0 - 0), \\
// =& \pi.
// \end{aligned}
// """),
//       StepItem(tex: r""" \textbf{【補足】}"""),
//       StepItem(tex: r""" \text{奇偶性を用いる方法（}\sin x\text{の対称性）もあるが、ここでは標準的な部分積分で計算した。}"""),
//     ],
//   ),

  /// 問題4: ∫ e^x sin x dx （中級／繰り返し部分積分）
//   MathProblem(
//       id: "5C64DEF5-13F5-4F53-BAB1-3939CC6F9994",
//     no: 4,
//     category: '部分積分',
//     level: '中級',
//     question: r""" \displaystyle \int e^x \sin x \,dx""",
//     answer: r""" \displaystyle \frac{1}{2}\,e^x(\sin x - \cos x) + C""",
//         imageAsset: 'assets/graphs/integral/problems_integration_by_parts/problem_4.png',
//     steps: [
//       StepItem(tex: r""" \textbf{【方針】}"""),
//       StepItem(tex: r""" \text{ }I=\displaystyle \int e^x\sin x\,dx\ \text{とおき、部分積分を2回行って }I\ \text{を自分自身の式で表し解く。}"""),
//       StepItem(tex: r""" \textbf{【ポイント】}"""),
//       StepItem(tex: r""" \text{1回目で } \displaystyle \int e^x\cos x\,dx \ \text{が現れる。これを }J\ \text{とおいて再度部分積分し、最後に連立で }I\ \text{を求める。}"""),
//       StepItem(tex: r""" \textbf{【解説】}"""),
//       StepItem(tex: r"""\begin{aligned}
// I =& \displaystyle \int e^x\sin x\,dx, \\
// u =& e^x, \\
// du =& e^x\,dx, \\
// dv =& \sin x\,dx, \\
// v =& -\cos x, \\[4pt]
// I =& uv - \displaystyle \int v\,du, \\
// =& e^x(-\cos x) - \displaystyle \int (-\cos x)\,e^x\,dx, \\
// =& -e^x\cos x + \displaystyle \int e^x\cos x\,dx.
// \end{aligned}
// """),
//       StepItem(tex: r"""\begin{aligned}
// J =& \displaystyle \int e^x\cos x\,dx, \\
// u =& e^x, \\
// du =& e^x\,dx, \\
// dv =& \cos x\,dx, \\
// v =& \sin x, \\[4pt]
// J =& uv - \displaystyle \int v\,du, \\
// =& e^x\sin x - \displaystyle \int \sin x\,e^x\,dx, \\
// =& e^x\sin x - I.
// \end{aligned}
// """),
//       StepItem(tex: r"""\begin{aligned}
// I =& -e^x\cos x + J, \\
// =& -e^x\cos x + \left(e^x\sin x - I\right), \\
// 2I =& e^x(\sin x - \cos x), \\
// I =& \displaystyle \frac{1}{2}\,e^x(\sin x - \cos x) + C.
// \end{aligned}
// """),
//     ],
//   ),

  /// 問題5: ∫₀^∞ x e^(−x) sin 2x dx （上級／ラプラス変換）
//   MathProblem(
//       id: "603166CF-56C7-4075-8D7B-5D7EB90A9E20",
//     no: 5,
//     category: '積（指数・三角）',
//     level: '上級',
//     question: r"""\displaystyle
// \displaystyle \int_{0}^{\infty} x e^{-x}\sin 2x\,dx
// """,
//     answer: r""" \displaystyle \frac{4}{25}""",
//         imageAsset: 'assets/graphs/integral/problems_integration_by_parts/problem_5.png',
//     steps: [
//       StepItem(tex: r""" \textbf{【方針】}"""),
//       StepItem(tex: r""" \text{ラプラス変換 }F(s)=\displaystyle \int_{0}^{\infty}e^{-sx}\sin(2x)\,dx=\displaystyle \frac{2}{s^2+4}\ \text{を用い、} -F'(s)=\displaystyle \int_{0}^{\infty}x e^{-sx}\sin(2x)\,dx\ \text{より }s=1\text{で評価する。}"""),
//       StepItem(tex: r""" \textbf{【ポイント】}"""),
//       StepItem(tex: r""" \text{微分と積分の順序交換が正当化される（絶対可積分かつ指数減衰）。計算は有理関数の微分に帰着。}"""),
//       StepItem(tex: r""" \textbf{【解説】}"""),
//       StepItem(tex: r"""\begin{aligned}
// F(s) =& \displaystyle \int_{0}^{\infty} e^{-sx}\sin(2x)\,dx, \\
// F(s) =& \displaystyle \frac{2}{s^2+4}, \\[4pt]
// -F'(s) =& \displaystyle \int_{0}^{\infty} x e^{-sx}\sin(2x)\,dx, \\
// F'(s) =& \displaystyle \frac{d}{ds}\!\left(\displaystyle \frac{2}{s^2+4}\right), \\
// =& 2\cdot\displaystyle \frac{d}{ds}\!\left((s^2+4)^{-1}\right), \\
// =& 2\cdot\left(-1\right)\cdot(s^2+4)^{-2}\cdot(2s), \\
// =& -\displaystyle \frac{4s}{(s^2+4)^2}, \\[4pt]
// \displaystyle \int_{0}^{\infty} x e^{-x}\sin(2x)\,dx =& -F'(1), \\
// =& -\left(-\displaystyle \frac{4\cdot 1}{(1^2+4)^2}\right), \\
// =& \displaystyle \frac{4}{25}.
// \end{aligned}
// """),
//       StepItem(tex: r""" \textbf{【補足】}"""),
//       StepItem(tex: r""" \text{複素積分 } \Im\displaystyle \int_{0}^{\infty} x e^{-(1-2i)x}\,dx \ \text{からも同値の結果が得られる。}"""),
//     ],
//   ),

  /// 問題6: ∫_{π/4}^{π} x e^x sin x dx （上級／繰り返し部分積分）
//   MathProblem(
//       id: "F8352C53-F7CA-4173-85C0-E6A94D2ABA5E",
//     no: 6,
//     category: '指数×三角（部分積分）',
//     level: '上級',
//     question: r"""\displaystyle
// \displaystyle \int_{ \frac {\pi} {4}}^{\pi} x e^{x}\sin x \,dx
// """,
//     answer: r""" \displaystyle \frac{1}{2}e^{\pi}(\pi - 1) - \displaystyle \frac{\sqrt{2}}{4}\,e^{ \frac{\pi}{4}}""",
//         imageAsset: 'assets/graphs/integral/problems_integration_by_parts/problem_6.png',
//     steps: [
//       StepItem(tex: r""" \textbf{【方針】}"""),
//       StepItem(tex: r""" \text{不定積分 } \displaystyle \int x e^x\sin x\,dx \ \text{を部分積分で求め、得た原始関数に }x=\pi,\ \displaystyle \frac{\pi}{4}\ \text{を代入する。}"""),
//       StepItem(tex: r""" \textbf{【ポイント】}"""),
//       StepItem(tex: r""" \ 
//        \begin{aligned}
//        \displaystyle \int e^x\sin x\,dx=\displaystyle \frac{1}{2}e^x(\sin x-\cos x) + C\\ 
//        \displaystyle \int e^x\cos x\,dx=\displaystyle \frac{1}{2}e^x(\sin x + \cos x) + C\\ 
//        \end{aligned}
//        \text{を利用する。}
//        """),
//       StepItem(tex: r""" \textbf{【解説】}"""),
//       StepItem(tex: r"""\begin{aligned}
// \displaystyle \int e^x\sin x\,dx =& \displaystyle \frac{1}{2}e^x(\sin x - \cos x) + C.
// \end{aligned}
// """),
//       StepItem(tex: r"""\begin{aligned}
// &\ \ \displaystyle \int x e^x\sin x\,dx \\
// =&\ \ \displaystyle \int x \left( \displaystyle \frac{1}{2}e^x(\sin x - \cos x \right)\,dx \\
// =& \displaystyle \frac{1}{2}x e^x(\sin x - \cos x) - \displaystyle \int \displaystyle \frac{1}{2}e^x(\sin x - \cos x)\,dx \ \cdots (1)
// \end{aligned}
// """),
//       StepItem(tex: r"""\begin{aligned}
// \displaystyle \int \displaystyle \frac{1}{2}e^x(\sin x - \cos x)\,dx
// =& \displaystyle \frac{1}{2}\displaystyle \int e^x\sin x\,dx - \displaystyle \frac{1}{2}\displaystyle \int e^x\cos x\,dx, \\
// =& \displaystyle \frac{1}{2}\cdot\displaystyle \frac{1}{2}e^x(\sin x - \cos x) - \displaystyle \frac{1}{2}\cdot\displaystyle \frac{1}{2}e^x(\sin x + \cos x), \\
// =& \displaystyle \frac{1}{4}e^x\left[(\sin x - \cos x) - (\sin x + \cos x)\right], \\
// =& \displaystyle \frac{1}{4}e^x(-2\cos x), \\
// =& -\displaystyle \frac{1}{2}e^x\cos x \ \cdots (2)
// \end{aligned}
// """),
//       StepItem(tex: r""" \text{よって(1),(2)より}
// \begin{aligned}
// &\ \ \displaystyle \int x e^x\sin x\,dx\\
// =& \displaystyle \frac{1}{2}x e^x(\sin x - \cos x) - \left(-\displaystyle \frac{1}{2}e^x\cos x\right), \\
// =& \displaystyle \frac{1}{2}x e^x(\sin x - \cos x) + \displaystyle \frac{1}{2}e^x\cos x + C, \\
// =& \displaystyle \frac{1}{2}e^x\left[x(\sin x - \cos x) + \cos x\right] + C.
// \end{aligned}
// """),
//       StepItem(tex: r"""\begin{aligned}
// \displaystyle \int_{ \frac{\pi}{4}}^{\pi} x e^x\sin x\,dx
// =& \left[\displaystyle \frac{1}{2}e^x\left\{x(\sin x - \cos x) + \cos x\right\}\right]_{ \frac{\pi}{4}}^{\pi}, \\
// =& \displaystyle \frac{1}{2}e^{\pi}\left\{\pi(\sin\pi - \cos\pi) + \cos\pi\right\} - \displaystyle \frac{1}{2}e^{ \frac{\pi}{4}}\left\{\displaystyle \frac{\pi}{4}(\sin\displaystyle \frac{\pi}{4} - \cos\displaystyle \frac{\pi}{4}) + \cos\displaystyle \frac{\pi}{4}\right\}, \\
// =& \displaystyle \frac{1}{2}e^{\pi}\left\{\pi(0 - (-1)) + (-1)\right\} - \displaystyle \frac{1}{2}e^{ \frac{\pi}{4}}\left\{\displaystyle \frac{\pi}{4}(0) + \displaystyle \frac{\sqrt{2}}{2}\right\}, \\
// =& \displaystyle \frac{1}{2}e^{\pi}(\pi - 1) - \displaystyle \frac{1}{2}e^{ \frac{\pi}{4}}\cdot\displaystyle \frac{\sqrt{2}}{2}, \\
// =& \displaystyle \frac{1}{2}e^{\pi}(\pi - 1) - \displaystyle \frac{\sqrt{2}}{4}\,e^{ \frac{\pi}{4}}.
// \end{aligned}
// """),
//       // StepItem(tex: r""" \textbf{【補足】}"""),
//       // StepItem(tex: r""" \text{複素表示 }e^x\sin x=\Im\{e^{(1+i)x}\}\text{を用いても同じ結果に到達する。}"""),
//     ],
//   ),

  /// 問題7: ∫_{ \frac {1} {2}}^{1} (x+1)e^{−x} dx （中級／指数関数の積）
  MathProblem(
      id: "26D1B6CC-77F8-4522-88A0-0A06A41D8D67",
    no: 7,
    category: '部分積分（指数）',
    level: '中級',
    question: r"""\displaystyle
\displaystyle \int_{ {0}}^{\log 2} \displaystyle \frac{x+1}{e^{x}}\,dx
""",
    answer: r""" \displaystyle -\frac{\log 2}{2} + 1""",
        imageAsset: 'assets/graphs/integral/problems_integration_by_parts/problem_7.png',
    hint: r""" \displaystyle \frac{1}{e^x} = e^{-x} \text{ と見て、部分積分を実行する。}""",
    steps: [
      StepItem(tex: r""" \textbf{【方針】}"""),
      StepItem(tex: r""" \displaystyle \frac{1}{e^x} = e^{-x} \text{ と見て、部分積分を実行する。}"""),
      StepItem(tex: r""" \textbf{【解法】}"""),
      StepItem(tex: r"""\text{部分積分を用いる。}"""),
      StepItem(tex: r"""\begin{aligned}
\int_0^{\log 2} (x+1)e^{-x} \, dx &= \int_0^{\log 2} (x+1) \cdot (-e^{-x})' \, dx \\
&= \left[-(x+1)e^{-x}\right]_0^{\log 2} + \int_0^{\log 2} e^{-x} \, dx \\
&= -(\log 2 + 1)e^{-\log 2} + 0 \cdot e^0 + \left[-e^{-x}\right]_0^{\log 2} \\
&= -\frac{\log 2 + 1}{2} + \left(-e^{-\log 2} + e^0\right) \\
&= -\frac{\log 2 + 1}{2} + \left(-\frac{1}{2} + 1\right) \\
&= -\frac{\log 2 + 1}{2} + \frac{1}{2} \\
&= -\frac{\log 2}{2} + 1
\end{aligned}
"""),
    ],
  ),

  /// 問題9: ∫₀^{π/2} x² cosx dx （中級／部分積分）
  MathProblem(
    id: "CC1A2E7C-04EF-4D32-BB13-907FBEC6515D",
    no: 9,
    category: '部分積分',
    level: '中級',
    question: r"""\displaystyle \int_0^{\frac{\pi}{2}} x^2 \cos x \, dx""",
    answer: r"""\displaystyle \frac{\pi^2}{4} - 2""",
    imageAsset: 'assets/graphs/integral/problems_integration_by_parts/problem_9.png',
    steps: [
      StepItem(tex: r"""\textbf{【背景】}"""),
      StepItem(tex: r"""\text{この問題は、曲線 } y = \sin x \left( 0 \leq x \leq \displaystyle \frac{\pi}{2} \right) \text{を } y \text{ 軸の周りに回転させてできる回転体の体積を求める問題である。}"""),
      StepItem(tex: '', imageAsset: 'assets/graphs/integral/problems_curves/problem_9_volume.png'),
      StepItem(tex: r"""\text{実際、回転体の体積は }"""),
      StepItem(tex: r"""
      \begin{aligned}
      \displaystyle  V =  \pi \int_0^{1} Y(x)^2 dy \\
      =  \pi \int_0^{\frac{\pi}{2}} x^2 \frac {dy}{dx} dx \\
      =  \pi \int_0^{\frac{\pi}{2}} x^2 \cos x \, dx
      \end{aligned}
      """),
      StepItem(tex: r"""\text{ で与えられる。}"""),
      StepItem(tex: r"""\textbf{【解法】}"""),
      StepItem(tex: r"""\text{部分積分を用いる。}"""),
      StepItem(tex: r"""\begin{aligned}
\int_0^{\frac{\pi}{2}} x^2 \cos x \, dx &= \int_0^{\frac{\pi}{2}} x^2 \cdot (\sin x)' \, dx \\
&= \left[x^2 \sin x\right]_0^{\frac{\pi}{2}} - \int_0^{\frac{\pi}{2}} \sin x \cdot 2x \, dx \\
&= \left(\displaystyle \frac{\pi}{2}\right)^2 \cdot 1 - 0 - 2\int_0^{\frac{\pi}{2}} x \sin x \, dx \\
&= \displaystyle \frac{\pi^2}{4} - 2\textcolor{blue} {\int_0^{\frac{\pi}{2}} x \sin x \, dx}
\end{aligned}"""),
      StepItem(tex: r"""\text{次に、} \displaystyle \int_0^{\frac{\pi}{2}} x \sin x \, dx \text{ を部分積分する。}"""),
      StepItem(tex: r"""\begin{aligned}
\textcolor{blue} {\int_0^{\frac{\pi}{2}} x \sin x \, dx} &= \int_0^{\frac{\pi}{2}} x \cdot (-\cos x)' \, dx \\
&= \left[-x \cos x\right]_0^{\frac{\pi}{2}} + \int_0^{\frac{\pi}{2}} \cos x \, dx \\
&= -\displaystyle\frac{\pi}{2} \cdot 0 + 0 + \left[\sin x\right]_0^{\frac{\pi}{2}} \\
&= \textcolor{blue} {1}
\end{aligned}"""),
      StepItem(tex: r"""\text{したがって、}"""),
      StepItem(tex: r"""\begin{aligned}
\int_0^{\frac{\pi}{2}} x^2 \cos x \, dx &= \displaystyle \frac{\pi^2}{4} - 2 \cdot \textcolor{blue} {1} \\
&= \displaystyle \frac{\pi^2}{4} - 2
\end{aligned}"""),

    ],
  ),

  /// 問題10: ∫_{0}^{π/5} e^{-2x} cos 5x dx （中級／繰り返し部分積分）
  MathProblem(
    id: "D9E29F85-E082-42D3-A2E6-34D162864716",
    no: 10,
    category: '部分積分（指数×三角）',
    level: '上級',
    question: r"""\displaystyle \int_{0}^{\frac{\pi}{5}} e^{-2x}\cos 5x \,dx""",
    answer: r"""\displaystyle \frac{2(e^{\frac{-2\pi}{5}}+1)}{29}""",
    imageAsset: 'assets/graphs/integral/problems_integration_by_parts/problem_10.png',
    hint: r"""\text{部分積分を2回行い、元の積分を自分自身で表して解く。}""",
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{ } I = \displaystyle \int_{0}^{\frac{\pi}{5}} e^{-2x}\cos 5x \,dx \text{ とおき、部分積分を2回行って } I \text{ を自分自身の式で表し解く。}"""),
      StepItem(tex: r"""\textbf{【解法】}"""),
      StepItem(tex: r"""\text{部分積分を用いる。}"""),
      StepItem(tex: r"""\begin{aligned}
I &= \int_{0}^{\frac{\pi}{5}} e^{-2x}\cos 5x \,dx\\[5pt]
&= \int_{0}^{\frac{\pi}{5}} e^{-2x} \cdot \left(\displaystyle\frac{1}{5}\sin 5x\right)' \,dx\\[5pt]
&= \left[e^{-2x} \cdot \displaystyle\frac{1}{5}\sin 5x\right]_{0}^{\frac{\pi}{5}} - \int_{0}^{\frac{\pi}{5}} \displaystyle\frac{1}{5}\sin 5x \cdot (-2e^{-2x})\,dx\\[5pt]
&= \left(\displaystyle\frac{1}{5}e^{\frac{-2\pi}{5}}\sin\pi - \displaystyle\frac{1}{5}e^{0}\sin 0\right) + \displaystyle\frac{2}{5}\int_{0}^{\frac{\pi}{5}} e^{-2x}\sin 5x \,dx\\[5pt]
&= \displaystyle\frac{2}{5}\textcolor{blue}{\int_{0}^{\frac{\pi}{5}} e^{-2x}\sin 5x \,dx}
\end{aligned}"""),
      StepItem(tex: r"""\text{次に、} \textcolor{blue}{\displaystyle \int_{0}^{\frac{\pi}{5}} e^{-2x}\sin 5x \,dx} \text{ を部分積分する。}"""),
      StepItem(tex: r"""\begin{aligned}
&\ \ \ \ \ \textcolor{blue}{\int_{0}^{\frac{\pi}{5}} e^{-2x}\sin 5x \,dx} \\[5pt]
&= \int_{0}^{\frac{\pi}{5}} e^{-2x} \cdot \left(-\displaystyle\frac{1}{5}\cos 5x\right)' \,dx\\[5pt]
&= \left[e^{-2x} \cdot \left(-\displaystyle\frac{1}{5}\cos 5x\right)\right]_{0}^{\frac{\pi}{5}} - \int_{0}^{\frac{\pi}{5}} \left(-\displaystyle\frac{1}{5}\cos 5x\right) \cdot (-2e^{-2x})\,dx\\[5pt]
&= \left(-\displaystyle\frac{1}{5}e^{\frac{-2\pi}{5}}\cos\pi + \displaystyle\frac{1}{5}e^{0}\cos 0\right) - \displaystyle\frac{2}{5}\int_{0}^{\frac{\pi}{5}} e^{-2x}\cos 5x \,dx\\[5pt]
&= -\displaystyle\frac{1}{5}e^{\frac{-2\pi}{5}}\cos\pi + \displaystyle\frac{1}{5} - \displaystyle\frac{2}{5}I\\[5pt]
&= \textcolor{blue}{\displaystyle\frac{1}{5}e^{\frac{-2\pi}{5}} + \displaystyle\frac{1}{5} - \displaystyle\frac{2}{5}I}
\end{aligned}"""),
      StepItem(tex: r"""\text{したがって、}"""),
      StepItem(tex: r"""\begin{aligned}
&\ \ \ \ \ I = \displaystyle\frac{2}{5}\textcolor{blue}{\left(\displaystyle\frac{1}{5}e^{\frac{-2\pi}{5}} + \displaystyle\frac{1}{5} - \displaystyle\frac{2}{5}I\right)}\\[5pt]
&\Leftrightarrow I = \displaystyle\frac{2}{25}e^{\frac{-2\pi}{5}} + \displaystyle\frac{2}{25} - \displaystyle\frac{4}{25}I\\
&\Leftrightarrow I + \displaystyle\frac{4}{25}I = \displaystyle\frac{2}{25}e^{\frac{-2\pi}{5}} + \displaystyle\frac{2}{25}\\[5pt]
&\Leftrightarrow \displaystyle\frac{29}{25}I = \displaystyle\frac{2(e^{\frac{-2\pi}{5}} + 1)}{25}\\[5pt]
&\Leftrightarrow I = \displaystyle\frac{2(e^{\frac{-2\pi}{5}} + 1)}{29}
\end{aligned}"""),
    ],
  ),

];
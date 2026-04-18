import '../../models/math_problem.dart';
import '../../models/step_item.dart';

/// ============================================================================
/// 基本公式の定積分 3題
/// =========================================================================
/// 定積分の基本（対数・三角・指数・奇関数）
///
/// 改善内容
/// - 問題本文（question）は一切変更しない
/// - 最終【answer】はすべて「数値のみ」（π, e, ルート, log, 分数, 累乗などは可）
/// - 【方針】【ポイント】【解説】【補足】に分け、途中式は一切省略せず丁寧に記載
/// - 数式は \begin{aligned} を用いて整形し、同一行に 2 個以上の「=」を並べない
/// - cot, csc, sec は使用しない
/// =========================================================================

const basicFormulaProblems = <MathProblem>[
  // ────────────────────────────────
  // 問題 1: 対数関数の定積分
  // ∫[1→e] log x dx
  // ────────────────────────────────
  MathProblem(
      id: "180399F4-71C4-4CAE-8392-D57061DDCBA6",
    no: 1,
    category: 'その他 - 対数（基本）',    level: '初級',    question: r"""\displaystyle \int_{1}^{e} \log  x \, dx""",
    // 最終【解答】（数値のみ）
    answer: r"""1
""",
    imageAsset: 'assets/graphs/integral/problems_basic_formula/problem_1.png',
    steps: [
      // 【ポイント】
      StepItem(tex: r"""\textbf{【ポイント】}""",),
      StepItem(
        tex: r"""\log x = (x)'\log {x} \text{とみなして、部分積分の公式を用いる。}
""",      ),
      StepItem(tex: r"""\begin{aligned}
&\displaystyle \int \log x\,dx = \displaystyle \int (x)' \log x\,dx 
&= x\log x - \displaystyle \int x\cdot\displaystyle \frac{1}{x}\,dx \\
&\phantom{\displaystyle \int \log x\,dx } = x\log x - \displaystyle \int 1\,dx \\
&\phantom{\displaystyle \int \log x\,dx } = x\log x - x + C
\end{aligned}
"""),

      // 【解説】
      StepItem(tex: r"""\textbf{【計算】}""",),
      StepItem(tex: r"""\begin{aligned}
\displaystyle \int_{1}^{e} \log x\,dx
&= \left[x\log x - x\right]_{x=1}^{x=e} \\
&= \left(e\cdot \log e - e\right) - \left(1\cdot \log 1 - 1\right) \\
&= \left(e\cdot 1 - e\right) - \left(1\cdot 0 - 1\right) \\
&= (e-e) - (0-1) \\
&= 1
\end{aligned}
"""),
    ],
  ),

  // ────────────────────────────────
  // 問題 2: 三角関数の定積分（tan）
  // ∫[π/6→π/4] tan x dx
  // ────────────────────────────────
  MathProblem(
      id: "F41A1522-30A9-4428-AB89-02F6A0650991",
    no: 2,
    category: '三角（基本）',    level: '初級',    question: r"""\displaystyle \int_{ \frac {\pi} {6}}^{ \frac {\pi} {4}} \tan x \, dx""",
    // 最終【解答】（数値のみ；log を含む数値表現）
    answer: r"""\displaystyle \frac{1}{2}\,\log \left(\displaystyle \frac{3}{2}\right)""",
    imageAsset: 'assets/graphs/integral/problems_basic_formula/problem_2.png',
    hint: r"""\begin{aligned}
&\tan x=\dfrac{\sin x}{\cos x} \text{ と書き，} u=\cos x \text{ の置換で } \displaystyle \int \tan x\,dx \text{ を求める。}\\
&\text{得られた原始関数に } x=\displaystyle \frac{\pi}{6},\displaystyle \frac{\pi}{4} \text{ を代入して定積分を評価する。}
\end{aligned}
""",    steps: [
      // 【方針】
      StepItem(tex: r"""\textbf{【方針】}""",),
      StepItem(
        tex: r"""\begin{aligned}
&\tan x=\dfrac{\sin x}{\cos x} \text{ と書き，} u=\cos x \text{ の置換で } \displaystyle \int \tan x\,dx \text{ を求める。}\\
&\text{得られた原始関数に } x=\displaystyle \frac{\pi}{6},\displaystyle \frac{\pi}{4} \text{ を代入して定積分を評価する。}
\end{aligned}
""",      ),
      // 【ポイント】
      StepItem(tex: r"""\textbf{【ポイント】}""",),
      StepItem(
        tex: r"""\begin{aligned}
&u=\cos x , \ \ du=-\sin x\,dx \\[4pt]
&\displaystyle \int \tan x\,dx = \displaystyle \int \displaystyle \frac{\sin x}{\cos x}\,dx \\
&\phantom{\displaystyle \int \tan x\,dx } = \displaystyle \int \displaystyle \frac{-1}{u}\,du \\
&\phantom{\displaystyle \int \tan x\,dx } = -\displaystyle \int \displaystyle \frac{1}{u}\,du \\
&\phantom{\displaystyle \int \tan x\,dx } = -\log |u| + C \\
&\phantom{\displaystyle \int \tan x\,dx } = -\log |\cos x| + C \\[6pt]
&\cos \displaystyle \frac{\pi}{4} =\displaystyle \frac{\sqrt{2}}{2},\quad
\cos \displaystyle \frac{\pi}{6}=\displaystyle \frac{\sqrt{3}}{2} \\
&\text{区間 } \left[\displaystyle \frac{\pi}{6},\displaystyle \frac{\pi}{4}\right] \text{ では } \cos x>0 \text{ なので } |\cos x|=\cos x \text{ としてよい。}
\end{aligned}
""",      ),
      // 【解説】
      StepItem(tex: r"""\textbf{【解説】}""",),
      StepItem(tex: r"""\begin{aligned}
\displaystyle \int_{ \frac{\pi}{6}}^{ \frac{\pi}{4}} \tan x\,dx
&= \Biggl[-\log |\cos x|\Biggr]_{x= \frac{\pi}{6}}^{x= \frac{\pi}{4}} \\
&= \Biggl[-\log \cos x \Biggr]_{x= \frac{\pi}{6}}^{x= \frac{\pi}{4}} \\
&= \left(-\log \cos\displaystyle \frac{\pi}{4}\right) - \left(-\log \cos\displaystyle \frac{\pi}{6}\right) \\
&= -\log\!\left(\displaystyle \frac{\sqrt{2}}{2}\right) + \log\!\left(\displaystyle \frac{\sqrt{3}}{2}\right) \\
&= \log\!\left(\displaystyle \frac{\displaystyle \frac{\sqrt{3}}{2}}{\displaystyle \frac{\sqrt{2}}{2}}\right) \\
&= \log\!\left(\displaystyle \frac{\sqrt{3}}{\sqrt{2}}\right) \\
&= \log\!\left(\sqrt{\displaystyle \frac{3}{2}}\right) \\
&= \displaystyle \frac{1}{2}\,\log\!\left(\displaystyle \frac{3}{2}\right)
\end{aligned}
"""),
    ],
  ),

  // ────────────────────────────────
  // 問題 3: 指数関数の定積分
  // ∫[\displaystyle \frac {1} {4}→\displaystyle \frac {1} {2}] 2^x dx
  // ────────────────────────────────
  MathProblem(
      id: "ECB70663-7BFE-4801-8F92-21A71BF20AD3",
    no: 3,
    category: '指数関数（基本）',    level: '初級',    question: r"""\displaystyle \int_{ \frac {1} {4}}^{ \frac {1} {2}} 2^{x} \, dx""",
    // 最終【解答】（数値のみ；log を含む数値表現）
    answer: r"""\displaystyle \frac{\sqrt{2}-2^{ \frac{1}{4}}}{\log 2}
""",
    imageAsset: 'assets/graphs/integral/problems_basic_formula/problem_3.png',
    hint: r"""\displaystyle \int a^x\,dx = \dfrac{a^x}{\log a} + C\ (a>0, a\neq 1) \text{の公式を用いる。}
""",    steps: [
      // 【方針】
      StepItem(tex: r"""\textbf{【方針】}""",),
      StepItem(
        tex: r"""\displaystyle \int a^x\,dx = \dfrac{a^x}{\log a} + C\ (a>0, a\neq 1) \text{の公式を用いる。}
""",      ),      
StepItem(tex: r"""\textbf{【ポイント】}""",),
StepItem(
  tex: r"""\text{公式は合成関数の微分で導出可能である。すなわち、} 2^x = e^{\log 2 x}= (e^{x})^{\log 2 } \text{と見る。}
""",),
      // 【解説】
      StepItem(tex: r"""\textbf{【解説】}""",),
      StepItem(tex: r"""\begin{aligned}
\displaystyle \int_{ \frac{1}{4}}^{ \frac{1}{2}} 2^x\,dx
&= \left[\displaystyle \frac{2^x}{\log 2}\right]_{x=\displaystyle \frac{1}{4}}^{x=\displaystyle \frac{1}{2}} \\
&= \displaystyle \frac{2^{ \frac{1}{2}}}{\log 2} - \displaystyle \frac{2^{ \frac{1}{4}}}{\log 2} \\
&= \displaystyle \frac{2^{ \frac{1}{2}} - 2^{ \frac{1}{4}}}{\log 2} \\
&= \displaystyle \frac{\sqrt{2} - 2^{ \frac{1}{4}}}{\log 2}
\end{aligned}
"""),
// 【解説】
      StepItem(tex: r"""\textbf{【補足-合成関数として考えた公式導出】}
""",),
      StepItem(tex: r"""  \begin{aligned}
(2^x)' &= \left((e^{\log 2})^x\right)'\\
&=  \left(e^{x \log 2}\right)'\\
&=  (e^{x \log 2}) \left(x \log 2\right)'\\
&=  2^x \log 2\\
&=  (\log 2) 2^x\\
\end{aligned}
"""),
StepItem(tex: r"""\text{よって、}\left(\displaystyle \frac {2^x}{\log 2}\right)' = 2^x""",),
StepItem(tex: r"""\text{よって、}\displaystyle \int 2^x\,dx = \displaystyle \frac{2^x}{\log 2} + C""",),
    ],
  ),
];
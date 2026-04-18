import '../../models/math_problem.dart';
import '../../models/step_item.dart';

/// ============================================================================
/// 三角関数の有理関数 12問
/// ============================================================================


/// 方針・ポイント・解説・補足を明示し、式変形は一切省略せずに丁寧に記述。
/// cot, csc, sec は使用しない（必要なら sin, cos, tan を用いる）。
/// 定積分は必ず定数で答え、無理数は根号のまま・対数は log 表記で明記。
const trigFractionProblems = <MathProblem>[
  // 1) ∫ dx / (1 + sin x)
//   MathProblem(
//     id: "A80163F0-5A93-4748-9E8B-A9FBF63483A8",
//     no: 1,// sec を使わない表現にしたバージョン
//   category: '三角関数の分数式',
//   level: '上級',
//   question: r"""\displaystyle \int \frac{dx}{1+\sin x}""",
//   answer: r"""\tan x - \dfrac{1}{\cos x} + C \quad \text{又は、} -\dfrac{2}{1+\tan(\frac x 2)} + C """,
//   imageAsset: 'assets/graphs/integral/problems_trig_fraction/problem_1.png',
//   steps: [
//     StepItem(tex: r"""\textbf{【方針】}"""),
//     StepItem(tex: r"""\; \text{分母を有理化して } \sin,\cos \text{ のみで積分する（}\sec\text{は使わない）。}"""),
//     StepItem(tex: r"""\textbf{【有理化】}"""),
//     StepItem(tex: r"""\begin{aligned}
// \displaystyle \frac{1}{1+\sin x}
// =& \displaystyle \frac{1-\sin x}{(1+\sin x)(1-\sin x)}\\[6pt]
// =& \displaystyle \frac{1-\sin x}{1-\sin^2 x}\\[6pt]
// =& \displaystyle \frac{1-\sin x}{\cos^2 x}\\[6pt]
// =& \displaystyle \frac{1}{\cos^2 x}-\displaystyle \frac{\sin x}{\cos^2 x}.
// \end{aligned}"""),
//     StepItem(tex: r"""\textbf{【積分】}"""),
//     StepItem(tex: r"""\begin{aligned}
// \displaystyle &\int \frac{dx}{1+\sin x}\\[6pt]
// =& \displaystyle \int \left(\frac{1}{\cos^2 x}-\frac{\sin x}{\cos^2 x}\right)\,dx\\[6pt]
// =& \displaystyle \int \frac{1}{\cos^2 x}\,dx - \displaystyle \int \frac{\sin x}{\cos^2 x}\,dx
// \end{aligned}"""),
//     StepItem(tex: r"""\text{ここで}
// \begin{aligned}
// \begin{cases}
// \displaystyle \int \frac{1}{\cos^2 x}\,dx=\tan x\\[5pt]
// \displaystyle \int \frac{\sin x}{\cos^2 x}\,dx = \dfrac{1}{\cos x}
// \end{cases}
// \end{aligned}
// \text{なので、}"""),
// StepItem(tex: r"""\displaystyle \int \frac{dx}{1+\sin x}=\tan x - \dfrac{1}{\cos x} + C"""),
//   ],
// ),


  // 2) ∫ sin x / cos^3 x dx
//   MathProblem(
//     id: "704B2074-890B-48AA-94A7-B218C49F9F90",
//     no: 2,
//     category: '三角関数の分数式',
//     level: '初級',
//     question: r""" \displaystyle \int \displaystyle \frac{\sin x}{\cos^3 x}\,dx""",
//     answer: r""" \displaystyle \frac{1}{2\cos^2 x} + C""",
//     imageAsset: 'assets/graphs/integral/problems_trig_fraction/problem_2.png',
//     steps: [
//       StepItem(tex: r""" \textbf{【方針】}"""),
//       StepItem(tex: r""" \text{置換}\;u=\cos x\;\text{を行う。}"""),
//       StepItem(tex: r""" \textbf{【解説】}"""),
//       StepItem(  tex: r"""u=\cos x\text{ の時、} \ du=-\sin x\,dx  \text{なので、}"""),
//       StepItem(
//         tex: r"""\begin{aligned}
// \displaystyle \int \displaystyle \frac{\sin x}{\cos^3 x}\,dx
// =& \displaystyle \int \sin x\,\cos^{-3}x\,dx\\[5pt]
// =& -\displaystyle \int u^{-3}\,du\\[5pt]
// =& -\left(\displaystyle \frac{u^{-2}}{-2}\right)+C\\[5pt]
// =& \displaystyle \frac{1}{2}u^{-2}+C\\[5pt]
// =& \displaystyle \frac{1}{2\cos^2 x}+C.
// \end{aligned}
// """
//       ),
//     ],
//   ),

  // 3) ∫ cos x / (1 + sin^2 x) dx
//   MathProblem(
//     id: "D3A7479B-AAC4-447E-8B59-E468854817B6",
//     no: 3,
//     category: '三角関数の分数式',
//     level: '初級',
//     question: r""" \displaystyle \int \displaystyle \frac{\cos x}{1+\sin^2 x}\,dx""",
//     answer: r""" \displaystyle \frac{1}{2\mathrm{i}}\log \!\left(\displaystyle \frac{1+\mathrm{i}\,\sin x}{1-\mathrm{i}\,\sin x}\right)+C""",
//     imageAsset: 'assets/graphs/integral/problems_trig_fraction/problem_3.png',
//     steps: [
//       StepItem(tex: r""" \textbf{【方針】}"""),
//       StepItem(tex: r""" \text{置換}\;u=\sin x\;\text{で}\;\displaystyle \int \displaystyle \frac{du}{1+u^2}\;\text{に帰着し、逆三角関数は用いず対数表示（複素対数）で表す。}"""),
//       StepItem(tex: r""" \textbf{【ポイント】}"""),
//       StepItem(
//         tex: r"""\begin{aligned}
// &u=\sin x\\[5pt]
// &\Rightarrow\;du=\cos x\,dx\\[5pt]
// &\Rightarrow\;\displaystyle \int \displaystyle \frac{\cos x}{1+\sin^2 x}\,dx=\displaystyle \int \displaystyle \frac{du}{1+u^2}.\\[5pt]
// &\text{恒等式}\;\;\arctan u=\displaystyle \frac{1}{2\mathrm{i}}\log\!\left(\displaystyle \frac{1+\mathrm{i}u}{1-\mathrm{i}u}\right)\;(\mathrm{i}^2=-1).
// \end{aligned}
// """
//       ),
//       StepItem(tex: r""" \textbf{【解説】}"""),
//       StepItem(
//         tex: r"""\begin{aligned}
// \displaystyle \int \displaystyle \frac{\cos x}{1+\sin^2 x}\,dx
// =& \displaystyle \int \displaystyle \frac{du}{1+u^2}\\[5pt]
// =& \displaystyle \frac{1}{2\mathrm{i}}\log\!\left(\displaystyle \frac{1+\mathrm{i}u}{1-\mathrm{i}u}\right)+C\\[5pt]
// =& \displaystyle \frac{1}{2\mathrm{i}}\log\!\left(\displaystyle \frac{1+\mathrm{i}\,\sin x}{1-\mathrm{i}\,\sin x}\right)+C.
// \end{aligned}
// """
//       ),
//       StepItem(tex: r""" \textbf{【補足】}"""),
//       StepItem(
//         tex: r"""\begin{aligned}
// &\text{実関数で書けば}\;\displaystyle \int \displaystyle \frac{\cos x}{1+\sin^2 x}\,dx=\arctan(\sin x)+C.\\[5pt]
// \end{aligned}
// """
//       ),
//     ],
//   ),

  // 4) ∫_{0}^{π/2} dx / (1 + tan x)
//   MathProblem(
//     id: "8CD196F8-A54F-4A9A-93E7-8897C01ED59C",
//     no: 4,
//     category: '三角関数の分数式',
//     level: '上級',
//     question: r""" \displaystyle \int_{0}^{ \frac{\pi}{2}} \displaystyle \frac{dx}{1+\tan x}""",
//     answer: r""" \displaystyle \frac{\pi}{4}""",
//     imageAsset: 'assets/graphs/integral/problems_trig_fraction/problem_4.png',
//     steps: [
//       StepItem(tex: r""" \textbf{【方針】}"""),
//       StepItem(tex: r""" \text{置換}\;x\mapsto \displaystyle \frac{\pi}{2}-x\;\text{で同じ積分を作り、和をとって値を決める。}"""),
//       StepItem(tex: r""" \textbf{【ポイント】}"""),
//       StepItem(
//         tex: r"""\begin{aligned}
// &\tan\!\left(\displaystyle \frac{\pi}{2}-x\right)=\displaystyle \frac{1}{\tan x}\\[5pt]
// &\Rightarrow\;\displaystyle \frac{1}{1+\tan\!\left(\displaystyle \frac{\pi}{2}-x\right)}
// =\displaystyle \frac{1}{1+\displaystyle \frac{1}{\tan x}}
// =\displaystyle \frac{\tan x}{1+\tan x}.
// \end{aligned}
// """
//       ),
//       StepItem(tex: r""" \textbf{【解説】}"""),
//       StepItem(
//         tex: r"""\begin{aligned}
// I
// =& \displaystyle \int_{0}^{ \frac{\pi}{2}}\displaystyle \frac{dx}{1+\tan x}\\[5pt]
// =& \displaystyle \int_{0}^{ \frac{\pi}{2}}\displaystyle \frac{dx}{1+\tan\!\left(\displaystyle \frac{\pi}{2}-x\right)}\\[5pt]
// =& \displaystyle \int_{0}^{ \frac{\pi}{2}}\displaystyle \frac{\tan x}{1+\tan x}\,dx.\\[5pt]
// 2I
// =& \displaystyle \int_{0}^{ \frac{\pi}{2}}
// \left(\displaystyle \frac{1}{1+\tan x}+\displaystyle \frac{\tan x}{1+\tan x}\right)dx\\[5pt]
// =& \displaystyle \int_{0}^{ \frac{\pi}{2}}1\,dx\\[5pt]
// =& \displaystyle \frac{\pi}{2}.\\[5pt]
// I
// =& \displaystyle \frac{\pi}{4}.
// \end{aligned}
// """
//       ),
//       StepItem(tex: r""" \textbf{【補足】}"""),
//       StepItem(tex: r""" \text{部分分数や半角置換で直接計算することも可能だが、対称性を用いるのが最短である。}"""),
//     ],
//   ),

  // 5) ∫ dx / (sin x + cos x)
//   MathProblem(
//     id: "B840CE86-BC98-491C-9C1D-4AE2B5872CD3",
//     no: 5,
//     category: '三角関数の分数式',
//     level: '中級',
//     question: r""" \displaystyle \int \displaystyle \frac{dx}{\sin x + \cos x}""",
//     answer: r""" \displaystyle \frac{1}{\sqrt{2}}\,\log \!\left|\tan\!\left(\displaystyle \frac{x}{2}+\displaystyle \frac{\pi}{8}\right)\right| + C""",
//     imageAsset: 'assets/graphs/integral/problems_trig_fraction/problem_5.png',
//     steps: [
//       StepItem(tex: r""" \textbf{【方針】}"""),
//       StepItem(tex: r""" \text{和}\;\sin x+\cos x\;\text{を位相シフトで単一の正弦にし、基本積分へ帰着させる。}"""),
//       StepItem(tex: r""" \textbf{【ポイント】}"""),
//       StepItem(
//         tex: r"""\begin{aligned}
// &\sin x+\cos x=\sqrt{2}\,\sin\!\left(x+\displaystyle \frac{\pi}{4}\right)\\[5pt]
// &u=x+\displaystyle \frac{\pi}{4}\;\Rightarrow\;du=dx.
// \end{aligned}
// """
//       ),
//       StepItem(tex: r""" \textbf{【解説】}"""),
//       StepItem(
//         tex: r"""\begin{aligned}
// \displaystyle \int \displaystyle \frac{dx}{\sin x+\cos x}
// =& \displaystyle \int \displaystyle \frac{dx}{\sqrt{2}\,\sin\!\left(x+\displaystyle \frac{\pi}{4}\right)}\\[5pt]
// =& \displaystyle \frac{1}{\sqrt{2}}\displaystyle \int \displaystyle \frac{du}{\sin u}\\[5pt]
// =& \displaystyle \frac{1}{\sqrt{2}}\displaystyle \int \csc u\,du\;\text{ではなく、半角公式を使って}\\[5pt]
// =& \displaystyle \frac{1}{\sqrt{2}}\displaystyle \int \displaystyle \frac{du}{\sin u}\\[5pt]
// =& \displaystyle \frac{1}{\sqrt{2}}\,
// \log \!\left|\tan\!\left(\displaystyle \frac{u}{2}\right)\right|+C\\[5pt]
// =& \displaystyle \frac{1}{\sqrt{2}}\,
// \log \!\left|\tan\!\left(\displaystyle \frac{x}{2}+\displaystyle \frac{\pi}{8}\right)\right|+C.
// \end{aligned}
// """
//       ),
//       StepItem(tex: r""" \textbf{【補足】}"""),
//       StepItem(
//         tex: r"""\begin{aligned}
// &\text{半角置換}\;t=\tan\!\left(\displaystyle \frac{x}{2}\right),\;
// \sin x=\displaystyle \frac{2t}{1+t^2},\;dx=\displaystyle \frac{2\,dt}{1+t^2}\\[5pt]
// &\Rightarrow\;\displaystyle \int \displaystyle \frac{dx}{\sin x+\cos x}
// =\displaystyle \int \displaystyle \frac{\displaystyle \frac{2\,dt}{1+t^2}}{\displaystyle \frac{2t}{1+t^2}+\displaystyle \frac{1-t^2}{1+t^2}}\\[5pt]
// =& \displaystyle \int \displaystyle \frac{2\,dt}{1+t^2}\cdot\displaystyle \frac{1+t^2}{1+2t-t^2}\\[5pt]
// =& \displaystyle \int \displaystyle \frac{2\,dt}{1+2t-t^2}\\[5pt]
// =& -\displaystyle \frac{1}{\sqrt{2}}\,
// \log \!\left|\displaystyle \frac{t-1-\sqrt{2}}{t-1+\sqrt{2}}\right|+C\\[5pt]
// =& \displaystyle \frac{1}{\sqrt{2}}\,
// \log \!\left|\tan\!\left(\displaystyle \frac{x}{2}+\displaystyle \frac{\pi}{8}\right)\right|+C\;\text{に一致する。}
// \end{aligned}
// """
//       ),
//     ],
//   ),

  // 6) ∫_{π/12}^{π/6} dx / (5 sin x + 3)
//   MathProblem(
//     id: "D5531EC7-67F5-4A26-8EAC-8A686F066365",
//     no: 6,
//     category: '三角関数（半角置換）',
//     level: '上級',
//     question: r""" \displaystyle \int_{ \frac {\pi} {12}}^{ \frac {\pi} {6}}\displaystyle \frac{dx}{5\sin x+3}""",
//     answer: r"""\displaystyle \frac{1}{4}\log \!\left|
// \displaystyle \frac{\displaystyle \frac{\,2-\sqrt{3}+\displaystyle \frac{1}{3}\,}{\,2-\sqrt{3}+3\,}}
// {\displaystyle \frac{\,\displaystyle \frac{4-\sqrt{6}-\sqrt{2}}{\sqrt{6}-\sqrt{2}}+\displaystyle \frac{1}{3}\,}{\,\displaystyle \frac{4-\sqrt{6}-\sqrt{2}}{\sqrt{6}-\sqrt{2}}+3\,}}
// \right|
// """,
//     imageAsset: 'assets/graphs/integral/problems_trig_fraction/problem_6.png',
//     steps: [
//       StepItem(tex: r""" \textbf{【方針】}"""),
//       StepItem(tex: r""" \text{半角置換}\;t=\tan\!\left(\displaystyle \frac{x}{2}\right)\;\text{で有理式化し、部分分数分解後、上下限を}\;x\to t\;\text{へ写す。}"""),
//       StepItem(tex: r""" \textbf{【ポイント】}"""),
//       StepItem(
//         tex: r"""\begin{aligned}
// &\sin x=\displaystyle \frac{2t}{1+t^2},\quad dx=\displaystyle \frac{2\,dt}{1+t^2}.\\[5pt]
// &x=\displaystyle \frac{\pi}{6}\Rightarrow t=\tan\!\left(\displaystyle \frac{\pi}{12}\right)=2-\sqrt{3}.\\[5pt]
// &x=\displaystyle \frac{\pi}{12}\Rightarrow t=\tan\!\left(\displaystyle \frac{\pi}{24}\right)
// =\displaystyle \frac{1-\cos\!\left(\displaystyle \frac{\pi}{12}\right)}{\sin\!\left(\displaystyle \frac{\pi}{12}\right)}\\[5pt]
// &\qquad\qquad=\displaystyle \frac{1-\displaystyle \frac{\sqrt{6}+\sqrt{2}}{4}}{\displaystyle \frac{\sqrt{6}-\sqrt{2}}{4}}
// =\displaystyle \frac{4-\sqrt{6}-\sqrt{2}}{\sqrt{6}-\sqrt{2}}.
// \end{aligned}
// """
//       ),
//       StepItem(tex: r""" \textbf{【解説】}"""),
//       StepItem(
//         tex: r"""\begin{aligned}
// \displaystyle \int\displaystyle \frac{dx}{5\sin x+3}
// =& \displaystyle \int \displaystyle \frac{\displaystyle \frac{2\,dt}{1+t^2}}{5\cdot\displaystyle \frac{2t}{1+t^2}+3}\\[5pt]
// =& \displaystyle \int \displaystyle \frac{2\,dt}{10t+3(1+t^2)}\\[5pt]
// =& \displaystyle \int \displaystyle \frac{2\,dt}{3t^2+10t+3}.\\[5pt]
// 3t^2+10t+3
// =& 3\left(t+\displaystyle \frac{1}{3}\right)(t+3).\\[5pt]
// \displaystyle \frac{2}{3t^2+10t+3}
// =& \displaystyle \frac{2/3}{\left(t+\displaystyle \frac{1}{3}\right)(t+3)}\\[5pt]
// =& \displaystyle \frac{1}{4}\left(\displaystyle \frac{1}{t+\displaystyle \frac{1}{3}}-\displaystyle \frac{1}{t+3}\right)
// \quad\text{（係数確認済）}.\\[5pt]
// \displaystyle \int \displaystyle \frac{2\,dt}{3t^2+10t+3}
// =& \displaystyle \frac{1}{4}\displaystyle \int\left(\displaystyle \frac{1}{t+\displaystyle \frac{1}{3}}-\displaystyle \frac{1}{t+3}\right)dt\\[5pt]
// =& \displaystyle \frac{1}{4}\left(\log\left|t+\displaystyle \frac{1}{3}\right|-\log|t+3|\right)+C\\[5pt]
// =& \displaystyle \frac{1}{4}\log\left|\displaystyle \frac{t+\displaystyle \frac{1}{3}}{t+3}\right|+C.
// \end{aligned}
// """
//       ),
//       StepItem(tex: r""" \textbf{【解説（定積分の評価）】}"""),
//       StepItem(
//         tex: r"""\begin{aligned}
// \displaystyle \int_{ \frac{\pi}{12}}^{ \frac{\pi}{6}}\displaystyle \frac{dx}{5\sin x+3}
// =& \left[\displaystyle \frac{1}{4}\log\left|\displaystyle \frac{t+\displaystyle \frac{1}{3}}{t+3}\right|\right]_{\,t=\displaystyle \frac{4-\sqrt{6}-\sqrt{2}}{\sqrt{6}-\sqrt{2}}}^{\,t=\,2-\sqrt{3}}\\[5pt]
// =& \displaystyle \frac{1}{4}\log\left|
// \displaystyle \frac{\displaystyle \frac{\,2-\sqrt{3}+\displaystyle \frac{1}{3}\,}{\,2-\sqrt{3}+3\,}}
// {\displaystyle \frac{\,\displaystyle \frac{4-\sqrt{6}-\sqrt{2}}{\sqrt{6}-\sqrt{2}}+\displaystyle \frac{1}{3}\,}{\,\displaystyle \frac{4-\sqrt{6}-\sqrt{2}}{\sqrt{6}-\sqrt{2}}+3\,}}
// \right|.
// \end{aligned}
// """
//       ),
//       StepItem(tex: r""" \textbf{【補足】}"""),
//       StepItem(
//         tex: r"""\begin{aligned}
// &\tan\!\left(\displaystyle \frac{\pi}{12}\right)=2-\sqrt{3}\;\text{は有名値。}\\[5pt]
// &\tan\!\left(\displaystyle \frac{\pi}{24}\right)
// =\displaystyle \frac{1-\cos\!\left(\displaystyle \frac{\pi}{12}\right)}{\sin\!\left(\displaystyle \frac{\pi}{12}\right)}
// =\displaystyle \frac{4-\sqrt{6}-\sqrt{2}}{\sqrt{6}-\sqrt{2}}\;\text{と根号のみで表せる。}\\[5pt]
// &\text{上式は厳密値（定数）であり、小数化は不要。}
// \end{aligned}
// """
//       ),
//     ],
//   ),

  // 7) ∫_{π/6}^{π/2} 1/sin^4 x dx
//   MathProblem(
//     id: "994945E2-9216-4776-A0C1-8B83F5F86B6C",
//     no: 7,
//     category: '三角関数（置換）',
//     level: '上級',
//     question: r""" \displaystyle \int_{ \frac {\pi} {6}}^{ \frac {\pi} {2}}\displaystyle \frac{dx}{\sin^{4}x}""",
//     answer: r"""2\sqrt{3}""",
//     imageAsset: 'assets/graphs/integral/problems_trig_fraction/problem_7.png',
//     steps: [
//       StepItem(tex: r""" \textbf{【方針】}"""),
//       StepItem(tex: r""" \text{比}\;u=\dfrac{\cos x}{\sin x}\;\text{を置換変数に選び、被積分関数を}\;u\;\text{の多項式に変換する。}"""),
//       StepItem(tex: r""" \textbf{【ポイント】}"""),
//       StepItem(
//         tex: r"""\begin{aligned}
// &u=\displaystyle \frac{\cos x}{\sin x}\\[5pt]
// &\Rightarrow\;du=\displaystyle \frac{-\sin^2 x-\cos^2 x}{\sin^2 x}\,dx\\[5pt]
// &\Rightarrow\;du=-\displaystyle \frac{dx}{\sin^2 x}.\\[5pt]
// &\displaystyle \frac{1}{\sin^4 x}\,dx
// =\displaystyle \frac{1}{\sin^2 x}\cdot\displaystyle \frac{1}{\sin^2 x}\,dx\\[5pt]
// &\qquad=\left(1+u^2\right)\cdot(-du)\\[5pt]
// &\qquad=-(1+u^2)\,du.
// \end{aligned}
// """
//       ),
//       StepItem(tex: r""" \textbf{【解説】}"""),
//       StepItem(
//         tex: r"""\begin{aligned}
// I
// =& \displaystyle \int_{ \frac{\pi}{6}}^{ \frac{\pi}{2}}\displaystyle \frac{dx}{\sin^4 x}.\\[5pt]
// x=\displaystyle \frac{\pi}{6}
// &\Rightarrow u=\displaystyle \frac{\cos(\displaystyle \frac{\pi}{6})}{\sin(\displaystyle \frac{\pi}{6})}
// =\displaystyle \frac{\displaystyle \frac{\sqrt{3}}{2}}{\displaystyle \frac{1}{2}}=\sqrt{3}.\\[5pt]
// x=\displaystyle \frac{\pi}{2}
// &\Rightarrow u=\displaystyle \frac{\cos(\displaystyle \frac{\pi}{2})}{\sin(\displaystyle \frac{\pi}{2})}
// =\displaystyle \frac{0}{1}=0.\\[5pt]
// I
// =& \displaystyle \int_{x=\frac{\pi}{6}}^{x=\frac{\pi}{2}}\displaystyle \frac{dx}{\sin^4 x}\\[5pt]
// =& \displaystyle \int_{u=\sqrt{3}}^{u=0}-(1+u^2)\,du\\[5pt]
// =& \displaystyle \int_{0}^{\sqrt{3}}(1+u^2)\,du\\[5pt]
// =& \left[u+\displaystyle \frac{u^3}{3}\right]_{0}^{\sqrt{3}}\\[5pt]
// =& \left(\sqrt{3}+\displaystyle \frac{(\sqrt{3})^3}{3}\right)-0\\[5pt]
// =& \sqrt{3}+\displaystyle \frac{3\sqrt{3}}{3}\\[5pt]
// =& 2\sqrt{3}.
// \end{aligned}
// """
//       ),
//       StepItem(tex: r""" \textbf{【補足】}"""),
//       StepItem(tex: r""" \text{他の方法として、}\;\sin^2 x=\displaystyle \frac{1-\cos(2x)}{2}\;\text{でべき下げして有理式積分にしても良い。}"""),
//     ],
//   ),

  // 8) ∫_{π/6}^{π/2} 1/sin x dx
  MathProblem(
    id: "A1B2C3D4-E5F6-G7H8-I9J0-K1L2M3N4O5",
    no: 8,
    category: '三角関数の分数式',
    level: '中級',
    question: r"""\displaystyle \int_{\frac{\pi}{6}}^{\frac{\pi}{2}} \frac{dx}{\sin x}""",
    answer: r"""\log(2+\sqrt{3})""",
    imageAsset: 'assets/graphs/integral/problems_trig_fraction/problem_8.png',
    hint: r"""\text{分母分子に } \sin x \text{ をかけて、} u = \cos x \text{ と置換する。}""",
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{分母分子に } \sin x \text{ をかけて、} u = \cos x \text{ と置換する。}"""),
      StepItem(tex: r"""\textbf{【解説】}"""),
      StepItem(tex: r"""\text{分母分子に } \sin x \text{ をかけると、}"""),
      StepItem(tex: r"""\begin{aligned}
\int_{\frac{\pi}{6}}^{\frac{\pi}{2}} \frac{dx}{\sin x}
&= \int_{\frac{\pi}{6}}^{\frac{\pi}{2}} \frac{\sin x}{\sin^2 x} \, dx\\[5pt]
&= \textcolor{blue}{\int_{\frac{\pi}{6}}^{\frac{\pi}{2}} \frac{\sin x}{1-\cos^2 x} \, dx}
\end{aligned}"""),
      StepItem(tex: r"""\text{ } u = \cos x \text{ とおくと、} du = -\sin x \, dx \text{ であり、}"""),
      StepItem(tex: r"""\begin{aligned}
x = \frac{\pi}{6} &\Rightarrow u = \cos\frac{\pi}{6} = \frac{\sqrt{3}}{2}\\[5pt]
x = \frac{\pi}{2} &\Rightarrow u = \cos\frac{\pi}{2} = 0
\end{aligned}"""),
      StepItem(tex: r"""\begin{aligned}
&\ \ \ \ \ \textcolor{blue}{\int_{\frac{\pi}{6}}^{\frac{\pi}{2}} \frac{\sin x}{1-\cos^2 x} \, dx}\\[5pt]
&= \int_{u=\frac{\sqrt{3}}{2}}^{u=0} \frac{-du}{1-u^2}\\[5pt]
&= \int_{0}^{\frac{\sqrt{3}}{2}} \frac{du}{1-u^2}\\[5pt]
&= \int_{0}^{\frac{\sqrt{3}}{2}} \frac{1}{2}\left(\frac{1}{1-u} + \frac{1}{1+u}\right) du\\[5pt]
&= \frac{1}{2}\left[-\log|1-u| + \log|1+u|\right]_{0}^{\frac{\sqrt{3}}{2}}\\[5pt]
&= \frac{1}{2}\log\left|\frac{1+u}{1-u}\right|_{0}^{\frac{\sqrt{3}}{2}}\\[5pt]
&= \frac{1}{2}\log\left(\frac{1+\frac{\sqrt{3}}{2}}{1-\frac{\sqrt{3}}{2}}\right)\\[5pt]
&= \frac{1}{2}\log\left({\frac{2+\sqrt{3}}{2-\sqrt{3}}}\right)\\[5pt]
&= \frac{1}{2}\log\left(\frac{2+\sqrt{3}}{2-\sqrt{3}} \cdot \frac{2+\sqrt{3}}{2+\sqrt{3}}\right)\\[5pt]
&= \frac{1}{2}\log\left(\frac{(2+\sqrt{3})^2}{(2-\sqrt{3})(2+\sqrt{3})}\right)\\[5pt]
&= \frac{1}{2}\log\left(\frac{(2+\sqrt{3})^2}{4-3}\right)\\[5pt]
&= \frac{1}{2}\log\left((2+\sqrt{3})^2\right)\\[5pt]
&= \log(2+\sqrt{3})
\end{aligned}"""),
    ],
  ),

  // 9) ∫_{0}^{π/4} 1/cos x dx
  MathProblem(
    id: "B2C3D4E5-F6G7-H8I9-J0K1-L2M3N4O5P6",
    no: 9,
    category: '三角関数の分数式',
    level: '中級',
    question: r"""\displaystyle \int_{0}^{\frac{\pi}{4}} \frac{dx}{\cos x}""",
    answer: r"""\log(1+\sqrt{2})""",
    imageAsset: 'assets/graphs/integral/problems_trig_fraction/problem_9.png',
    hint: r"""\text{分母分子に } \cos x \text{ をかけて、} u = \sin x \text{ と置換する。}""",
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{分母分子に } \cos x \text{ をかけて、} u = \sin x \text{ と置換する。}"""),
      StepItem(tex: r"""\textbf{【解説】}"""),
      StepItem(tex: r"""\text{分母分子に } \cos x \text{ をかけると、}"""),
      StepItem(tex: r"""\begin{aligned}
\int_{0}^{\frac{\pi}{4}} \frac{dx}{\cos x}
&= \int_{0}^{\frac{\pi}{4}} \frac{\cos x}{\cos^2 x} \, dx\\[5pt]
&= \textcolor{blue}{\int_{0}^{\frac{\pi}{4}} \frac{\cos x}{1-\sin^2 x} \, dx}
\end{aligned}"""),
      StepItem(tex: r"""\text{ } u = \sin x \text{ とおくと、} du = \cos x \, dx \text{ であり、}"""),
      StepItem(tex: r"""\begin{aligned}
x = 0 &\Rightarrow u = \sin 0 = 0\\[5pt]
x = \frac{\pi}{4} &\Rightarrow u = \sin\frac{\pi}{4} = \frac{\sqrt{2}}{2}
\end{aligned}"""),
      StepItem(tex: r"""\begin{aligned}
&\ \ \ \ \ \textcolor{blue}{\int_{0}^{\frac{\pi}{4}} \frac{\cos x}{1-\sin^2 x} \, dx}\\[5pt]
&= \int_{u=0}^{u=\frac{\sqrt{2}}{2}} \frac{du}{1-u^2}\\[5pt]
&= \int_{0}^{\frac{\sqrt{2}}{2}} \frac{1}{2}\left(\frac{1}{1-u} + \frac{1}{1+u}\right) du\\[5pt]
&= \frac{1}{2}\left[-\log|1-u| + \log|1+u|\right]_{0}^{\frac{\sqrt{2}}{2}}\\[5pt]
&= \frac{1}{2}\log\left|\frac{1+u}{1-u}\right|_{0}^{\frac{\sqrt{2}}{2}}\\[5pt]
&= \frac{1}{2}\log\left(\frac{1+\frac{\sqrt{2}}{2}}{1-\frac{\sqrt{2}}{2}}\right)\\[5pt]
&= \frac{1}{2}\log\left({\frac{2+\sqrt{2}}{2-\sqrt{2}}}\right)\\[5pt]
&= \frac{1}{2}\log\left(\frac{2+\sqrt{2}}{2-\sqrt{2}} \cdot \frac{2+\sqrt{2}}{2+\sqrt{2}}\right)\\[5pt]
&= \frac{1}{2}\log\left(\frac{(2+\sqrt{2})^2}{(2-\sqrt{2})(2+\sqrt{2})}\right)\\[5pt]
&= \frac{1}{2}\log\left(\frac{(2+\sqrt{2})^2}{4-2}\right)\\[5pt]
&= \frac{1}{2}\log\left(\frac{(2+\sqrt{2})^2}{2}\right)\\[5pt]
&= \frac{1}{2}\log\left(\frac{6+4\sqrt{2}}{2}\right)\\[5pt]
&= \frac{1}{2}\log(3+2\sqrt{2})\\[5pt]
&= \frac{1}{2}\log\left((1+\sqrt{2})^2\right)\\[5pt]
&= \log(1+\sqrt{2})
\end{aligned}"""),
    ],
  ),

  // 11') ∫_{0}^{π/2} 1/(2 + sin x) dx — 有名角を使える例
  MathProblem(
    id: "F92FA824-A0AC-486A-95B7-C731A52DEEC9-variant",
    no: 11,
    category: '三角関数の分数式',
    level: '上級',
    question: r"""\displaystyle \int_{0}^{\frac{\pi}{2}} \frac{dx}{2 + \sin x}""",
    answer: r"""\displaystyle \frac{\pi}{3\sqrt{3}}""",
    imageAsset: 'assets/graphs/integral/problems_trig_fraction/problem_11_variant.png',
    hint: r"""\text{半角置換 } t = \tan\left(\frac{x}{2}\right) \text{ を用いる。}""",
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{半角置換 } \displaystyle t = \tan\left(\frac{x}{2}\right) \text{ を用いて三角関数を多項式の分数関数にする。}"""),
      StepItem(tex: r"""\textbf{【ポイント】}"""),
      StepItem(tex: r"""\begin{aligned}
&\textcolor{green}{\sin x = \frac{2t}{1+t^2}, \quad dx = \frac{2\,dt}{1+t^2}}\ \ \textcolor{green}{(補足参照)}\\[5pt]
&2 + \sin x = 2 + \frac{2t}{1+t^2} = \frac{2(1+t^2) + 2t}{1+t^2} = \frac{2(t^2+t+1)}{1+t^2}
\end{aligned}"""),
      StepItem(tex: r"""\textbf{【解説】}"""),
      StepItem(tex: r"""\begin{aligned}
x=0 &\Rightarrow t=\tan0=0,\\[5pt]
x=\frac{\pi}{2} &\Rightarrow t=\tan\frac{\pi}{4}=1.
\end{aligned}"""),
      StepItem(tex: r"""\begin{aligned}
\int_{0}^{\frac{\pi}{2}}\frac{dx}{2+\sin x}
&= \int_{t=0}^{t=1} \frac{1}{\frac{2(t^2+t+1)}{1+t^2}}\cdot\frac{2\,dt}{1+t^2}\\[6pt]
&= \int_{0}^{1} \frac{2\,dt}{2(t^2+t+1)}\\[6pt]
&= \int_{0}^{1} \frac{dt}{t^2+t+1}\\[6pt]
&= \int_{0}^{1} \frac{dt} {\left(t+\frac{1}{2}\right)^2 + \frac{3}{4}}\\[6pt]
&=\textcolor{blue}{\int_{0}^{1} \frac{dt}{\left(t+\frac{1}{2}\right)^2 + \left(\frac{\sqrt{3}}{2}\right)^2}}
\end{aligned}"""),
      StepItem(tex: r"""\text{ } t + \frac{1}{2} = \frac{\sqrt{3}}{2}\tan\theta \text{ とおくと、} dt = \frac{\sqrt{3}}{2}(1+\tan^2\theta) \, d\theta \text{ であり、}"""),
      StepItem(tex: r"""\begin{aligned}
t = 0 &\Rightarrow t + \frac{1}{2} = \frac{1}{2} \Rightarrow \frac{\sqrt{3}}{2}\tan\theta = \frac{1}{2} \Rightarrow \tan\theta = \frac{1}{\sqrt{3}} \Rightarrow \theta = \frac{\pi}{6}\\[5pt]
t = 1 &\Rightarrow t + \frac{1}{2} = \frac{3}{2} \Rightarrow \frac{\sqrt{3}}{2}\tan\theta = \frac{3}{2} \Rightarrow \tan\theta = \sqrt{3} \Rightarrow \theta = \frac{\pi}{3}
\end{aligned}"""),
      StepItem(tex: r"""\text{したがって、}"""),
      StepItem(tex: r"""\begin{aligned}
&=\textcolor{blue}{\int_{0}^{1} \frac{dt}{\left(t+\frac{1}{2}\right)^2 + \left(\frac{\sqrt{3}}{2}\right)^2}}\\[5pt]
&=\int_{\theta=\frac{\pi}{6}}^{\theta=\frac{\pi}{3}} \frac{\frac{\sqrt{3}}{2}(1+\tan^2\theta) \, d\theta}{\left(\frac{\sqrt{3}}{2}\tan\theta\right)^2 + \left(\frac{\sqrt{3}}{2}\right)^2}\\[5pt]
&= \int_{\theta=\frac{\pi}{6}}^{\theta=\frac{\pi}{3}} \frac{\frac{\sqrt{3}}{2}(1+\tan^2\theta) \, d\theta}{\left(\frac{\sqrt{3}}{2}\tan\theta\right)^2 + \left(\frac{\sqrt{3}}{2}\right)^2}\\[5pt]
&= \int_{\frac{\pi}{6}}^{\frac{\pi}{3}} \frac{\frac{\sqrt{3}}{2}(1+\tan^2\theta) \, d\theta}{\frac{3}{4}(\tan^2\theta + 1)}\\[5pt]
&= \int_{\frac{\pi}{6}}^{\frac{\pi}{3}} \frac{\frac{\sqrt{3}}{2}(1+\tan^2\theta) \, d\theta}{\frac{3}{4}(1+\tan^2\theta)}\\[5pt]
&= \int_{\frac{\pi}{6}}^{\frac{\pi}{3}} \frac{2}{\sqrt{3}} \, d\theta\\[5pt]
&= \frac{2}{\sqrt{3}}\left[\theta\right]_{\frac{\pi}{6}}^{\frac{\pi}{3}}\\[5pt]
&= \frac{2}{\sqrt{3}}\left(\frac{\pi}{3} - \frac{\pi}{6}\right)\\[5pt]
&= \frac{\pi}{3\sqrt{3}}
\end{aligned}"""),
      StepItem(tex: r"""\textbf{【補足】}"""),
      StepItem(tex: r"""\text{半角置換 } t = \tan\left(\frac{x}{2}\right) \text{ により、三角関数が } t \text{ の有理式で表せる。}"""),
      StepItem(tex: r"""\text{ } t = \tan\left(\frac{x}{2}\right) \text{ より、} \sin\left(\frac{x}{2}\right) = t\cos\left(\frac{x}{2}\right) \text{ である。}"""),
      StepItem(tex: r"""\text{また、} \sin^2\left(\frac{x}{2}\right) + \cos^2\left(\frac{x}{2}\right) = 1 \text{ より、}"""),
      StepItem(tex: r"""\begin{aligned}
&t^2\cos^2\left(\frac{x}{2}\right) + \cos^2\left(\frac{x}{2}\right) = 1\\[5pt]
&\cos^2\left(\frac{x}{2}\right)(1+t^2) = 1\\[5pt]
&\textcolor{green}{\cos\left(\frac{x}{2}\right) = \frac{1}{\sqrt{1+t^2}}}, \quad \textcolor{green}{\sin\left(\frac{x}{2}\right) = \frac{t}{\sqrt{1+t^2}}}
\end{aligned}"""),
      StepItem(tex: r"""\text{倍角の公式より、}"""),
      StepItem(tex: r"""\begin{aligned}
&\textcolor{green}{\sin x = 2\sin\left(\frac{x}{2}\right)\cos\left(\frac{x}{2}\right) = \frac{2t}{1+t^2}}
\end{aligned}"""),
      StepItem(tex: r"""\text{また、} t = \tan\left(\frac{x}{2}\right) \text{ を } x \text{ で微分すると、}"""),
      StepItem(tex: r"""\begin{aligned}
&t' = \left(\tan\left(\frac{x}{2}\right)\right)' = \frac{1}{\cos^2\left(\frac{x}{2}\right)} \cdot \frac{1}{2} = \frac{1+t^2}{2}\\[5pt]
&\textcolor{green}{dx = \frac{2}{1+t^2} \, dt}
\end{aligned}"""),
    ],
  ),

    // 12) ∫_{-π/6}^{π/6} 1/cos^3 x dx
  MathProblem(
    id: "B9B22B73-65CB-4AE7-A6BF-79E52EEDA3BC",
    no: 12,
    category: '三角関数の分数式',
    level: '上級',
    question: r"""\displaystyle \int_{-\frac{\pi}{6}}^{\frac{\pi}{6}} \frac{dx}{\cos^3 x}""",
    answer: r"""\displaystyle \frac{1}{2}\log 3 + \frac{2}{3}""",
    imageAsset: 'assets/graphs/integral/problems_trig_fraction/problem_12.png',
    hint: r"""\text{被積分関数は偶関数なので、} 2\int_{0}^{\frac{\pi}{6}} \frac{dx}{\cos^3 x} \text{ として計算する。}""",
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{被積分関数 }\displaystyle \frac{1}{\cos^3 x} \text{ は偶関数なので、}\displaystyle \int_{-\frac{\pi}{6}}^{\frac{\pi}{6}} \frac{dx}{\cos^3 x} = 2\int_{0}^{\frac{\pi}{6}} \frac{dx}{\cos^3 x} \text{ として計算する。}"""),
      StepItem(tex: r"""\textbf{【解説】}"""),
      StepItem(tex: r"""\begin{aligned}
&\ \ \ \ \ \int_{-\frac{\pi}{6}}^{\frac{\pi}{6}} \frac{dx}{\cos^3 x}\\[5pt]
&= 2\int_{0}^{\frac{\pi}{6}} \frac{dx}{\cos^3 x}\\[5pt]
&= 2\int_{0}^{\frac{\pi}{6}} \frac{\cos x}{\cos^4 x}dx\\[5pt]
&= 2\int_{0}^{\frac{\pi}{6}} \frac{\cos x}{(1-\sin^2 x)^2} \, dx
\end{aligned}"""),
      StepItem(tex: r"""u=\sin x\text{と置換すると、}"""),
      StepItem(tex: r"""\begin{aligned}

&= 2\int_{u=0}^{u=\sin\frac{\pi}{6}} \frac{du}{(1-u^2)^2}\\[5pt]
&= \textcolor{blue}{2\int_{0}^{\frac{1}{2}} \frac{du}{(1-u^2)^2}}\cdots \star
\end{aligned}"""),
      StepItem(tex: r"""\text{部分分数分解を行う。} \displaystyle \frac{1}{(1-u^2)^2} = \frac{1}{(1-u)^2(1+u)^2} \text{ より、}"""),
      StepItem(tex: r"""\begin{aligned}
& \ \ \ \ \ \frac{1}{(1-u^2)^2} \\[5pt]
&= \frac{A}{1-u} + \frac{B}{(1-u)^2} + \frac{C}{1+u} + \frac{D}{(1+u)^2}\\[5pt]
&= \frac{A(1-u)(1+u)^2 + B(1+u)^2 + C(1+u)(1-u)^2 + D(1-u)^2}{(1-u^2)^2}
\end{aligned}"""),
      StepItem(tex: r"""\text{分子を展開すると、} """),
      StepItem(tex: r"""\begin{aligned}
&\ \ \ \ \ A(1-u)(1+u)^2 + B(1+u)^2\\[5pt]
&\ \ \ \ \ \ \ \ \ \ + C(1+u)(1-u)^2 + D(1-u)^2\\[5pt]
&= A(1-u^2)(1+u) + B(1+2u+u^2)\\[5pt]
&\ \ \ \ \ \ \ \ \ \ + C(1-u^2)(1-u) + D(1-2u+u^2)\\[5pt]
&= A(1+u-u^2-u^3) + B(1+2u+u^2)\\[5pt]
&\ \ \ \ \ \ \ \ \ \ + C(1-u-u^2+u^3) + D(1-2u+u^2)\\[5pt]
&= (A+B+C+D) + (A+2B-C-2D)u \\[5pt]
&\ \ \ \ \ \ \ \ \ \ + (-A+B-C+D)u^2 + (-A+C)u^3
\end{aligned}"""),
      StepItem(tex: r"""\text{係数比較により、}"""),
      StepItem(tex: r"""
      \begin{aligned}&\ \ \ \ \ \begin{cases}
-A + C = 0\\
-A + B - C + D = 0\\
A + 2B - C - 2D = 0\\
A + B + C + D = 1
\end{cases} \\
&\Leftrightarrow 
\begin{cases}
A = \frac{1}{4}\\[6pt]
B = \frac{1}{4}\\[6pt]
C = \frac{1}{4}\\[6pt]
D = \frac{1}{4}
\end{cases} 
\end{aligned}"""),
      StepItem(tex: r"""\text{よって}\star \text{より、}"""),
      StepItem(tex: r"""\begin{aligned}
&\ \ \ \ \ \textcolor{blue}{2\int_{0}^{\frac{1}{2}} \frac{du}{(1-u^2)^2}}\\[5pt]
&= 2\int_{0}^{\frac{1}{2}} \left[\frac{1}{4(1-u)} + \frac{1}{4(1-u)^2} + \frac{1}{4(1+u)} + \frac{1}{4(1+u)^2}\right] du\\[5pt]
&= \frac{1}{2}\left[-\log|1-u| + \frac{1}{1-u} + \log|1+u| - \frac{1}{1+u}\right]_{0}^{\frac{1}{2}}\\[5pt]
&= \frac{1}{2}\left[\log\left|\frac{1+u}{1-u}\right| + \frac{2u}{1-u^2}\right]_{0}^{\frac{1}{2}}\\[5pt]
&= \frac{1}{2}\left[\log\left(\frac{1+\frac{1}{2}}{1-\frac{1}{2}}\right) + \frac{2 \cdot \frac{1}{2}}{1-\frac{1}{4}}\right]\\[5pt]
&= \frac{1}{2}\left[\log\left(\frac{\frac{3}{2}}{\frac{1}{2}}\right) + \frac{1}{\frac{3}{4}}\right]\\[5pt]
&= \frac{1}{2}\left[\log 3 + \frac{4}{3}\right]\\[5pt]
&= \frac{1}{2}\log 3 + \frac{2}{3}
\end{aligned}"""),
    ],
  ),

  // 13) ∫_{-π/12}^{π/12} 1/cos^2(3x) dx
  MathProblem(
    id: "C1D2E3F4-G5H6-I7J8-K9L0-M1N2O3P4Q5",
    no: 13,
    category: '三角関数の分数式',
    level: '中級',
    question: r"""\displaystyle \int_{-\frac{\pi}{12}}^{\frac{\pi}{12}} \frac{dx}{\cos^2(3x)}""",
    answer: r"""\displaystyle \frac{2}{3}""",
    imageAsset: 'assets/graphs/integral/problems_trig_fraction/problem_13.png',
    hint: r"""\text{置換 } u = 3x \text{ を用いて、基本積分 } \int \frac{1}{\cos^2 u} \, du = \tan u + C \text{ に帰着させる。}""",
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{置換 } u = 3x \text{ を用いて、基本積分 } \displaystyle \int \frac{1}{\cos^2 u} \, du = \tan u + C \text{ に帰着させる。}"""),
      StepItem(tex: r"""\textbf{【解説】}"""),
      StepItem(tex: r"""\text{ } u = 3x \text{ とおくと、} du = 3 \, dx \text{ であり、} \displaystyle dx = \frac{1}{3} \, du \text{ である。}"""),
      StepItem(tex: r"""\begin{aligned}
x = -\frac{\pi}{12} &\Rightarrow u = 3 \cdot \left(-\frac{\pi}{12}\right) = -\frac{\pi}{4}\\[5pt]
x = \frac{\pi}{12} &\Rightarrow u = 3 \cdot \frac{\pi}{12} = \frac{\pi}{4}
\end{aligned}"""),
      StepItem(tex: r"""\begin{aligned}
&\ \ \ \ \ \int_{-\frac{\pi}{12}}^{\frac{\pi}{12}} \frac{dx}{\cos^2(3x)}\\[5pt]
&= \int_{u=-\frac{\pi}{4}}^{u=\frac{\pi}{4}} \frac{1}{\cos^2 u} \cdot \frac{1}{3} \, du\\[5pt]
&= \frac{1}{3} \int_{-\frac{\pi}{4}}^{\frac{\pi}{4}} \frac{1}{\cos^2 u} \, du\\[5pt]
&= \frac{1}{3} \left[\tan u\right]_{-\frac{\pi}{4}}^{\frac{\pi}{4}}\\[5pt]
&= \frac{1}{3} \left(\tan\frac{\pi}{4} - \tan\left(-\frac{\pi}{4}\right)\right)\\[5pt]
&= \frac{1}{3} \left(1 - (-1)\right)\\[5pt]
&= \frac{1}{3} \cdot 2\\[5pt]
&= \frac{2}{3}
\end{aligned}"""),
    ],
  ),

];
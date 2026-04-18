import '../../models/math_problem.dart';
import '../../models/step_item.dart';

/// ============================================================================
/// 2次の無理式・平方根 12問
/// ============================================================================


const quadraticRadicalProblems = <MathProblem>[
  // 1. ∫√(x²+1) dx
//   MathProblem(
//     id: "C13B40D7-8559-43C1-8D36-0EBEA7E37F30",
//     no: 1,
//     category: '2次の無理式',
//     level: '上級',
//     question: r"""\displaystyle \int \sqrt{x^2+1}\,dx""",
//     answer: r"""\displaystyle \frac{x}{2}\sqrt{x^2+1} + \displaystyle \frac{1}{2}\log\!\left|x+\sqrt{x^2+1}\right| + C""",
//     imageAsset: 'assets/graphs/basic_definite_integral_areas/problem_1.png',
//     steps: [
//       StepItem(tex: r"""\textbf{【方針】}"""),
//       StepItem(tex: r"""\text{部分積分で }\;I=\displaystyle \int\sqrt{x^2+1}\,dx\;\text{ を自分自身に戻す形にし、 }\displaystyle \int\displaystyle \frac{dx}{\sqrt{x^2+1}}\text{ を既知形に帰着する。}"""),
//       StepItem(tex: r"""\textbf{【ポイント】}"""),
//       StepItem(tex: r"""\text{\(u=\sqrt{x^2+1},\;dv=dx\) の部分積分。さらに }x^2=(x^2+1)-1\text{ の分解を用いる。}"""),
//       StepItem(tex: r"""\textbf{【解説】}"""),
//       StepItem(
//         tex: r"""\begin{aligned}
// I
// &= \displaystyle \int 1\cdot\sqrt{x^2+1}\,dx\\
// &= x\sqrt{x^2+1} - \displaystyle \int x\cdot\displaystyle \frac{x}{\sqrt{x^2+1}}\,dx\\
// &= x\sqrt{x^2+1} - \displaystyle \int \displaystyle \frac{x^2}{\sqrt{x^2+1}}\,dx\\
// &= x\sqrt{x^2+1} - \displaystyle \int \displaystyle \frac{(x^2+1)-1}{\sqrt{x^2+1}}\,dx\\
// &= x\sqrt{x^2+1} - \displaystyle \int \sqrt{x^2+1}\,dx + \displaystyle \int \displaystyle \frac{dx}{\sqrt{x^2+1}}\\
// &= x\sqrt{x^2+1} - I + \displaystyle \int \displaystyle \frac{dx}{\sqrt{x^2+1}}\\
// 2I
// &= x\sqrt{x^2+1} + \displaystyle \int \displaystyle \frac{dx}{\sqrt{x^2+1}}\\
// I
// &= \displaystyle \frac{x}{2}\sqrt{x^2+1} + \displaystyle \frac{1}{2}\displaystyle \int \displaystyle \frac{dx}{\sqrt{x^2+1}}\\
// \displaystyle \int \displaystyle \frac{dx}{\sqrt{x^2+1}}
// &= \log\!\left|x+\sqrt{x^2+1}\right| + C\quad\text{(微分して確認)}\\
// I
// &= \displaystyle \frac{x}{2}\sqrt{x^2+1} + \displaystyle \frac{1}{2}\log\!\left|x+\sqrt{x^2+1}\right| + C
// \end{aligned}
// """,
//       ),
//     ],
//   ),

//   // 2. ∫_{-1}^{1} 1/√(1-x²) dx
//   MathProblem(
//     id: "295EB83A-31A6-4379-955A-58D4E7614320",
//     no: 2,
//     category: '2次の無理式',
//     level: '中級',
//     question: r"""\displaystyle \int_{-1}^{1} \displaystyle \frac{dx}{\sqrt{1-x^2}}""",
//     answer: r"""\pi""",
//     imageAsset: 'assets/graphs/basic_definite_integral_areas/problem_2.png',
//     steps: [
//       StepItem(tex: r"""\textbf{【方針】}"""),
//       StepItem(tex: r"""\text{三角置換 }x=\sin\theta\text{ により被積分関数が }1\text{ になるようにする。}"""),
//       StepItem(tex: r"""\textbf{【ポイント】}"""),
//       StepItem(tex: r"""\text{範囲変換 }
// \begin{aligned}
// \begin{cases}
// x=-1 \rightarrow x=1,\\
// \theta = -\displaystyle \frac{\pi}{2} \rightarrow \displaystyle \frac{\pi}{2}
// \end{cases}
// \end{aligned}
// \text{。かつ }\sqrt{1-\sin^2\theta}=|\cos\theta|=\cos\theta"""),
//       StepItem(tex: r"""\textbf{【解説】}"""),
//       StepItem(
//         tex: r"""\begin{aligned}
// \displaystyle \int_{-1}^{1}\displaystyle \frac{dx}{\sqrt{1-x^2}}
// &= \displaystyle \int_{-\frac{\pi}{2}}^{ \frac{\pi}{2}} \displaystyle \frac{\cos\theta}{\cos\theta}\,d\theta\\
// &= \displaystyle \int_{-\frac{\pi}{2}}^{ \frac{\pi}{2}} 1\,d\theta\\
// &= \left[\theta\right]_{-\displaystyle \frac{\pi}{2}}^{ \frac{\pi}{2}}\\
// &= \displaystyle \frac{\pi}{2} - \!\left(-\displaystyle \frac{\pi}{2}\right)\\
// &= \pi
// \end{aligned}
// """,
//       ),
//       StepItem(tex: r"""\textbf{【補足】}"""),
//       StepItem(tex: r"""\text{単位円の上半分の弧長（角度）としても }\pi\text{ と解釈できる。}"""),
//     ],
//   ),

  // 3. ∫√(x²+4x+5) dx
//   MathProblem(
//     id: "9BA403E8-04E8-48FC-9200-99FD6A2D7846",
//     no: 3,
//     category: '2次の無理式',
//     level: '上級',
//     question: r"""\displaystyle \int \sqrt{x^2+4x+5}\,dx""",
//     answer: r"""\displaystyle \frac{x+2}{2}\sqrt{(x+2)^2+1} + \displaystyle \frac{1}{2}\log\!\left|x+2+\sqrt{(x+2)^2+1}\right| + C""",
//     imageAsset: 'assets/graphs/basic_definite_integral_areas/problem_3.png',
//     steps: [
//       StepItem(tex: r"""\textbf{【方針】}"""),
//       StepItem(tex: r"""\text{平方完成して }u=x+2\text{ と置換し、問題1の結果を適用する。}"""),
//       StepItem(tex: r"""\textbf{【ポイント】}"""),
//       StepItem(tex: r"""\text{ }x^2+4x+5=(x+2)^2+1\text{ より、 }\displaystyle \int\sqrt{u^2+1}\,du\text{ の形に一致する。}"""),
//       StepItem(tex: r"""\textbf{【解説】}"""),
//       StepItem(
//         tex: r"""\begin{aligned}
// \displaystyle \int \sqrt{x^2+4x+5}\,dx
// &= \displaystyle \int \sqrt{(x+2)^2+1}\,dx\\
// &\xrightarrow{\,u=x+2\,} \displaystyle \int \sqrt{u^2+1}\,du\\
// &= \displaystyle \frac{u}{2}\sqrt{u^2+1} + \displaystyle \frac{1}{2}\log\!\right|u+\sqrt{u^2+1}\right| + C\\
// &= \displaystyle \frac{x+2}{2}\sqrt{(x+2)^2+1} + \displaystyle \frac{1}{2}\log\!\left|x+2+\sqrt{(x+2)^2+1}\right| + C
// \end{aligned}
// """,
//       ),
//       StepItem(tex: r"""\textbf{【補足】}"""),
//       StepItem(tex: r"""\text{より一般に }\displaystyle \int\sqrt{(x+b)^2+c^2}\,dx\text{ は問題1の式に }x\mapsto x+b,\;1\mapsto c\text{ を施せばよい。}"""),
//     ],
//   ),

  // 4. ∫ x²/√(x²+1) dx
//   MathProblem(
//     id: "CEC675CF-86F7-4027-B139-DB88DD3D662F",
//     no: 4,
//     category: '2次の無理式',
//     level: '上級',
//     question: r"""\displaystyle \int \displaystyle \frac{x^2}{\sqrt{x^2+1}}\,dx""",
//     answer: r"""\displaystyle \frac{1}{2}x\sqrt{x^2+1} - \displaystyle \frac{1}{2}\log\!\left|x+\sqrt{x^2+1}\right| + C""",
//     imageAsset: 'assets/graphs/basic_definite_integral_areas/problem_4.png',
//     steps: [
//       StepItem(tex: r"""\textbf{【方針】}"""),
//       StepItem(tex: r"""\text{ }x^2=(x^2+1)-1\text{ と分解して、 }\displaystyle \int\sqrt{x^2+1}\,dx\text{ と }\displaystyle \int\displaystyle \frac{dx}{\sqrt{x^2+1}}\text{ に分ける。}"""),
//       StepItem(tex: r"""\textbf{【ポイント】}"""),
//       StepItem(tex: r"""\text{ }\displaystyle \int\sqrt{x^2+1}\,dx\text{ は問題1、 }\displaystyle \int\displaystyle \frac{dx}{\sqrt{x^2+1}}\text{ は }\log\!\left|x+\sqrt{x^2+1}\right|\text{。}"""),
//       StepItem(tex: r"""\textbf{【解説】}"""),
//       StepItem(
//         tex: r"""\begin{aligned}
// \displaystyle \int \displaystyle \frac{x^2}{\sqrt{x^2+1}}\,dx
// &= \displaystyle \int \displaystyle \frac{(x^2+1)-1}{\sqrt{x^2+1}}\,dx\\
// &= \displaystyle \int \sqrt{x^2+1}\,dx - \displaystyle \int \displaystyle \frac{dx}{\sqrt{x^2+1}}\\
// &= \left(\displaystyle \frac{x}{2}\sqrt{x^2+1} + \displaystyle \frac{1}{2}\log\!\left|x+\sqrt{x^2+1}\right|\right) - \log\!\left|x+\sqrt{x^2+1}\right| + C\\
// &= \displaystyle \frac{1}{2}x\sqrt{x^2+1} - \displaystyle \frac{1}{2}\log\!\left|x+\sqrt{x^2+1}\right| + C
// \end{aligned}
// """,
//       ),
//       StepItem(tex: r"""\textbf{【補足】}"""),
//       StepItem(tex: r"""\text{ }\displaystyle \int\displaystyle \frac{dx}{\sqrt{x^2+1}}=\log\!\left|x+\sqrt{x^2+1}\right|+C\text{ は、微分確認で容易に確かめられる。}"""),
//     ],
//   ),

  // 5. ∫ 1/√(x² - a²) dx   (x > a > 0)
//   MathProblem(
//     id: "733CD527-888E-479D-B4D1-1AD5AB48856E",
//     no: 5,
//     category: '2次の無理式',
//     level: '中級',
//     question: r"""\displaystyle \int \displaystyle \frac{dx}{\sqrt{x^2 - a^2}}\quad (x>a>0)""",
//     answer: r"""\displaystyle \log\!\left|x + \sqrt{x^2 - a^2}\right| + C""",
//     imageAsset: 'assets/graphs/basic_definite_integral_areas/problem_5.png',
//     steps: [
//       StepItem(tex: r"""\textbf{【方針】}"""),
//       StepItem(tex: r"""\text{原始関数候補 }F(x)=\log\!\left|x+\sqrt{x^2-a^2}\right|\text{ を立て、微分して確認する。}"""),
//       StepItem(tex: r"""\textbf{【ポイント】}"""),
//       StepItem(tex: r"""\text{合成関数の微分と有理化 } \displaystyle \frac{d}{dx}\sqrt{x^2-a^2}=\displaystyle \frac{x}{\sqrt{x^2-a^2}},\;
// \displaystyle \frac{1}{x+\sqrt{\cdot}}\text{ の形に注意。}"""),
//       StepItem(tex: r"""\textbf{【解説】}"""),
//       StepItem(
//         tex: r"""\begin{aligned}
// F(x)
// &= \log\!\left|x+\sqrt{x^2-a^2}\right|\\
// F'(x)
// &= \displaystyle \frac{1}{x+\sqrt{x^2-a^2}}\left(1+\displaystyle \frac{x}{\sqrt{x^2-a^2}}\right)\\
// &= \displaystyle \frac{\sqrt{x^2-a^2}+x}{\left(x+\sqrt{x^2-a^2}\right)\sqrt{x^2-a^2}}\\
// &= \displaystyle \frac{1}{\sqrt{x^2-a^2}}\\
// \displaystyle \int \displaystyle \frac{dx}{\sqrt{x^2-a^2}}
// &= \log\!\left|x+\sqrt{x^2-a^2}\right| + C
// \end{aligned}
// """,
//       ),
//     ],
//   ),

  // 7. ∫_{-1}^{1} 1/[(x²+2)√(x²+2)] dx
// 7) tan置換による解法
// MathProblem(
//   id: "649EB9D0-FDDB-410A-AC5B-A756A35E2D58",
//   no: 7,
//   category: '平方根（積分公式）',
//   level: '中級',
//   question: r"""\displaystyle \int_{-1}^{1}\displaystyle \frac{dx}{(x^2+2)\sqrt{x^2+2}}""",
//   answer: r"""\displaystyle \frac{1}{\sqrt{3}}""",
//   imageAsset: 'assets/graphs/basic_definite_integral_areas/problem_7.png',
//   steps: [
//     StepItem(tex: r"""\textbf{【方針】}"""),
//     StepItem(tex: r"""\; \text{平方根項が }x^2+2\text{ の形なので }x=\sqrt{2}\tan\theta\text{ の置換を行う。}"""),
//     StepItem(tex: r"""\textbf{【置換】}"""),
//     StepItem(tex: r"""\; x=\sqrt{2}\tan\theta\quad\Rightarrow\quad dx=\sqrt{2}\sec^2\theta\,d\theta."""),
//     StepItem(tex: r"""\; x^2+2=2\tan^2\theta+2=2\sec^2\theta,\quad \sqrt{x^2+2}=\sqrt{2}\,\sec\theta."""),
//     StepItem(tex: r"""\textbf{【被積分関数の変形】}"""),
//     StepItem(tex: r"""\begin{aligned}
// \displaystyle \frac{dx}{(x^2+2)\sqrt{x^2+2}}
// &=\displaystyle \frac{\sqrt{2}\sec^2\theta\,d\theta}{(2\sec^2\theta)(\sqrt{2}\sec\theta)}\\[4pt]
// &=\displaystyle \frac{\sec^2\theta}{2\sec^3\theta}\,d\theta
// =\displaystyle \frac{1}{2}\cos\theta\,d\theta.
// \end{aligned}"""),
//     StepItem(tex: r"""\textbf{【積分区間】}"""),
//     StepItem(tex: r"""\; x= \pm 1 \Longrightarrow \theta=\arctan\!\left(\pm\frac{1}{\sqrt{2}}\right)
// =\pm \arctan\!\left(\frac{1}{\sqrt{2}}\right)."""),
//     StepItem(tex: r"""\textbf{【積分】}"""),
//     StepItem(tex: r"""\begin{aligned}
// \displaystyle \int_{-1}^{1}\displaystyle \frac{dx}{(x^2+2)\sqrt{x^2+2}}
// &=\displaystyle \int_{-\arctan(1/\sqrt{2})}^{\arctan(1/\sqrt{2})}\frac{1}{2}\cos\theta\,d\theta\\[4pt]
// &=\displaystyle \frac{1}{2}\cdot 2\int_{0}^{\arctan(1/\sqrt{2})}\cos\theta\,d\theta
// =\int_{0}^{\arctan(1/\sqrt{2})}\cos\theta\,d\theta\\[4pt]
// &=\sin\theta\Big|_{0}^{\arctan(1/\sqrt{2})}
// =\sin\!\bigl(\arctan(1/\sqrt{2})\bigr).
// \end{aligned}"""),
//     StepItem(tex: r"""\textbf{【三角比の計算】}"""),
//     StepItem(tex: r"""\; \text{角 } \alpha=\arctan(1/\sqrt{2}) \text{ とおくと } \tan\alpha=1/\sqrt{2}。\text{ よって } 
// \sin\alpha=\dfrac{\tan\alpha}{\sqrt{1+\tan^2\alpha}}=\dfrac{1/\sqrt{2}}{\sqrt{1+1/2}}=\dfrac{1}{\sqrt{3}}. """),
//     StepItem(tex: r"""\textbf{【結論】}"""),
//     StepItem(tex: r"""\displaystyle \int_{-1}^{1}\displaystyle \frac{dx}{(x^2+2)\sqrt{x^2+2}}=\displaystyle \frac{1}{\sqrt{3}}."""),
//     StepItem(tex: r"""\textbf{【補足】}"""),
//     StepItem(tex: r"""\; \text{被積分関数は偶関数なので }2\int_{0}^{1}\cdots\text{ としてもよい。別解として原始関数公式 }
// \int \dfrac{dx}{(x^2+a^2)^{3/2}}=\dfrac{x}{a^2\sqrt{x^2+a^2}}+C
// \text{ を用いても同じ値が得られる。}"""),
//   ],
// ),

  // 8. ∫_{1}^{a/2} √(a² - x²) dx  （a≥2）
//   MathProblem(
//     id: "897CD524-5BB7-47CB-BF28-E3E68E133F32",
//     no: 8,
//     category: '平方根（円弧）',
//     level: '中級',
//     question: r"""\displaystyle \int_{1}^{a/2}\sqrt{a^{2}-x^{2}}\,dx\quad(a\ge 2)""",
//     answer: r"""\displaystyle \frac{a^{2}\sqrt{3}}{8} - \displaystyle \frac{1}{2}\sqrt{a^{2}-1} + \displaystyle \frac{a^{2}}{2}\left(\displaystyle \frac{\pi}{6}-\arcsin\displaystyle \frac{1}{a}\right)""",
//     imageAsset: 'assets/graphs/basic_definite_integral_areas/problem_8.png',
//     steps: [
//       StepItem(tex: r"""\textbf{【方針】}"""),
//       StepItem(tex: r"""\text{三角置換 }x=a\sin\theta\;(0\le\theta\le\displaystyle \frac{\pi}{2})\text{ を用いて、 }\cos^2\theta\text{ の積分に帰着する。}"""),
//       StepItem(tex: r"""\textbf{【ポイント】}"""),
//       StepItem(
//         tex: r"""\text{範囲変換 }
// \begin{aligned}
// \begin{cases}
// x=1 \rightarrow \theta=\arcsin\!\displaystyle \frac{1}{a},\\
// x=\displaystyle \frac{a}{2} \rightarrow \theta=\arcsin\!\displaystyle \frac{1}{2}=\displaystyle \frac{\pi}{6}
// \end{cases}
// \end{aligned}
// \text{。}"""
//       ),
//       StepItem(tex: r"""\textbf{【解説】}"""),
//       StepItem(
//         tex: r"""\begin{aligned}
// I
// &= \displaystyle \int_{1}^{ \frac{a}{2}}\sqrt{a^2-x^2}\,dx\\
// &\xrightarrow{\,x=a\sin\theta\,} \displaystyle \int_{\theta=\arcsin(1/a)}^{\theta=\pi/6} \sqrt{a^2-a^2\sin^2\theta}\,a\cos\theta\,d\theta\\
// &= \displaystyle \int_{\arcsin(1/a)}^{\pi/6} a\cos\theta\cdot a\cos\theta\,d\theta\\
// &= a^2\displaystyle \int_{\arcsin(1/a)}^{\pi/6}\cos^2\theta\,d\theta\\
// &= a^2\displaystyle \int_{\arcsin(1/a)}^{\pi/6}\displaystyle \frac{1+\cos 2\theta}{2}\,d\theta\\
// &= \displaystyle \frac{a^2}{2}\left[\theta+\displaystyle \frac{\sin 2\theta}{2}\right]_{\theta=\arcsin(1/a)}^{\theta=\pi/6}\\
// &= \displaystyle \frac{a^2}{2}\left(\displaystyle \frac{\pi}{6}-\arcsin\!\displaystyle \frac{1}{a}\right)
//    + \displaystyle \frac{a^2}{2}\left(\displaystyle \frac{\sin(\pi/3)}{2} - \displaystyle \frac{\sin\left(2\arcsin(1/a)\right)}{2}\right)\\
// &= \displaystyle \frac{a^2}{2}\left(\displaystyle \frac{\pi}{6}-\arcsin\!\displaystyle \frac{1}{a}\right)
//    + \displaystyle \frac{a^2\sqrt{3}}{8} - \displaystyle \frac{a^2}{2}\cdot \displaystyle \frac{1}{a}\cdot \displaystyle \frac{\sqrt{a^2-1}}{a}\\
// &= \displaystyle \frac{a^{2}\sqrt{3}}{8} - \displaystyle \frac{1}{2}\sqrt{a^{2}-1}
//    + \displaystyle \frac{a^{2}}{2}\left(\displaystyle \frac{\pi}{6}-\arcsin\!\displaystyle \frac{1}{a}\right)
// \end{aligned}
// """,
//       ),
//       StepItem(tex: r"""\textbf{【補足】}"""),
//       StepItem(
//         tex: r"""\text{ }\arcsin\!\displaystyle \frac{1}{a}=\arctan\!\displaystyle \frac{1}{\sqrt{a^2-1}}\text{（ }a\ge 1\text{）も成り立つ。逆三角関数を用いない別表現は一般には困難である。}"""
//       ),
//     ],
//   ),

  // 9. ∫_{0}^{1} 1/√(x²+1) dx
//   MathProblem(
//     id: "A28E4B29-0D6F-4B4D-8C13-343682C251A1",
//     no: 9,
//     category: '平方根（ログ表示）',
//     level: '中級',
//     question: r"""\displaystyle \int_{0}^{1}\displaystyle \frac{dx}{\sqrt{x^{2}+1}}""",
//     answer: r"""\displaystyle \log\!\left(1+\sqrt{2}\right)""",
//     imageAsset: 'assets/graphs/basic_definite_integral_areas/problem_9.png',
//     steps: [
//       StepItem(tex: r"""\textbf{【方針】}"""),
//       StepItem(tex: r"""\text{不定積分 } \displaystyle \int \displaystyle \frac{dx}{\sqrt{x^2+1}}=\log\!\left|x+\sqrt{x^2+1}\right|+C \text{ を用いて定積分を評価する。}"""),
//       StepItem(tex: r"""\textbf{【ポイント】}"""),
//       StepItem(tex: r"""\text{原始関数の微分確認 }\displaystyle \frac{d}{dx}\log\!\left(x+\sqrt{x^2+1}\right)=\displaystyle \frac{1}{\sqrt{x^2+1}}\text{。}"""),
//       StepItem(tex: r"""\textbf{【解説】}"""),
//       StepItem(
//         tex: r"""\begin{aligned}
// \displaystyle \int_{0}^{1}\displaystyle \frac{dx}{\sqrt{x^{2}+1}}
// &= \left[\log\!\left(x+\sqrt{x^2+1}\right)\right]_{0}^{1}\\
// &= \log\!\left(1+\sqrt{2}\right) - \log\!\left(0+\sqrt{0^2+1}\right)\\
// &= \log\!\left(1+\sqrt{2}\right)
// \end{aligned}
// """,
//       ),
//     ],
//   ),

  // 10. ∫_{0}^{1} 1/(x+√(x²+1)) dx
//   MathProblem(
//     id: "B7FBE400-DE79-4365-AD89-A544F45A8170",
//     no: 10,
//     category: '有理化（代数的簡約）',
//     level: '中級',
//     question: r"""\displaystyle \int_{0}^{1}\displaystyle \frac{dx}{x+\sqrt{x^{2}+1}}""",
//     answer: r"""\displaystyle \frac{\sqrt{2}}{2} + \displaystyle \frac{1}{2}\log\!\left(1+\sqrt{2}\right) - \displaystyle \frac{1}{2}""",
//     imageAsset: 'assets/graphs/basic_definite_integral_areas/problem_10.png',
//     steps: [
//       StepItem(tex: r"""\textbf{【方針】}"""),
//       StepItem(tex: r"""\text{分母を有理化し、} \displaystyle \frac{1}{x+\sqrt{x^2+1}}=\sqrt{x^2+1}-x \text{に変形してから積分する。}"""),
//       StepItem(tex: r"""\textbf{【ポイント】}"""),
//       StepItem(
//         tex: r"""\text{有理化の確認}\displaystyle \frac{1}{x+\sqrt{x^2+1}}\cdot\displaystyle \frac{\sqrt{x^2+1}-x}{\sqrt{x^2+1}-x}
// =\displaystyle \frac{\sqrt{x^2+1}-x}{(x+\sqrt{x^2+1})(\sqrt{x^2+1}-x)}=\sqrt{x^2+1}-x"""
//       ),
//       StepItem(tex: r"""\textbf{【解説】}"""),
//       StepItem(
//         tex: r"""\begin{aligned}
// \displaystyle \int_{0}^{1}\displaystyle \frac{dx}{x+\sqrt{x^{2}+1}}
// &= \displaystyle \int_{0}^{1}\left(\sqrt{x^2+1}-x\right)\,dx\\
// &= \left[\displaystyle \frac{x}{2}\sqrt{x^2+1} + \displaystyle \frac{1}{2}\log\!\left(x+\sqrt{x^2+1}\right)\right]_{0}^{1}
//    - \left[\displaystyle \frac{x^2}{2}\right]_{0}^{1}\\
// &= \left(\displaystyle \frac{1}{2}\sqrt{2} + \displaystyle \frac{1}{2}\log\!\left(1+\sqrt{2}\right)\right)
//    - \left(0 + \displaystyle \frac{1}{2}\log 1\right) - \displaystyle \frac{1}{2}\\
// &= \displaystyle \frac{\sqrt{2}}{2} + \displaystyle \frac{1}{2}\log\!\left(1+\sqrt{2}\right) - \displaystyle \frac{1}{2}
// \end{aligned}
// """,
//       ),
//       StepItem(tex: r"""\textbf{【補足】}"""),
//       StepItem(tex: r"""\text{被積分関数は }0\le x\le 1\text{ で正、したがって結果も正になる（数値的に }\fallingdotseq 0.648\text{）。}"""),
//     ],
//   ),

  // 11. ∫_{0}^{3} 1/√(x²+9) dx
  MathProblem(
    id: "D36E79F5-FF3C-442A-8A3A-DE453F25EA60",
    no: 11,
    category: '2次の無理式',
    level: '中級',
    question: r"""\displaystyle \int_{0}^{3} \frac{dx}{\sqrt{x^2+9}}""",
    answer: r"""\log(1+\sqrt{2})""",
    imageAsset: 'assets/graphs/integral/problems_quadratic_radical/problem_11.png',
    hint: r"""\text{三角置換 } x = 3\tan\theta \text{ を用いる。}""",
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{三角置換 } x = 3\tan\theta \text{ を用いて、被積分関数を簡略化する。}"""),
      StepItem(tex: r"""\textbf{【解説】}"""),
      StepItem(tex: r"""\text{ } x = 3\tan\theta \text{ とおくと、}"""),
      StepItem(tex: r"""\begin{aligned}
x = 0 &\Rightarrow 0 = 3\tan\theta \Rightarrow \theta = 0\\[5pt]
x = 3 &\Rightarrow 3 = 3\tan\theta \Rightarrow \tan\theta = 1 \Rightarrow \theta = \frac{\pi}{4}
\end{aligned}"""),
      StepItem(tex: r"""\text{また、}"""),
      StepItem(tex: r"""\begin{aligned}\begin{cases}
dx = 3(\tan\theta)' \, d\theta = 3 \cdot \frac{1}{\cos^2\theta} \, d\theta = 3(1+\tan^2\theta) \, d\theta\\[5pt]
\sqrt{x^2+9} = 3\sqrt{1+\tan^2\theta}
\end{cases}\end{aligned}"""),
StepItem(tex: r"""\text{であるので}"""),
      StepItem(tex: r"""\begin{aligned}
\int_{0}^{3} \frac{dx}{\sqrt{x^2+9}}
&= \int_{\theta=0}^{\theta=\frac{\pi}{4}} \frac{3(1+\tan^2\theta)\,d\theta}{3\sqrt{1+\tan^2\theta}}\\[5pt]
&= \int_{0}^{\frac{\pi}{4}} \frac{1+\tan^2\theta}{\sqrt{1+\tan^2\theta}} \, d\theta\\[5pt]
&= \int_{0}^{\frac{\pi}{4}} \sqrt{1+\tan^2\theta} \, d\theta\\[5pt]
&= \int_{0}^{\frac{\pi}{4}} \frac{1}{\cos\theta} \, d\theta\\[5pt]
&= \int_{0}^{\frac{\pi}{4}} \frac{\cos\theta}{\cos^2\theta} \, d\theta\\[5pt]
&= \textcolor{blue}{\int_{0}^{\frac{\pi}{4}} \frac{\cos\theta}{1-\sin^2\theta} \, d\theta}
\end{aligned}"""),
      StepItem(tex: r"""\text{ } u = \sin\theta \text{ とおくと、} du = \cos\theta \, d\theta \text{ であり、}"""),
      StepItem(tex: r"""\begin{aligned}
\theta = 0 &\Rightarrow u = 0\\[5pt]
\theta = \frac{\pi}{4} &\Rightarrow u = \frac{\sqrt{2}}{2}
\end{aligned}"""),
      StepItem(tex: r"""\begin{aligned}
 &\ \ \ \ \ \textcolor{blue}{\int_{0}^{\frac{\pi}{4}} \frac{\cos\theta}{1-\sin^2\theta} \, d\theta}\\[5pt]
&= \int_{0}^{\frac{\sqrt{2}}{2}} \frac{du}{1-u^2}\\[5pt]
&= \int_{0}^{\frac{\sqrt{2}}{2}} \frac{1}{2}\left(\frac{1}{1-u} + \frac{1}{1+u}\right) du\\[5pt]
&= \frac{1}{2}\left[-\log|1-u| + \log|1+u|\right]_{0}^{\frac{\sqrt{2}}{2}}\\[5pt]
&= \frac{1}{2}\log\left|\frac{1+u}{1-u}\right|_{0}^{\frac{\sqrt{2}}{2}}\\[5pt]
&= \frac{1}{2}\log\left(\frac{1+\frac{\sqrt{2}}{2}}{1-\frac{\sqrt{2}}{2}}\right)\\[5pt]
&= \frac{1}{2}\log\left(\frac{2+\sqrt{2}}{2-\sqrt{2}}\right)\\[5pt]
&= \frac{1}{2}\log\left(\frac{(2+\sqrt{2})^2}{4-2}\right)\\[5pt]
&= \frac{1}{2}\log\left(\frac{6+4\sqrt{2}}{2}\right)\\[5pt]
&= \frac{1}{2}\log(3+2\sqrt{2})\\[5pt]
&= \frac{1}{2} \log\left(\left(1+\sqrt{2}\right)^2\right)\\[5pt]
&=\log(1+\sqrt{2})
\end{aligned}"""),
    ],
  ),

  // 12. ∫_{0}^{2} 1/(4+x²)^(3/2) dx
  MathProblem(
    id: "14D0F717-BEC3-49D9-98CF-F56C33CB6B3B",
    no: 12,
    category: '2次の無理式',
    level: '中級',
    question: r"""\displaystyle \int_{0}^{2} \frac{dx}{(4+x^2)^{\frac{3}{2}}}""",
    answer: r"""\displaystyle \frac{\sqrt{2}}{8}""",
    imageAsset: 'assets/graphs/integral/problems_quadratic_radical/problem_12.png',
    hint: r"""\text{三角置換 } x = 2\tan\theta \text{ を用いる。}""",
    steps: [
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{三角置換 } x = 2\tan\theta \text{ を用いて、被積分関数を簡略化する。}"""),
      StepItem(tex: r"""\textbf{【解説】}"""),
      StepItem(tex: r"""\text{ } x = 2\tan\theta \text{ とおくと、}"""),
      StepItem(tex: r"""\begin{aligned}
x = 0 &\Rightarrow 0 = 2\tan\theta \Rightarrow \theta = 0\\[5pt]
x = 2 &\Rightarrow 2 = 2\tan\theta \Rightarrow \tan\theta = 1 \Rightarrow \theta = \frac{\pi}{4}
\end{aligned}"""),
      StepItem(tex: r"""\text{また、}"""),
      StepItem(tex: r"""\begin{aligned}\begin{cases}
dx = 2(\tan\theta)' \, d\theta = 2 \cdot \frac{1}{\cos^2\theta} \, d\theta = 2(1+\tan^2\theta) \, d\theta\\[5pt]
(4+x^2)^{\frac{3}{2}} = [4(1+\tan^2\theta)]^{\frac{3}{2}} = 8(1+\tan^2\theta)^{\frac{3}{2}}
\end{cases}\end{aligned}"""),
      StepItem(tex: r"""\text{したがって、}"""),
      StepItem(tex: r"""\begin{aligned}
\int_{0}^{2} \frac{dx}{(4+x^2)^{\frac{3}{2}}}
&= \int_{\theta=0}^{\theta=\frac{\pi}{4}} \frac{2(1+\tan^2\theta)\,d\theta}{8(1+\tan^2\theta)^{\frac{3}{2}}}\\[5pt]
&= \int_{0}^{\frac{\pi}{4}} \frac{1+\tan^2\theta}{4(1+\tan^2\theta)^{\frac{3}{2}}} \, d\theta\\[5pt]
&= \frac{1}{4}\int_{0}^{\frac{\pi}{4}} \frac{1}{(1+\tan^2\theta)^{\frac{1}{2}}} \, d\theta
\end{aligned}"""),
      StepItem(tex: r"""\text{ここで、} 1+\tan^2\theta = \frac{1}{\cos^2\theta} \text{ より、} (1+\tan^2\theta)^{\frac{1}{2}} = \frac{1}{|\cos\theta|} = \frac{1}{\cos\theta} \text{（} 0 \leq \theta \leq \frac{\pi}{4} \text{ では } \cos\theta > 0 \text{）}"""),
      StepItem(tex: r"""\begin{aligned}
\frac{1}{4}\int_{0}^{\frac{\pi}{4}} \frac{1}{(1+\tan^2\theta)^{\frac{1}{2}}} \, d\theta
&= \frac{1}{4}\int_{0}^{\frac{\pi}{4}} \cos\theta \, d\theta\\[5pt]
&= \frac{1}{4}\left[\sin\theta\right]_{0}^{\frac{\pi}{4}}\\[5pt]
&= \frac{1}{4}\left(\sin\frac{\pi}{4} - \sin 0\right)\\[5pt]
&= \frac{1}{4} \cdot \frac{\sqrt{2}}{2}\\[5pt]
&= \frac{\sqrt{2}}{8}
\end{aligned}"""),
    ],
  ),
];

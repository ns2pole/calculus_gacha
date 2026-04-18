// lib/data/ft_ode_all_split_with_ids_v5.dart
// 方針：
// - prime 記法（d/dt は使わない）、引数 (t), (V), (ρ) は省略しない
// - 係数はすべて「」である旨を問題文に明記
// - 一次：積分因子法で初期値を用いて厳密解（当て推量・複素数なし）
// - 二次強制：因果 G 関数（Duhamel）で厳密導出、実関数のみ
// - 途中式は \begin{aligned} と &= で整列、途中計算の省略なし（基礎積分は先頭で完全導出）
//
// 重要：コメント行 // --- ... --- は「物理的な1フレーズ例のみ」。
//       category は「一般/数値 × 一階/二階 × 斉次/非斉次」の数学的分類のみ。


import '../../models/math_problem.dart';
import '../../models/step_item.dart';

// ======================================================================
// 0) 補助：実関数の積分公式（以後の問題で参照）
// ======================================================================

// --- 実指数×正弦の積分公式 ---
// const auxIntegral = MathProblem(
//   id: "26B96D2C-B75A-41EE-9C07-0E1CBE45D019",
//   no: 0,
//   category: '補助',
//   level: '参考',
//   question: r"""以降で用いる実関数の積分公式（導出を明記）""",
//   answer: r"""\displaystyle 
// \int e^{\alpha t}\cos(\beta t)\,dt=\displaystyle \frac{e^{\alpha t}}{\alpha^2+\beta^2}\big(\alpha\cos(\beta t)+\beta\sin(\beta t)\big),\quad
// \int e^{\alpha t}\sin(\beta t)\,dt=\displaystyle \frac{e^{\alpha t}}{\alpha^2+\beta^2}\big(\alpha\sin(\beta t)-\beta\cos(\beta t)\big)
// """,
//   imageAsset: '',
//   steps: [
//     StepItem(tex: r"""\textbf{分部積分の二重連立（実関数のみで導出）"""}),
//     StepItem(tex: r"""
// \begin{aligned}
// I_1(t)&\equiv \int e^{\alpha t}\cos(\beta t)\,dt,\quad
// I_2(t)\equiv \int e^{\alpha t}\sin(\beta t)\,dt.
// \end{aligned}
// """),
//     StepItem(tex: r"""I_1 の分部積分："""),
//     StepItem(tex: r"""
// \begin{aligned}
// I_1(t)
// &= \displaystyle \frac{e^{\alpha t}}{\beta}\sin(\beta t) - \displaystyle \frac{\alpha}{\beta}\int e^{\alpha t}\sin(\beta t)\,dt \\
// &= \displaystyle \frac{e^{\alpha t}}{\beta}\sin(\beta t) - \displaystyle \frac{\alpha}{\beta}\, I_2(t).
// \end{aligned}
// """),
//     StepItem(tex: r"""I_2 の分部積分："""),
//     StepItem(tex: r"""
// \begin{aligned}
// I_2(t)
// &= -\displaystyle \frac{e^{\alpha t}}{\beta}\cos(\beta t) + \displaystyle \frac{\alpha}{\beta}\int e^{\alpha t}\cos(\beta t)\,dt \\
// &= -\displaystyle \frac{e^{\alpha t}}{\beta}\cos(\beta t) + \displaystyle \frac{\alpha}{\beta}\, I_1(t).
// \end{aligned}
// """),
//     StepItem(tex: r"""I_1 に代入して連立を閉じる："""),
//     StepItem(tex: r"""
// \begin{aligned}
// I_1(t)
// &= \displaystyle \frac{e^{\alpha t}}{\beta}\sin(\beta t) + \displaystyle \frac{\alpha e^{\alpha t}}{\beta^2}\cos(\beta t) - \displaystyle \frac{\alpha^2}{\beta^2}I_1(t), \\
// \left(1+\displaystyle \frac{\alpha^2}{\beta^2}\right)I_1(t)
// &= \displaystyle \frac{e^{\alpha t}}{\beta}\sin(\beta t) + \displaystyle \frac{\alpha e^{\alpha t}}{\beta^2}\cos(\beta t), \\
// I_1(t)
// &= \displaystyle \frac{e^{\alpha t}}{\alpha^2+\beta^2}\big(\alpha\cos(\beta t)+\beta\sin(\beta t)\big).
// \end{aligned}
// """),
//     StepItem(tex: r"""I_2 も同様に得る。以降は\textbf{この公式を参照して評価する。"""),
//   ],
// );

// ======================================================================
// A) 一般（記号）セクション
// ======================================================================
const uniform_accelerationProblems = <MathProblem>[

  // --- 自由落下（等加速度・速度） ---
  MathProblem(
    id: "5FDE5472-2F31-46C7-89A5-F564360CD6C5",
    no: 1,
    category: '一般・一階・非斉次',    level: '初級',    question: r"""f'(t)=g, \quad f(0) = f_0""",
    answer: r"""f(t)=g t + f_0""",
    imageAsset: '',
    equation: r"""f'(t)=g""",
    conditions: r"""f(0)=f_0""",    constants: r"""g:定数""",    keywords: ['等加速度直線運動', '一般'],    steps: [
      StepItem(tex: r"""\textcolor{brown}{\large{【力学】}}""",),
      StepItem(tex: r"""\text{• 自由落下運動の速度変化についての微分方程式。}""",),
      StepItem(tex: r"""\text{• 力学においては、} v'(t) = g \text{の形でよく登場する。これは重力を受ける質点の速度変化を表す。}""",),
      StepItem(tex: r"""\textcolor{brown}{\large{【問題の記号と力学における記号の対応】}}""",),
      StepItem(tex: r"""\text{自由落下運動の速度変化}""",),
      StepItem(tex: r"""v'(t) = g"""),
      StepItem(tex: r"""\text{• } f(t) \leftrightarrow v(t) \text{（速度）}""",),
      StepItem(tex: r"""\text{• } g \leftrightarrow g \text{（重力加速度）}""",),
      StepItem(tex: r"""\text{• } f_0 \leftrightarrow v_0 \text{（初期速度）}""",),
      StepItem(tex: r"""\textcolor{brown}{\large{【解法】}}""",),
      StepItem(tex: r"""f'(t) = g"""),
      StepItem(tex: r"""\text{両辺を }0\text{ から }t\text{ まで定積分する：}""",),
      StepItem(tex: r"""
\begin{aligned}
&\Leftrightarrow \int_0^t f'(s)\,ds = \int_0^t g\,ds\\[5pt]
&\Leftrightarrow [f(s)]_{0}^{t} = [gs]_{0}^{t}\\[5pt]
&\Leftrightarrow \ f(t) - f(0) = g t - 0\\[5pt]
&\Leftrightarrow \ f(t) = g t + f(0)
\end{aligned}
"""),
      StepItem(tex: r"""\text{初期条件より} f(0) = f_0 \text{なので、}""",),
      StepItem(tex: r"""\Leftrightarrow \ f(t) = g t + f_0"""),
    ],
  ),



  // --- 自由落下（等加速度・位置） ---
  MathProblem(
    id: "C5C2514A-CF06-4F19-BE62-4F99731FA905",
    no: 2,
    category: '一般・二階・非斉次',    level: '初級',    question: r"""f''(t)=g,\ f(0)=f_0,\ f'(0)=v_0""",
    answer: r"""f(t)=\displaystyle \frac{1}{2}g t^2 + v_0 t + f_0""",
    imageAsset: '',
    equation: r"""f''(t)=g""",
    conditions: r"""f(0)=f_0,\ f'(0)=v_0""",    keywords: ['等加速度直線運動', '一般'],    steps: [
      StepItem(tex: r"""\textcolor{brown}{\large{【力学】}}""",),
      StepItem(tex: r"""\text{• 初期位置 }x_0=f_0\text{、初期速度 }v_0\text{、重力加速度 }g\text{ の自由落下運動の位置についての微分方程式。}""",),
      StepItem(tex: r"""\text{• 力学においては、} x''(t) = g \text{の形でよく登場する。これは重力を受ける質点の位置変化を表す。}""",),
      StepItem(tex: r"""\text{• 解 }f(t) = \displaystyle \frac{1}{2}g t^2 + v_0 t + f_0\text{ は、等加速度運動の位置公式そのものである。}""",),
      StepItem(tex: r"""\textcolor{brown}{\large{【問題の記号と力学における記号の対応】}}""",),
      StepItem(tex: r"""\text{自由落下運動の位置変化}""",),
      StepItem(tex: r"""x''(t) = g"""),
      StepItem(tex: r"""\text{• } f(t) \leftrightarrow x(t) \text{（位置）}""",),
      StepItem(tex: r"""\text{• } f'(t) \leftrightarrow v(t) \text{（速度）}""",),
      StepItem(tex: r"""\text{• } f''(t) \leftrightarrow a(t) \text{（加速度）}""",),
      StepItem(tex: r"""\text{• } g \leftrightarrow g \text{（重力加速度）}""",),
      StepItem(tex: r"""\text{• } f_0 \leftrightarrow x_0 \text{（初期位置）}""",),
      StepItem(tex: r"""\text{• } v_0 \leftrightarrow v_0 \text{（初期速度）}""",),
      StepItem(tex: r"""\textcolor{brown}{\large{【解法】}}""",),
      StepItem(tex: r"""f''(t) = g"""),
      StepItem(tex: r"""\text{両辺を }0\text{ から }t\text{ まで定積分する：}""",),
      StepItem(tex: r"""
\begin{aligned}
&\Leftrightarrow \int_0^t f''(s)\,ds = \int_0^t g\,ds\\[5pt]
&\Leftrightarrow [f'(s)]_{0}^{t} = [gs]_{0}^{t}\\[5pt]
&\Leftrightarrow \ f'(t) - f'(0) = g t - 0\\[5pt]
&\Leftrightarrow \ f'(t) = g t + f'(0)
\end{aligned}
"""),
      StepItem(tex: r"""\text{初期条件より} f'(0) = v_0 \text{なので、}""",),
      StepItem(tex: r"""\Leftrightarrow \ f'(t) = g t + v_0"""),
      StepItem(tex: r"""\text{さらに両辺を }0\text{ から }t\text{ まで定積分する：}""",),
      StepItem(tex: r"""
\begin{aligned}
&\Leftrightarrow \int_0^t f'(s)\,ds = \int_0^t (g s + v_0)\,ds\\[5pt]
&\Leftrightarrow [f(s)]_{0}^{t} = \left[\displaystyle \frac{1}{2}g s^2 + v_0 s\right]_{0}^{t}\\[5pt]
&\Leftrightarrow \ f(t) - f(0) = \displaystyle \frac{1}{2}g t^2 + v_0 t - 0\\[5pt]
&\Leftrightarrow \ f(t) = \displaystyle \frac{1}{2}g t^2 + v_0 t + f(0)
\end{aligned}
"""),
      StepItem(tex: r"""\text{初期条件より} f(0) = f_0 \text{なので、}""",),
      StepItem(tex: r"""\Leftrightarrow \ f(t) = \displaystyle \frac{1}{2}g t^2 + v_0 t + f_0"""),
    ],
  ),


  // --- 自由落下（等加速度・速度：数値） ---
  MathProblem(
    id: "9B75DE01-6B72-487F-B653-EE769057E58B",
    no: 101,
    category: '数値・一階・非斉次',    level: '初級',    question: r"""f'(t)=2,\quad f(0)=1""",
    answer: r"""f(t)=2t + 1""",
    imageAsset: '',
    equation: r"""f'(t)=2""",
    conditions: r"""f(0)=1""",    keywords: ['等加速度直線運動', '数値'],    steps: [
      StepItem(tex: r"""\textcolor{brown}{\large{【力学】}}""",),
      StepItem(tex: r"""\text{• 一定加速度運動の速度変化についての微分方程式。}""",),
      StepItem(tex: r"""\text{• 力学においては、} v'(t) = a \text{の形でよく登場する。これは一定の力を受ける質点の速度変化を表す。}""",),
      StepItem(tex: r"""\textcolor{brown}{\large{【問題の記号と力学における記号の対応】}}""",),
      StepItem(tex: r"""\text{一定加速度運動の速度変化}""",),
      StepItem(tex: r"""\text{• } f(t) \leftrightarrow v(t) \text{（速度）}""",),
      StepItem(tex: r"""\text{• } 1 \leftrightarrow v_0 \text{（初期速度）}""",),
      StepItem(tex: r"""\textcolor{brown}{\large{【解法】}}""",),
      StepItem(tex: r"""f'(t) = 2"""),
      StepItem(tex: r"""\text{両辺を }0\text{ から }t\text{ まで定積分する：}""",),
      StepItem(tex: r"""
\begin{aligned}
&\Leftrightarrow \int_0^t f'(s)\,ds = \int_0^t 2\,ds\\[5pt]
&\Leftrightarrow [f(s)]_{0}^{t} = [2s]_{0}^{t}\\[5pt]
&\Leftrightarrow \ f(t) - f(0) = 2 t - 0\\[5pt]
&\Leftrightarrow \ f(t) = 2 t + f(0)
\end{aligned}
"""),
      StepItem(tex: r"""\text{初期条件より} f(0) = 1 \text{なので、}""",),
      StepItem(tex: r"""\Leftrightarrow \ f(t) = 2 t + 1"""),
    ],
  ),


  // --- 自由落下（等加速度・位置：数値） ---
  MathProblem(
    id: "6B6506AA-7296-4C18-9A00-44CAF515FDD4",
    no: 102,
    category: '数値・二階・非斉次',    level: '初級',    question: r"""f''(t)=2,\quad f(0)=-1,\ f'(0)=3""",
    answer: r"""f(t)=t^2+3t-1""",
    imageAsset: '',
    equation: r"""f''(t)=2""",
    conditions: r"""f(0)=-1,\ f'(0)=3""",    constants: r"""""",
    keywords: ['等加速度直線運動', '数値'],    steps: [
      StepItem(tex: r"""\textcolor{brown}{\large{【力学】}}""",),
      StepItem(tex: r"""\text{• 初期位置 }x_0=-1\text{、初期速度 }v_0=3\text{、加速度 }a=2\text{ の等加速度直線運動の位置についての微分方程式。}""",),
      StepItem(tex: r"""\text{• 力学においては、} x''(t) = a \text{の形でよく登場する。これは一定の力を受ける質点の位置変化を表す。}""",),
      StepItem(tex: r"""\textcolor{brown}{\large{【問題の記号と力学における記号の対応】}}""",),
      StepItem(tex: r"""\text{一定加速度運動の位置変化}""",),
      StepItem(tex: r"""\text{• } f(t) \leftrightarrow x(t) \text{（位置）}""",),
      StepItem(tex: r"""\text{• } f'(t) \leftrightarrow v(t) \text{（速度）}""",),
      StepItem(tex: r"""\text{• } f''(t) \leftrightarrow a(t) \text{（加速度）}""",),
      StepItem(tex: r"""\text{• } f(0)=-1 \leftrightarrow x_0=-1 \text{（初期位置）}""",),
      StepItem(tex: r"""\text{• } f'(0)=3 \leftrightarrow v_0=3 \text{（初期速度）}""",),
      StepItem(tex: r"""\textcolor{brown}{\large{【解法】}}""",),
      StepItem(tex: r"""f''(t) = 2"""),
      StepItem(tex: r"""\text{両辺を }0\text{ から }t\text{ まで定積分する：}""",),
      StepItem(tex: r"""
\begin{aligned}
&\Leftrightarrow \int_0^t f''(s)\,ds = \int_0^t 2\,ds\\[5pt]
&\Leftrightarrow [f'(s)]_{0}^{t} = [2s]_{0}^{t}\\[5pt]
&\Leftrightarrow \ f'(t) - f'(0) = 2 t - 0\\[5pt]
&\Leftrightarrow \ f'(t) = 2 t + f'(0)
\end{aligned}
"""),
      StepItem(tex: r"""\text{初期条件より} f'(0) = 3 \text{なので、}""",),
      StepItem(tex: r"""\Leftrightarrow \ f'(t) = 2 t + 3"""),
      StepItem(tex: r"""\text{さらに両辺を }0\text{ から }t\text{ まで定積分する：}""",),
      StepItem(tex: r"""
\begin{aligned}
&\Leftrightarrow \int_0^t f'(s)\,ds = \int_0^t (2 s + 3)\,ds\\[5pt]
&\Leftrightarrow [f(s)]_{0}^{t} = [s^2 + 3s]_{0}^{t}\\[5pt]
&\Leftrightarrow \ f(t) - f(0) = t^2 + 3 t - 0\\[5pt]
&\Leftrightarrow \ f(t) = t^2 + 3 t + f(0)
\end{aligned}
"""),
      StepItem(tex: r"""\text{初期条件より} f(0) = -1 \text{なので、}""",),
      StepItem(tex: r"""\Leftrightarrow \ f(t) = t^2 + 3 t - 1"""),
    ],
  ),

];

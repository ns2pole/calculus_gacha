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
const first_order_expProblems = <MathProblem>[




  // --- 比例抵抗（指数減衰：RC放電） ---
  MathProblem(
    id: "F744D6AB-A8EB-42F0-9740-0FD4DC4EA29D",
    no: 3,
    category: '一般・一階・斉次',
    level: '初級',
    question: r"""f'(t)+a\,f(t)=0,\quad f(0)=f_0""",
    answer: r"""f(t)=f_0 e^{-a t}""",
    imageAsset: '',
    equation: r"""f'(t)+a\,f(t)=0""",
    conditions: r"""f(0)=f_0""",
    constants: r"""a:定数""",
    keywords: ['一般', '直流', '電圧0', 'コンデンサ', '抵抗'],
    steps: [
      StepItem(tex: r"""\textcolor{brown}{\large{【力学】}}"""),
      StepItem(tex: r"""\text{• 力学の空気抵抗のみを受ける質点の速度減衰は} v'(t) + \displaystyle \frac{k}{m}v(t) = 0 \text{ でモデル化される。速度は指数関数的に減少する。}"""),
      StepItem(tex: r"""\textcolor{brown}{\large{【電磁気学】}}"""),
      StepItem(tex: r"""\text{• 電磁気学のRC放電回路においては、キルヒホッフの第二法則より、}
      RI(t) + \displaystyle \frac{Q(t)}{C} = 0 \text{が成り立ち、これを}R\text{で割って両辺微分すると、}
      I'(t) + \displaystyle \frac{1}{RC}I(t) = 0 \text{ を得る。これはRC回路の放電過程の回路に流れる電流の時間変化を表す。電流は指数関数的に減少する。}"""),
      StepItem(tex: r"""\textcolor{brown}{\large{【問題の記号と力学における記号の対応】}}"""),
      StepItem(tex: r"""\text{空気抵抗下での質点の運動:} \ v'(t) + \displaystyle \frac{k}{m}v(t) = 0"""),
      StepItem(tex: r"""\text{• } f(t) \leftrightarrow v(t) \text{（速度）}"""),
      StepItem(tex: r"""\text{• } a \leftrightarrow \displaystyle \frac{k}{m} \text{（抵抗係数 ÷ 質量）}"""),
      StepItem(tex: r"""\text{• } f_0 \leftrightarrow v_0 \text{（初期速度）}"""),
      StepItem(tex: r"""\textcolor{brown}{\large{【問題の記号と電磁気学における記号の対応】}}"""),
      StepItem(tex: r"""\text{RC回路の放電:} \ I'(t) + \displaystyle \frac{1}{RC}I(t) = 0"""),
      StepItem(tex: r"""\text{• } f(t) \leftrightarrow I(t) \text{（電流）}"""),
      StepItem(tex: r"""\text{• } a \leftrightarrow \displaystyle \frac{1}{RC} \text{（時定数の逆数）}"""),
      StepItem(tex: r"""\text{• } f_0 \leftrightarrow I_0 \text{（初期電流）}"""),
      StepItem(tex: r"""\textcolor{brown}{\large{【解法】}}"""),
      StepItem(tex: r"""f'(t)+a\,f(t) = 0"""),
      StepItem(tex: r"""\text{両辺に}e^{at}\text{ を掛ける。(こうやるとうまくいく)}"""),
      StepItem(tex: r"""\Leftrightarrow \ e^{at}f'(t) + ae^{at}f(t) = 0"""),
      StepItem(tex: r"""\text{積の微分より}"""),
      StepItem(tex: r"""\Leftrightarrow (e^{at}f(t))' = 0"""),
      StepItem(tex: r"""\text{両辺を }0 \text{ から }t \text{ まで定積分する。}"""),
      StepItem(tex: r"""
\begin{aligned}
&\Leftrightarrow \int_0^t (e^{as}f(s))'\,ds = \int_0^t 0\,ds\\[5pt]
&\Leftrightarrow [e^{as}f(s)]_{0}^{t} = 0\\[5pt]
&\Leftrightarrow \ e^{at}f(t) - e^0 f(0) = 0\\[5pt]
&\Leftrightarrow \ e^{at}f(t) = f(0)
\end{aligned}
"""),
      StepItem(tex: r"""\text{初期条件より} f(0) = f_0 \text{なので、}"""),
      StepItem(tex: r"""
\begin{aligned}
&\Leftrightarrow \ e^{at}f(t) = f_0\\[5pt]
&\Leftrightarrow \ f(t) = f_0e^{-at}
\end{aligned}
"""),

      StepItem(tex: r"""\text{この解は指数減衰関数で、減衰定数 }a\text{ で指数関数的に減少する。}"""),
      ],
  ),



  // --- 目標到達（一次遅れ：RL直流立上がり） ---
  MathProblem(
    id: "E5E4228F-7819-4063-A4DB-9F1DB3D27225",
    no: 4,
    category: '一般・一階・非斉次',
    level: '初級',
    question: r"""f'(t)+a\,f(t)=b""",
    answer: r"""f(t)=\dfrac{b}{a}+\Big(f_0-\dfrac{b}{a}\Big)e^{-a t}""",
    imageAsset: '',
    equation: r"""f'(t)+a\,f(t)=b""",
    conditions: r"""f(0)=f_0""",
    constants: r"""a \neq 0,\ b:定数""",
    keywords: ['空気抵抗',  '直流', '一般', 'コイル', '抵抗'],
    steps: [
      StepItem(tex: r"""\text{【力学】}""") ,
      StepItem(tex: r"""\text{• 力学の空気抵抗を受ける質点の自由落下は} v'(t) = -\displaystyle \frac{k}{m}v(t) + g \text{ でモデル化され、速度は指数関数的に}\ \displaystyle \frac{mg}{k} \text{に収束する。}"""),
      StepItem(tex: r"""\textcolor{brown}{\large{【電磁気学】}}"""),
      StepItem(tex: r"""\text{• 直流電圧を印加したRL回路について、キルヒホッフの第二法則を適用すると、微分方程式}
      LI'(t) + RI(t) = V \text{を得られ、両辺をコイルの自己インダクタンス}L \text{で割ると、問題の式の形に帰着される。電流の値は指数関数的}\ \displaystyle \frac{V}{R} \text{に収束する。}"""),
      StepItem(tex: r"""\textcolor{brown}{\large{【問題の記号と力学における記号の対応】}}"""),
      StepItem(tex: r"""\text{空気抵抗を受ける自由落下の運動方程式:} \ mv'(t) = -kv(t)+mg"""),
      StepItem(tex: r"""\text{• } f(t) \leftrightarrow v(t) \text{（速度）}"""),
      StepItem(tex: r"""\text{• } a \leftrightarrow \displaystyle \frac{k}{m} \text{（抵抗係数 ÷ 質量）}"""),
      StepItem(tex: r"""\text{• } \frac b a \leftrightarrow \displaystyle \frac{mg}{k} \text{(終端速度)}"""),
      StepItem(tex: r"""\text{• } b \leftrightarrow \displaystyle \frac{mg}{m} = g \text{（重力加速度）}"""),
      StepItem(tex: r"""\text{• } f_0 \leftrightarrow v_0 \text{（初期速度）}"""),
      StepItem(tex: r"""\textcolor{brown}{\large{【問題の記号と電磁気学における記号の対応】}}"""),
      StepItem(tex: r"""\text{RL回路(直流):} \ LI'(t) + RI(t) = V"""),
      StepItem(tex: r"""\text{• } f(t) \leftrightarrow I(t) \text{（電流）}"""),
      StepItem(tex: r"""\text{• } a \leftrightarrow \displaystyle \frac{R}{L} \text{（時定数の逆数）}"""),
      StepItem(tex: r"""\text{• } b \leftrightarrow \displaystyle \frac{V}{L} \text{（電圧 ÷ インダクタンス）}"""),
      StepItem(tex: r"""\text{• } \frac b a \leftrightarrow \displaystyle \frac{V}{R} \text{（定常電流）}"""),
      StepItem(tex: r"""\text{• } f_0 \leftrightarrow I_0 \text{（初期電流）}"""),
      StepItem(tex: r"""\textcolor{brown}{\large{【解法】}}"""),
      StepItem(tex: r"""f'(t) + af(t) = b"""),
      StepItem(tex: r"""\text{両辺に}e^{at}\text{ を掛ける。(こうやるとうまくいく)}"""),
      StepItem(tex: r"""\Leftrightarrow \ e^{at}f'(t) + ae^{at}f(t) = be^{at}"""),
      StepItem(tex: r"""\text{積の微分より}"""),
      StepItem(tex: r"""\Leftrightarrow (e^{at}f(t))' = be^{at}"""),
      StepItem(tex: r"""\text{両辺を }0\text{ から }t\text{ まで定積分：}"""),
      StepItem(tex: r"""
\begin{aligned}
&\Leftrightarrow \int_0^t (e^{as}f(s))'\,ds = \int_0^t be^{as}\,ds\\[5pt]
&\Leftrightarrow [e^{as}f(s)]_{0}^{t} = \left[\displaystyle \frac{b}{a}e^{as}\right]_{0}^{t}\\[5pt]
&\Leftrightarrow \ e^{at}f(t) - e^0 f(0) = \displaystyle \frac{b}{a}e^{at} - \displaystyle \frac{b}{a}e^0\\[5pt]
&\Leftrightarrow \ e^{at}f(t) = f(0) + \displaystyle \frac{b}{a}(e^{at}-1) 
\end{aligned}
"""),
      StepItem(tex: r"""\text{初期条件より} f(0) = f_0 \text{なので、}"""),
      StepItem(tex: r"""\Leftrightarrow \ e^{at}f(t) = f_0 + \displaystyle \frac{b}{a}(e^{at}-1)"""),
      StepItem(tex: r"""\Leftrightarrow \ e^{at}f(t) = \displaystyle \frac{b}{a}e^{at} + f_0 - \displaystyle \frac{b}{a}"""),
      StepItem(tex: r"""\Leftrightarrow \ f(t) = \displaystyle \frac{b}{a}+\left(f_0-\displaystyle \frac{b}{a}\right)e^{-at}"""),
      StepItem(tex: r"""\text{この解は目標値}\displaystyle \frac{b}{a} \text{ への指数関数的収束で、時定数は}\displaystyle \frac{1}{a}\text{ である。}"""),
    ],
  ),



  // --- 線形抵抗　一定外力（一次→位置：直線＋指数関数） ---
  MathProblem(
    id: "D87D022C-7BED-4C0D-BC95-8A74C64BCD86",
    no: 5,
    category: '一般・二階・非斉次',
    level: '初級',
    question: r"""f''(t)+a\,f'(t)=b""",
    answer: r"""f(t)=f_0 +\dfrac{v_0 - \dfrac{b}{a}}{a} + \dfrac{b}{a}t-\dfrac{v_0-\dfrac{b}{a}}{a}e^{-a t}""",
    imageAsset: '',
    equation: r"""f''(t)+a\,f'(t)=b""",
    conditions: r"""f(0)=f_0,\ f'(0)=v_0""",
    constants: r"""a\neq 0,\ b:定数""",
    keywords: ['空気抵抗',  '直流', '一般', 'コイル', '抵抗'],
    steps: [
      StepItem(tex: r"""\textcolor{brown}{\large{【力学】}}"""),
      StepItem(tex: r"""\text{• 力学の空気抵抗下での一定外力運動は} mx'' + kx' = mg \text{ でモデル化される。}"""),
      StepItem(tex: r"""\text{• 速度は指数関数的に終端速度} \displaystyle \frac{mg}{k} \text{ に収束する。終端速度に近くになると、外力と抵抗力がつり合った、等速直線運動に近似できる。}"""),
      StepItem(tex: r"""\textcolor{brown}{\large{【問題の記号と力学における記号の対応】}}"""),
      StepItem(tex: r"""\text{空気抵抗下での一定外力運動:} \ mx''(t) + kx'(t) = mg"""),
      StepItem(tex: r"""\text{• } f(t) \leftrightarrow x(t) \text{（位置）}"""),
      StepItem(tex: r"""\text{• } f'(t) \leftrightarrow v(t) \text{（速度）}"""),
      StepItem(tex: r"""\text{• } f''(t) \leftrightarrow a(t) \text{（加速度）}"""),
      StepItem(tex: r"""\text{• } a \leftrightarrow \displaystyle \frac{k}{m} \text{（抵抗係数 ÷ 質量）}"""),
      StepItem(tex: r"""\text{• } b \leftrightarrow \displaystyle \frac{mg}{m} = g \text{（重力加速度）}"""),
      StepItem(tex: r"""\text{• } f_0 \leftrightarrow x_0 \text{（初期位置）}"""),
      StepItem(tex: r"""\text{• } v_0 \leftrightarrow v_0 \text{（初期速度）}"""),
      StepItem(tex: r"""\textcolor{brown}{\large{【解法】}}"""),
      StepItem(tex: r"""f''(t) + af'(t) = b"""),
      StepItem(tex: r"""\textcolor{green}{1.\ } \textcolor{green}{一階線形非斉次に帰着}"""),
      StepItem(tex: r"""\text{置換：}u(t) = f'(t)\text{ とおくと、}"""),
      StepItem(tex: r"""\Leftrightarrow \ u'(t) + au(t) = b"""),
      StepItem(tex: r"""\textcolor{green}{2.\ } \textcolor{green}{積分因子法で} \textcolor{green}{u} \textcolor{green}{を求める}"""),
      StepItem(tex: r"""\text{両辺に}e^{at}\text{ を掛ける。(こうやるとうまくいく)}"""),
      StepItem(tex: r"""\Leftrightarrow \ e^{at}u'(t) + ae^{at}u(t) = be^{at}"""),
      StepItem(tex: r"""\text{積の微分より}"""),
      StepItem(tex: r"""\Leftrightarrow (e^{at}u(t))' = be^{at}"""),
      StepItem(tex: r"""\text{両辺を }0\text{ から }t\text{ まで定積分：}"""),
      StepItem(tex: r"""
\begin{aligned}
&\Leftrightarrow \int_0^t (e^{as}u(s))'\,ds = \int_0^t be^{as}\,ds\\[5pt]
&\Leftrightarrow [e^{as}u(s)]_{0}^{t} = \left[\displaystyle \frac{b}{a}e^{as}\right]_{0}^{t}\\[5pt]
&\Leftrightarrow \ e^{at}u(t) - e^0 u(0) = \displaystyle \frac{b}{a}e^{at} - \displaystyle \frac{b}{a}e^0\\[5pt]
&\Leftrightarrow \ e^{at}u(t) = u(0) + \displaystyle \frac{b}{a}(e^{at}-1)
\end{aligned}
"""),
      StepItem(tex: r"""\text{初期条件より} u(0) = v_0 \text{なので、}"""),
      StepItem(tex: r"""\Leftrightarrow \ e^{at}u(t) = v_0 + \displaystyle \frac{b}{a}(e^{at}-1)"""),
      StepItem(tex: r"""\Leftrightarrow \ e^{at}u(t) = \displaystyle \frac{b}{a}e^{at} + v_0 - \displaystyle \frac{b}{a}"""),
      StepItem(tex: r"""\Leftrightarrow \ u(t) = \displaystyle \frac{b}{a} + \left(v_0-\displaystyle \frac{b}{a}\right)e^{-at}"""),
      StepItem(tex: r"""\textcolor{green}{3.\ } \textcolor{green}{f} \textcolor{green}{を求める}"""),
      StepItem(tex: r"""\text{元の変数に戻す：}f'(t) = u(t)\text{ より}"""),
      StepItem(tex: r"""\text{両辺を }0\text{ から }t\text{ まで定積分：}"""),
      StepItem(tex: r"""
\begin{aligned}
&\Leftrightarrow \int_0^t f'(s)\,ds = \int_0^t u(s)\,ds\\[5pt]
&\Leftrightarrow [f(s)]_{0}^{t} = \int_0^t \left[\displaystyle \frac{b}{a} + \left(v_0-\displaystyle \frac{b}{a}\right)e^{-as}\right]ds\\[5pt]
&\Leftrightarrow \ f(t) - f(0) = \left[\displaystyle \frac{b}{a}s\right]_{0}^{t} + \left(v_0-\displaystyle \frac{b}{a}\right)\left[-\displaystyle \frac{1}{a}e^{-as}\right]_{0}^{t}\\[5pt]
&\Leftrightarrow \ f(t) = f(0) + \displaystyle \frac{b}{a}t - 0 + \left(v_0-\displaystyle \frac{b}{a}\right)\left(-\displaystyle \frac{1}{a}e^{-at} + \displaystyle \frac{1}{a}e^0\right)
\end{aligned}
"""),
      StepItem(tex: r"""\text{初期条件より} f(0) = f_0 \text{なので、}"""),
      StepItem(tex: r"""\Leftrightarrow \ f(t) = f_0 + \displaystyle \frac{b}{a}t + \left(v_0-\displaystyle \frac{b}{a}\right)\left(-\displaystyle \frac{1}{a}e^{-at} + \displaystyle \frac{1}{a}\right)"""),
      StepItem(tex: r"""\Leftrightarrow \ f(t) = f_0 + \displaystyle \frac{b}{a}t - \displaystyle \frac{v_0-\displaystyle \frac{b}{a}}{a}e^{-at} + \displaystyle \frac{v_0-\displaystyle \frac{b}{a}}{a}"""),
      StepItem(tex: r"""\Leftrightarrow \ f(t) = f_0 + \displaystyle \frac{v_0-\displaystyle \frac{b}{a}}{a} + \displaystyle \frac{b}{a}t - \displaystyle \frac{v_0-\displaystyle \frac{b}{a}}{a}e^{-at}"""),
      StepItem(tex: r"""\text{この解は、時定数 }a\text{ で指数関数的に}f_0 + \displaystyle \frac{v_0-\displaystyle \frac{b}{a}}{a} + \displaystyle \frac{b}{a}t\text{の一次関数に収束する。}"""),
    ],
  ),


  // --- 一次遅れ交流（RL交流） ---
  MathProblem(
    id: "1DAE0FE3-E342-4547-956C-6CD1EA31EAD3",
    no: 10,
    category: '一般・一階・非斉次',
    level: '中級',
    question: r"""f'(t)+a\,f(t)=F\cos(\omega t)""",
    answer: r"""f(t)=\dfrac{F}{\sqrt{a^2+\omega^2}}\cos(\omega t-\alpha)+\left(f_0-\dfrac{F a}{a^2+\omega^2}\right)e^{-a t},\quad \alpha=\arctan\left(\dfrac{\omega}{a}\right)""",
        imageAsset: '',
    equation: r"""f'(t)+a\,f(t)=F\cos(\omega t)""",
    conditions: r"""f(0)=f_0""",
    constants: r"""a \neq 0,\ \omega \neq 0""",
    keywords: [ '交流',  '一般', 'コイル', '抵抗'],
        steps: [
      // StepItem(tex: r"""\text{【力学】}"""),
      // StepItem(tex: r"""\text{• 力学の空気抵抗下での強制振動は} mv'(t) + kv(t) = F_0\cos(\omega t) \text{ でモデル化される。}"""),
      StepItem(tex: r"""\textcolor{brown}{\large{【電磁気学】}}"""),
      StepItem(tex: r"""\text{• RL交流回路について、キルヒホッフの第二法則を用いると }
      LI'(t) + RI(t) = V_0\cos(\omega t) \text{が成り立つ。}"""),
      // StepItem(tex: r"""\text{【問題の記号と力学における記号の対応】}"""),
      // StepItem(tex: r"""\text{空気抵抗下での強制振動:} \ mv'(t) + kv(t) = F_0\cos(\omega t)"""),
      // StepItem(tex: r"""\text{• } f(t) \leftrightarrow v(t) \text{（速度）}"""),
      // StepItem(tex: r"""\text{• } a \leftrightarrow \displaystyle \frac{k}{m} \text{（抵抗係数 ÷ 質量）}"""),
      // StepItem(tex: r"""\text{• } F \leftrightarrow \displaystyle \frac{F_0}{m} \text{（外力振幅 ÷ 質量）}"""),
      // StepItem(tex: r"""\text{• } \omega \leftrightarrow \omega \text{（角周波数）}"""),
      // StepItem(tex: r"""\text{• } f_0 \leftrightarrow v_0 \text{（初期速度）}"""),
      StepItem(tex: r"""\textcolor{brown}{\large{【問題の記号と電磁気学における記号の対応】}}"""),
      StepItem(tex: r"""\text{RL交流回路:} \ LI'(t) + RI(t) = V_0\cos(\omega t)"""),
      StepItem(tex: r"""\text{• } f(t) \leftrightarrow I(t) \text{（電流）}"""),
      StepItem(tex: r"""\text{• } a \leftrightarrow \displaystyle \frac{R}{L} \text{（時定数の逆数）}"""),
      StepItem(tex: r"""\text{• } F \leftrightarrow \displaystyle \frac{V_0}{L} \text{（電圧振幅 ÷ インダクタンス）}"""),
      StepItem(tex: r"""\text{• } \omega \leftrightarrow \omega \text{（角周波数）}"""),
      StepItem(tex: r"""\text{• } f_0 \leftrightarrow I_0 \text{（初期電流）}"""),
      StepItem(tex: r"""\text{• } |Z| = \sqrt{a^2+\omega^2} \leftrightarrow \sqrt{R^2+(\omega L)^2} \text{（インピーダンスの大きさ）}"""),
      StepItem(tex: r"""\text{• } \displaystyle \frac{F}{\sqrt{a^2+\omega^2}} \leftrightarrow \displaystyle \frac{V_0}{\sqrt{R^2+(\omega L)^2}} = \displaystyle \frac{V_0}{|Z|} \text{（定常電流の振幅）}"""),
      StepItem(tex: r"""\text{• } \tan\alpha = \displaystyle \frac{\omega}{a} \leftrightarrow \displaystyle \frac{\omega L}{R} \text{（位相遅れ角）}"""),
      StepItem(tex: r"""\textcolor{brown}{\large{【解法】}}"""),
      StepItem(tex: r"""f'(t) + af(t) = F\cos(\omega t)"""),
      StepItem(tex: r"""\text{両辺に}e^{at}\text{ を掛ける。(こうやるとうまくいく)}"""),
      StepItem(tex: r"""\Leftrightarrow \ e^{at}f'(t) + ae^{at}f(t) = Fe^{at}\cos(\omega t)"""),
      StepItem(tex: r"""\text{積の微分より}"""),
      StepItem(tex: r"""\Leftrightarrow (e^{at}f(t))' = Fe^{at}\cos(\omega t)"""),
      StepItem(tex: r"""\text{両辺を }0\text{ から }t\text{ まで定積分：}"""),
      StepItem(tex: r"""\Leftrightarrow \int_0^t (e^{as}f(s))'\,ds = \int_0^t Fe^{as}\cos(\omega s)\,ds"""),
      StepItem(tex: r"""\Leftrightarrow [e^{as}f(s)]_{0}^{t} = F\int_0^t e^{as}\cos(\omega s)\,ds"""),
      StepItem(tex: r"""\Leftrightarrow \ e^{at}f(t) - f_0 = F\int_0^t e^{as}\cos(\omega s)\,ds"""),
      StepItem(tex: r"""\textcolor{green}{ここで右辺は積分公式より、不定積分は}"""),
      StepItem(tex: r"""\textcolor{green}{\int e^{as}\cos(\omega s)\,ds = \displaystyle \frac{e^{as}}{a^2+\omega^2}\big(a\cos(\omega s)+\omega\sin(\omega s)\big) + C}"""),
      StepItem(tex: r"""\textcolor{green}{したがって、定積分は}"""),
      StepItem(tex: r"""\textcolor{green}{\int_0^t e^{as}\cos(\omega s)\,ds = \left[\displaystyle \frac{e^{as}}{a^2+\omega^2}\big(a\cos(\omega s)+\omega\sin(\omega s)\big)\right]_{0}^{t}}"""),
      StepItem(tex: r"""\textcolor{green}{= \displaystyle \frac{e^{at}}{a^2+\omega^2}\big(a\cos(\omega t)+\omega\sin(\omega t)\big) - \displaystyle \frac{e^{0}}{a^2+\omega^2}\big(a\cos(0)+\omega\sin(0)\big)}"""),
      StepItem(tex: r"""\textcolor{green}{= \displaystyle \frac{e^{at}}{a^2+\omega^2}\big(a\cos(\omega t)+\omega\sin(\omega t)\big) - \displaystyle \frac{a}{a^2+\omega^2}}"""),
      StepItem(tex: r"""\text{よって、}"""),
      StepItem(tex: r"""\Leftrightarrow \ e^{at}f(t) - f_0 = F\left(\displaystyle \frac{e^{at}}{a^2+\omega^2}\big(a\cos(\omega t)+\omega\sin(\omega t)\big) - \displaystyle \frac{a}{a^2+\omega^2}\right)"""),
      StepItem(tex: r"""\Leftrightarrow \ e^{at}f(t) = \displaystyle \frac{Fe^{at}}{a^2+\omega^2}\big(a\cos(\omega t)+\omega\sin(\omega t)\big) - \displaystyle \frac{Fa}{a^2+\omega^2} + f_0"""),
      StepItem(tex: r"""\Leftrightarrow \ f(t) = \displaystyle \frac{F}{a^2+\omega^2}(a\cos(\omega t) + \omega\sin(\omega t)) + \left(f_0 - \displaystyle \frac{Fa}{a^2+\omega^2}\right)e^{-at}"""),
      StepItem(tex: r"""\text{強制振動項を} \sqrt{a^2+\omega^2} \text{で括ると、}"""),
      StepItem(tex: r"""\Leftrightarrow \ f(t) = \displaystyle \frac{F}{\sqrt{a^2+\omega^2}} \cdot \displaystyle \frac{a\cos(\omega t) + \omega\sin(\omega t)}{\sqrt{a^2+\omega^2}} + \left(f_0 - \displaystyle \frac{Fa}{a^2+\omega^2}\right)e^{-at}"""),
      StepItem(tex: r"""\text{三角関数の合成により、}"""),
      StepItem(tex: r"""\Leftrightarrow \ f(t) = \displaystyle \frac{F}{\sqrt{a^2+\omega^2}}\cos(\omega t - \alpha) + \left(f_0 - \displaystyle \frac{Fa}{a^2+\omega^2}\right)e^{-at}"""),
      StepItem(tex: r"""\text{ただし、} \tan\alpha = \displaystyle \frac{\omega}{a}"""),
      StepItem(tex: r"""\text{ここで、} t \to \infty \text{ のとき、 } e^{-at} \to 0 \text{ となるため、}"""),
      StepItem(tex: r"""f(t) = \displaystyle \frac{F}{\sqrt{a^2+\omega^2}}\cos(\omega t - \alpha) \text{に収束する。}"""),
      StepItem(tex: r"""\text{すなわち、右辺の三角関数の位相} \omega t \text{に比べて、解の関数の位相は} \alpha \text{遅れる。}"""),
      // StepItem(tex: r"""\text{【熱力学】}"""),
      // StepItem(tex: r"""\text{周期的加熱による温度変化。}"""),
      // StepItem(tex: r"""\text{【流体力学】}"""),
      // StepItem(tex: r"""\text{周期的圧力変化による流速応答。}"""),
    ],
  ),



    // --- RC回路積分方程式（一般） ---// --- RC回路積分方程式（一般） ---
MathProblem(
  id: "574DF54B-E141-4B50-944D-F38724F1ADC3",
  no: 11,
  category: '一般・一階・非斉次',
  level: '中級',
  question: r"""\displaystyle \frac{\int_0^t f(s) \, ds}{a}+bf(t)=F\cos(\omega t)""",
  // 初期条件 f_0 を廃止し、t=0 における方程式から f(0)=F/b を用いる形にしています。
  answer: r"""f(t)=\displaystyle \frac{F}{\sqrt{b^2+\left(\displaystyle \frac{1}{a \omega}\right)^2}}\cos(\omega t + \alpha)
  +\displaystyle \frac{F}{b a^2\omega^2\left(b^2 + \left(\displaystyle\frac{1}{a \omega}\right)^2\right)}\,e^{- \frac{t}{ab}},\quad \alpha=\arctan\left(\dfrac{1}{ab\omega}\right)""",
  imageAsset: '',
  equation: r"""\displaystyle \frac{\int_0^t f(s) \, ds}{a}+bf(t)=F\cos(\omega t)""",
  // 明示的に f_0 は廃止。方程式自体から t=0 で f(0)=F/b が導かれることを明記します。
  // conditions: r"""\text{（初期条件）方程式の t=0 評価より } f(0)=\dfrac{F}{b}""",
  constants: r"""a,\ b,\ F,\ \omega :正の定数""",
  keywords: [ '交流',  'コンデンサ', '抵抗',  '一般'],
  steps: [
    StepItem(tex: r"""\textcolor{brown}{\large{【電磁気学】}}"""),
    StepItem(tex: r"""\text{• RC交流回路について、コンデンサ初期電荷0のとき、キルヒホッフの第二法則を用いると }
    RI(t) + \displaystyle \frac{1}{C}\int_0^t I(s)\,ds = V_0\cos(\omega t) \text{が成り立つ。}"""),
    StepItem(tex: r"""\text{• 定常状態では、電流 }I(t) \text{ は電圧と同じ角周波数 } \omega \text{ で振動し、振幅は } \displaystyle \frac{V_0}{\sqrt{R^2+\left(\displaystyle \frac{1}{\omega C}\right)^2}} \text{ となる}"""),
    StepItem(tex: r"""\textcolor{brown}{\large{【問題の記号と電磁気学における記号の対応】}}"""),
    StepItem(tex: r"""\text{RC交流回路(コンデンサ初期電荷0の場合):} \ \displaystyle \frac{1}{C}\int_0^t I(s)ds + RI(t) = V_0\cos(\omega t)"""),
    StepItem(tex: r"""\text{• } f(t) \leftrightarrow I(t) \text{（電流）}"""),
    StepItem(tex: r"""\text{• } a \leftrightarrow C \text{（静電容量）}"""),
    StepItem(tex: r"""\text{• } b \leftrightarrow R \text{（抵抗）}"""),
    StepItem(tex: r"""\text{• } F \leftrightarrow V_0 \text{（電圧振幅）}"""),
    StepItem(tex: r"""\text{• } \omega \leftrightarrow \omega \text{（角周波数）}"""),
    StepItem(tex: r"""\text{• } \tan\alpha = \displaystyle \frac{1}{a b \omega} \leftrightarrow \displaystyle \frac{1}{ RC \omega} \text{（位相進み角）}"""),
    StepItem(tex: r"""\textcolor{brown}{\large{【解法】}}"""),
    StepItem(tex: r"""\displaystyle \frac{\int_0^t f(s) \, ds}{a} + bf(t) = F\cos(\omega t)"""),
    StepItem(tex: r"""\text{両辺を微分：}"""),
    StepItem(tex: r"""\Leftrightarrow \ \displaystyle \frac{f(t)}{a} + bf'(t) = -F\omega\sin(\omega t)"""),
    StepItem(tex: r"""\Leftrightarrow \ f'(t) + \displaystyle \frac{1}{ab}f(t) = -\displaystyle \frac{F\omega}{b}\sin(\omega t)"""),
    StepItem(tex: r"""\text{両辺に}e^{ \frac{t}{ab}}\text{ を掛ける。}"""),
    StepItem(tex: r"""\Leftrightarrow \ e^{ \frac{t}{ab}}f'(t) + \displaystyle \frac{1}{ab}e^{ \frac{t}{ab}}f(t) = -\displaystyle \frac{F\omega}{b}e^{ \frac{t}{ab}}\sin(\omega t)"""),
    StepItem(tex: r"""\text{積の微分より}"""),
    StepItem(tex: r"""\Leftrightarrow (e^{ \frac{t}{ab}}f(t))' = -\displaystyle \frac{F\omega}{b}e^{ \frac{t}{ab}}\sin(\omega t)"""),
    StepItem(tex: r"""\text{両辺を }0\text{ から }t\text{ まで定積分：}"""),
    StepItem(tex: r"""\Leftrightarrow [e^{ \frac{s}{ab}}f(s)]_{0}^{t} = -\displaystyle \frac{F\omega}{b}\int_0^t e^{ \frac{s}{ab}}\sin(\omega s)\,ds"""),
    StepItem(tex: r"""\Leftrightarrow \ e^{ \frac{t}{ab}}f(t) - f(0) = -\displaystyle \frac{F\omega}{b}\int_0^t e^{ \frac{s}{ab}}\sin(\omega s)\,ds \cdots(1)"""),
    StepItem(tex: r"""\text{ここで方程式を }t=0\text{ で評価すると } \displaystyle \frac{0}{a} + b f(0) = F \Rightarrow f(0)=\dfrac{F}{b}\text{ が得られる。}"""),
    StepItem(tex: r"""\text{不定積分（公式）: } \textcolor{blue}{\int e^{\alpha t}\sin(\beta t)\,dt = \displaystyle \frac{e^{\alpha t}}{\alpha^2+\beta^2}\big(\alpha\sin(\beta t)-\beta\cos(\beta t)\big) + C}"""),
    StepItem(tex: r"""\text{ここで、}\alpha=\displaystyle \frac{1}{ab},\ \beta=\omega\text{ とすると、}"""),
    StepItem(tex: r"""\text{(1)の右辺} = -\displaystyle \frac{F\omega}{b}\int_0^t e^{ \frac{s}{ab}}\sin(\omega s)\,ds"""),
    StepItem(tex: r"""= -\displaystyle \frac{F\omega}{b} \textcolor{blue}{\left[\displaystyle \frac{e^{ \frac{s}{ab}}}{\left(\frac{1}{ab}\right)^2+\omega^2}\left(\frac{1}{ab}\sin(\omega s)-\omega\cos(\omega s)\right)\right]_0^t}"""),
    StepItem(tex: r"""= -\displaystyle \frac{F\omega}{b\left(\left(\frac{1}{ab}\right)^2+\omega^2\right)}\left(e^{ \frac{t}{ab}}\left(\frac{1}{ab}\sin(\omega t)-\omega\cos(\omega t)\right) - \left(\frac{1}{ab}\cdot 0 - \omega\cdot 1\right)\right)"""),
    StepItem(tex: r"""= -\displaystyle \frac{F\omega}{b\left(\left(\frac{1}{ab}\right)^2+\omega^2\right)}\left(e^{ \frac{t}{ab}}\left(\frac{1}{ab}\sin(\omega t)-\omega\cos(\omega t)\right) + \omega\right)"""),
    StepItem(tex: r"""= -\displaystyle \frac{F\omega e^{ \frac{t}{ab}}}{b\left(\left(\frac{1}{ab}\right)^2+\omega^2\right)}\left(\frac{1}{ab}\sin(\omega t)-\omega\cos(\omega t)\right) - \displaystyle \frac{F\omega^2}{b\left(\left(\frac{1}{ab}\right)^2+\omega^2\right)}"""),
    StepItem(tex: r"""\text{よって (1)は}"""),
    StepItem(tex: r"""\Leftrightarrow \ e^{ \frac{t}{ab}}f(t) = f(0) - \displaystyle \frac{F\omega e^{ \frac{t}{ab}}}{b\left(\left(\frac{1}{ab}\right)^2+\omega^2\right)}\left(\frac{1}{ab}\sin(\omega t)-\omega\cos(\omega t)\right) - \displaystyle \frac{F\omega^2}{b\left(\left(\frac{1}{ab}\right)^2+\omega^2\right)}"""),
    StepItem(tex: r"""\Leftrightarrow \ e^{ \frac{t}{ab}}f(t) = \dfrac{F}{b} - \displaystyle \frac{F\omega e^{ \frac{t}{ab}}}{b\left(\left(\frac{1}{ab}\right)^2+\omega^2\right)}\left(\frac{1}{ab}\sin(\omega t)-\omega\cos(\omega t)\right) - \displaystyle \frac{F\omega^2}{b\left(\left(\frac{1}{ab}\right)^2+\omega^2\right)}"""),
    StepItem(tex: r"""\text{よって}"""),
    StepItem(tex: r"""\Leftrightarrow \ f(t) = \displaystyle \frac{F\omega}{b\left(\left(\frac{1}{ab}\right)^2+\omega^2\right)}\left(\omega\cos(\omega t) - \frac{1}{ab}\sin(\omega t)\right) 
    + \left(\dfrac{F}{b} - \dfrac{F\omega^2}{b\left(\left(\frac{1}{ab}\right)^2+\omega^2\right)}\right)e^{- \frac{t}{ab}}"""),
    StepItem(tex: r"""\text{遷移項の定数を整理する（}D=(\tfrac{1}{ab})^2+\omega^2\text{）:}"""),
    StepItem(tex: r"""
    \begin{aligned}
    \dfrac{F}{b} - \dfrac{F\omega^2}{bD}
    &= \dfrac{F}{b}\left(1 - \dfrac{\omega^2}{D}\right)\\[5pt]
    &= \dfrac{F}{b}\cdot\dfrac{D-\omega^2}{D} \\[5pt]
    &= \dfrac{F}{b}\cdot\dfrac{\left(\frac{1}{ab}\right)^2}{D}\\[5pt]
    &= \dfrac{F}{b\bigl(1+(ab\omega)^2\bigr)} \\[5pt]
    &= \dfrac{F}{b}\cdot\dfrac{1}{a^2\omega^2\left(b^2 + \left(\displaystyle\frac{1}{a \omega}\right)^2\right)} \\[5pt]
    &= \dfrac{F}{b a^2\omega^2\left(b^2 + \left(\displaystyle\frac{1}{a \omega}\right)^2\right)}
    \end{aligned}
    """),
    StepItem(tex: r"""\text{よって遷移項は}"""),
    StepItem(tex: r"""\dfrac{F}{b\bigl(1+(ab\omega)^2\bigr)} = \dfrac{F}{b a^2\omega^2\left(b^2 + \left(\displaystyle\frac{1}{a \omega}\right)^2\right)}"""),
    StepItem(tex: r"""\text{したがって最終的に、}"""),
    StepItem(tex: r"""    \boxed{\,f(t)=\displaystyle \frac{F}{\sqrt{b^2+\left(\displaystyle \frac{1}{a \omega}\right)^2}}\cos(\omega t + \alpha)
    +\displaystyle \frac{F}{b a^2\omega^2\left(b^2 + \left(\displaystyle\frac{1}{a \omega}\right)^2\right)}\,e^{- \frac{t}{ab}}\,}"""),
    StepItem(tex: r"""\text{ただし } \tan\alpha = \displaystyle \frac{1}{ ab \omega} \text{（位相）}。"""),
    StepItem(tex: r"""t\to\infty \text{のとき、遷移項は消え、解は定常解 }
    \displaystyle \frac{F}{\sqrt{b^2+\left(\displaystyle \frac{1}{a \omega}\right)^2}}\cos(\omega t + \alpha) \text{ に収束する。}"""),
  ],
),  




  // --- 体積時間駆動（V(t)既知→合成） ---
  // MathProblem(
  //   id: "30948029-223D-426E-92E9-DAF075344AA4",
  //   no: 23,
  //   category: '一般・一階・斉次',
  //   level: '中級',
  //   question: r"""V(t)\ 既知,\ f'(V)+\gamma\dfrac{f(V)}{V}=0,\ \gamma>1,\ f(V_0)=p_0""",
  //   answer: r"""f(V)=p_0\left(\dfrac{V_0}{V}\right)^{\gamma},\quad \Leftrightarrow \ f(t)=p_0\,V_0^{\gamma}\,[V(t)]^{-\gamma}""",
  //   imageAsset: '',
  //   equation: r"""f'(V)+\gamma\dfrac{f(V)}{V}=0""",
  //   conditions: r"""f(V_0)=p_0""",
  //   constants: r"""V(t)\ 既知,\ \gamma>1""",
  //   steps: [
  //     StepItem(tex: r"""f(V)=C\,V^{-\gamma}\text{。初期値 }f(V_0)=p_0\text{ から }C=p_0 V_0^{\gamma}\text{。合成 }f(t)=f(V(t))\text{。}"""),
  //     StepItem(tex: r"""\textbf{【熱力学】}"""),
  //     StepItem(tex: r"""\text{体積が増えるほど圧力はべき的に減少。}"""),
  //   ],
  // ),


  // --- 交流をコイルに接続（一般） ---
  MathProblem(
    id: "B4FDC2FF-78D4-5C52-C9FE-2477A027B74E",
    no: 24,
    category: '一般・一階・非斉次',
    level: '初級',
    question: r"""Lf'(t)=A\sin(\omega t),\quad f(0)=0""",
    answer: r"""f(t)=-\displaystyle \frac{A}{L\omega}\cos(\omega t)+\displaystyle \frac{A}{L\omega}""",
    imageAsset: '',
    equation: r"""Lf'(t)=A\sin(\omega t)""",
    conditions: r"""f(0)=0""",
    constants: r"""L>0,\ A,\omega:定数""",
    keywords: ['交流', '一般', 'コイル'],
    steps: [
      StepItem(tex: r"""\textcolor{brown}{\large{【電磁気学】}}"""),
      StepItem(tex: r"""\text{• 電磁気学においては、} LI'(t) = V_0\sin(\omega t) \text{ の形で登場する。}"""),
      StepItem(tex: r"""\text{• 電圧 }V_0\sin(\omega t)\text{ の位相}\omega t \text{よりも、電流 }I(t)\text{ の位相は}\displaystyle \frac{\pi}{2}\text{遅れる。}"""),
      StepItem(tex: r"""\text{• 電流 }I(t)\text{ の振幅は電圧振幅の} \displaystyle \frac{1}{\omega L} \text{倍} (誘導性リアクタンス)"""),
      StepItem(tex: r"""\textcolor{brown}{\large{【問題の記号と電磁気学における記号の対応】}}"""),
      StepItem(tex: r"""\text{コイルのみ交流回路:} \ LI'(t) = V_0\sin(\omega t)"""),
      StepItem(tex: r"""\text{• } f(t) \leftrightarrow I(t) \text{（電流）}"""),
      StepItem(tex: r"""\text{• } L \leftrightarrow L \text{（インダクタンス）}"""),
      StepItem(tex: r"""\text{• } A \leftrightarrow V_0 \text{（電圧振幅）}"""),
      StepItem(tex: r"""\text{• } \omega \leftrightarrow \omega \text{（角周波数）}"""),
      StepItem(tex: r"""\text{• } f(0)=0 \leftrightarrow I_0=0 \text{（初期電流）}"""),
      StepItem(tex: r"""\text{• 誘導性リアクタンス：} X_L = \omega L"""),
      StepItem(tex: r"""\textcolor{brown}{\large{【解法】}}"""),
      StepItem(tex: r"""Lf'(t) = A\sin(\omega t)"""),
      StepItem(tex: r"""\text{両辺を}L\text{で割る：}"""),
      StepItem(tex: r"""\Leftrightarrow \ f'(t) = \displaystyle \frac{A}{L}\sin(\omega t)"""),
      StepItem(tex: r"""\text{両辺を }0\text{ から }t\text{ まで定積分：}"""),
      StepItem(tex: r"""\Leftrightarrow \int_0^t f'(s)\,ds = \int_0^t \displaystyle \frac{A}{L}\sin(\omega s)\,ds"""),
      StepItem(tex: r"""\Leftrightarrow [f(s)]_{0}^{t} = \displaystyle \frac{A}{L}\int_0^t \sin(\omega s)\,ds"""),
      StepItem(tex: r"""\Leftrightarrow \ f(t) - f(0) = \displaystyle \frac{A}{L}\left[-\displaystyle \frac{1}{\omega}\cos(\omega s)\right]_{0}^{t}"""),
      StepItem(tex: r"""\Leftrightarrow \ f(t) = f(0) + \displaystyle \frac{A}{L}\left(-\displaystyle \frac{1}{\omega}\cos(\omega t) + \displaystyle \frac{1}{\omega}\cos(0)\right)"""),
      StepItem(tex: r"""\text{初期条件より} f(0) = 0 \text{なので、}"""),
      StepItem(tex: r"""\Leftrightarrow \ f(t) = 0 + \displaystyle \frac{A}{L}\left(-\displaystyle \frac{1}{\omega}\cos(\omega t) + \displaystyle \frac{1}{\omega}\right)"""),
      StepItem(tex: r"""\Leftrightarrow \ f(t) = -\displaystyle \frac{A}{L\omega}\cos(\omega t) + \displaystyle \frac{A}{L\omega}"""),
      StepItem(tex: r"""\text{位相差を明確にするため、定常部分を三角関数の変換公式で変形：}"""),
      StepItem(tex: r"""\Leftrightarrow \ f(t) = \displaystyle \frac{A}{L\omega}\sin\left(\omega t - \displaystyle \frac{\pi}{2}\right) + \displaystyle \frac{A}{L\omega}"""),
    ],
  ),


  // --- 交流をコンデンサに接続（一般） ---
  MathProblem(
    id: "A3ECB1EE-67C3-4B41-B8ED-13669F16A63D",
    no: 25,
    category: '一般・一階・非斉次',
    level: '初級',
    question: r"""\displaystyle \frac{\int_0^t f(s) \, ds}{C}=A\sin(\omega t),\quad f(0)=0""",
    answer: r"""f(t)=\omega CA\sin\left(\omega t+\displaystyle \frac{\pi}{2}\right)""",
    imageAsset: '',
    equation: r"""\displaystyle \frac{\int_0^t f(s) \, ds}{C}=A\sin(\omega t)""",
    conditions: r"""C:正の定数""",
    constants: r"""""",
    keywords: ['交流', 'コンデンサ', '一般'],
    steps: [
      StepItem(tex: r"""\textcolor{brown}{\large{【電磁気学】}}"""),
      StepItem(tex: r"""\text{• コンデンサのみの回路に交流をかけた時、キルヒホッフ第二法則を適用すると、} \displaystyle \frac{Q(t)}{C} = V_0\sin(\omega t) \text{という微分方程式になる。}"""),
      StepItem(tex: r"""\text{• 電圧 }V_0\sin(\omega t)\text{ の位相}\omega t \text{よりも、電流 }I(t)\text{ の位相は}\displaystyle \frac{\pi}{2}\text{進む。}"""),
      StepItem(tex: r"""\text{• 電流 }I(t)\text{ の振幅は電圧振幅の} \omega C \text{倍} (容量性リアクタンス)"""),
      StepItem(tex: r"""\textcolor{brown}{\large{【問題の記号と電磁気学における記号の対応】}}"""),
      StepItem(tex: r"""\text{コンデンサのみ交流回路:} \ \displaystyle \frac{Q(t)}{C} = V_0\sin(\omega t)"""),
      StepItem(tex: r"""\text{• } f(t) \leftrightarrow I(t) \text{（電流）}"""),
      StepItem(tex: r"""\text{• } C \leftrightarrow C \text{（静電容量）}"""),
      StepItem(tex: r"""\text{• } A \leftrightarrow V_0 \text{（電圧振幅）}"""),
      StepItem(tex: r"""\text{• } \omega \leftrightarrow \omega \text{（角周波数）}"""),
      StepItem(tex: r"""\text{• } f(0)=0 \leftrightarrow I_0=0 \text{（初期電流）}"""),
      StepItem(tex: r"""\text{• 容量性リアクタンス：} X_C = \displaystyle \frac{1}{\omega C}"""),
      StepItem(tex: r"""\textcolor{brown}{\large{【解法】}}"""),
      StepItem(tex: r"""\displaystyle \frac{\int_0^t f(s) \, ds}{C} = A\sin(\omega t)"""),
      StepItem(tex: r"""\text{両辺を}C\text{で掛ける：}"""),
      StepItem(tex: r"""\Leftrightarrow \ \int_0^t f(s) \, ds = CA\sin(\omega t)"""),
      StepItem(tex: r"""\text{両辺を微分：}"""),
      StepItem(tex: r"""\Leftrightarrow \ f(t) = \omega CA\cos(\omega t)"""),
      StepItem(tex: r"""\text{位相差を明確にするため、三角関数の変換公式で変形：}"""),
      StepItem(tex: r"""\Leftrightarrow \ f(t) = \omega CA\sin\left(\omega t + \displaystyle \frac{\pi}{2}\right)"""),
    ],
  ),



  // --- 比例抵抗（指数減衰：RC放電 数値） ---
  MathProblem(
    id: "035BEF48-5556-4099-9AD4-1FBE772833CE",
    no: 103,
    category: '数値・一階・斉次',
    level: '初級',
    question: r"""f'(t)=-2\,f(t),\quad f(0)=f_0""",
    answer: r"""f(t)=f_0 e^{-2 t}""",
    imageAsset: '',
    equation: r"""f'(t)=-2\,f(t)""",
    conditions: r"""f(0)=f_0""",
    constants: r"""""",
    keywords: ['数値', '直流', '電圧0', 'コンデンサ', '抵抗'],
    steps: [
      StepItem(tex: r"""\textcolor{brown}{\large{【力学】}}"""),
      StepItem(tex: r"""\text{• 力学の空気抵抗を受ける質点の速度減衰は} v'(t) + \displaystyle \frac{k}{m}v(t) = 0 \text{ でモデル化される。速度は指数関数的に減少する。}"""),
      StepItem(tex: r"""\textcolor{brown}{\large{【電磁気学】}}"""),
      StepItem(tex: r"""\text{• RC放電。コンデンサの電荷の指数関数的減少。}"""),
      StepItem(tex: r"""\text{• 電磁気学のRC回路においては、キルヒホッフの第二法則より、}
      RI(t) + \displaystyle \frac{Q(t)}{C} = 0 \text{が成り立ち、これを}R\text{で割って両辺微分すると、}
      I'(t) + \displaystyle \frac{1}{RC}I(t) = 0 \text{ を得る。これはRC回路の放電過程の回路に流れる電流の時間変化を表す。}"""),
      StepItem(tex: r"""\textcolor{brown}{\large{【問題の記号と力学における記号の対応】}}"""),
      StepItem(tex: r"""\text{空気抵抗下での質点の運動:} \ v'(t) + \displaystyle \frac{k}{m}v(t) = 0"""),
      StepItem(tex: r"""\text{• } f(t) \leftrightarrow v(t) \text{（速度）}"""),
      StepItem(tex: r"""\text{• } 2 \leftrightarrow \displaystyle \frac{k}{m} \text{（抵抗係数 ÷ 質量）}"""),
      StepItem(tex: r"""\text{• } f_0 \leftrightarrow v_0 \text{（初期速度）}"""),
      StepItem(tex: r"""\textcolor{brown}{\large{【問題の記号と電磁気学における記号の対応】}}"""),
      StepItem(tex: r"""\text{RC回路の放電:} \ I'(t) + \displaystyle \frac{1}{RC}I(t) = 0"""),
      StepItem(tex: r"""\text{• } f(t) \leftrightarrow I(t) \text{（電流）}"""),
      StepItem(tex: r"""\text{• } 2 \leftrightarrow \displaystyle \frac{1}{RC} \text{（時定数の逆数）}"""),
      StepItem(tex: r"""\text{• } f_0 \leftrightarrow I_0 \text{（初期電流）}"""),
      StepItem(tex: r"""\textcolor{brown}{\large{【解法】}}"""),
      StepItem(tex: r"""f'(t) + 2f(t) = 0"""),
      StepItem(tex: r"""\text{両辺に}e^{2t}\text{ を掛ける。(こうやるとうまくいく)}"""),
      StepItem(tex: r"""\Leftrightarrow \ e^{2t}f'(t) + 2e^{2t}f(t) = 0"""),
      StepItem(tex: r"""\text{積の微分より}"""),
      StepItem(tex: r"""\Leftrightarrow (e^{2t}f(t))' = 0"""),
      StepItem(tex: r"""\text{両辺を }0 \text{ から }t \text{ まで定積分する：}"""),
      StepItem(tex: r"""
\begin{aligned}
&\Leftrightarrow \int_0^t (e^{2s}f(s))'\,ds = \int_0^t 0\,ds\\[5pt]
&\Leftrightarrow [e^{2s}f(s)]_{0}^{t} = 0\\[5pt]
&\Leftrightarrow \ e^{2t}f(t) - e^0 f(0) = 0\\[5pt]
&\Leftrightarrow \ e^{2t}f(t) = f(0)
\end{aligned}
"""),
      StepItem(tex: r"""\text{初期条件より} f(0) = f_0 \text{なので、}"""),
      StepItem(tex: r"""\Leftrightarrow \ e^{2t}f(t) = f_0"""),
      StepItem(tex: r"""\Leftrightarrow \ f(t) = f_0e^{-2t}"""),
      StepItem(tex: r"""\text{この解は指数減衰関数で、減衰定数 }2\text{ で指数関数的に減少する。}"""),
    ],
  ),


  // --- 目標到達（一次遅れ：RL直流立上がり 数値） ---
  MathProblem(
    id: "D2706488-8F89-46F4-8636-834028B00CFC",
    no: 104,
    category: '数値・一階・非斉次',
    level: '初級',
    question: r"""f'(t)+3\,f(t)=2\ ,\quad f(0)=1""",
    answer: r"""f(t)=\dfrac{2}{3}+\dfrac{1}{3}e^{-3 t}""",
    imageAsset: '',
    equation: r"""f'(t)+3\,f(t)=2""",
    conditions: r"""f(0)=1""",
    constants: r"""""",    keywords: ['空気抵抗',  '直流', '数値', 'コイル', '抵抗'],

    steps: [
      StepItem(tex: r"""\textcolor{brown}{\large{【力学】}}"""),
      StepItem(tex: r"""\text{• 力学の空気抵抗を受ける質点の自由落下は} v'(t) = -\displaystyle \frac{k}{m}v(t) + g \text{ でモデル化され、速度は指数関数的に}\ \displaystyle \frac{mg}{k} \text{に収束する。}"""),
      StepItem(tex: r"""\textcolor{brown}{\large{【電磁気学】}}"""),
      StepItem(tex: r"""\text{• 直流電圧を印加したRL回路について、キルヒホッフの第二法則を適用すると、微分方程式}
      LI'(t) + RI(t) = V \text{を得られ、両辺をコイルの自己インダクタンス}L \text{で割ると、問題の式の形に帰着される。電流の値は指数関数的}\ \displaystyle \frac{V}{R} \text{に収束する。}"""),
      StepItem(tex: r"""\textcolor{brown}{\large{【問題の記号と力学における記号の対応】}}"""),
      StepItem(tex: r"""\text{空気抵抗を受ける自由落下の運動方程式:} \ mv'(t) = -kv(t)+mg"""),
      StepItem(tex: r"""\text{• } f(t) \leftrightarrow v(t) \text{（速度）}"""),
      StepItem(tex: r"""\text{• } 3 \leftrightarrow \displaystyle \frac{k}{m} \text{（抵抗係数 ÷ 質量）}"""),
      StepItem(tex: r"""\text{• } \displaystyle \frac 2 3 \leftrightarrow \displaystyle \frac{mg}{k} \text{(終端速度)}"""),
      StepItem(tex: r"""\text{• } 2 \leftrightarrow \displaystyle \frac{mg}{m} = g \text{（重力加速度）}"""),
      StepItem(tex: r"""\text{• } f(0)=1 \leftrightarrow v_0=1 \text{（初期速度）}"""),
      StepItem(tex: r"""\textcolor{brown}{\large{【問題の記号と電磁気学における記号の対応】}}"""),
      StepItem(tex: r"""\text{RL回路(直流):} \ LI'(t) + RI(t) = V"""),
      StepItem(tex: r"""\text{• } f(t) \leftrightarrow I(t) \text{（電流）}"""),
      StepItem(tex: r"""\text{• } 3 \leftrightarrow \displaystyle \frac{R}{L} \text{（時定数の逆数）}"""),
      StepItem(tex: r"""\text{• } 2 \leftrightarrow \displaystyle \frac{V}{L} \text{（電圧 ÷ インダクタンス）}"""),
      StepItem(tex: r"""\text{• } \displaystyle \frac 2 3 \leftrightarrow \displaystyle \frac{V}{R} \text{（定常電流）}"""),
      StepItem(tex: r"""\text{• } f(0)=1 \leftrightarrow I_0=1 \text{（初期電流）}"""),
      StepItem(tex: r"""\textcolor{brown}{\large{【解法】}}"""),
      StepItem(tex: r"""f'(t) + 3f(t) = 2"""),
      StepItem(tex: r"""\text{両辺に}e^{3t}\text{ を掛ける。(こうやるとうまくいく)}"""),
      StepItem(tex: r"""\Leftrightarrow \ e^{3t}f'(t) + 3e^{3t}f(t) = 2e^{3t}"""),
      StepItem(tex: r"""\text{積の微分より}"""),
      StepItem(tex: r"""\Leftrightarrow (e^{3t}f(t))' = 2e^{3t}"""),
      StepItem(tex: r"""\text{両辺を }0\text{ から }t\text{ まで定積分：}"""),
      StepItem(tex: r"""
\begin{aligned}
&\Leftrightarrow \int_0^t (e^{3s}f(s))'\,ds = \int_0^t 2e^{3s}\,ds\\[5pt]
&\Leftrightarrow [e^{3s}f(s)]_{0}^{t} = \left[\displaystyle \frac{2}{3}e^{3s}\right]_{0}^{t}\\[5pt]
&\Leftrightarrow \ e^{3t}f(t) - e^0 f(0) = \displaystyle \frac{2}{3}e^{3t} - \displaystyle \frac{2}{3}e^0\\[5pt]
&\Leftrightarrow \ e^{3t}f(t) = f(0) + \displaystyle \frac{2}{3}(e^{3t}-1)
\end{aligned}
"""),
      StepItem(tex: r"""\text{初期条件より} f(0) = 1 \text{なので、}"""),
      StepItem(tex: r"""\Leftrightarrow \ e^{3t}f(t) = 1 + \displaystyle \frac{2}{3}(e^{3t}-1)"""),
      StepItem(tex: r"""\Leftrightarrow \ e^{3t}f(t) = \displaystyle \frac{2}{3}e^{3t} + \displaystyle \frac{1}{3}"""),
      StepItem(tex: r"""\Leftrightarrow \ f(t) = \displaystyle \frac{2}{3} + \displaystyle \frac{1}{3}e^{-3t}"""),
      StepItem(tex: r"""\text{この解は目標値}\displaystyle \frac 2 3 \text{への指数関数的収束で、時定数 }\displaystyle \frac{1}{3}\text{ で収束する。}"""),
    ],
  ),


  // --- 線形抵抗　一定外力（一次→位置：直線＋指数関数 数値） ---
  MathProblem(
    id: "5FFA2B66-BA71-44F4-9834-EF997E17081D",
    no: 105,
    category: '数値・二階・非斉次',
    level: '初級',
    question: r"""f''(t)+3\,f'(t)=2,\quad f(0)=1,\ f'(0)=5""",
    answer: r"""f(t)=\dfrac{22}{9} + \dfrac{2}{3}t-\dfrac{13}{9}e^{-3 t}""",
    imageAsset: '',
    equation: r"""f''(t)+3\,f'(t)=2""",
    conditions: r"""f(0)=1,\ f'(0)=5""",
    constants: r"""""",    keywords: ['空気抵抗',  '直流', '数値', 'コイル', '抵抗'],

    steps: [
      StepItem(tex: r"""\textcolor{brown}{\large{【力学】}}"""),
      StepItem(tex: r"""\text{• 力学の空気抵抗下での一定外力運動は} mx'' + kx' = mg \text{ でモデル化される。}"""),
      StepItem(tex: r"""\text{• 速度は指数関数的に終端速度} \displaystyle \frac{mg}{k} \text{ に収束する。終端速度に近くになると、外力と抵抗力がつり合った、等速直線運動に近似できる。}"""),
      StepItem(tex: r"""\textcolor{brown}{\large{【問題の記号と力学における記号の対応】}}"""),
      StepItem(tex: r"""\text{空気抵抗下での一定外力運動:} \ mx''(t) + kx'(t) = mg"""),
      StepItem(tex: r"""\text{• } f(t) \leftrightarrow x(t) \text{（位置）}"""),
      StepItem(tex: r"""\text{• } f'(t) \leftrightarrow v(t) \text{（速度）}"""),
      StepItem(tex: r"""\text{• } f''(t) \leftrightarrow a(t) \text{（加速度）}"""),
      StepItem(tex: r"""\text{• } 3 \leftrightarrow \displaystyle \frac{k}{m} \text{（抵抗係数 ÷ 質量）}"""),
      StepItem(tex: r"""\text{• } 2 \leftrightarrow \displaystyle \frac{mg}{m} = g \text{（重力加速度）}"""),
      StepItem(tex: r"""\text{• } f(0)=1 \leftrightarrow x_0=1 \text{（初期位置）}"""),
      StepItem(tex: r"""\text{• } f'(0)=5 \leftrightarrow v_0=5 \text{（初期速度）}"""),
      // StepItem(tex: r"""\text{【問題の記号と電磁気学における記号の対応】}"""),
      // StepItem(tex: r"""\text{RL回路での電荷量変化}"""),
      // StepItem(tex: r"""Lq''(t) + Rq'(t) = V"""),
      // StepItem(tex: r"""\text{• } f(t) \leftrightarrow q(t) \text{（電荷）}"""),
      // StepItem(tex: r"""\text{• } f'(t) \leftrightarrow I(t) \text{（電流）}"""),
      // StepItem(tex: r"""\text{• } f''(t) \leftrightarrow I' \text{（電流変化率）}"""),
      // StepItem(tex: r"""\text{• } 3 \leftrightarrow \displaystyle \frac{R}{L} \text{（抵抗 ÷ インダクタンス）}"""),
      // StepItem(tex: r"""\text{• } 2 \leftrightarrow \displaystyle \frac{V}{L} \text{（電圧 ÷ インダクタンス）}"""),
      // StepItem(tex: r"""\text{• } f(0)=1 \leftrightarrow q_0=1 \text{（初期電荷）}"""),
      // StepItem(tex: r"""\text{• } f'(0)=5 \leftrightarrow I_0=5 \text{（初期電流）}"""),
      StepItem(tex: r"""\textcolor{brown}{\large{【解法】}}"""),
      StepItem(tex: r"""f''(t) + 3f'(t) = 2"""),
      StepItem(tex: r"""\text{置換：}u(t) = f'(t)\text{ とおくと、}"""),
      StepItem(tex: r"""\Leftrightarrow \ u'(t) + 3u(t) = 2"""),
      StepItem(tex: r"""\text{両辺に}e^{3t}\text{ を掛ける。(こうやるとうまくいく)}"""),
      StepItem(tex: r"""\Leftrightarrow \ e^{3t}u'(t) + 3e^{3t}u(t) = 2e^{3t}"""),
      StepItem(tex: r"""\text{積の微分より}"""),
      StepItem(tex: r"""\Leftrightarrow (e^{3t}u(t))' = 2e^{3t}"""),
      StepItem(tex: r"""\text{両辺を }0\text{ から }t\text{ まで定積分：}"""),
      StepItem(tex: r"""
\begin{aligned}
&\Leftrightarrow \int_0^t (e^{3s}u(s))'\,ds = \int_0^t 2e^{3s}\,ds\\[5pt]
&\Leftrightarrow [e^{3s}u(s)]_{0}^{t} = \left[\displaystyle \frac{2}{3}e^{3s}\right]_{0}^{t}\\[5pt]
&\Leftrightarrow \ e^{3t}u(t) - e^0 u(0) = \displaystyle \frac{2}{3}e^{3t} - \displaystyle \frac{2}{3}e^0\\[5pt]
&\Leftrightarrow \ e^{3t}u(t) = u(0) + \displaystyle \frac{2}{3}(e^{3t}-1)
\end{aligned}
"""),
      StepItem(tex: r"""\text{初期条件より} u(0) = 5 \text{なので、}"""),
      StepItem(tex: r"""\Leftrightarrow \ e^{3t}u(t) = 5 + \displaystyle \frac{2}{3}(e^{3t}-1)"""),
      StepItem(tex: r"""\Leftrightarrow \ e^{3t}u(t) = \displaystyle \frac{2}{3}e^{3t} + 5 - \displaystyle \frac{2}{3}"""),
      StepItem(tex: r"""\Leftrightarrow \ e^{3t}u(t) = \displaystyle \frac{2}{3}e^{3t} + \displaystyle \frac{13}{3}"""),
      StepItem(tex: r"""\Leftrightarrow \ u(t) = \displaystyle \frac{2}{3} + \displaystyle \frac{13}{3}e^{-3t}"""),
      StepItem(tex: r"""\text{元の変数に戻す：}f'(t) = u(t)\text{ より}"""),
      StepItem(tex: r"""\text{両辺を }0\text{ から }t\text{ まで定積分：}"""),
      StepItem(tex: r"""
\begin{aligned}
&\Leftrightarrow \int_0^t f'(s)\,ds = \int_0^t u(s)\,ds\\[5pt]
&\Leftrightarrow [f(s)]_{0}^{t} = \int_0^t \left[\displaystyle \frac{2}{3} + \displaystyle \frac{13}{3}e^{-3s}\right]ds\\[5pt]
&\Leftrightarrow \ f(t) - f(0) = \left[\displaystyle \frac{2}{3}s\right]_{0}^{t} + \displaystyle \frac{13}{3}\left[-\displaystyle \frac{1}{3}e^{-3s}\right]_{0}^{t}\\[5pt]
&\Leftrightarrow \ f(t) = f(0) + \displaystyle \frac{2}{3}t - 0 + \displaystyle \frac{13}{3}\left(-\displaystyle \frac{1}{3}e^{-3t} + \displaystyle \frac{1}{3}e^0\right)
\end{aligned}
"""),
      StepItem(tex: r"""\text{初期条件より} f(0) = 1 \text{なので、}"""),
      StepItem(tex: r"""\Leftrightarrow \ f(t) = 1 + \displaystyle \frac{2}{3}t + \displaystyle \frac{13}{3}\left(-\displaystyle \frac{1}{3}e^{-3t} + \displaystyle \frac{1}{3}\right)"""),
      StepItem(tex: r"""\Leftrightarrow \ f(t) = 1 + \displaystyle \frac{2}{3}t - \displaystyle \frac{13}{9}e^{-3t} + \displaystyle \frac{13}{9}"""),
      StepItem(tex: r"""\Leftrightarrow \ f(t) = \displaystyle \frac{22}{9} + \displaystyle \frac{2}{3}t - \displaystyle \frac{13}{9}e^{-3t}"""),
      StepItem(tex: r"""\text{この解は直線＋指数関数の形で、減衰定数 }3\text{ で指数関数的に収束する。}"""),
    ],
  ),



  // --- 一次遅れ交流（RL交流 60°） ---
  MathProblem(
    id: "666687A5-6EF8-434E-9209-818CE7092863",
    no: 110,
    category: '数値・一階・非斉次',
    level: '中級',
    question: r"""\sqrt{3}f'(t)+2f(t)=3\sqrt{3}\cos(2t),\quad f(0)=0""",
    answer: r"""f(t)=\displaystyle \frac{3\sqrt{3}}{4}\cos \left( 2t- \displaystyle \frac{\pi}{3} \right)-\displaystyle \frac{3\sqrt{3}}{8}e^{- \frac{2}{\sqrt{3}}t}""",
    imageAsset: '',
    equation: r"""\sqrt{3}f'(t)+2f(t)=3\sqrt{3}\cos(2t)""",
    conditions: r"""f(0)=0""",
    constants: r"""""",    keywords: [ '交流',  '数値', 'コイル', '抵抗'],

    steps: [
      // StepItem(tex: r"""\text{【力学】}"""),
      // StepItem(tex: r"""\text{• 力学の空気抵抗下での強制振動は} mv'(t) + kv(t) = F_0\cos(\omega t) \text{ でモデル化される。}"""),
      StepItem(tex: r"""\textcolor{brown}{\large{【電磁気学】}}"""),
      StepItem(tex: r"""\text{• RL交流回路について、キルヒホッフの第二法則を用いると }
      LI'(t) + RI(t) = V_0\cos(\omega t) \text{が成り立つ。}"""),
      // StepItem(tex: r"""\text{【問題の記号と力学における記号の対応】}"""),
      // StepItem(tex: r"""\text{空気抵抗下での強制振動:} \ mv'(t) + kv(t) = F_0\cos(\omega t)"""),
      // StepItem(tex: r"""\text{• } f(t) \leftrightarrow v(t) \text{（速度）}"""),
      // StepItem(tex: r"""\text{• } m \leftrightarrow \sqrt{3} \text{（質量）}"""),
      // StepItem(tex: r"""\text{• } k \leftrightarrow 2 \text{（抵抗係数）}"""),
      // StepItem(tex: r"""\text{• } F_0 \leftrightarrow 3\sqrt{3} \text{（外力振幅）}"""),
      // StepItem(tex: r"""\text{• } \omega \leftrightarrow 2 \text{（角周波数）}"""),
      // StepItem(tex: r"""\text{• } f_0 \leftrightarrow v_0 \text{（初期速度）}"""),
      StepItem(tex: r"""\text{【問題の記号とRL交流回路における記号の対応】}"""),
      StepItem(tex: r"""\text{• } f(t) \leftrightarrow I(t) \text{（電流）}"""),
      StepItem(tex: r"""\text{• } \sqrt{3} \leftrightarrow L \text{（インダクタンス）}"""),
      StepItem(tex: r"""\text{• } 2 \leftrightarrow R \text{（抵抗）}"""),
      StepItem(tex: r"""\text{• } 3\sqrt{3} \leftrightarrow V_0 \text{（電圧振幅）}"""),
      StepItem(tex: r"""\text{• } \displaystyle \frac{2}{\sqrt{3}} \leftrightarrow \displaystyle \frac{R}{L} \text{（時定数の逆数）}"""),
      StepItem(tex: r"""\text{• } 3 \leftrightarrow \displaystyle \frac{V_0}{L} \text{（電圧振幅 ÷ インダクタンス）}"""),
      StepItem(tex: r"""\text{• } 2 \leftrightarrow \omega \text{（角周波数）}"""),
      StepItem(tex: r"""\text{• } 0 \leftrightarrow I_0 \text{（初期電流）}"""),
      StepItem(tex: r"""\text{• } |Z| = \sqrt{(2\sqrt{3})^2+2^2} = 4 \leftrightarrow \sqrt{R^2+(\omega L)^2} \text{（インピーダンスの大きさ）}"""),
      StepItem(tex: r"""\text{• } \displaystyle \frac{3}{\sqrt{\left(\displaystyle \frac{2}{\sqrt{3}}\right)^2+2^2}}= \frac {3 \sqrt 3}{4} \leftrightarrow \displaystyle \frac{V_0}{\sqrt{R^2+(\omega L)^2}} = \displaystyle \frac{V_0}{|Z|} \text{（定常電流の振幅）}"""),
      StepItem(tex: r"""\text{• } \tan\alpha = \displaystyle \frac{2}{\displaystyle \frac{2}{\sqrt{3}}} = \sqrt 3 \Leftrightarrow \alpha = \frac \pi 3 \leftrightarrow \displaystyle \frac{\omega L}{R} \text{（位相遅れ角）}"""),
      StepItem(tex: r"""\textcolor{red}{\textbf{指数関数×三角関数の積分公式：}}"""),
      StepItem(tex: r"""\textcolor{red}{\displaystyle \int e^{a t}\cos(\omega t)\,dt=\displaystyle \frac{e^{a t}}{a^2+\omega^2}\big(a\cos(\omega t)+\omega\sin(\omega t)\big)}"""),
      StepItem(tex: r"""\textcolor{brown}{\large{【解法】}}"""),
      StepItem(tex: r"""\sqrt{3}f'(t) + 2f(t) = 3\sqrt{3}\cos(2t)"""),
      StepItem(tex: r"""\text{両辺を } \sqrt{3} \text{ で割って標準形に変形：}"""),
      StepItem(tex: r"""\Leftrightarrow \ f'(t) + \displaystyle \frac{2}{\sqrt{3}}f(t) = 3\cos(2t)"""),
      StepItem(tex: r"""\text{両辺に}e^{ \frac{2}{\sqrt{3}}t}\text{ を掛ける。(こうやるとうまくいく)}"""),
      StepItem(tex: r"""\Leftrightarrow \ e^{ \frac{2}{\sqrt{3}}t}f'(t) + \displaystyle \frac{2}{\sqrt{3}}e^{ \frac{2}{\sqrt{3}}t}f(t) = 3e^{ \frac{2}{\sqrt{3}}t}\cos(2t)"""),
      StepItem(tex: r"""\text{積の微分より}"""),
      StepItem(tex: r"""\Leftrightarrow (e^{ \frac{2}{\sqrt{3}}t}f(t))' = 3e^{ \frac{2}{\sqrt{3}}t}\cos(2t)"""),
      StepItem(tex: r"""\text{両辺を }0\text{ から }t\text{ まで定積分：}"""),
      StepItem(tex: r"""\Leftrightarrow \int_0^t \left(e^{ \frac{2}{\sqrt{3}}s}f(s)\right)'\,ds = \int_0^t 3e^{ \frac{2}{\sqrt{3}}s}\cos(2s)\,ds"""),
      StepItem(tex: r"""\Leftrightarrow \left[e^{ \frac{2}{\sqrt{3}}s}f(s)\right]_{0}^{t} = 3\int_0^t e^{ \frac{2}{\sqrt{3}}s}\cos(2s)\,ds"""),
      StepItem(tex: r"""\Leftrightarrow \ e^{ \frac{2}{\sqrt{3}}t}f(t) - e^0 f(0) = 3\int_0^t e^{ \frac{2}{\sqrt{3}}s}\cos(2s)\,ds"""),
      StepItem(tex: r"""\Leftrightarrow \ e^{ \frac{2}{\sqrt{3}}t}f(t) = 3\int_0^t e^{ \frac{2}{\sqrt{3}}s}\cos(2s)\,ds"""),
      StepItem(tex: r"""\Leftrightarrow \ f(t) = 3e^{ -\frac{2}{\sqrt{3}}t}\int_0^t e^{ \frac{2}{\sqrt{3}}s}\cos(2s)\,ds"""),
      StepItem(tex: r"""\textcolor{red}{\textbf{ここで右辺は積分公式より、不定積分は}}"""),
      StepItem(tex: r"""\textcolor{red}{\int e^{\frac{2}{\sqrt{3}}s}\cos(2s)\,ds = \displaystyle \frac{e^{\frac{2}{\sqrt{3}}s}}{\left(\frac{2}{\sqrt{3}}\right)^2+2^2}\left(\frac{2}{\sqrt{3}}\cos(2s)+2\sin(2s)\right) + C}"""),
      StepItem(tex: r"""\textcolor{green}{したがって、定積分は}"""),
      StepItem(tex: r"""\textcolor{green}{\int_0^t e^{\frac{2}{\sqrt{3}}s}\cos(2s)\,ds = \left[\displaystyle \frac{e^{\frac{2}{\sqrt{3}}s}}{\left(\frac{2}{\sqrt{3}}\right)^2+2^2}\left(\frac{2}{\sqrt{3}}\cos(2s)+2\sin(2s)\right)\right]_{0}^{t}}"""),
      StepItem(tex: r"""\textcolor{green}{= \displaystyle \frac{e^{\frac{2}{\sqrt{3}}t}}{\left(\frac{2}{\sqrt{3}}\right)^2+2^2}\left(\frac{2}{\sqrt{3}}\cos(2t)+2\sin(2t)\right) - \displaystyle \frac{1}{\left(\frac{2}{\sqrt{3}}\right)^2+2^2}\left(\frac{2}{\sqrt{3}}\cos(0)+2\sin(0)\right)}"""),
      StepItem(tex: r"""\textcolor{green}{= \displaystyle \frac{e^{\frac{2}{\sqrt{3}}t}}{\left(\frac{2}{\sqrt{3}}\right)^2+2^2}\left(\frac{2}{\sqrt{3}}\cos(2t)+2\sin(2t)\right) - \displaystyle \frac{\frac{2}{\sqrt{3}}}{\left(\frac{2}{\sqrt{3}}\right)^2+2^2}}"""),
      StepItem(tex: r"""\text{ここで、} \left(\frac{2}{\sqrt{3}}\right)^2+2^2 = \frac{4}{3} + 4 = \frac{16}{3} \text{ より、}"""),
      StepItem(tex: r"""\textcolor{green}{= \displaystyle \frac{3e^{\frac{2}{\sqrt{3}}t}}{16}\left(\frac{2}{\sqrt{3}}\cos(2t)+2\sin(2t)\right) - \displaystyle \frac{3 \cdot \frac{2}{\sqrt{3}}}{16}}"""),
      StepItem(tex: r"""\text{よって、}"""),
      StepItem(tex: r"""\Leftrightarrow \ f(t) = 3e^{-\frac{2}{\sqrt{3}}t} \left( \displaystyle \frac{3e^{\frac{2}{\sqrt{3}}t}}{16}\left(\frac{2}{\sqrt{3}}\cos(2t)+2\sin(2t)\right) - \frac{3\sqrt{3}}{8} \right)"""),
      StepItem(tex: r"""\Leftrightarrow \ f(t) = \displaystyle \frac{9}{16}\left(\frac{2}{\sqrt{3}}\cos(2t)+2\sin(2t)\right) - \displaystyle \frac{3\sqrt{3}}{8}e^{-\frac{2}{\sqrt{3}}t}"""),
      StepItem(tex: r"""\Leftrightarrow \ f(t) = \displaystyle \frac{9}{16}\left(\frac{2}{\sqrt{3}}\cos(2t)+2\sin(2t)\right) - \displaystyle \frac{3\sqrt{3}}{8}e^{-\frac{2}{\sqrt{3}}t}"""),
      StepItem(tex: r"""\text{強制振動項を} \sqrt{\left(\displaystyle \frac{2}{\sqrt{3}}\right)^2+2^2} = \displaystyle \frac{4}{\sqrt{3}} \text{で括ると、}"""),
      StepItem(tex: r"""\Leftrightarrow \ f(t) = \displaystyle \frac{9}{16} \cdot \displaystyle \frac{4}{\sqrt{3}}\left(\displaystyle \frac{1}{2}\cos(2t) + \displaystyle \frac{\sqrt{3}}{2}\sin(2t)\right) - \displaystyle \frac{3\sqrt{3}}{8}e^{- \frac{2}{\sqrt{3}}t}"""),
      StepItem(tex: r"""\Leftrightarrow \ f(t) = \displaystyle \frac{3\sqrt{3}}{4}\cos\left(2t - \displaystyle \frac{\pi}{3}\right) - \displaystyle \frac{3\sqrt{3}}{8}e^{- \frac{2}{\sqrt{3}}t}"""),
      StepItem(tex: r"""\text{ここで、} t \to \infty \text{ のとき、 } e^{- \frac{2}{\sqrt{3}}t} \to 0 \text{ となるため、}"""),
      StepItem(tex: r"""f(t) = \displaystyle \frac{3\sqrt{3}}{4}\cos\left(2t - \displaystyle \frac{\pi}{3}\right) \text{に収束する。}"""),
      StepItem(tex: r"""\text{すなわち、右辺の三角関数の位相} \omega t \text{に比べて、解の関数の位相は} \displaystyle \frac{\pi}{3} \text{遅れる。}"""),
    ],
  ),



  // --- RC回路積分方程式（数値） ---
  MathProblem(
    id: "A6304C30-50F4-40E4-A056-A57A60548064",
    no: 111,
    category: '数値・一階・非斉次',
    level: '中級',
    question: r"""\displaystyle \frac{\int_0^t f(s) \, ds}{2}+\sqrt{3}f(t)=4\cos\left(\displaystyle \frac{t}{2}\right),\quad f(0)=0""",
    answer: r"""f(t)=2\cos\left(\displaystyle \frac{t}{2} + \displaystyle \frac{\pi}{6}\right)-\sqrt{3}e^{- \frac{t}{2\sqrt{3}}}""",
    imageAsset: '',
    equation: r"""\displaystyle \frac{\int_0^t f(s) \, ds}{2}+\sqrt{3}f(t)=4\cos\left(\displaystyle \frac{t}{2}\right)""",
    conditions: r"""f(0)=0""",
    constants: r"""""",
    keywords: [ '交流',  'コンデンサ', '抵抗',  '数値'],

    steps: [
      // StepItem(tex: r"""\text{【力学】}"""),
      // StepItem(tex: r"""\text{• 力学の空気抵抗と復元力を受ける質点の強制振動は} mv'(t) + kv(t) + k\int_0^t v(s)ds = F_0\cos(\omega t) \text{ でモデル化される。}"""),
      // StepItem(tex: r"""\text{• 定常状態では、速度 }v(t) \text{ は外力と同じ角周波数 } \omega \text{ で振動し、振幅は } \displaystyle \frac{F_0}{\sqrt{\left(\frac{k}{m}\right)^2+\left(\displaystyle \frac{1}{\frac{\omega m}{k}}\right)^2}} \text{ となる}"""),
      StepItem(tex: r"""\textcolor{brown}{\large{【電磁気学】}}"""),
      StepItem(tex: r"""\text{• RC交流回路について、コンデンサ初期電荷0のとき、キルヒホッフの第二法則を用いると }
      RI(t) + \displaystyle \frac{1}{C}\int_0^t I(s)\,ds = V_0\cos(\omega t) \text{が成り立つ。}"""),
      StepItem(tex: r"""\text{• 定常状態では、電流 }I(t) \text{ は電圧と同じ角周波数 } \omega \text{ で振動し、振幅は } \displaystyle \frac{V_0}{\sqrt{R^2+\left(\displaystyle \frac{1}{\omega C}\right)^2}} \text{ となる}"""),
      // StepItem(tex: r"""\text{【問題の記号と力学における記号の対応】}"""),
      // StepItem(tex: r"""\text{空気抵抗下での強制振動:} \ mv'(t) + kv(t) + k\int_0^t v(s)ds = F_0\cos(\omega t)"""),
      // StepItem(tex: r"""\text{• } f(t) \leftrightarrow v(t) \text{（速度）}"""),
      // StepItem(tex: r"""\text{• } 2 \leftrightarrow \displaystyle \frac{1}{k} \text{（ばね定数の逆数）}"""),
      // StepItem(tex: r"""\text{• } \sqrt{3} \leftrightarrow \displaystyle \frac{k}{m} \text{（抵抗係数 ÷ 質量）}"""),
      // StepItem(tex: r"""\text{• } F \leftrightarrow \displaystyle \frac{F_0}{m} \text{（外力振幅 ÷ 質量）}"""),
      // StepItem(tex: r"""\text{• } \displaystyle \frac{t}{2} \leftrightarrow \omega t \text{（角周波数}\omega=\displaystyle \frac{1}{2}\text{）}"""),
      // StepItem(tex: r"""\text{• } f(0)=0 \leftrightarrow v_0=0 \text{（初期速度）}"""),
      StepItem(tex: r"""\textcolor{brown}{\large{【問題の記号と電磁気学における記号の対応】}}"""),
      StepItem(tex: r"""\text{RC交流回路(コンデンサ初期電荷0の場合):} \ \displaystyle \frac{1}{C}\int_0^t I(s)ds + RI(t) = V_0\cos(\omega t)"""),
      StepItem(tex: r"""\text{• } f(t) \leftrightarrow I(t) \text{（電流）}"""),
      StepItem(tex: r"""\text{• } 2 \leftrightarrow C \text{（静電容量）}"""),
      StepItem(tex: r"""\text{• } \sqrt{3} \leftrightarrow R \text{（抵抗）}"""),
      StepItem(tex: r"""\text{• } 4 \leftrightarrow V_0 \text{（電圧振幅）}"""),
      StepItem(tex: r"""\text{• } \displaystyle \frac{1}{2} \leftrightarrow \omega \text{（角周波数）}"""),
      StepItem(tex: r"""\text{• } 0 \leftrightarrow I_0 \text{（初期電流）}"""),
      StepItem(tex: r"""\text{• } |Z| = \sqrt{(\sqrt{3})^2+\left(\displaystyle \frac{1}{\displaystyle \frac{1}{2} \times 2}\right)^2} = 2 \leftrightarrow \sqrt{R^2+\left(\displaystyle \frac{1}{\omega C}\right)^2} \text{（インピーダンスの大きさ）}"""),
      StepItem(tex: r"""\text{• } \displaystyle \frac{4}{\sqrt{(\sqrt{3})^2+\left(\displaystyle \frac{1}{\displaystyle \frac{1}{2} \times 2}\right)^2}} = 2 \leftrightarrow \displaystyle \frac{V_0}{\sqrt{R^2+\left(\displaystyle \frac{1}{\omega C}\right)^2}} = \displaystyle \frac{V_0}{|Z|} \text{（定常電流の振幅）}"""),
      StepItem(tex: r"""\text{• } \tan\alpha = \displaystyle \frac{1}{\displaystyle \frac{1}{2} \times 2 \times \sqrt{3}} = \displaystyle \frac{1}{\sqrt{3}} \Leftrightarrow \alpha = \displaystyle \frac{\pi}{6} \leftrightarrow \displaystyle \frac{1}{\omega RC} \text{（位相進み角）}"""),  
      StepItem(tex: r"""\textcolor{brown}{\large{【解法】}}"""),
      StepItem(tex: r"""\displaystyle \frac{\int_0^t f(s) \, ds}{2} + \sqrt{3}f(t) = 4\cos\left(\displaystyle \frac{t}{2}\right)"""),
      StepItem(tex: r"""\text{両辺を微分：}"""),
      StepItem(tex: r"""\Leftrightarrow \ \displaystyle \frac{f(t)}{2} + \sqrt{3}f'(t) = -2\sin\left(\displaystyle \frac{t}{2}\right)"""),
      StepItem(tex: r"""\Leftrightarrow \ f'(t) + \displaystyle \frac{1}{2\sqrt{3}}f(t) = -\displaystyle \frac{2}{\sqrt{3}}\sin\left(\displaystyle \frac{t}{2}\right)"""),
      StepItem(tex: r"""\text{両辺に}e^{\frac{t}{2\sqrt{3}}}\text{ を掛ける。(こうやるとうまくいく)}"""),
      StepItem(tex: r"""\Leftrightarrow \ e^{\frac{t}{2\sqrt{3}}}f'(t) + \displaystyle \frac{1}{2\sqrt{3}}e^{\frac{t}{2\sqrt{3}}}f(t) = -\displaystyle \frac{2}{\sqrt{3}}e^{\frac{t}{2\sqrt{3}}}\sin\left(\displaystyle \frac{t}{2}\right)"""),
      StepItem(tex: r"""\text{積の微分より}"""),
      StepItem(tex: r"""\Leftrightarrow (e^{\frac{t}{2\sqrt{3}}}f(t))' = -\displaystyle \frac{2}{\sqrt{3}}e^{\frac{t}{2\sqrt{3}}}\sin\left(\displaystyle \frac{t}{2}\right)"""),
      StepItem(tex: r"""\Leftrightarrow \int_0^t (e^{\frac{s}{2\sqrt{3}}}f(s))'\,ds = -\displaystyle \frac{2}{\sqrt{3}}\int_0^t e^{\frac{s}{2\sqrt{3}}}\sin\left(\displaystyle \frac{s}{2}\right)\,ds"""),
      StepItem(tex: r"""\Leftrightarrow [e^{\frac{s}{2\sqrt{3}}}f(s)]_{0}^{t} = -\displaystyle \frac{2}{\sqrt{3}}\int_0^t e^{\frac{s}{2\sqrt{3}}}\sin\left(\displaystyle \frac{s}{2}\right)\,ds"""),
      StepItem(tex: r"""\Leftrightarrow \ e^{\frac{t}{2\sqrt{3}}}f(t) - 0 = -\displaystyle \frac{2}{\sqrt{3}}\int_0^t e^{\frac{s}{2\sqrt{3}}}\sin\left(\displaystyle \frac{s}{2}\right)\,ds"""),
      StepItem(tex: r"""\Leftrightarrow \ f(t) = -\displaystyle \frac{2}{\sqrt{3}}e^{-\frac{t}{2\sqrt{3}}} \int_0^t e^{\frac{s}{2\sqrt{3}}}\sin\left(\displaystyle \frac{s}{2}\right)\,ds"""),
      StepItem(tex: r"""\textcolor{red}{\textbf{ここで右辺は積分公式より、不定積分は}}"""),
      StepItem(tex: r"""\textcolor{red}{\int e^{\frac{s}{2\sqrt{3}}}\sin\left(\displaystyle \frac{s}{2}\right)\,ds = \displaystyle \frac{e^{\frac{s}{2\sqrt{3}}}}{\left(\frac{1}{2\sqrt{3}}\right)^2+\left(\frac{1}{2}\right)^2}\left(\frac{1}{2\sqrt{3}}\sin\left(\displaystyle \frac{s}{2}\right)-\frac{1}{2}\cos\left(\displaystyle \frac{s}{2}\right)\right) + C}"""),
      StepItem(tex: r"""\textcolor{green}{したがって、定積分は}"""),
      StepItem(tex: r"""\textcolor{green}{\int_0^t e^{\frac{s}{2\sqrt{3}}}\sin\left(\displaystyle \frac{s}{2}\right)\,ds = \left[\displaystyle \frac{e^{\frac{s}{2\sqrt{3}}}}{\left(\frac{1}{2\sqrt{3}}\right)^2+\left(\frac{1}{2}\right)^2}\left(\frac{1}{2\sqrt{3}}\sin\left(\displaystyle \frac{s}{2}\right)-\frac{1}{2}\cos\left(\displaystyle \frac{s}{2}\right)\right)\right]_{0}^{t}}"""),
      StepItem(tex: r"""\textcolor{green}{= \displaystyle \frac{e^{\frac{t}{2\sqrt{3}}}}{\left(\frac{1}{2\sqrt{3}}\right)^2+\left(\frac{1}{2}\right)^2}\left(\frac{1}{2\sqrt{3}}\sin\left(\displaystyle \frac{t}{2}\right)-\frac{1}{2}\cos\left(\displaystyle \frac{t}{2}\right)\right) - \displaystyle \frac{1}{\left(\frac{1}{2\sqrt{3}}\right)^2+\left(\frac{1}{2}\right)^2}\left(\frac{1}{2\sqrt{3}}\sin(0)-\frac{1}{2}\cos(0)\right)}"""),
      StepItem(tex: r"""\textcolor{green}{= \displaystyle \frac{e^{\frac{t}{2\sqrt{3}}}}{\left(\frac{1}{2\sqrt{3}}\right)^2+\left(\frac{1}{2}\right)^2}\left(\frac{1}{2\sqrt{3}}\sin\left(\displaystyle \frac{t}{2}\right)-\frac{1}{2}\cos\left(\displaystyle \frac{t}{2}\right)\right) + \displaystyle \frac{\frac{1}{2}}{\left(\frac{1}{2\sqrt{3}}\right)^2+\left(\frac{1}{2}\right)^2}}"""),
      StepItem(tex: r"""\text{ここで、} \left(\frac{1}{2\sqrt{3}}\right)^2+\left(\frac{1}{2}\right)^2 = \frac{1}{12} + \frac{1}{4} = \frac{1}{3} \text{ より、}"""),
      StepItem(tex: r"""\textcolor{green}{= \displaystyle \frac{\sqrt{3}e^{\frac{t}{2\sqrt{3}}}}{2}\sin\left(\displaystyle \frac{t}{2}\right) - \frac{3e^{\frac{t}{2\sqrt{3}}}}{2}\cos\left(\displaystyle \frac{t}{2}\right) + \frac{3}{2}}"""),
      StepItem(tex: r"""\text{よって、}"""),
      StepItem(tex: r"""\Leftrightarrow \ f(t) = -\displaystyle \frac{2}{\sqrt{3}}e^{-\frac{t}{2\sqrt{3}}} \left( \displaystyle \frac{\sqrt{3}e^{\frac{t}{2\sqrt{3}}}}{2}\sin\left(\displaystyle \frac{t}{2}\right) - \frac{3e^{\frac{t}{2\sqrt{3}}}}{2}\cos\left(\displaystyle \frac{t}{2}\right) + \frac{3}{2} \right)"""),
      StepItem(tex: r"""\Leftrightarrow \ f(t) = -\sin\left(\displaystyle \frac{t}{2}\right) + \sqrt{3}\cos\left(\displaystyle \frac{t}{2}\right) - \sqrt{3}e^{- \frac{t}{2\sqrt{3}}}"""),
      StepItem(tex: r"""\Leftrightarrow \ f(t) = \sqrt{3}\cos\left(\displaystyle \frac{t}{2}\right) - \sin\left(\displaystyle \frac{t}{2}\right) - \sqrt{3}e^{- \frac{t}{2\sqrt{3}}}"""),
      StepItem(tex: r"""\text{強制振動項を} \sqrt{(\sqrt{3})^2+1^2} = 2 \text{で括ると、}"""),
      StepItem(tex: r"""\Leftrightarrow \ f(t) = 2\left(\displaystyle \frac{\sqrt{3}}{2}\cos\left(\displaystyle \frac{t}{2}\right) - \frac{1}{2}\sin\left(\displaystyle \frac{t}{2}\right)\right) - \sqrt{3}e^{- \frac{t}{2\sqrt{3}}}"""),
      StepItem(tex: r"""\text{三角関数の合成により、}"""),
      StepItem(tex: r"""\Leftrightarrow \ f(t) = 2\cos\left(\displaystyle \frac{t}{2} + \displaystyle \frac{\pi}{6}\right) - \sqrt{3}e^{- \frac{t}{2\sqrt{3}}}"""),
      StepItem(tex: r"""\text{ここで、} t \to \infty \text{ のとき、 } e^{- \frac{t}{2\sqrt{3}}} \to 0 \text{ となるため、}"""),
      StepItem(tex: r"""f(t) = 2\cos\left(\displaystyle \frac{t}{2} + \displaystyle \frac{\pi}{6}\right) \text{に収束する。}"""),
      StepItem(tex: r"""\text{すなわち、右辺の三角関数の位相} \omega t \text{に比べて、解の関数の位相は} \displaystyle \frac{\pi}{6} \text{進む。}"""),
    ],
  ),


  // --- 交流をコイルに接続（数値） ---
  MathProblem(
    id: "448E166D-FEF8-4A70-8541-FCA04C82C7F8",
    no: 124,
    category: '数値・一階・非斉次',
    level: '初級',
    question: r"""2f'(t)=12\sin(4t),\quad f(0)=0""",
    answer: r"""f(t)=-\displaystyle \frac{3}{2}\cos(4t)+\displaystyle \frac{3}{2}""",
    imageAsset: '',
    equation: r"""2f'(t)=12\sin(4t)""",
    conditions: r"""f(0)=0""",
    constants: r"""""",
    keywords: ['交流', '数値', 'コイル'],
    steps: [
      StepItem(tex: r"""\textcolor{brown}{\large{【電磁気学】}}"""),
      StepItem(tex: r"""\text{• コイルのみの回路に交流をかけた時、キルヒホッフ第二法則を適用すると、} LI'(t) = V_0\sin(\omega t) \text{という微分方程式が出てくる。}"""),
      StepItem(tex: r"""\text{• 電圧 }V_0\sin(\omega t)\text{ の位相}\omega t \text{よりも、電流 }I(t)\text{ の位相は}\displaystyle \frac{\pi}{2}\text{遅れる。}"""),
      StepItem(tex: r"""\text{• 電流 }I(t)\text{ の振幅は電圧振幅の} \displaystyle \frac{1}{\omega L} \text{倍}"""),
      StepItem(tex: r"""\textcolor{brown}{\large{【問題の記号と電磁気学における記号の対応】}}"""),
      StepItem(tex: r"""\text{コイルのみ交流回路:} \ LI'(t) = V_0\sin(\omega t)"""),
      StepItem(tex: r"""\text{• } f(t) \leftrightarrow I(t) \text{（電流）}"""),
      StepItem(tex: r"""\text{• } 2 \leftrightarrow L \text{（インダクタンス）}"""),
      StepItem(tex: r"""\text{• } 12 \leftrightarrow V_0 \text{（電圧振幅）}"""),
      StepItem(tex: r"""\text{• } 4 \leftrightarrow \omega \text{（角周波数）}"""),
      StepItem(tex: r"""\text{• } f(0)=0 \leftrightarrow I_0=0 \text{（初期電流）}"""),
      StepItem(tex: r"""\text{• }4 \times 2 = 8 \leftrightarrow X_L = \omega L \text{(誘導性リアクタンス)} """),
      StepItem(tex: r"""\textcolor{brown}{\large{【解法】}}"""),
      StepItem(tex: r"""2f'(t) = 12\sin(4t)"""),
      StepItem(tex: r"""\text{両辺を}2\text{で割る：}"""),
      StepItem(tex: r"""\Leftrightarrow \ f'(t) = 6\sin(4t)"""),
      StepItem(tex: r"""\text{両辺を }0\text{ から }t\text{ まで定積分：}"""),
      StepItem(tex: r"""\Leftrightarrow \int_0^t f'(s)\,ds = \int_0^t 6\sin(4s)\,ds"""),
      StepItem(tex: r"""\Leftrightarrow [f(s)]_{0}^{t} = 6\int_0^t \sin(4s)\,ds"""),
      StepItem(tex: r"""\Leftrightarrow \ f(t) - f(0) = 6\left[-\displaystyle \frac{1}{4}\cos(4s)\right]_{0}^{t}"""),
      StepItem(tex: r"""\Leftrightarrow \ f(t) = f(0) + 6\left(-\displaystyle \frac{1}{4}\cos(4t) + \displaystyle \frac{1}{4}\cos(0)\right)"""),
      StepItem(tex: r"""\text{初期条件より} f(0) = 0 \text{なので、}"""),
      StepItem(tex: r"""\Leftrightarrow \ f(t) = 0 + 6\left(-\displaystyle \frac{1}{4}\cos(4t) + \displaystyle \frac{1}{4}\right)"""),
      StepItem(tex: r"""\Leftrightarrow \ f(t) = -\displaystyle \frac{3}{2}\cos(4t) + \displaystyle \frac{3}{2}"""),
      StepItem(tex: r"""\text{位相差を明確にするため、三角関数の変換公式で変形：}"""),
      StepItem(tex: r"""\Leftrightarrow \ f(t) = \displaystyle \frac{3}{2}\sin\left(4t - \displaystyle \frac{\pi}{2}\right) + \displaystyle \frac{3}{2}"""),
    ],
  ),


  // --- 交流をコンデンサに接続（数値） ---
  MathProblem(
    id: "7E10C37B-AB59-4B49-8037-D1D34D1B3055",
    no: 125,
    category: '数値・一階・非斉次',
    level: '初級',
    question: r"""\displaystyle \frac{\int_0^t f(s) \, ds}{0.2}=8\sin(10t),\quad f(0)=0""",
    answer: r"""f(t)=16\sin\left(10t+\displaystyle \frac{\pi}{2}\right)""",
    imageAsset: '',
    equation: r"""\displaystyle \frac{\int_0^t f(s) \, ds}{0.2}=8\sin(10t)""",
    conditions: r"""f(0)=0""",
    constants: r"""""",
    keywords: ['交流', '数値', 'コンデンサ'],
    steps: [
      StepItem(tex: r"""\textcolor{brown}{\large{【電磁気学】}}"""),
      StepItem(tex: r"""\text{• コンデンサのみの回路に交流をかけた時、キルヒホッフ第二法則を適用すると、} \displaystyle \frac{Q(t)}{C} = V_0\sin(\omega t) \text{という微分方程式が出てくる。}"""),
      StepItem(tex: r"""\text{• 電圧 }V_0\sin(\omega t)\text{ の位相}\omega t \text{よりも、電流 }I(t)\text{ の位相は}\displaystyle \frac{\pi}{2}\text{進む。}"""),
      StepItem(tex: r"""\text{• 電流 }I(t)\text{ の振幅は電圧振幅の} \omega C \text{倍}  (容量性リアクタンス)"""),
      StepItem(tex: r"""\textcolor{brown}{\large{【問題の記号と電磁気学における記号の対応】}}"""),
      StepItem(tex: r"""\text{コンデンサのみ交流回路:} \ \displaystyle \frac{Q(t)}{C} = V_0\sin(\omega t)"""),
      StepItem(tex: r"""\text{• } f(t) \leftrightarrow I(t) \text{（電流）}"""),
      StepItem(tex: r"""\text{• } 0.2 \leftrightarrow C \text{（静電容量）}"""),
      StepItem(tex: r"""\text{• } 8 \leftrightarrow V_0 \text{（電圧振幅）}"""),
      StepItem(tex: r"""\text{• } 10 \leftrightarrow \omega \text{（角周波数）}"""),
      StepItem(tex: r"""\text{• } f(0)=0 \leftrightarrow I_0=0 \text{（初期電流）}"""),
      StepItem(tex: r"""\text{• }\displaystyle \frac{1}{10 \times 0.2}  = \frac 1 2 \leftrightarrow X_C = \displaystyle \frac{1}{\omega C} \text{(容量性リアクタンス)} """),
      StepItem(tex: r"""\textcolor{brown}{\large{【解法】}}"""),
      StepItem(tex: r"""\displaystyle \frac{\int_0^t f(s) \, ds}{0.2} = 8\sin(10t)"""),
      StepItem(tex: r"""\text{両辺を}0.2\text{で掛ける：}"""),
      StepItem(tex: r"""\Leftrightarrow \ \int_0^t f(s) \, ds = 1.6\sin(10t)"""),
      StepItem(tex: r"""\text{両辺を微分：}"""),
      StepItem(tex: r"""\Leftrightarrow \ f(t) = 1.6 \times 10\cos(10t)"""),
      StepItem(tex: r"""\Leftrightarrow \ f(t) = 16\cos(10t)"""),
      StepItem(tex: r"""\text{位相差を明確にするため、三角関数の変換公式で変形：}"""),
      StepItem(tex: r"""\Leftrightarrow \ f(t) = 16\sin\left(10t + \displaystyle \frac{\pi}{2}\right)"""),
    ],
  ),

];

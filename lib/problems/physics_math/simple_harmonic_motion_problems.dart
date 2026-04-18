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
const simple_harmonicProblems = <MathProblem>[



  // --- 単振動（LC自由） 一般---
  MathProblem(
    id: "BEB5E18C-4AF5-4411-8578-2CE052A3CDE8",
    no: 6,
    category: '二階同次・定数係数',
    level: '中級',
    question: r"""f''(t) = -\omega_0^2\,f(t),\quad f(0) = A_0,\ f'(0) = v_0""",
    answer: r"""\displaystyle f(t)=A_0\cos(\omega_0 t)+\displaystyle \frac{v_0}{\omega_0}\sin(\omega_0 t)""",
    imageAsset: '',
    equation: r"""f''(t) = -\omega_0^2\,f(t)""",
    conditions: r"""f(0)=A_0,\ f'(0)=v_0""",
    keywords: ['単振動',  '一般', 'コンデンサ', 'コイル'],
    steps: [
      StepItem(tex: r"""\textcolor{brown}{\large{【力学】}}"""),
      StepItem(tex: r"""\text{• 力学においては、} mx''(t) + kx(t) = 0 \text{ の形でよく登場する。これはばね-質量系の単振動の運動方程式。}"""),
      StepItem(tex: r"""\textcolor{brown}{\large{【電磁気学】}}"""),
      StepItem(tex: r"""\text{• 電磁気学においては、} LQ''(t) + \displaystyle \frac{Q(t)}{C} = 0 \text{ の形でよく登場する。これはLC回路の放電におけるキルヒホッフの法則であり、電気振動をする。}"""),
      StepItem(tex: r"""\textcolor{brown}{\large{【問題の記号と力学における記号の対応】}}"""),
      StepItem(tex: r"""\text{単振動（ばね-質量系の自由振動）:} \ mx''(t) + kx(t) = 0"""),
      StepItem(tex: r"""\text{• } f(t) \leftrightarrow x(t) \text{（位置）}"""),
      StepItem(tex: r"""\text{• } f'(t) \leftrightarrow v(t) \text{（速度）}"""),
      StepItem(tex: r"""\text{• } f''(t) \leftrightarrow a(t) \text{（加速度）}"""),
      StepItem(tex: r"""\text{• } \omega_0 \leftrightarrow \sqrt{\displaystyle \frac{k}{m}} \text{（固有角周波数）}"""),
      StepItem(tex: r"""\text{• } A_0 \leftrightarrow x_0 \text{（初期位置）}"""),
      StepItem(tex: r"""\text{• } v_0 \leftrightarrow v_0 \text{（初期速度）}"""),
      StepItem(tex: r"""\textcolor{brown}{\large{【問題の記号と電磁気学における記号の対応】}}"""),
      StepItem(tex: r"""\text{LC振動回路（コンデンサとコイルの自由振動）:} \ LQ''(t) + \displaystyle \frac{Q(t)}{C} = 0"""),
      StepItem(tex: r"""\text{• } f(t) \leftrightarrow Q(t) \text{（コンデンサに蓄えられた電荷）}"""),
      StepItem(tex: r"""\text{• } f'(t) \leftrightarrow I(t) \text{（電流）}"""),
      StepItem(tex: r"""\text{• } f''(t) \leftrightarrow I' \text{（電流変化率）}"""),
      StepItem(tex: r"""\text{• } \omega_0 \leftrightarrow \displaystyle \frac{1}{\sqrt{LC}} \text{（固有角周波数）}"""),
      StepItem(tex: r"""\text{• } A_0 \leftrightarrow Q_0 \text{（コンデンサに蓄えられた初期電荷）}"""),
      StepItem(tex: r"""\text{• } v_0 \leftrightarrow I_0 \text{（初期電流）}"""),
      StepItem(tex: r"""\textcolor{brown}{\large{【解法】}}"""),
      StepItem(tex: r"""\textcolor{green}{1.\ } \textcolor{green}{\displaystyle \frac{1}{2}f'(t)^2 + \displaystyle \frac{\omega_0^2}{2}f(t)^2} \textcolor{green}{は時間によらず一定}"""),
      StepItem(tex: r"""f''(t) = -\omega_0^2 f(t) \text{の両辺に}f'(t)\text{ を掛ける。(こうやるとうまくいく)}"""),
      StepItem(tex: r"""\Rightarrow \ f''(t)f'(t) = -\omega_0^2 f(t)f'(t)"""),
      StepItem(tex: r"""\text{積の微分より}"""),
      StepItem(tex: r"""\Leftrightarrow \ \left(\displaystyle \frac{1}{2}f'(t)^2\right)' = \left(-\displaystyle \frac{\omega_0^2}{2}f(t)^2\right)'"""),
      StepItem(tex: r"""\text{移項する：}"""),
      StepItem(tex: r"""\Leftrightarrow \ \left(\displaystyle \frac{1}{2}f'(t)^2\right)' - \left(-\displaystyle \frac{\omega_0^2}{2}f(t)^2\right)' = 0"""),
      StepItem(tex: r"""\Leftrightarrow \ \left(\displaystyle \frac{1}{2}f'(t)^2 + \displaystyle \frac{\omega_0^2}{2}f(t)^2\right)' = 0"""),
      StepItem(tex: r"""\text{時間微分が0なので、} \displaystyle  \frac{1}{2}f'(t)^2 + \displaystyle \frac{\omega_0^2}{2}f(t)^2 \text{は時間によらない保存量である。}"""),
      StepItem(tex: r"""\textcolor{green}{2.\ } \textcolor{green}{任意の時刻} \textcolor{green}{t} \textcolor{green}{において、} \textcolor{green}{\left(\displaystyle \frac{f'(t)}{\omega_0}\right)^2 + f(t)^2 = \displaystyle \frac{v_0^2+\omega_0^2 A_0^2}{\omega_0^2}} \textcolor{green}{　: 一定} """),
      StepItem(tex: r"""\text{初期条件} f(0)=A_0,\ f'(0)=v_0 \text{より、上段で求めた時間によらない保存量} \displaystyle \frac{1}{2}f'(t)^2 + \displaystyle \frac{\omega_0^2}{2}f(t)^2 \text{の値を}C\text{と置く。ここで初期条件を用いると、} """),
      StepItem(tex: r"""C = \displaystyle \frac12\cdot v_0^2 + \displaystyle \frac{\omega_0^2}{2}\cdot A_0^2"""),
      StepItem(tex: r"""\text{よって、任意の時刻} t \text{で、} """),
      StepItem(tex: r""" \displaystyle \frac{1}{2}f'(t)^2 + \displaystyle \frac{\omega_0^2}{2}f(t)^2 = \displaystyle \frac{v_0^2+\omega_0^2 A_0^2}{2} \  \cdots (1)"""),
      StepItem(tex: r""" \text{が成り立つ。(1)の両辺を}\displaystyle \frac{\omega_0^2}{2}\text{で割って}"""),
      StepItem(tex: r"""\Leftrightarrow \left(\displaystyle \frac{f'(t)}{\omega_0}\right)^2 + f(t)^2 = \displaystyle \frac{v_0^2+\omega_0^2 A_0^2}{\omega_0^2} \  \cdots (2)"""),
      StepItem(tex: r"""\textcolor{green}{3.\ } \textcolor{green}{\displaystyle \frac{f'(t)}{\omega_0} = \frac{\sqrt{v_0^2+\omega_0^2 A_0^2}}{\omega_0}\cos\theta(t),\ \  f(t) = \frac{\sqrt{v_0^2+\omega_0^2 A_0^2}}{\omega_0}\sin\theta(t)} \textcolor{green}{を満たす関数} \textcolor{green}{\theta(t)}\textcolor{green}{を取る事ができる。}"""),
      StepItem(tex: r"""(2) \text{より} \left(\displaystyle \frac{f'(t)}{\omega_0},\, f(t)\right) \text{は常に半径}\displaystyle \frac{\sqrt{v_0^2+\omega_0^2 A_0^2}}{\omega_0}\text{の円上。}"""),
      StepItem(tex: r"""\text{よって、連続な角度} \theta(t) \text{を用いて下記のように表すことができる。}"""),
      StepItem(tex: r"""
      \begin{cases}
      \displaystyle \frac{f'(t)}{\omega_0}=\frac{\sqrt{v_0^2+\omega_0^2 A_0^2}}{\omega_0}\cos\theta(t)\ \ \cdots (3)\\[6pt]
      f(t)=\frac{\sqrt{v_0^2+\omega_0^2 A_0^2}}{\omega_0}\sin\theta(t)\ \ \cdots (4)
      \end{cases}
      """),
      StepItem(tex: r"""\text{ここで、}\displaystyle A=\displaystyle \frac{\sqrt{v_0^2+\omega_0^2 A_0^2}}{\omega_0}\text{とおくと、}"""),
      StepItem(tex: r"""
      \begin{cases}
      \displaystyle \frac{f'(t)}{\omega_0}=A\cos\theta(t)\ \ \cdots (3)\\[6pt]
      f(t)=A\sin\theta(t)\ \ \cdots (4)
      \end{cases}
      """),

      StepItem(tex: r"""\textcolor{green}{4.\ } \textcolor{green}{\cos\theta(0) = \displaystyle \frac{v_0}{\omega_0 A} , \ \sin\theta(0) = \displaystyle \frac{A_0}{A}} \textcolor{green}{が成り立つ。}"""),
      StepItem(tex: r"""\text{(3),(4)に }t=0 \text{を代入すると、初期条件より}"""),
      StepItem(tex: r"""
      \begin{aligned}
      &\quad \begin{cases}
      \displaystyle \frac{f'(0)}{\omega_0}=\displaystyle \frac{v_0}{\omega_0}=A\cos\theta(0) \cdots (5)\\[6pt]
      f(0)=A_0=A\sin\theta(0)\cdots (6)
      \end{cases}
      \end{aligned}
      """),
      
      StepItem(tex: r"""\textcolor{green}{5.\ } \textcolor{green}{\theta'(t) = \omega_0} \textcolor{green}{が成り立つ}"""),
      StepItem(tex: r"""\text{(4)より}f(t) = A\sin\theta(t) \text{なので、連鎖律により} f'(t) = A \theta'(t)\cos\theta(t)"""),
      StepItem(tex: r"""\text{一方、定義(3)より} \displaystyle \frac{f'(t)}{\omega_0}=A\cos\theta(t) \text{なので} f'(t) = \omega_0 A\cos\theta(t)"""),
      StepItem(tex: r"""\text{ゆえに、} A \theta'(t)\cos\theta(t) = \omega_0 A\cos\theta(t)"""),
      StepItem(tex: r"""\cos\theta(t)\text{の係数を比較して} A \theta'(t) = \omega_0 A \text{よって} \cos\theta(t)\neq 0 \text{を満たす}t{では} \theta'(t)=\omega_0"""),
      StepItem(tex: r"""\theta'(t)\text{の連続性から、任意の時刻で、} \theta'(t)=\omega_0 """),
      StepItem(tex: r"""\textcolor{green}{6.\ } \textcolor{green}{f(t)=A_0\cos(\omega_0 t)+\displaystyle \frac{v_0}{\omega_0}\sin(\omega_0 t)}\textcolor{green}{ が成り立つ}"""),
      StepItem(tex: r"""\theta'(t) = \omega_0 \text{より、両辺を不定積分して、}\theta(t)=\omega_0 t+\theta_0 \text{とできる。}"""),
      StepItem(tex: r"""\text{ゆえに、}"""),
      StepItem(tex: r"""
      \begin{aligned}
      f(t)&=A\sin\theta(t)\\[5pt]
      &=A\sin(\omega_0 t+\theta_0)\\[5pt]
      &=A\sin(\omega_0 t)\cos\theta_0+A\cos(\omega_0 t)\sin\theta_0\ \cdots (7)
      \end{aligned}
      """),
      StepItem(tex: r""""""),
      StepItem(tex: r"""\text{ここで(5),(6)より}"""),
      StepItem(tex: r"""
      \begin{aligned}
      \begin{cases}
      \cos\theta_0= \displaystyle \cos \theta(0)\ \underset{(5)}{=} \  \displaystyle \frac{v_0}{\omega_0 A}\\[5pt]
      \sin\theta_0= \displaystyle \sin \theta(0)\ \underset{(6)}{=} \  \displaystyle \frac{A_0}{A}
      \end{cases}
      \end{aligned}
      """),
      StepItem(tex: r"""\text{よって(7)より、}
      \begin{aligned}
      f(t)&=A\sin(\omega_0 t)\cos\theta_0+A\cos(\omega_0 t)\sin\theta_0\\[5pt]
      &=A\sin(\omega_0 t)\cdot\displaystyle \frac{v_0}{\omega_0 A}+A\cos(\omega_0 t)\cdot\displaystyle \frac{A_0}{A}\\[5pt]
      &=\displaystyle \frac{v_0}{\omega_0}\sin(\omega_0 t)+A_0\cos(\omega_0 t)
      \end{aligned}
      """),
    ],
  ),



  // --- 一定外力（単振動） ---
  MathProblem(
    id: "F2C5AEF4-1FD1-4BD6-A7FE-D0E65756456A",
    no: 7,
    category: '二階同次・定数係数',
    level: '中級',
    question: r"""f''(t) = -\omega_0^2\,f(t) + G,\quad f(0) = f_0,\ f'(0) = v_0""",
    answer: r"""\displaystyle f(t)=\displaystyle \frac{G}{\omega_0^2}+\Big(f_0-\displaystyle \frac{G}{\omega_0^2}\Big)\cos(\omega_0 t)+\displaystyle \frac{v_0}{\omega_0}\sin(\omega_0 t)""",
    imageAsset: '',
    equation: r"""f''(t) = -\omega_0^2\,f(t) + G""",
    conditions: r"""f(0) = f_0,\ f'(0) = v_0""",
    keywords: ['単振動',  '直流', '一般', 'コンデンサ', 'コイル'],
    hint: r"""\text{定数解を求めて平行移動し、外力がない場合の微分方程式の解の式を利用する。}""",
    steps: [
      StepItem(tex: r"""\textcolor{brown}{\large{【力学】}}"""),
      StepItem(tex: r"""\text{• 力学においては、} mx''(t) + kx(t) = mg \text{ の形でよく登場する。これは重力下のばね-質量系の運動を表す。重力による平衡位置シフトが起きる。}"""),
      // StepItem(tex: r"""\text{【電磁気学】}"""),
      // StepItem(tex: r"""\text{• 電磁気学においては、} LQ''(t) + \displaystyle \frac{Q(t)}{C} = V \text{ の形でよく登場する。これは直流電圧が印加されたLC回路を表す。}"""),
      // StepItem(tex: r"""\text{• 定常電流：} CV \text{（定常状態でのコンデンサに蓄えられる電荷）}"""),
      // StepItem(tex: r"""\text{【問題の記号と力学における記号の対応】}"""),
      StepItem(tex: r"""\text{重力下のばねの運動:} \ mx''(t) + kx(t) = mg"""),
      StepItem(tex: r"""\text{• } f(t) \leftrightarrow x(t) \text{（位置）}"""),
      StepItem(tex: r"""\text{• } f'(t) \leftrightarrow v(t) \text{（速度）}"""),
      StepItem(tex: r"""\text{• } f''(t) \leftrightarrow a(t) \text{（加速度）}"""),
      StepItem(tex: r"""\text{• } \omega_0 \leftrightarrow \sqrt{\displaystyle \frac{k}{m}} \text{（固有角周波数）}"""),
      StepItem(tex: r"""\text{• } G \leftrightarrow \displaystyle \frac{mg}{m} = g \text{（重力加速度）}"""),
      StepItem(tex: r"""\text{• } \frac{G}{\omega_0^2} \leftrightarrow \displaystyle \frac{mg}{k} \text{（平衡点。振動中心。重力とばねの力がつり合う位置）}"""),
      StepItem(tex: r"""\text{• } f(0)=f_0 \leftrightarrow x_0=f_0 \text{（初期位置）}"""),
      StepItem(tex: r"""\text{• } f'(0)=v_0 \leftrightarrow v_0=v_0 \text{（初期速度）}"""),
      // StepItem(tex: r"""\text{【問題の記号と電磁気学における記号の対応】}"""),
      // StepItem(tex: r"""\text{直流LC回路:} \ LQ''(t) + \displaystyle \frac{Q(t)}{C} = V"""),
      // StepItem(tex: r"""\text{• } f(t) \leftrightarrow Q(t) \text{コンデンサに蓄えられた電荷）}"""),
      // StepItem(tex: r"""\text{• } f'(t) \leftrightarrow I(t) \text{（電流）}"""),
      // StepItem(tex: r"""\text{• } f''(t) \leftrightarrow I' \text{（電流変化率）}"""),
      // StepItem(tex: r"""\text{• } \omega_0 \leftrightarrow \displaystyle \frac{1}{\sqrt{LC}} \text{（固有角周波数）}"""),
      // StepItem(tex: r"""\text{• } G \leftrightarrow \displaystyle \frac{V}{L} \text{（電圧 ÷ インダクタンス）}"""),
      // StepItem(tex: r"""\text{• } f(0)=f_0 \leftrightarrow Q_0=f_0 \text{（コンデンサに蓄えられた初期電荷）}"""),
      // StepItem(tex: r"""\text{• } f'(0)=v_0 \leftrightarrow I_0=v_0 \text{（初期電流）}"""),
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{定数解を求めて平行移動し、外力がない場合の微分方程式の解の式を利用する。}"""),
      
      StepItem(tex: r"""\textcolor{brown}{\large{【解法】}}"""),
      StepItem(tex: r"""\textcolor{green}{右辺の定数項が無い(同次方程式)の場合の公式}"""),
      StepItem(tex: r"""\text{微分方程式 } f''(t) = -\omega^2 f(t) \text{ に対する初期値問題}"""),
      StepItem(tex: r"""f(0) = A_0,\quad f'(0) = v_0"""),
      StepItem(tex: r"""\text{の解は}"""),
      StepItem(tex: r"""f(t) = A_0\cos(\omega t) + \displaystyle \frac{v_0}{\omega}\sin(\omega t)"""),
      StepItem(tex: r"""\text{である。（問題6で導出済み）}"""),
       StepItem(tex: r"""\textcolor{blue}{この公式を用いて、本問を解く。}"""),
      StepItem(tex: r"""f''(t) = -\omega_0^2 f(t) + G"""),
      StepItem(tex: r"""\textcolor{green}{1.\ } \textcolor{green}{定数解を探す}"""),
      StepItem(tex: r"""\text{定数解}f_s\text{を求める。}f_s'' = 0\text{より}"""),
      StepItem(tex: r"""0 = -\omega_0^2 f_s + G \quad \Leftrightarrow \quad f_s = \displaystyle \frac{G}{\omega_0^2}"""),
      StepItem(tex: r"""\textcolor{green}{2.\ } \textcolor{green}{平行移動で新たな関数} \textcolor{green}{g} \textcolor{green}{を置いて同次化(バネのみの力による単振動の式にする)}"""),
      StepItem(tex: r"""\text{平行移動：}g(t) = f(t) - f_s \text{ とおく。}"""),
      StepItem(tex: r"""\begin{aligned}
      g''(t) &= f''(t) = -\omega_0^2 f(t) + G \\[5pt]
      &= -\omega_0^2(g(t) + f_s) + G \\[5pt]
      &= -\omega_0^2 g(t) - \omega_0^2 \cdot \displaystyle \frac{G}{\omega_0^2} + G \\[5pt]
      &= -\omega_0^2 g(t)
      \end{aligned}"""),
      StepItem(tex: r"""\text{よって }g''(t) = -\omega_0^2 g(t) \text{（同次化完了）}"""),
      StepItem(tex: r"""\textcolor{green}{3.\ } \textcolor{green}{g} \textcolor{green}{の初期条件を求める}"""),
      StepItem(tex: r"""\begin{aligned}
      g(0) &= f(0) - f_s = f_0 - \displaystyle \frac{G}{\omega_0^2} \\[5pt]
      g'(0) &= f'(0) = v_0
      \end{aligned}"""),
      StepItem(tex: r"""\textcolor{green}{4.\ } \textcolor{green}{公式を適用し} \textcolor{green}{g} \textcolor{green}{を求める}"""),
      StepItem(tex: r"""g''(t) = -\omega_0^2 g(t) \text{で、}g(0) = f_0 - \displaystyle \frac{G}{\omega_0^2},\ g'(0) = v_0"""),
      StepItem(tex: r"""\text{公式より}"""),
      StepItem(tex: r"""\begin{aligned}
      g(t) &= g(0)\cos(\omega_0 t) + \displaystyle \frac{g'(0)}{\omega_0}\sin(\omega_0 t) \\[5pt]
      &= \Big(f_0 - \displaystyle \frac{G}{\omega_0^2}\Big)\cos(\omega_0 t) + \displaystyle \frac{v_0}{\omega_0}\sin(\omega_0 t)
      \end{aligned}"""),
      StepItem(tex: r"""\textcolor{green}{5.\ } \textcolor{green}{g} \textcolor{green}{から} \textcolor{green}{f} \textcolor{green}{を求める}"""),
      StepItem(tex: r"""f(t) = g(t) + f_s = \Big(f_0 - \displaystyle \frac{G}{\omega_0^2}\Big)\cos(\omega_0 t) + \displaystyle \frac{v_0}{\omega_0}\sin(\omega_0 t) + \displaystyle \frac{G}{\omega_0^2}"""),
      StepItem(tex: r"""\quad = \displaystyle \frac{G}{\omega_0^2}+\Big(f_0-\displaystyle \frac{G}{\omega_0^2}\Big)\cos(\omega_0 t)+\displaystyle \frac{v_0}{\omega_0}\sin(\omega_0 t)"""),
    ],
  ),


  // --- 双曲型（反発力） 一般---
  MathProblem(
    id: "EE1DFDFD-1094-42EC-9572-34CA88066BCD",
    no: 8,
    category: '二階同次・定数係数（双曲型）',
    level: '中級',
    question: r"""f''(t) = \omega_0^2\,f(t),\quad f(0) = A_0,\ f'(0) = v_0""",
    answer: r"""\displaystyle f(t)=\displaystyle \frac{A_0+\frac {v_0} {\omega_0}}{2}e^{\omega_0 t}+\displaystyle \frac{A_0-\frac {v_0} {\omega_0}}{2}e^{-\omega_0 t} \quad \text{または} \quad f(t)=A_0\cosh(\omega_0 t)+\displaystyle \frac{v_0}{\omega_0}\sinh(\omega_0 t)""",
    imageAsset: '',
    equation: r"""f''(t) = \omega_0^2\,f(t)""",
    conditions: r"""f(0)=A_0,\ f'(0)=v_0""",
    constants: r"""\omega_0>0:定数""",
    keywords: ['一般', '大学'],
    steps: [
      // StepItem(tex: r"""\text{【問題の記号と力学における記号の対応】}"""),
      // StepItem(tex: r"""\text{反発力による運動（不安定平衡点からの運動）}"""),
      // StepItem(tex: r"""mx''(t) - kx(t) = 0"""),
      // StepItem(tex: r"""\text{• } f(t) \leftrightarrow x(t) \text{（位置）}"""),
      // StepItem(tex: r"""\text{• } f'(t) \leftrightarrow v(t) \text{（速度）}"""),
      // StepItem(tex: r"""\text{• } f''(t) \leftrightarrow a(t) \text{（加速度）}"""),
      // StepItem(tex: r"""\text{• } \omega_0 \leftrightarrow \sqrt{\displaystyle \frac{k}{m}} \text{（反発力定数 ÷ 質量）}"""),
      // StepItem(tex: r"""\text{• } A_0 \leftrightarrow x_0 \text{（初期位置）}"""),
      // StepItem(tex: r"""\text{• } v_0 \leftrightarrow v_0 \text{（初期速度）}"""),
      // StepItem(tex: r"""\text{【問題の記号と電磁気学における記号の対応】}"""),
      // StepItem(tex: r"""\text{負性抵抗回路（不安定な電気回路）}"""),
      // StepItem(tex: r"""LQ''(t) - \displaystyle \frac{Q(t)}{C} = 0"""),
      // StepItem(tex: r"""\text{• } f(t) \leftrightarrow Q(t) \text{（コンデンサに蓄えられた電荷）}"""),
      // StepItem(tex: r"""\text{• } f'(t) \leftrightarrow I(t) \text{（電流）}"""),
      // StepItem(tex: r"""\text{• } f''(t) \leftrightarrow I' \text{（電流変化率）}"""),
      // StepItem(tex: r"""\text{• } \omega_0 \leftrightarrow \displaystyle \frac{1}{\sqrt{LC}} \text{（固有角周波数）}"""),
      // StepItem(tex: r"""\text{• } A_0 \leftrightarrow Q_0 \text{（コンデンサに蓄えられた初期電荷）}"""),
      // StepItem(tex: r"""\text{• } v_0 \leftrightarrow I_0 \text{（初期電流）}"""),
      StepItem(tex: r"""\textcolor{brown}{\large{【解法】}}"""),
      StepItem(tex: r"""\text{【双曲線関数の定義】}"""),
      StepItem(tex: r"""\text{双曲線関数（ハイパボリック関数）は以下のように定義される：}"""),
      StepItem(tex: r"""\cosh x = \displaystyle \frac{e^x + e^{-x}}{2} \quad \text{（双曲線余弦関数）}"""),
      StepItem(tex: r"""\sinh x = \displaystyle \frac{e^x - e^{-x}}{2} \quad \text{（双曲線正弦関数）}"""),
      StepItem(tex: r"""\text{これらの関数は三角関数と類似の性質を持ち、} \cosh^2 x - \sinh^2 x = 1 \text{ が成り立つ。すなわち、} (\cosh x, \sinh x) \text{は双曲線} x^2 - y^2 = 1 \text{上にある。}"""), 
      StepItem(tex: r"""\text{微分公式：}"""),
      StepItem(tex: r"""(\cosh x)' = \sinh x, \quad (\sinh x)' = \cosh x"""),
      StepItem(tex: r"""\text{加法定理：}"""),
      StepItem(tex: r"""\cosh(a+b) = \cosh a \cosh b + \sinh a \sinh b"""),
      StepItem(tex: r"""\sinh(a+b) = \sinh a \cosh b + \cosh a \sinh b"""),
      StepItem(tex: r"""\textcolor{green}{1.\ } \textcolor{green}{保存量} \textcolor{green}{\displaystyle \frac{1}{2}f'(t)^2 - \displaystyle \frac{\omega_0^2}{2}f(t)^2} \textcolor{green}{は時間によらず一定}"""),
      StepItem(tex: r"""f''(t) = \omega_0^2 f(t) \text{の両辺に}f'(t)\text{ を掛ける。(こうやるとうまくいく)}"""),
      StepItem(tex: r"""\Rightarrow \ f''(t)f'(t) = \omega_0^2 f(t)f'(t)"""),
      StepItem(tex: r"""\text{積の微分より}"""),
      StepItem(tex: r"""\Leftrightarrow \ \left(\displaystyle \frac{1}{2}f'(t)^2\right)' = \left(\displaystyle \frac{\omega_0^2}{2}f(t)^2\right)'"""),
      StepItem(tex: r"""\text{移項する：}"""),
      StepItem(tex: r"""\Leftrightarrow \ \left(\displaystyle \frac{1}{2}f'(t)^2\right)' - \left(\displaystyle \frac{\omega_0^2}{2}f(t)^2\right)' = 0"""),
      StepItem(tex: r"""\Leftrightarrow \ \left(\displaystyle \frac{1}{2}f'(t)^2 - \displaystyle \frac{\omega_0^2}{2}f(t)^2\right)' = 0"""),
      StepItem(tex: r"""\text{これは、時間微分が0なので、} \displaystyle  \frac{1}{2}f'(t)^2 - \displaystyle \frac{\omega_0^2}{2}f(t)^2 \text{は時間によらない保存量である。}"""),
      StepItem(tex: r"""\textcolor{green}{2.\ } \textcolor{green}{任意の時刻} \textcolor{green}{t} \textcolor{green}{において、} \textcolor{green}{\left(\displaystyle \frac{f'(t)}{\omega_0}\right)^2 - f(t)^2 = \displaystyle \frac{v_0^2-\omega_0^2 A_0^2}{\omega_0^2}} \textcolor{green}{ : 一定}"""),
      StepItem(tex: r"""\text{初期条件} f(0)=A_0,\ f'(0)=v_0 \text{より、上段で求めた時間によらない保存量} \displaystyle \frac{1}{2}f'(t)^2 - \displaystyle \frac{\omega_0^2}{2}f(t)^2 \text{の値を}C\text{と置く。ここで初期条件を用いると、} """),
      StepItem(tex: r"""C = \displaystyle \frac12\cdot v_0^2 - \displaystyle \frac{\omega_0^2}{2}\cdot A_0^2"""),
      StepItem(tex: r"""\text{よって、任意の時刻} t \text{で、} """),
      StepItem(tex: r""" \displaystyle \frac{1}{2}f'(t)^2 - \displaystyle \frac{\omega_0^2}{2}f(t)^2 = \displaystyle \frac{v_0^2-\omega_0^2 A_0^2}{2} \  \cdots (1)"""),
      StepItem(tex: r""" \text{が成り立つ。(1)の両辺を}\displaystyle \frac{\omega_0^2}{2}\text{で割って}"""),
      StepItem(tex: r"""\Leftrightarrow \left(\displaystyle \frac{f'(t)}{\omega_0}\right)^2 - f(t)^2 = \displaystyle \frac{v_0^2-\omega_0^2 A_0^2}{\omega_0^2} \  \cdots (2)"""),
      StepItem(tex: r"""\textcolor{green}{3.\ } \textcolor{green}{場合分け}"""),
      StepItem(tex: r"""\text{保存量の符号により以下の3つの場合に分ける：}"""),
      StepItem(tex: r"""\text{• } v_0^2 > \omega_0^2 A_0^2 \text{ の場合（双曲線型1）}"""),
      StepItem(tex: r"""\text{• } v_0^2 < \omega_0^2 A_0^2 \text{ の場合（双曲線型2）}"""),
      StepItem(tex: r"""\text{• } v_0^2 = \omega_0^2 A_0^2 \text{ の場合（境界型）}"""),

         // 場合1: v_0^2 > ω_0^2 A_0^2
      StepItem(tex: r"""\textcolor{red}{\textbf{・}\ } \textcolor{red}{v_0^2 > \omega_0^2 A_0^2} \textcolor{red}{\textbf{ の場合}}"""),
      StepItem(tex: r"""\text{この場合、}\displaystyle \frac{v_0^2-\omega_0^2 A_0^2}{\omega_0^2} > 0 \text{である。}"""),
      StepItem(tex: r"""\text{双曲線には2つの枝があり、初期速度 } v_0 \text{ の符号によってどちらの枝を使うかが決まる。}"""),
      StepItem(tex: r"""\text{枝の符号を } s \text{ とおく（} v_0 > 0 \text{ のとき } s = 1\text{、} v_0 < 0 \text{ のとき } s = -1\text{）。連続な双曲線パラメータ } \theta(t) \text{ を用いて}"""),
      StepItem(tex: r"""\textcolor{green}{\displaystyle \frac{f'(t)}{\omega_0} = s\frac{\sqrt{v_0^2-\omega_0^2 A_0^2}}{\omega_0}\cosh\theta(t),\quad  f(t) = s\frac{\sqrt{v_0^2-\omega_0^2 A_0^2}}{\omega_0}\sinh\theta(t)} \textcolor{green}{を満たす関数} \textcolor{green}{\theta(t)}\textcolor{green}{を取ることができる。}"""),
      StepItem(tex: r"""(2) より \left(\displaystyle \frac{f'(t)}{\omega_0},\, f(t)\right) \text{は常に双曲線 } x^2 - y^2 = \displaystyle \frac{v_0^2-\omega_0^2 A_0^2}{\omega_0^2} > 0 \text{ の上にある。}"""),
      StepItem(tex: r"""\text{よって、連続な双曲線パラメータ } \theta(t) \text{ を用いて下記のように表すことができる。}"""),
      StepItem(tex: r"""
      \begin{cases}
      \displaystyle \frac{f'(t)}{\omega_0}=s\frac{\sqrt{v_0^2-\omega_0^2 A_0^2}}{\omega_0}\cosh\theta(t)\\[6pt]
      f(t)=s\frac{\sqrt{v_0^2-\omega_0^2 A_0^2}}{\omega_0}\sinh\theta(t)
      \end{cases}
      """),
      StepItem(tex: r"""\text{ここで、}\displaystyle A=\displaystyle \frac{\sqrt{v_0^2-\omega_0^2 A_0^2}}{\omega_0}\ (>0)\text{とおくと、}"""),
      StepItem(tex: r"""
      \begin{cases}
      \displaystyle \frac{f'(t)}{\omega_0}=sA\cosh\theta(t)\ \ \cdots (3)\\[6pt]
      f(t)=sA\sinh\theta(t)\ \ \cdots (4)
      \end{cases}
      """),

      StepItem(tex: r"""\textcolor{green}{4-1.\ } \textcolor{green}{\cosh \theta(0) = \frac{|v_0|}{\omega_0 A},\ \sinh \theta(0) = \frac{sA_0}{A}} \textcolor{green}{が成り立つ}"""),
      StepItem(tex: r"""\text{(3),(4)に }t=0 \text{を代入すると、初期条件より}"""),
      StepItem(tex: r"""
      \begin{aligned}
      \quad &\begin{cases}
      \displaystyle \frac{f'(0)}{\omega_0}=\displaystyle \frac{v_0}{\omega_0}=sA\cosh\theta(0)\\[6pt]
      f(0)=A_0=sA\sinh\theta(0)
      \end{cases}\\[7pt]
      \Leftrightarrow & 
      \begin{cases}
      \cosh\theta(0) = \displaystyle \frac{|v_0|}{\omega_0 A}\ \ \ \cdots (5)\\[6pt] 
      \sinh\theta(0) = \displaystyle \frac{sA_0}{A}\ \ \ \cdots (6)
      \end{cases}
      \end{aligned}
      """),

      StepItem(tex: r"""\textcolor{green}{5-1.\ } \textcolor{green}{\theta '(t) = \omega_0} \textcolor{green}{が成り立つ}"""),
      StepItem(tex: r"""\text{(4)より } f(t) = sA\sinh\theta(t) \text{ なので、連鎖律により } f'(t) = sA \theta'(t)\cosh\theta(t)."""),
      StepItem(tex: r"""\text{一方、定義(3)より } \displaystyle \frac{f'(t)}{\omega_0}=sA\cosh\theta(t) \text{ なので } f'(t) = s\omega_0 A\cosh\theta(t)."""),
      StepItem(tex: r"""\text{ゆえに、 } sA \theta'(t)\cosh\theta(t) = s\omega_0 A\cosh\theta(t). \text{ ( } \cosh\theta(t)\neq0\text{ の時) }"""),
      StepItem(tex: r"""\text{係数比較により } \theta'(t)=\omega_0 \text{ が得られる。連続性から任意の } t \text{ で成立する。}"""),

      StepItem(tex: r"""\textcolor{green}{6-1.\ } \textcolor{green}{f(t) = A_0 \cosh(\omega_0 t) + \displaystyle \frac{v_0}{\omega_0} \sinh(\omega_0 t)} \textcolor{green}{が成り立つ}"""),
      StepItem(tex: r"""\text{(5),(6) より } \theta(0)=\theta_0 \text{ を定めると } \theta(t)=\omega_0 t+\theta_0 \text{ となる。ここで } \cosh\theta_0=\frac{|v_0|}{\omega_0 A},\ \sinh\theta_0=\frac{sA_0}{A}"""),
      StepItem(tex: r"""\text{従って、}"""),
      StepItem(tex: r"""
      \begin{aligned}
      f(t)&=sA\sinh(\omega_0 t+\theta_0)\\[5pt]
      &=sA\big(\sinh(\omega_0 t)\cosh\theta_0+\cosh(\omega_0 t)\sinh\theta_0\big)\\[5pt]
      &=sA\sinh(\omega_0 t)\cdot\frac{|v_0|}{\omega_0 A}+sA\cosh(\omega_0 t)\cdot\frac{sA_0}{A}\\[5pt]
      &=\displaystyle \frac{v_0}{\omega_0}\sinh(\omega_0 t)+A_0\cosh(\omega_0 t)
      \end{aligned}
      """),

      // 場合2: v_0^2 < ω_0^2 A_0^2
      StepItem(tex: r"""\textcolor{red}{\textbf{・}\ } \textcolor{red}{v_0^2 < \omega_0^2 A_0^2} \textcolor{red}{\textbf{ の場合}}"""),
      StepItem(tex: r"""\text{この場合、}\displaystyle \frac{v_0^2-\omega_0^2 A_0^2}{\omega_0^2} < 0 \text{である。}"""),
      StepItem(tex: r"""\text{双曲線には2つの枝があり、初期位置 } A_0 \text{ の符号によってどちらの枝を使うかが決まる。}"""),
      StepItem(tex: r"""\text{枝の符号を } r \text{ とおく（} A_0 > 0 \text{ のとき } r = 1\text{、} A_0 < 0 \text{ のとき } r = -1\text{）。連続な双曲線パラメータ } \theta(t) \text{ を用いて}"""),
      StepItem(tex: r"""\textcolor{green}{\displaystyle \frac{f'(t)}{\omega_0} = r\frac{\sqrt{\omega_0^2 A_0^2-v_0^2}}{\omega_0}\sinh\theta(t),\quad  f(t) = r\frac{\sqrt{\omega_0^2 A_0^2-v_0^2}}{\omega_0}\cosh\theta(t)} \textcolor{green}{を満たす関数} \textcolor{green}{\theta(t)}\textcolor{green}{を取ることができる。}"""),
      StepItem(tex: r"""(2) より \left(\displaystyle \frac{f'(t)}{\omega_0},\, f(t)\right) \text{は常に双曲線 } x^2 - y^2 = \displaystyle \frac{v_0^2-\omega_0^2 A_0^2}{\omega_0^2} (<0) \text{ の上にある。}"""),
      StepItem(tex: r"""\text{よって、下記のように表すことができる。}"""),
      StepItem(tex: r"""
      \begin{cases}
      \displaystyle \frac{f'(t)}{\omega_0}=rA\sinh\theta(t)\\[6pt]
      f(t)=rA\cosh\theta(t)
      \end{cases}
      \quad\text{ただし } A=\frac{\sqrt{\omega_0^2 A_0^2-v_0^2}}{\omega_0}>0
      """),

      StepItem(tex: r"""\textcolor{green}{4-2.\ } \textcolor{green}{\sinh\theta(0) = \frac{v_0}{\omega_0 A},\ \cosh\theta(0) = \frac{rA_0}{A}} \textcolor{green}{が成り立つ}"""),
      StepItem(tex: r"""\text{(3),(4)に }t=0 \text{を代入すると、初期条件より}"""),
      StepItem(tex: r"""
      \begin{aligned}
      \quad &\begin{cases}
      \displaystyle \frac{f'(0)}{\omega_0}=\displaystyle \frac{v_0}{\omega_0}=rA\sinh\theta(0)\\[6pt]
      f(0)=A_0=rA\cosh\theta(0)
      \end{cases}\\[7pt]
      \Leftrightarrow & 
      \begin{cases}
      \sinh\theta(0) = \displaystyle \frac{v_0}{\omega_0 A}\ \ \ \cdots (5)\\[6pt] 
      \cosh\theta(0) = \displaystyle \frac{rA_0}{A}\ \ \ \cdots (6)
      \end{cases}
      \end{aligned}
      """),

      StepItem(tex: r"""\textcolor{green}{5-2.\ } \textcolor{green}{\theta '(t) = \omega_0} \textcolor{green}{が成り立つ}"""),
      StepItem(tex: r"""\text{(4)より } f(t)=rA\cosh\theta(t) \text{ なので } f'(t)=rA\theta'(t)\sinh\theta(t)."""),
      StepItem(tex: r"""\text{一方、定義(3)より } \displaystyle \frac{f'(t)}{\omega_0}=rA\sinh\theta(t) \text{ なので } f'(t)=r\omega_0 A\sinh\theta(t)."""),
      StepItem(tex: r"""\text{よって係数比較により } \theta'(t)=\omega_0 \text{ が得られる（連続性から任意の } t \text{ で成立）。}"""),

      StepItem(tex: r"""\textcolor{green}{6-2.\ } \textcolor{green}{f(t) = A_0 \cosh(\omega_0 t) + \displaystyle \frac{v_0}{\omega_0} \sinh(\omega_0 t)} \textcolor{green}{が成り立つ}"""),
      StepItem(tex: r"""\text{(5),(6) より } \theta(t)=\omega_0 t+\theta_0 \text{ ととれる。ここで } \sinh\theta_0=\frac{v_0}{\omega_0 A},\ \cosh\theta_0=\frac{rA_0}{A} """),
      StepItem(tex: r"""\text{したがって、}"""),
      StepItem(tex: r"""
      \begin{aligned}
      f(t)&=rA\cosh(\omega_0 t+\theta_0)\\[5pt]
      &=rA\big(\cosh(\omega_0 t)\cosh\theta_0+\sinh(\omega_0 t)\sinh\theta_0\big)\\[5pt]
      &=rA\cosh(\omega_0 t)\cdot\frac{rA_0}{A}+rA\sinh(\omega_0 t)\cdot\frac{v_0}{\omega_0 A}\\[5pt]
      &=A_0\cosh(\omega_0 t)+\displaystyle \frac{v_0}{\omega_0}\sinh(\omega_0 t)
      \end{aligned}
      """),

      // 場合3: v_0^2 = ω_0^2 A_0^2
      StepItem(tex: r"""\textcolor{red}{\textbf{・}\ } \textcolor{red}{v_0^2 = \omega_0^2 A_0^2} \textcolor{red}{\textbf{ の場合}}"""),
      StepItem(tex: r"""\text{この場合、}\left(\displaystyle \frac{f'(t)}{\omega_0}\right)^2 - f(t)^2 = 0 \Leftrightarrow \displaystyle \frac{f'(t)}{\omega_0} = \pm f(t)."""),
      StepItem(tex: r"""\text{これは直線上の運動で、指数関数で直接表現できる。}"""),

      StepItem(tex: r"""\textcolor{green}{4-3.\ } \textcolor{green}{指数関数形での解}"""),
      StepItem(tex: r"""\text{一般解は } f(t) = C_1 e^{\omega_0 t} + C_2 e^{-\omega_0 t} \text{ の形で表される。}"""),
      StepItem(tex: r"""\text{初期条件 } f(0) = A_0,\ f'(0) = v_0 \text{ より}"""),
      StepItem(tex: r"""
      \begin{aligned}
      \quad &\begin{cases}
      f(0) = C_1 + C_2 = A_0\\[6pt]
      f'(0) = \omega_0 C_1 - \omega_0 C_2 = v_0
      \end{cases}\\[7pt]
      \Leftrightarrow & 
      \begin{cases}
      C_1 + C_2 = A_0\ \ \ \cdots (7)\\[6pt] 
      C_1 - C_2 = \frac{v_0}{\omega_0}\ \ \ \cdots (8)
      \end{cases}
      \end{aligned}
      """),
      StepItem(tex: r"""\text{これを解くと}"""),
      StepItem(tex: r"""
      \begin{aligned}
      C_1 &= \displaystyle \frac{A_0 + \frac{v_0}{\omega_0}}{2}\\[6pt]
      C_2 &= \displaystyle \frac{A_0 - \frac{v_0}{\omega_0}}{2}
      \end{aligned}
      """),

      StepItem(tex: r"""\textcolor{green}{5-3.\ } \textcolor{green}{f(t) = \frac{A_0 + \frac{v_0}{\omega_0}}{2} e^{\omega_0 t} + \frac{A_0 - \frac{v_0}{\omega_0}}{2} e^{-\omega_0 t}} \textcolor{green}{が成り立つ}"""),
      StepItem(tex: r"""\text{よって}"""),
      StepItem(tex: r"""
      \begin{aligned}
      f(t) &= \displaystyle \frac{A_0 + \frac{v_0}{\omega_0}}{2}e^{\omega_0 t} + \displaystyle \frac{A_0 - \frac{v_0}{\omega_0}}{2}e^{-\omega_0 t}\\[6pt]
      &= A_0 \cdot \displaystyle \frac{e^{\omega_0 t} + e^{-\omega_0 t}}{2} + \displaystyle \frac{v_0}{\omega_0} \cdot \displaystyle \frac{e^{\omega_0 t} - e^{-\omega_0 t}}{2}\\[6pt]
      &= A_0\cosh(\omega_0 t) + \displaystyle \frac{v_0}{\omega_0}\sinh(\omega_0 t)
      \end{aligned}
      """),

      // 共通の最終結果
      StepItem(tex: r"""\textcolor{green}{7.\ } \textcolor{green}{指数関数形での表現}"""),
      StepItem(tex: r"""\text{よって、すべての場合で最終的な解は}"""),
      StepItem(tex: r"""f(t) = A_0\cosh(\omega_0 t) + \displaystyle \frac{v_0}{\omega_0}\sinh(\omega_0 t)"""),
      StepItem(tex: r"""\text{となる。指数関数で表すと}"""),
      StepItem(tex: r"""
      \begin{aligned}
      f(t) &= A_0\cosh(\omega_0 t) + \displaystyle \frac{v_0}{\omega_0}\sinh(\omega_0 t)\\[6pt]
      &= A_0 \cdot \displaystyle \frac{e^{\omega_0 t} + e^{-\omega_0 t}}{2} + \displaystyle \frac{v_0}{\omega_0} \cdot \displaystyle \frac{e^{\omega_0 t} - e^{-\omega_0 t}}{2}\\[6pt]
      &= \displaystyle \frac{A_0 + \frac{v_0}{\omega_0}}{2}e^{\omega_0 t} + \displaystyle \frac{A_0 - \frac{v_0}{\omega_0}}{2}e^{-\omega_0 t}
      \end{aligned}
      """),

      // StepItem(tex: r"""\text{【力学】}"""),
      // StepItem(tex: r"""\text{• 力学においては、} mx'' - kx = 0 \text{ の形でよく登場する。これは反発力を受ける質点の運動方程式。指数関数的に発散する。}"""),
      // StepItem(tex: r"""\text{【電磁気学】}"""),
      // StepItem(tex: r"""\text{• 電磁気学においては、} LQ'' - \displaystyle \frac{Q}{C} = 0 \text{ の形でよく登場する。これは負性抵抗回路のキルヒホッフの法則であり、指数関数的に発散する。}"""),
    ],
  ),



  // --- 無減衰・非共振（LC駆動）  一般---
  MathProblem(
    id: "1105E028-5A00-4735-8506-CC3FF3BF43E7",
    no: 16,
    category: '一般・二階・非斉次',
    level: '上級',
    question: r"""f''(t)+\omega_0^2 f(t)=F\cos(\omega t),\quad \omega\neq\omega_0,\ F:定数,\ f(0)=0,\ f'(0)=0""",
    answer: r"""f(t)=\dfrac{F}{\omega_0^2-\omega^2}\big(\cos(\omega t)-\cos(\omega_0 t)\big)""",
    imageAsset: '',
    equation: r"""f''(t)+\omega_0^2 f(t)=F\cos(\omega t)""",
    conditions: r"""f(0)=0,\ f'(0)=0""",
    constants: r"""\omega_0>0,\ \omega\neq\omega_0,\ F:定数""",
    keywords: ['一般', '大学'],
    hint: r"""\text{2階非線形微分方程式を、回転変数によって1階線形微分方程式×2本に変換し、積分で解く。}""",
    steps: [
      StepItem(tex: r"""\textcolor{brown}{\large{【力学】}}"""),
      StepItem(tex: r"""\text{• 無減衰強制振動（オフ共振駆動）}"""),
      StepItem(tex: r"""\text{• 力学においては、} mx''(t) + kx(t) = F_0\cos(\omega t) \text{ の形でよく登場する。これは無減衰強制振動を表す。外力の角周波数 } \omega \text{ と固有角周波数 } \omega_0 \text{ が異なる場合の解。}"""),
      StepItem(tex: r"""\textcolor{brown}{\large{【電磁気学】}}"""),
      StepItem(tex: r"""\text{• LC回路の強制振動（非共振）}"""),
      StepItem(tex: r"""\text{• 電磁気学においては、} LI'(t) + \displaystyle \frac{q(t)}{C} = V_0\cos(\omega t) \text{ の形でよく登場する。これはLC回路の強制振動を表す。駆動周波数と共振周波数が異なる場合の電気振動。}"""),
      StepItem(tex: r"""\textcolor{brown}{\large{【問題の記号と力学における記号の対応】}}"""),
      StepItem(tex: r"""\text{無減衰強制振動:} \ mx''(t) + kx(t) = F_0\cos(\omega t)"""),
      StepItem(tex: r"""\text{• } f(t) \leftrightarrow x(t) \text{（位置）}"""),
      StepItem(tex: r"""\text{• } f'(t) \leftrightarrow v(t) \text{（速度）}"""),
      StepItem(tex: r"""\text{• } f''(t) \leftrightarrow a(t) \text{（加速度）}"""),
      StepItem(tex: r"""\text{• } \omega_0 \leftrightarrow \sqrt{\displaystyle \frac{k}{m}} \text{（固有角周波数）}"""),
      StepItem(tex: r"""\text{• } F \leftrightarrow \displaystyle \frac{F_0}{m} \text{（外力振幅 ÷ 質量）}"""),
      StepItem(tex: r"""\text{• } \omega \leftrightarrow \omega \text{（外力の角周波数）}"""),
      StepItem(tex: r"""\text{• } f(0)=0 \leftrightarrow x_0=0 \text{（初期位置）}"""),
      StepItem(tex: r"""\text{• } f'(0)=0 \leftrightarrow v_0=0 \text{（初期速度）}"""),
      StepItem(tex: r"""\textcolor{brown}{\large{【問題の記号と電磁気学における記号の対応】}}"""),
      StepItem(tex: r"""\text{LC回路の強制振動:} \ LI'(t) + \displaystyle \frac{q(t)}{C} = V_0\cos(\omega t)"""),
      StepItem(tex: r"""\text{• } f(t) \leftrightarrow q(t) \text{（電荷）}"""),
      StepItem(tex: r"""\text{• } f'(t) \leftrightarrow I(t) \text{（電流）}"""),
      StepItem(tex: r"""\text{• } f''(t) \leftrightarrow I'(t) \text{（電流変化率）}"""),
      StepItem(tex: r"""\text{• } \omega_0 \leftrightarrow \displaystyle \frac{1}{\sqrt{LC}} \text{（共振角周波数）}"""),
      StepItem(tex: r"""\text{• } F \leftrightarrow \displaystyle \frac{V_0}{L} \text{（電圧振幅 ÷ インダクタンス）}"""),
      StepItem(tex: r"""\text{• } \omega \leftrightarrow \omega \text{（駆動角周波数）}"""),
      StepItem(tex: r"""\text{• } f(0)=0 \leftrightarrow q_0=0 \text{（初期電荷）}"""),
      StepItem(tex: r"""\text{• } f'(0)=0 \leftrightarrow I_0=0 \text{（初期電流）}"""),
      StepItem(tex: r"""\textcolor{brown}{\large{【解法】}}"""),
      StepItem(tex: r"""\text{【方針】}"""),
      StepItem(tex: r"""\text{2階非線形微分方程式を、回転変数によって1階線形微分方程式×2本に変換し、積分で解く。}"""),
      StepItem(tex: r"""\textcolor{green}{1.\ } \textcolor{green}{回転変数を導入}"""),
      StepItem(tex: r"""\text{回転変数 } A(t), B(t) \text{ を以下のように定義する：}"""),
      StepItem(tex: r"""
      \begin{aligned}
      A(t) &\equiv f'(t)\cos(\omega_0 t) + \omega_0 f(t)\sin(\omega_0 t), \\[5pt]
      B(t) &\equiv f'(t)\sin(\omega_0 t) - \omega_0 f(t)\cos(\omega_0 t)
      \end{aligned}
      """),
      StepItem(tex: r"""\textcolor{green}{2.\ } \textcolor{green}{回転変数の微分を計算（交差項が消える）}"""),
      StepItem(tex: r"""A'(t) \text{ を計算する：}"""),
      StepItem(tex: r"""
      \begin{aligned}
      A'(t) &= f''(t)\cos(\omega_0 t) - f'(t)\omega_0\sin(\omega_0 t) + \omega_0 f'(t)\sin(\omega_0 t) + \omega_0^2 f(t)\cos(\omega_0 t) \\[5pt]
      &= f''(t)\cos(\omega_0 t) + \omega_0^2 f(t)\cos(\omega_0 t) \\[5pt]
      &= \big(f''(t) + \omega_0^2 f(t)\big)\cos(\omega_0 t)
      \end{aligned}
      """),
      StepItem(tex: r"""\text{元の微分方程式 } f''(t) + \omega_0^2 f(t) = F\cos(\omega t) \text{ より、}"""),
      StepItem(tex: r"""
      \begin{aligned}
      A'(t) &= F\cos(\omega t)\cos(\omega_0 t)
      \end{aligned}
      """),
      StepItem(tex: r"""\text{同様に } B'(t) \text{ を計算する：}"""),
      StepItem(tex: r"""
      \begin{aligned}
      B'(t) &= f''(t)\sin(\omega_0 t) + f'(t)\omega_0\cos(\omega_0 t) - \omega_0 f'(t)\cos(\omega_0 t) + \omega_0^2 f(t)\sin(\omega_0 t) \\[5pt]
      &= f''(t)\sin(\omega_0 t) + \omega_0^2 f(t)\sin(\omega_0 t) \\[5pt]
      &= \big(f''(t) + \omega_0^2 f(t)\big)\sin(\omega_0 t) \\[5pt]
      &= F\cos(\omega t)\sin(\omega_0 t)
      \end{aligned}
      """),
      StepItem(tex: r"""\textcolor{green}{3.\ } \textcolor{green}{初期条件から} \textcolor{green}{A(0)=B(0)=0} \textcolor{green}{が成り立つ}"""),
      StepItem(tex: r"""\text{初期条件 } f(0)=0, f'(0)=0 \text{ より、}"""),
      StepItem(tex: r"""
      \begin{aligned}
      A(0) &= f'(0)\cos(0) + \omega_0 f(0)\sin(0) = 0, \\[5pt]
      B(0) &= f'(0)\sin(0) - \omega_0 f(0)\cos(0) = 0
      \end{aligned}
      """),
      StepItem(tex: r"""\textcolor{green}{4.\ } \textcolor{green}{積分で} \textcolor{green}{A(t), B(t)} \textcolor{green}{を求める}"""),
      StepItem(tex: r"""\text{積和公式を用いて積分する。まず } A(t) \text{ から：}"""),
      StepItem(tex: r"""
      \begin{aligned}
      A(t) &= \int_0^t F\cos(\omega\tau)\cos(\omega_0\tau)\,d\tau \\[5pt]
      &= \frac{F}{2}\int_0^t \big(\cos((\omega-\omega_0)\tau) + \cos((\omega+\omega_0)\tau)\big)\,d\tau \\[5pt]
      &= \frac{F}{2}\left[\frac{\sin((\omega-\omega_0)\tau)}{\omega-\omega_0} + \frac{\sin((\omega+\omega_0)\tau)}{\omega+\omega_0}\right]_0^t \\[5pt]
      &= \frac{F}{2}\left(\frac{\sin((\omega-\omega_0)t)}{\omega-\omega_0} + \frac{\sin((\omega+\omega_0)t)}{\omega+\omega_0}\right)
      \end{aligned}
      """),
      StepItem(tex: r"""\text{次に } B(t) \text{ を計算する：}"""),
      StepItem(tex: r"""
      \begin{aligned}
      B(t) &= \int_0^t F\cos(\omega\tau)\sin(\omega_0\tau)\,d\tau \\[5pt]
      &= \frac{F}{2}\int_0^t \big(\sin((\omega+\omega_0)\tau) - \sin((\omega-\omega_0)\tau)\big)\,d\tau \\[5pt]
      &= \frac{F}{2}\left[-\frac{\cos((\omega+\omega_0)\tau)}{\omega+\omega_0} + \frac{\cos((\omega-\omega_0)\tau)}{\omega-\omega_0}\right]_0^t \\[5pt]
      &= \frac{F}{2}\left(-\frac{\cos((\omega+\omega_0)t)}{\omega+\omega_0} + \frac{\cos((\omega-\omega_0)t)}{\omega-\omega_0} + \frac{1}{\omega+\omega_0} - \frac{1}{\omega-\omega_0}\right) \\[5pt]
      &= \frac{F}{2}\left(\frac{1-\cos((\omega+\omega_0)t)}{\omega+\omega_0} + \frac{1-\cos((\omega-\omega_0)t)}{\omega-\omega_0}\right)
      \end{aligned}
      """),
      StepItem(tex: r"""\textcolor{green}{5.\ } \textcolor{green}{逆変換で} \textcolor{green}{f(t)} \textcolor{green}{を求める}"""),
      StepItem(tex: r"""\text{回転変数 } A(t), B(t) \text{ から } f(t) \text{ を求める逆変換は、}"""),
      StepItem(tex: r"""
      \begin{aligned}
      f(t) &= \frac{A(t)\sin(\omega_0 t) - B(t)\cos(\omega_0 t)}{\omega_0}
      \end{aligned}
      """),
      StepItem(tex: r"""\text{したがって、}"""),
      StepItem(tex: r"""
      \begin{aligned}
      f(t) &= \frac{1}{\omega_0}\left[\frac{F}{2}\left(\frac{\sin((\omega-\omega_0)t)}{\omega-\omega_0} + \frac{\sin((\omega+\omega_0)t)}{\omega+\omega_0}\right)\sin(\omega_0 t) - \frac{F}{2}\left(\frac{1-\cos((\omega+\omega_0)t)}{\omega+\omega_0} + \frac{1-\cos((\omega-\omega_0)t)}{\omega-\omega_0}\right)\cos(\omega_0 t)\right] \\[5pt]
      &= \frac{F}{2\omega_0}\left[\frac{\sin((\omega-\omega_0)t)\sin(\omega_0 t)}{\omega-\omega_0} + \frac{\sin((\omega+\omega_0)t)\sin(\omega_0 t)}{\omega+\omega_0} - \frac{(1-\cos((\omega+\omega_0)t))\cos(\omega_0 t)}{\omega+\omega_0} - \frac{(1-\cos((\omega-\omega_0)t))\cos(\omega_0 t)}{\omega-\omega_0}\right] \\[5pt]
      &= \frac{F}{2\omega_0}\left[\frac{\sin((\omega-\omega_0)t)\sin(\omega_0 t) - (1-\cos((\omega-\omega_0)t))\cos(\omega_0 t)}{\omega-\omega_0} + \frac{\sin((\omega+\omega_0)t)\sin(\omega_0 t) - (1-\cos((\omega+\omega_0)t))\cos(\omega_0 t)}{\omega+\omega_0}\right]
      \end{aligned}
      """),
      StepItem(tex: r"""\textcolor{green}{6.\ } \textcolor{green}{積和公式で整理して結論へ}"""),
      StepItem(tex: r"""\text{積和公式を使って整理すると：}"""),
      StepItem(tex: r"""
      \begin{aligned}
      f(t) &= \frac{F}{2\omega_0}\left[\frac{\cos(\omega t) - \cos(\omega_0 t)}{\omega-\omega_0} + \frac{\cos((\omega+2\omega_0)t) - \cos(\omega_0 t)}{\omega+\omega_0}\right] \\[5pt]
      &= \frac{F}{2\omega_0(\omega_0^2-\omega^2)}\left[(\cos(\omega t) - \cos(\omega_0 t))(\omega+\omega_0) + (\cos((\omega+2\omega_0)t) - \cos(\omega_0 t))(\omega-\omega_0)\right] \\[5pt]
      &= \frac{F}{\omega_0^2 - \omega^2}\big(\cos(\omega t) - \cos(\omega_0 t)\big)
      \end{aligned}
      """),
    ],
  ),



  // --- 無減衰・共振（LC共振） 一般---
  MathProblem(
    id: "BAAFC855-C0E1-4C39-9496-406A89079285",
    no: 17,
    category: '一般・二階・非斉次',
    level: '上級',
    question: r"""f''(t)+\omega_0^2 f(t)=F\cos(\omega_0 t),\quad F:定数,\ f(0)=0,\ f'(0)=0""",
    answer: r"""f(t)=\dfrac{F}{2\omega_0}\,t\,\sin(\omega_0 t)""",
    imageAsset: '',
    equation: r"""f''(t)+\omega_0^2 f(t)=F\cos(\omega_0 t)""",
    conditions: r"""f(0)=0,\ f'(0)=0""",
    constants: r"""\omega_0>0,\ F:定数""",
    keywords: ['一般', '大学'],
    hint: r"""\text{2階非線形微分方程式を、回転変数によって1階線形微分方程式×2本に変換し、積分で解く。共振の場合（} \omega = \omega_0 \text{）は、極限を取る必要がある。}""",
    steps: [
      StepItem(tex: r"""\textcolor{brown}{\large{【力学】}}"""),
      StepItem(tex: r"""\text{• 無減衰強制振動（理想共振）}"""),
      StepItem(tex: r"""\text{• 力学においては、} mx''(t) + kx(t) = F_0\cos(\omega_0 t) \text{ の形でよく登場する。これは無減衰強制振動を表す。外力の角周波数 } \omega \text{ が固有角周波数 } \omega_0 \text{ と一致する場合、振幅が時間とともに線形に増大する共振現象が起こる。}"""),
      StepItem(tex: r"""\textcolor{brown}{\large{【電磁気学】}}"""),
      StepItem(tex: r"""\text{• LC回路の強制振動（共振）}"""),
      StepItem(tex: r"""\text{• 電磁気学においては、} LI'(t) + \displaystyle \frac{q(t)}{C} = V_0\cos(\omega_0 t) \text{ の形でよく登場する。これはLC回路の強制振動を表す。駆動周波数が共振周波数と一致する場合、コンデンサに蓄えられた電荷が時間とともに線形に増大する。}"""),
      StepItem(tex: r"""\textcolor{brown}{\large{【問題の記号と力学における記号の対応】}}"""),
      StepItem(tex: r"""\text{無減衰強制振動（共振）:} \ mx''(t) + kx(t) = F_0\cos(\omega_0 t)"""),
      StepItem(tex: r"""\text{• } f(t) \leftrightarrow x(t) \text{（位置）}"""),
      StepItem(tex: r"""\text{• } f'(t) \leftrightarrow v(t) \text{（速度）}"""),
      StepItem(tex: r"""\text{• } f''(t) \leftrightarrow a(t) \text{（加速度）}"""),
      StepItem(tex: r"""\text{• } \omega_0 \leftrightarrow \sqrt{\displaystyle \frac{k}{m}} \text{（固有角周波数）}"""),
      StepItem(tex: r"""\text{• } F \leftrightarrow \displaystyle \frac{F_0}{m} \text{（外力振幅 ÷ 質量）}"""),
      StepItem(tex: r"""\text{• } f(0)=0 \leftrightarrow x_0=0 \text{（初期位置）}"""),
      StepItem(tex: r"""\text{• } f'(0)=0 \leftrightarrow v_0=0 \text{（初期速度）}"""),
      StepItem(tex: r"""\textcolor{brown}{\large{【問題の記号と電磁気学における記号の対応】}}"""),
      StepItem(tex: r"""\text{LC回路の強制振動（共振）:} \ LI'(t) + \displaystyle \frac{q(t)}{C} = V_0\cos(\omega_0 t)"""),
      StepItem(tex: r"""\text{• } f(t) \leftrightarrow q(t) \text{（電荷）}"""),
      StepItem(tex: r"""\text{• } f'(t) \leftrightarrow I(t) \text{（電流）}"""),
      StepItem(tex: r"""\text{• } f''(t) \leftrightarrow I'(t) \text{（電流変化率）}"""),
      StepItem(tex: r"""\text{• } \omega_0 \leftrightarrow \displaystyle \frac{1}{\sqrt{LC}} \text{（共振角周波数）}"""),
      StepItem(tex: r"""\text{• } F \leftrightarrow \displaystyle \frac{V_0}{L} \text{（電圧振幅 ÷ インダクタンス）}"""),
      StepItem(tex: r"""\text{• } f(0)=0 \leftrightarrow q_0=0 \text{（初期電荷）}"""),
      StepItem(tex: r"""\text{• } f'(0)=0 \leftrightarrow I_0=0 \text{（初期電流）}"""),
      StepItem(tex: r"""\textcolor{brown}{\large{【解法】}}"""),
      StepItem(tex: r"""\text{【方針】}"""),
      StepItem(tex: r"""\text{2階非線形微分方程式を、回転変数によって1階線形微分方程式×2本に変換し、積分で解く。共振の場合（} \omega = \omega_0 \text{）は、極限を取る必要がある。}"""),
      StepItem(tex: r"""\textcolor{green}{1.\ } \textcolor{green}{回転変数を導入}"""),
      StepItem(tex: r"""\text{回転変数 } A(t), B(t) \text{ を以下のように定義する：}"""),
      StepItem(tex: r"""
      \begin{aligned}
      A(t) &\equiv f'(t)\cos(\omega_0 t) + \omega_0 f(t)\sin(\omega_0 t), \\[5pt]
      B(t) &\equiv f'(t)\sin(\omega_0 t) - \omega_0 f(t)\cos(\omega_0 t)
      \end{aligned}
      """),
      StepItem(tex: r"""\textcolor{green}{2.\ } \textcolor{green}{回転変数の微分を計算（交差項が消える）}"""),
      StepItem(tex: r"""A'(t) \text{ を計算する：}"""),
      StepItem(tex: r"""
      \begin{aligned}
      A'(t) &= f''(t)\cos(\omega_0 t) - f'(t)\omega_0\sin(\omega_0 t) + \omega_0 f'(t)\sin(\omega_0 t) + \omega_0^2 f(t)\cos(\omega_0 t) \\[5pt]
      &= f''(t)\cos(\omega_0 t) + \omega_0^2 f(t)\cos(\omega_0 t) \\[5pt]
      &= \big(f''(t) + \omega_0^2 f(t)\big)\cos(\omega_0 t)
      \end{aligned}
      """),
      StepItem(tex: r"""\text{元の微分方程式 } f''(t) + \omega_0^2 f(t) = F\cos(\omega_0 t) \text{ より、}"""),
      StepItem(tex: r"""
      \begin{aligned}
      A'(t) &= F\cos(\omega_0 t)\cos(\omega_0 t) = F\cos^2(\omega_0 t)
      \end{aligned}
      """),
      StepItem(tex: r"""\text{同様に } B'(t) \text{ を計算する：}"""),
      StepItem(tex: r"""
      \begin{aligned}
      B'(t) &= f''(t)\sin(\omega_0 t) + f'(t)\omega_0\cos(\omega_0 t) - \omega_0 f'(t)\cos(\omega_0 t) + \omega_0^2 f(t)\sin(\omega_0 t) \\[5pt]
      &= f''(t)\sin(\omega_0 t) + \omega_0^2 f(t)\sin(\omega_0 t) \\[5pt]
      &= \big(f''(t) + \omega_0^2 f(t)\big)\sin(\omega_0 t) \\[5pt]
      &= F\cos(\omega_0 t)\sin(\omega_0 t)
      \end{aligned}
      """),
      StepItem(tex: r"""\textcolor{green}{3.\ } \textcolor{green}{初期条件から} \textcolor{green}{A(0)=B(0)=0} \textcolor{green}{が成り立つ}"""),
      StepItem(tex: r"""\text{初期条件 } f(0)=0, f'(0)=0 \text{ より、}"""),
      StepItem(tex: r"""
      \begin{aligned}
      A(0) &= f'(0)\cos(0) + \omega_0 f(0)\sin(0) = 0, \\[5pt]
      B(0) &= f'(0)\sin(0) - \omega_0 f(0)\cos(0) = 0
      \end{aligned}
      """),
      StepItem(tex: r"""\textcolor{green}{4.\ } \textcolor{green}{積分で} \textcolor{green}{A(t), B(t)} \textcolor{green}{を求める（共振極限）}"""),
      StepItem(tex: r"""\text{まず } A(t) \text{ を計算する。}"""),
      StepItem(tex: r"""
      \begin{aligned}
      A(t) &= \int_0^t F\cos^2(\omega_0\tau)\,d\tau \\[5pt]
      &= F\int_0^t \frac{1+\cos(2\omega_0\tau)}{2}\,d\tau \\[5pt]
      &= \frac{F}{2}\left[t + \frac{\sin(2\omega_0 t)}{2\omega_0}\right] \\[5pt]
      &= \frac{Ft}{2} + \frac{F\sin(2\omega_0 t)}{4\omega_0}
      \end{aligned}
      """),
      StepItem(tex: r"""\text{次に } B(t) \text{ を計算する：}"""),
      StepItem(tex: r"""
      \begin{aligned}
      B(t) &= \int_0^t F\cos(\omega_0\tau)\sin(\omega_0\tau)\,d\tau \\[5pt]
      &= F\int_0^t \frac{\sin(2\omega_0\tau)}{2}\,d\tau \\[5pt]
      &= \frac{F}{2}\left[-\frac{\cos(2\omega_0\tau)}{2\omega_0}\right]_0^t \\[5pt]
      &= \frac{F}{4\omega_0}\left(1-\cos(2\omega_0 t)\right)
      \end{aligned}
      """),
      StepItem(tex: r"""\textcolor{green}{5.\ } \textcolor{green}{逆変換で} \textcolor{green}{f(t)} \textcolor{green}{を求める}"""),
      StepItem(tex: r"""\text{回転変数 } A(t), B(t) \text{ から } f(t) \text{ を求める逆変換は、}"""),
      StepItem(tex: r"""
      \begin{aligned}
      f(t) &= \frac{A(t)\sin(\omega_0 t) - B(t)\cos(\omega_0 t)}{\omega_0}
      \end{aligned}
      """),
      StepItem(tex: r"""\text{したがって、}"""),
      StepItem(tex: r"""
      \begin{aligned}
      f(t) &= \frac{1}{\omega_0}\left[\left(\frac{Ft}{2} + \frac{F\sin(2\omega_0 t)}{4\omega_0}\right)\sin(\omega_0 t) - \frac{F}{4\omega_0}\left(1-\cos(2\omega_0 t)\right)\cos(\omega_0 t)\right] \\[5pt]
      &= \frac{F}{2\omega_0}t\sin(\omega_0 t) + \frac{F}{4\omega_0^2}\sin(2\omega_0 t)\sin(\omega_0 t) - \frac{F}{4\omega_0^2}\cos(\omega_0 t) + \frac{F}{4\omega_0^2}\cos(2\omega_0 t)\cos(\omega_0 t)
      \end{aligned}
      """),
      StepItem(tex: r"""\textcolor{green}{6.\ } \textcolor{green}{三角恒等式で整理して結論へ}"""),
      StepItem(tex: r"""\text{積和公式を使って整理する：}"""),
      StepItem(tex: r"""
      \begin{aligned}
      \sin(2\omega_0 t)\sin(\omega_0 t) &= \frac{1}{2}\big(\cos(\omega_0 t) - \cos(3\omega_0 t)\big), \\[5pt]
      \cos(2\omega_0 t)\cos(\omega_0 t) &= \frac{1}{2}\big(\cos(\omega_0 t) + \cos(3\omega_0 t)\big)
      \end{aligned}
      """),
      StepItem(tex: r"""\text{したがって、}"""),
      StepItem(tex: r"""
      \begin{aligned}
      f(t) &= \frac{F}{2\omega_0}t\sin(\omega_0 t) + \frac{F}{4\omega_0^2}\cdot\frac{1}{2}\big(\cos(\omega_0 t) - \cos(3\omega_0 t)\big) - \frac{F}{4\omega_0^2}\cos(\omega_0 t) + \frac{F}{4\omega_0^2}\cdot\frac{1}{2}\big(\cos(\omega_0 t) + \cos(3\omega_0 t)\big) \\[5pt]
      &= \frac{F}{2\omega_0}t\sin(\omega_0 t) + \frac{F}{8\omega_0^2}\cos(\omega_0 t) - \frac{F}{8\omega_0^2}\cos(3\omega_0 t) - \frac{F}{4\omega_0^2}\cos(\omega_0 t) + \frac{F}{8\omega_0^2}\cos(\omega_0 t) + \frac{F}{8\omega_0^2}\cos(3\omega_0 t) \\[5pt]
      &= \frac{F}{2\omega_0}t\sin(\omega_0 t) + \left(\frac{F}{8\omega_0^2} - \frac{F}{4\omega_0^2} + \frac{F}{8\omega_0^2}\right)\cos(\omega_0 t) \\[5pt]
      &= \frac{F}{2\omega_0}t\sin(\omega_0 t)
      \end{aligned}
      """),
    ],
  ),

  // --- 回転トリック（実数版・一般式） ---
  // MathProblem(
  //   id: "3E5D27F0-5236-4F00-BD82-9BF5CA6CFDB9",
  //   no: 18,
  //   category: '一般式・二階・非斉次',
  //   level: '上級',
  //   question: r"""f''(t)+\omega_0^{2}\,f(t)=A e^{\beta t}\sin(\omega t),\quad f(0)=0,\ f'(0)=0""",
  //   answer: r"""
  // \displaystyle
  // f(t)=\frac{2A\beta\omega}{(\beta^2+(\omega+\omega_0)^2)(\beta^2+(\omega-\omega_0)^2)}\cos(\omega_0 t) + \frac{A\omega(\beta^2-\omega_0^2+\omega^2)}{\omega_0(\beta^2+(\omega+\omega_0)^2)(\beta^2+(\omega-\omega_0)^2)}\sin(\omega_0 t) + A e^{\beta t}\,\frac{(\beta^2+\omega_0^2-\omega^2)\sin(\omega t)-2\beta\omega\cos(\omega t)}{(\beta^2+(\omega+\omega_0)^2)(\beta^2+(\omega-\omega_0)^2)}\,.
  // """,
  //   imageAsset: '',
  //   equation: r"""f''(t)+\omega_0^{2}f(t)=A e^{\beta t}\sin(\omega t)""",
  //   conditions: r"""f(0)=0,\ f'(0)=0""",
  //   constants: r"""\omega_0>0,\ \beta>0,\ A>0,\ \omega\in\mathbb{R}""",
  //   keywords: ['一般', 'コイル', 'コンデンサ', '交流'],
  //   steps: [
  //     StepItem(tex: r"""\textbf{【方針】}"""),
  //     StepItem(tex: r"""\text{特解を求めて、それを引いた関数を新たに定義し、右辺0(同次方程式)の場合の公式を適用して解く。}"""),
      
  //     StepItem(tex: r"""\textcolor{brown}{\large{【解法】}}"""),
  //     StepItem(tex: r"""\textcolor{green}{右辺の定数項が無い(同次方程式)の場合の公式}"""),
  //     StepItem(tex: r"""\text{微分方程式 } f''(t) = -\omega^2 f(t) \text{ に対する初期値問題}"""),
  //     StepItem(tex: r"""f(0) = A_0,\quad f'(0) = v_0"""),
  //     StepItem(tex: r"""\text{の解は}"""),
  //     StepItem(tex: r"""f(t) = A_0\cos(\omega t) + \displaystyle \frac{v_0}{\omega}\sin(\omega t)"""),
  //     StepItem(tex: r"""\text{である。（問題6で導出済み）}"""),
  //      StepItem(tex: r"""\textcolor{blue}{この公式を用いて、本問を解く。}"""),
  //     StepItem(tex: r"""f''(t) + \omega_0^2 f(t) = A e^{\beta t}\sin(\omega t)"""),
      
  //     StepItem(tex: r"""\textcolor{green}{1.\ } \textcolor{green}{特解を求める}"""),
  //     StepItem(tex: r"""\text{非斉次項 }A e^{\beta t}\sin(\omega t)\text{ より、特解を }"""),
  //     StepItem(tex: r"""f_p(t) = e^{\beta t}\left(C\sin(\omega t) + D\cos(\omega t)\right)"""),
  //     StepItem(tex: r"""\text{の形で推定する（}C, D\text{ は未定係数）。}"""),
      
  //     StepItem(tex: r"""\text{まず、}f_p(t)\text{ を微分する：}"""),
  //     StepItem(tex: r"""
  //     \begin{aligned}
  //     f_p'(t) &= \beta e^{\beta t}\left(C\sin(\omega t) + D\cos(\omega t)\right) + e^{\beta t}\left(\omega C\cos(\omega t) - \omega D\sin(\omega t)\right) \\[5pt]
  //     &= e^{\beta t}\left((\beta C-\omega D)\sin(\omega t) + (\omega C+\beta D)\cos(\omega t)\right)
  //     \end{aligned}
  //     """),
  //     StepItem(tex: r"""\text{さらに微分すると、}"""),
  //     StepItem(tex: r"""
  //     \begin{aligned}
  //     f_p''(t) &= \beta e^{\beta t}\left((\beta C-\omega D)\sin(\omega t) + (\omega C+\beta D)\cos(\omega t)\right) \\[5pt]
  //     &\quad + e^{\beta t}\left(\omega(\beta C-\omega D)\cos(\omega t) - \omega(\omega C+\beta D)\sin(\omega t)\right) \\[5pt]
  //     &= e^{\beta t}\left((\beta^2 C-\beta\omega D-\omega^2 C-\beta\omega D)\sin(\omega t) + (\beta\omega C+\beta^2 D+\beta\omega C-\omega^2 D)\cos(\omega t)\right) \\[5pt]
  //     &= e^{\beta t}\left((\beta^2 C-\omega^2 C-2\beta\omega D)\sin(\omega t) + (2\beta\omega C+\beta^2 D-\omega^2 D)\cos(\omega t)\right)
  //     \end{aligned}
  //     """),
  //     StepItem(tex: r"""\text{これらを }f_p''(t) + \omega_0^2 f_p(t) = A e^{\beta t}\sin(\omega t)\text{ に代入すると、}"""),
  //     StepItem(tex: r"""
  //     \begin{aligned}
  //     f_p''(t) + \omega_0^2 f_p(t) &= e^{\beta t}\left((\beta^2 C-\omega^2 C-2\beta\omega D)\sin(\omega t) + (2\beta\omega C+\beta^2 D-\omega^2 D)\cos(\omega t)\right) \\[5pt]
  //     &\quad + \omega_0^2 e^{\beta t}\left(C\sin(\omega t) + D\cos(\omega t)\right) \\[5pt]
  //     &= e^{\beta t}\left((\beta^2 C-\omega^2 C-2\beta\omega D+\omega_0^2 C)\sin(\omega t) + (2\beta\omega C+\beta^2 D-\omega^2 D+\omega_0^2 D)\cos(\omega t)\right) \\[5pt]
  //     &= e^{\beta t}\left((\beta^2+\omega_0^2-\omega^2)C-2\beta\omega D)\sin(\omega t) + (2\beta\omega C+(\beta^2+\omega_0^2-\omega^2)D)\cos(\omega t)\right) \\[5pt]
  //     &= A e^{\beta t}\sin(\omega t)
  //     \end{aligned}
  //     """),
      
  //     StepItem(tex: r"""\textcolor{green}{2.\ } \textcolor{green}{係数を比較}"""),
  //     StepItem(tex: r"""\text{両辺の係数を比較して、}"""),
  //     StepItem(tex: r"""
  //     \begin{cases}
  //     (\beta^2+\omega_0^2-\omega^2)C - 2\beta\omega D = A \\[5pt]
  //     2\beta\omega C + (\beta^2+\omega_0^2-\omega^2)D = 0
  //     \end{cases}
  //     """),
  //     StepItem(tex: r"""\text{第2式より }D = -\displaystyle \frac{2\beta\omega}{\beta^2+\omega_0^2-\omega^2}C\text{ を第1式に代入して、}"""),
  //     StepItem(tex: r"""
  //     \begin{aligned}
  //     (\beta^2+\omega_0^2-\omega^2)C + \frac{4\beta^2\omega^2}{\beta^2+\omega_0^2-\omega^2}C &= A \\[5pt]
  //     \frac{(\beta^2+\omega_0^2-\omega^2)^2+4\beta^2\omega^2}{\beta^2+\omega_0^2-\omega^2}C &= A
  //     \end{aligned}
  //     """),
  //     StepItem(tex: r"""\text{分母を因数分解すると、}"""),
  //     StepItem(tex: r"""
  //     \begin{aligned}
  //     (\beta^2+\omega_0^2-\omega^2)^2+4\beta^2\omega^2 &= \left(\beta^2+(\omega+\omega_0)^2\right)\left(\beta^2+(\omega-\omega_0)^2\right)
  //     \end{aligned}
  //     """),
  //     StepItem(tex: r"""\text{したがって、}"""),
  //     StepItem(tex: r"""
  //     \begin{aligned}
  //     C &= \frac{A(\beta^2+\omega_0^2-\omega^2)}{(\beta^2+(\omega+\omega_0)^2)(\beta^2+(\omega-\omega_0)^2)} \\[5pt]
  //     D &= -\frac{2A\beta\omega}{(\beta^2+(\omega+\omega_0)^2)(\beta^2+(\omega-\omega_0)^2)}
  //     \end{aligned}
  //     """),
      
  //     StepItem(tex: r"""\textcolor{green}{3.\ } \textcolor{green}{平行移動で新たな関数} \textcolor{green}{g} \textcolor{green}{を置いて同次化}"""),
  //     StepItem(tex: r"""\text{平行移動：}g(t) = f(t) - f_p(t) \text{ とおく。}"""),
  //     StepItem(tex: r"""\text{微分の線形性と }f_p''(t) + \omega_0^2 f_p(t) = A e^{\beta t}\sin(\omega t)\text{ より、}"""),
  //     StepItem(tex: r"""
  //     \begin{aligned}
  //     g''(t) + \omega_0^2 g(t) &= (f(t) - f_p(t))'' + \omega_0^2(f(t) - f_p(t)) \\[5pt]
  //     &= (f''(t) + \omega_0^2 f(t)) - (f_p''(t) + \omega_0^2 f_p(t)) \\[5pt]
  //     &= A e^{\beta t}\sin(\omega t) - A e^{\beta t}\sin(\omega t) \\[5pt]
  //     &= 0
  //     \end{aligned}
  //     """),
  //     StepItem(tex: r"""\text{よって }g''(t) = -\omega_0^2 g(t) \text{（同次化完了）}"""),
      
  //     StepItem(tex: r"""\textcolor{green}{4.\ } \textcolor{green}{g} \textcolor{green}{の初期条件を求める}"""),
  //     StepItem(tex: r"""
  //     \begin{aligned}
  //     g(0) &= f(0) - f_p(0) \\[5pt]
  //     &= 0 - A e^{0}\,\frac{(\beta^2+\omega_0^2-\omega^2)\sin(0)-2\beta\omega\cos(0)}{(\beta^2+(\omega+\omega_0)^2)(\beta^2+(\omega-\omega_0)^2)} \\[5pt]
  //     &= 0 - \frac{A(-2\beta\omega)}{(\beta^2+(\omega+\omega_0)^2)(\beta^2+(\omega-\omega_0)^2)} \\[5pt]
  //     &= \frac{2A\beta\omega}{(\beta^2+(\omega+\omega_0)^2)(\beta^2+(\omega-\omega_0)^2)}
  //     \end{aligned}
  //     """),
  //     StepItem(tex: r"""\text{よって、}"""),
  //     StepItem(tex: r"""
  //     \begin{aligned}
  //     g'(0) &= f'(0) - f_p'(0) \\[5pt]
  //     &= 0 - e^{0}\left((\beta C-\omega D)\sin(0) + (\omega C+\beta D)\cos(0)\right) \\[5pt]
  //     &= -(\omega C+\beta D) \\[5pt]
  //     &= -\omega C - \beta D
  //     \end{aligned}
  //     """),
  //     StepItem(tex: r"""\text{C, D の値を代入すると、}"""),
  //     StepItem(tex: r"""
  //     \begin{aligned}
  //     g'(0) &= -\omega \cdot \frac{A(\beta^2+\omega_0^2-\omega^2)}{(\beta^2+(\omega+\omega_0)^2)(\beta^2+(\omega-\omega_0)^2)} - \beta \cdot \frac{-2A\beta\omega}{(\beta^2+(\omega+\omega_0)^2)(\beta^2+(\omega-\omega_0)^2)} \\[5pt]
  //     &= \frac{-A\omega(\beta^2+\omega_0^2-\omega^2)+2A\beta^2\omega}{(\beta^2+(\omega+\omega_0)^2)(\beta^2+(\omega-\omega_0)^2)} \\[5pt]
  //     &= \frac{A\omega(-\beta^2-\omega_0^2+\omega^2+2\beta^2)}{(\beta^2+(\omega+\omega_0)^2)(\beta^2+(\omega-\omega_0)^2)} \\[5pt]
  //     &= \frac{A\omega(\beta^2-\omega_0^2+\omega^2)}{(\beta^2+(\omega+\omega_0)^2)(\beta^2+(\omega-\omega_0)^2)}
  //     \end{aligned}
  //     """),
      
  //     StepItem(tex: r"""\textcolor{green}{5.\ } \textcolor{green}{公式を適用し} \textcolor{green}{g} \textcolor{green}{を求める}"""),
  //     StepItem(tex: r"""g''(t) = -\omega_0^2 g(t) \text{で、}g(0) = \displaystyle \frac{2A\beta\omega}{(\beta^2+(\omega+\omega_0)^2)(\beta^2+(\omega-\omega_0)^2)},\ g'(0) = \displaystyle \frac{A\omega(\beta^2-\omega_0^2+\omega^2)}{(\beta^2+(\omega+\omega_0)^2)(\beta^2+(\omega-\omega_0)^2)}"""),
  //     StepItem(tex: r"""\text{公式より}"""),
  //     StepItem(tex: r"""
  //     \begin{aligned}
  //     g(t) &= g(0)\cos(\omega_0 t) + \frac{g'(0)}{\omega_0}\sin(\omega_0 t) \\[5pt]
  //     &= \frac{2A\beta\omega}{(\beta^2+(\omega+\omega_0)^2)(\beta^2+(\omega-\omega_0)^2)}\cos(\omega_0 t) \\[5pt]
  //     &\quad + \frac{A\omega(\beta^2-\omega_0^2+\omega^2)}{\omega_0(\beta^2+(\omega+\omega_0)^2)(\beta^2+(\omega-\omega_0)^2)}\sin(\omega_0 t)
  //     \end{aligned}
  //     """),
      
  //     StepItem(tex: r"""\textcolor{green}{6.\ } \textcolor{green}{g} \textcolor{green}{から} \textcolor{green}{f} \textcolor{green}{を求める}"""),
  //     StepItem(tex: r"""\text{特解は、}"""),
  //     StepItem(tex: r"""
  //     \begin{aligned}
  //     f_p(t) &= e^{\beta t}\left(C\sin(\omega t) + D\cos(\omega t)\right) \\[5pt]
  //     &= A e^{\beta t}\,\frac{(\beta^2+\omega_0^2-\omega^2)\sin(\omega t)-2\beta\omega\cos(\omega t)}{(\beta^2+(\omega+\omega_0)^2)(\beta^2+(\omega-\omega_0)^2)}
  //     \end{aligned}
  //     """),
  //     StepItem(tex: r"""
  //     \begin{aligned}
  //     f(t) &= g(t) + f_p(t) \\[5pt]
  //     &= \frac{2A\beta\omega}{(\beta^2+(\omega+\omega_0)^2)(\beta^2+(\omega-\omega_0)^2)}\cos(\omega_0 t) \\[5pt]
  //     &\quad + \frac{A\omega(\beta^2-\omega_0^2+\omega^2)}{\omega_0(\beta^2+(\omega+\omega_0)^2)(\beta^2+(\omega-\omega_0)^2)}\sin(\omega_0 t) \\[5pt]
  //     &\quad + A e^{\beta t}\,\frac{(\beta^2+\omega_0^2-\omega^2)\sin(\omega t)-2\beta\omega\cos(\omega t)}{(\beta^2+(\omega+\omega_0)^2)(\beta^2+(\omega-\omega_0)^2)}
  //     \end{aligned}
  //     """),
  //   ],
  // ),

  // --- 無減衰・強制振動（指数×三角 数値） ---
  // MathProblem(
  //   id: "D87AC614-9562-4570-8921-38EF84BADF5F",
  //   no: 118,
  //   category: '数値・二階・非斉次',
  //   level: '上級',
  //   question: r"""f''(t)+4f(t)=2e^t\sin(3t),\quad f(0)=0,\ f'(0)=0""",
  //   answer: r"""\displaystyle f(t)=\frac{3}{13}\cos(2t) + \frac{9}{26}\sin(2t) + \frac{e^t}{13}\left(-2\sin(3t) - 3\cos(3t)\right)""",
  //   imageAsset: '',
  //   equation: r"""f''(t)+4f(t)=2e^t\sin(3t)""",
  //   conditions: r"""f(0)=0,\ f'(0)=0""",
  //   constants: r"""""",
  //   keywords: ['交流', '数値', 'コンデンサ', 'コイル'],
  //   steps: [
  //     StepItem(tex: r"""\textbf{【方針】}"""),
  //     StepItem(tex: r"""\text{特解を求めて、それを引いた関数を新たに定義し、右辺0(同次方程式)の場合sの公式を適用して解く。}"""),
      
  //     StepItem(tex: r"""\textcolor{brown}{\large{【解法】}}"""),
  //     StepItem(tex: r"""\textcolor{green}{右辺の定数項が無い(同次方程式)の場合の公式}"""),
  //     StepItem(tex: r"""\text{微分方程式 } f''(t) = -\omega^2 f(t) \text{ に対する初期値問題}"""),
  //     StepItem(tex: r"""f(0) = A_0,\quad f'(0) = v_0"""),
  //     StepItem(tex: r"""\text{の解は}"""),
  //     StepItem(tex: r"""f(t) = A_0\cos(\omega t) + \displaystyle \frac{v_0}{\omega}\sin(\omega t)"""),
  //     StepItem(tex: r"""\text{である。（問題6で導出済み）}"""),
  //      StepItem(tex: r"""\textcolor{blue}{この公式を用いて、本問を解く。}"""),
  //     StepItem(tex: r"""f''(t) + 4f(t) = 2e^t\sin(3t)"""),
      
  //     StepItem(tex: r"""\textcolor{green}{1.\ } \textcolor{green}{特解を求める}"""),
  //     StepItem(tex: r"""\text{非斉次項 }2e^t\sin(3t)\text{ より、特解を }"""),
  //     StepItem(tex: r"""f_p(t) = e^t\left(A\sin(3t) + B\cos(3t)\right)"""),
  //     StepItem(tex: r"""\text{の形で推定する（}A, B\text{ は未定係数）。}"""),
      
  //     StepItem(tex: r"""\text{まず、}f_p(t)\text{ を微分する：}"""),
  //     StepItem(tex: r"""
  //     \begin{aligned}
  //     f_p'(t) &= e^t\left(A\sin(3t) + B\cos(3t)\right) + e^t\left(3A\cos(3t) - 3B\sin(3t)\right) \\[5pt]
  //     &= e^t\left((A-3B)\sin(3t) + (3A+B)\cos(3t)\right)
  //     \end{aligned}
  //     """),
  //     StepItem(tex: r"""\text{さらに微分すると、}"""),
  //     StepItem(tex: r"""
  //     \begin{aligned}
  //     f_p''(t) &= e^t\left((A-3B)\sin(3t) + (3A+B)\cos(3t)\right) \\[5pt]
  //     &\quad + e^t\left(3(A-3B)\cos(3t) - 3(3A+B)\sin(3t)\right) \\[5pt]
  //     &= e^t\left((A-3B-9A-3B)\sin(3t) + (3A+B+3A-9B)\cos(3t)\right) \\[5pt]
  //     &= e^t\left((-8A-6B)\sin(3t) + (6A-8B)\cos(3t)\right)
  //     \end{aligned}
  //     """),
  //     StepItem(tex: r"""\text{これらを }f_p''(t) + 4f_p(t) = 2e^t\sin(3t)\text{ に代入すると、}"""),
  //     StepItem(tex: r"""
  //     \begin{aligned}
  //     f_p''(t) + 4f_p(t) &= e^t\left((-8A-6B)\sin(3t) + (6A-8B)\cos(3t)\right) \\[5pt]
  //     &\quad + 4e^t\left(A\sin(3t) + B\cos(3t)\right) \\[5pt]
  //     &= e^t\left((-8A-6B+4A)\sin(3t) + (6A-8B+4B)\cos(3t)\right) \\[5pt]
  //     &= e^t\left((-4A-6B)\sin(3t) + (6A-4B)\cos(3t)\right) \\[5pt]
  //     &= 2e^t\sin(3t)
  //     \end{aligned}
  //     """),
      
  //     StepItem(tex: r"""\textcolor{green}{2.\ } \textcolor{green}{係数を比較}"""),
  //     StepItem(tex: r"""\text{両辺の係数を比較して、}"""),
  //     StepItem(tex: r"""
  //     \begin{cases}
  //     -4A - 6B = 2 \\[5pt]
  //     6A - 4B = 0
  //     \end{cases}
  //     """),
  //     StepItem(tex: r"""\text{第2式より }A = \displaystyle \frac{2B}{3}\text{ を第1式に代入して、}"""),
  //     StepItem(tex: r"""
  //     \begin{aligned}
  //     -4 \cdot \frac{2B}{3} - 6B &= 2 \\[5pt]
  //     -\frac{26B}{3} &= 2 \\[5pt]
  //     B &= -\frac{3}{13},\quad A = -\frac{2}{13}
  //     \end{aligned}
  //     """),
  //     StepItem(tex: r"""\text{特解は、}"""),
  //     StepItem(tex: r"""
  //     \begin{aligned}
  //     f_p(t) &= \frac{e^t}{13}\left(-2\sin(3t) - 3\cos(3t)\right)
  //     \end{aligned}
  //     """),
      
  //     StepItem(tex: r"""\textcolor{green}{3.\ } \textcolor{green}{平行移動で新たな関数} \textcolor{green}{g} \textcolor{green}{を置いて同次化}"""),
  //     StepItem(tex: r"""\text{平行移動：}g(t) = f(t) - f_p(t) \text{ とおく。}"""),
  //     StepItem(tex: r"""\text{微分の線形性と }f_p''(t) + 4f_p(t) = 2e^t\sin(3t)\text{ より、}"""),
  //     StepItem(tex: r"""
  //     \begin{aligned}
  //     g''(t) + 4g(t) &= (f(t) - f_p(t))'' + 4(f(t) - f_p(t)) \\[5pt]
  //     &= (f''(t) + 4f(t)) - (f_p''(t) + 4f_p(t)) \\[5pt]
  //     &= 2e^t\sin(3t) - 2e^t\sin(3t) \\[5pt]
  //     &= 0
  //     \end{aligned}
  //     """),
  //     StepItem(tex: r"""\text{よって }g''(t) = -4 g(t) \text{（同次化完了）}"""),
      
  //     StepItem(tex: r"""\textcolor{green}{4.\ } \textcolor{green}{g} \textcolor{green}{の初期条件を求める}"""),
  //     StepItem(tex: r"""
  //     \begin{aligned}
  //     g(0) &= f(0) - f_p(0) \\[5pt]
  //     &= 0 - \frac{e^0}{13}\left(-2\sin(0) - 3\cos(0)\right) \\[5pt]
  //     &= 0 - \frac{1}{13}(-3) \\[5pt]
  //     &= \frac{3}{13}
  //     \end{aligned}
  //     """),
  //     StepItem(tex: r"""\text{次に、}f_p'(t)\text{ を計算する：}"""),
  //     StepItem(tex: r"""
  //     \begin{aligned}
  //     f_p'(t) &= \frac{e^t}{13}\left(-2\sin(3t) - 3\cos(3t)\right) \\[5pt]
  //     &\quad + \frac{e^t}{13}\left(-6\cos(3t) + 9\sin(3t)\right) \\[5pt]
  //     &= \frac{e^t}{13}\left((9-2)\sin(3t) + (-6-3)\cos(3t)\right) \\[5pt]
  //     &= \frac{e^t}{13}\left(7\sin(3t) - 9\cos(3t)\right)
  //     \end{aligned}
  //     """),
  //     StepItem(tex: r"""\text{よって、}"""),
  //     StepItem(tex: r"""
  //     \begin{aligned}
  //     g'(0) &= f'(0) - f_p'(0) \\[5pt]
  //     &= 0 - \frac{e^0}{13}\left(7\sin(0) - 9\cos(0)\right) \\[5pt]
  //     &= 0 - \frac{1}{13}(-9) \\[5pt]
  //     &= \frac{9}{13}
  //     \end{aligned}
  //     """),
      
  //     StepItem(tex: r"""\textcolor{green}{5.\ } \textcolor{green}{公式を適用し} \textcolor{green}{g} \textcolor{green}{を求める}"""),
  //     StepItem(tex: r"""g''(t) = -4 g(t) \text{で、}g(0) = \displaystyle \frac{3}{13},\ g'(0) = \displaystyle \frac{9}{13}"""),
  //     StepItem(tex: r"""\text{公式より（}\omega = 2\text{）}"""),
  //     StepItem(tex: r"""
  //     \begin{aligned}
  //     g(t) &= g(0)\cos(2t) + \frac{g'(0)}{2}\sin(2t) \\[5pt]
  //     &= \frac{3}{13}\cos(2t) + \frac{9}{13 \cdot 2}\sin(2t) \\[5pt]
  //     &= \frac{3}{13}\cos(2t) + \frac{9}{26}\sin(2t)
  //     \end{aligned}
  //     """),
      
  //     StepItem(tex: r"""\textcolor{green}{6.\ } \textcolor{green}{g} \textcolor{green}{から} \textcolor{green}{f} \textcolor{green}{を求める}"""),
  //     StepItem(tex: r"""
  //     \begin{aligned}
  //     f(t) &= g(t) + f_p(t) \\[5pt]
  //     &= \frac{3}{13}\cos(2t) + \frac{9}{26}\sin(2t) + \frac{e^t}{13}\left(-2\sin(3t) - 3\cos(3t)\right)
  //     \end{aligned}
  //     """),
  //   ],
  // ),


  // --- 単振動（LC自由） 数値---
  MathProblem(
    id: "4F674DAB-329F-45CC-9417-94C45BE5B203",
    no: 106,
    category: '二階同次・定数係数',
    level: '中級',
    question: r"""f''(t) = -4\,f(t),\quad f(0) = 0,\ f'(0) = 2""",
    answer: r"""\displaystyle f(t)=\sin(2t)""",
    imageAsset: '',
    equation: r"""f''(t) = -4\,f(t)""",
    conditions: r"""f(0)=0,\ f'(0)=2""",
    keywords: ['単振動',  '数値', 'コンデンサ', 'コイル'],
    steps: [
      StepItem(tex: r"""\textcolor{brown}{\large{【力学】}}"""),
      StepItem(tex: r"""\text{• 力学においては、} mx''(t) + kx(t) = 0 \text{ の形でよく登場する。これはばね-質量系の単振動の運動方程式。}"""),
      StepItem(tex: r"""\textcolor{brown}{\large{【電磁気学】}}"""),
      StepItem(tex: r"""\text{• 電磁気学においては、} LQ''(t) + \displaystyle \frac{Q(t)}{C} = 0 \text{ の形でよく登場する。これはLC回路の放電におけるキルヒホッフの法則であり、電気振動をする。}"""),
      StepItem(tex: r"""\textcolor{brown}{\large{【問題の記号と力学における記号の対応】}}"""),
      StepItem(tex: r"""\text{単振動の具体例（ばね-質量系の自由振動）:} \ mx''(t) + kx(t) = 0"""),
      StepItem(tex: r"""\text{• } f(t) \leftrightarrow x(t) \text{（位置）}"""),
      StepItem(tex: r"""\text{• } f'(t) \leftrightarrow v(t) \text{（速度）}"""),
      StepItem(tex: r"""\text{• } f''(t) \leftrightarrow a(t) \text{（加速度）}"""),
      StepItem(tex: r"""\text{• } 4 \leftrightarrow \displaystyle \frac{k}{m} \text{（ばね定数 ÷ 質量）}"""),
      StepItem(tex: r"""\text{• } f(0)=0 \leftrightarrow x_0=0 \text{（初期位置）}"""),
      StepItem(tex: r"""\text{• } f'(0)=2 \leftrightarrow v_0=2 \text{（初期速度）}"""),
      StepItem(tex: r"""\textcolor{brown}{\large{【問題の記号と電磁気学における記号の対応】}}"""),
      StepItem(tex: r"""\text{LC振動回路の具体例（コンデンサとコイルの自由振動）:} \ LQ''(t) + \displaystyle \frac{Q(t)}{C} = 0"""),
      StepItem(tex: r"""\text{• } f(t) \leftrightarrow Q(t) \text{（コンデンサに蓄えられた電荷）}"""),
      StepItem(tex: r"""\text{• } f'(t) \leftrightarrow I(t) \text{（電流）}"""),
      StepItem(tex: r"""\text{• } f''(t) \leftrightarrow I' \text{（電流変化率）}"""),
      StepItem(tex: r"""\text{• } 4 \leftrightarrow \displaystyle \frac{1}{LC} \text{（固有角周波数の2乗）}"""),
      StepItem(tex: r"""\text{• } f(0)=0 \leftrightarrow Q_0=0 \text{（コンデンサに蓄えられた初期電荷）}"""),
      StepItem(tex: r"""\text{• } f'(0)=2 \leftrightarrow I_0=2 \text{（初期電流）}"""),
      StepItem(tex: r"""\text{【方針】}"""),
      StepItem(tex: r"""\text{保存量と位相パラメータで直接決定する。}"""),
      StepItem(tex: r"""\textcolor{brown}{\large{【解法】}}"""),
      StepItem(tex: r"""\textcolor{green}{1.\ } \textcolor{green}{\displaystyle \frac{1}{2}f'(t)^2 + 2f(t)^2} \textcolor{green}{は時間によらず一定}"""),
      StepItem(tex: r"""f''(t) = -4f(t) \text{の両辺に}f'(t)\text{ を掛ける。(こうやるとうまくいく)}"""),
      StepItem(tex: r"""\Rightarrow \ f''(t)f'(t) = -4 f(t)f'(t)"""),
      StepItem(tex: r"""\text{積の微分より}"""),
      StepItem(tex: r"""\Leftrightarrow \ \left(\displaystyle \frac{1}{2}f'(t)^2\right)' = \left(-\displaystyle \frac{4}{2}f(t)^2\right)'"""),
      StepItem(tex: r"""\text{移項する：}"""),
      StepItem(tex: r"""\Leftrightarrow \ \left(\displaystyle \frac{1}{2}f'(t)^2\right)' - \left(-\displaystyle \frac{4}{2}f(t)^2\right)' = 0"""),
      StepItem(tex: r"""\Leftrightarrow \ \left(\displaystyle \frac{1}{2}f'(t)^2 + \displaystyle \frac{4}{2}f(t)^2\right)' = 0"""),
      StepItem(tex: r"""\text{これは、時間微分が0なので、} \displaystyle  \frac{1}{2}f'(t)^2 + \displaystyle \frac{4}{2}f(t)^2 \text{は時間によらない保存量である。}"""),
      StepItem(tex: r"""\Leftrightarrow \ \displaystyle \frac{1}{2}f'(t)^2 + \displaystyle 2f(t)^2 = C \quad(\text{定数}) \cdots (1)"""),
      StepItem(tex: r"""\textcolor{green}{2.\ } \textcolor{green}{任意の時刻} \textcolor{green}{t} \textcolor{green}{において、} \textcolor{green}{\left(\displaystyle \frac{f'(t)}{2}\right)^2 + f(t)^2 = 1} \textcolor{green}{ : 一定} """),
      StepItem(tex: r"""\text{初期条件} f(0)=0,\ f'(0)=2 \text{より、上段で求めた時間によらない保存量} \displaystyle \frac{1}{2}f'(t)^2 + \displaystyle \frac{4}{2}f(t)^2 \text{の値を}C\text{と置く。ここで初期条件を用いると、} """),
      StepItem(tex: r"""C = \displaystyle \frac12\cdot 2^2 + 2\cdot 0^2"""),
      StepItem(tex: r"""\text{よって、任意の時刻} t \text{で、} """),
      StepItem(tex: r""" \displaystyle \frac{1}{2}f'(t)^2 + 2f(t)^2 = 2 \  \cdots (1)"""),
      StepItem(tex: r""" \text{が成り立つ。(1)の両辺を}2\text{で割って}"""),
      StepItem(tex: r"""\Leftrightarrow \left(\displaystyle \frac{f'(t)}{2}\right)^2 + f(t)^2 = \displaystyle \frac{4}{4} = 1 \  \cdots (2)"""),
      StepItem(tex: r"""\textcolor{green}{3.\ } \textcolor{green}{\displaystyle \frac{f'(t)}{2} = \cos\theta(t),\  f(t) = \sin\theta(t)} \textcolor{green}{を満たす関数} \textcolor{green}{\theta(t)} \textcolor{green}{を取る事ができる。}"""),
      StepItem(tex: r"""(2) \text{より} \left(\displaystyle \frac{f'(t)}{2},\, f(t)\right) \text{は常に半径1の円上。}"""),
      StepItem(tex: r"""\text{よって、連続な角度} \theta(t) \text{を用いて下記のように表すことができる。}"""),
      StepItem(tex: r"""
      \begin{cases}
      \displaystyle \frac{f'(t)}{2}=\cos\theta(t)\ \ \cdots (3)\\[6pt]
      f(t)=\sin\theta(t)\ \ \cdots (4)
      \end{cases}
      """),
      StepItem(tex: r"""\textcolor{green}{4.\ } \textcolor{green}{\cos\theta(0) = 1, \ \sin\theta(0) = 0} \textcolor{green}{が成り立つ。}"""),
      StepItem(tex: r"""\text{(3),(4)に }t=0 \text{を代入すると、初期条件より}"""),
      StepItem(tex: r"""
      \begin{aligned}
      &\quad \begin{cases}
      \displaystyle \frac{f'(0)}{2}=\displaystyle \frac{2}{2}=1=\cos\theta(0)\\[6pt]
      f(0)=0=\sin\theta(0)
      \end{cases}
      \\[7pt]
      & \Leftrightarrow
      \begin{cases}
      \cos\theta(0) = \displaystyle \frac{1}{1} = 1\ \ \cdots (5)\\[6pt]
      \sin\theta(0) = \displaystyle \frac{0}{1} = 0\ \ \cdots (6)
      \end{cases}
      \end{aligned}
      """),
      StepItem(tex: r"""\text{(5),(6)より} \theta(0) = 0 \text{である。}"""),
      StepItem(tex: r"""\textcolor{green}{5.\ } \textcolor{green}{\theta'(t) = 2} \textcolor{green}{ が成り立つ}"""),
      StepItem(tex: r"""\text{(4)より}f(t) = \sin\theta(t) \text{なので、連鎖律により} f'(t) = 1 \cdot \theta'(t)\cos\theta(t)"""),
      StepItem(tex: r"""\text{一方、定義(3)より} \displaystyle \frac{f'(t)}{2}=\cos\theta(t) \text{なので} f'(t) = 2 \cdot \cos\theta(t)"""),
      StepItem(tex: r"""\text{ゆえに、} 1 \cdot \theta'(t)\cos\theta(t) = 2 \cdot \cos\theta(t)"""),
      StepItem(tex: r"""\cos\theta(t)\text{の係数を比較して} 1 \cdot \theta'(t) = 2 \text{よって} \cos\theta(t)\neq 0 \text{を満たす}t{では} \theta'(t)=2"""),
      StepItem(tex: r"""\theta'(t)\text{の連続性から、任意の時刻で、} \theta'(t)=2 """),
      StepItem(tex: r"""\textcolor{green}{6.\ } \textcolor{green}{f(t)=\sin(2t)}\textcolor{green}{ が成り立つ}"""),
      StepItem(tex: r"""\theta'(t) = 2 \text{と} \theta(0) = 0 \text{より}"""),
      StepItem(tex: r"""\text{両辺を不定積分して、}\theta(t)=2 t+\theta_0 \text{とできる。ここで、}\theta_0 \text{は、}t=0\text{ を代入して} \theta_0 = 0\text{なので、}"""),
      StepItem(tex: r"""\theta(t)=2 t \text{となる。}"""),
      StepItem(tex: r"""\text{ゆえに、(4)より}"""),
      StepItem(tex: r"""
      \begin{aligned}
      f(t) &= \sin\theta(t) \\[5pt]
      &= \sin(2 t)
      \end{aligned}
      """),
    ],
  ),



  // --- 一定外力（単振動 数値） ---
  MathProblem(
    id: "2C1016F1-C7DD-4BE8-8BC8-0C5AA7F05FB5",
    no: 107,
    category: '二階同次・定数係数',
    level: '中級',
    question: r"""f''(t) = -4\,f(t) + 2,\quad f(0) = 0,\ f'(0) = 0""",
    answer: r"""\displaystyle f(t)=\displaystyle \frac{1}{2}\big(1-\cos(2t)\big)""",
    imageAsset: '',
    equation: r"""f''(t) = -4\,f(t) + 2""",
    conditions: r"""f(0) = 0,\ f'(0) = 0""",
    keywords: ['単振動',  '直流', '数値', 'コンデンサ', 'コイル'],
    steps: [
      StepItem(tex: r"""\textcolor{brown}{\large{【力学】}}"""),
      StepItem(tex: r"""\text{• 力学においては、} mx''(t) + kx(t) = F \text{ の形でよく登場する。}F=mg\text{の場合は、重力下のばね-質量系の運動を表す。重力による平衡位置シフトが起きる。}"""),
      StepItem(tex: r"""\textcolor{brown}{\large{【電磁気学】}}"""),
      StepItem(tex: r"""\text{• 電磁気学においては、} LQ''(t) + \displaystyle \frac{Q(t)}{C} = V \text{ の形でよく登場する。これは直流電圧が印加されたLC回路を表す。}"""),
      StepItem(tex: r"""\textcolor{brown}{\large{【問題の記号と力学における記号の対応】}}"""),
      StepItem(tex: r"""\text{重力下のばねの運動:} \ mx''(t) + kx(t) = F"""),
      StepItem(tex: r"""\text{• } f(t) \leftrightarrow x(t) \text{（位置）}"""),
      StepItem(tex: r"""\text{• } f'(t) \leftrightarrow v(t) \text{（速度）}"""),
      StepItem(tex: r"""\text{• } f''(t) \leftrightarrow a(t) \text{（加速度）}"""),
      StepItem(tex: r"""\text{• } 4 \leftrightarrow \displaystyle \frac{k}{m} \text{（ばね定数 ÷ 質量）}"""),
      StepItem(tex: r"""\text{• } 2 \leftrightarrow \displaystyle \frac{F}{m} \text{（外力 ÷ 質量）}"""),
      StepItem(tex: r"""\text{• } f(0)=0 \leftrightarrow x_0=0 \text{（初期位置）}"""),
      StepItem(tex: r"""\text{• } f'(0)=0 \leftrightarrow v_0=0 \text{（初期速度）}"""),
      StepItem(tex: r"""\textcolor{brown}{\large{【問題の記号と電磁気学における記号の対応】}}"""),
      StepItem(tex: r"""\text{LC直流回路:} \ LQ''(t) + \displaystyle \frac{Q(t)}{C} = V"""),
      StepItem(tex: r"""\text{• } f(t) \leftrightarrow Q(t) \text{（コンデンサに蓄えられた電荷）}"""),
      StepItem(tex: r"""\text{• } f'(t) \leftrightarrow I(t) \text{（電流）}"""),
      StepItem(tex: r"""\text{• } f''(t) \leftrightarrow I' \text{（電流変化率）}"""),
      StepItem(tex: r"""\text{• } 4 \leftrightarrow \displaystyle \frac{1}{LC} \text{（固有角周波数の2乗）}"""),
      StepItem(tex: r"""\text{• } 2 \leftrightarrow \displaystyle \frac{V}{L} \text{（電圧 ÷ インダクタンス）}"""),
      StepItem(tex: r"""\text{• } f(0)=0 \leftrightarrow Q_0=0 \text{コンデンサに蓄えられた初期電荷）}"""),
      StepItem(tex: r"""\text{• } f'(0)=0 \leftrightarrow I_0=0 \text{（初期電流）}"""),
      StepItem(tex: r"""\textbf{【方針】}"""),
      StepItem(tex: r"""\text{定数解を求めて平行移動し、外力がない場合の微分方程式の解の式を利用する。}"""),
      
      StepItem(tex: r"""\textcolor{brown}{\large{【解法】}}"""),
      StepItem(tex: r"""\textcolor{green}{同次の場合の公式}"""),
      StepItem(tex: r"""\text{微分方程式 } f''(t) = -\omega^2 f(t) \text{ に対する初期値問題}"""),
      StepItem(tex: r"""f(0) = A_0,\quad f'(0) = v_0"""),
      StepItem(tex: r"""\text{の解は}"""),
      StepItem(tex: r"""f(t) = A_0\cos(\omega t) + \displaystyle \frac{v_0}{\omega}\sin(\omega t)"""),
      StepItem(tex: r"""\text{である。（問題6で導出済み）}"""),
       StepItem(tex: r"""\textcolor{blue}{この公式を用いて、本問を解く。}"""),
      StepItem(tex: r"""f''(t) = -4f(t) + 2"""),
      StepItem(tex: r"""\textcolor{green}{1.\ } \textcolor{green}{定数解を探す}"""),
      StepItem(tex: r"""\text{定数解}f_s\text{を求める。}f_s'' = 0\text{より}"""),
      StepItem(tex: r"""0 = -4 f_s + 2 \quad \Leftrightarrow \quad f_s = \displaystyle \frac{2}{4} = \displaystyle \frac{1}{2}"""),
      StepItem(tex: r"""\textcolor{green}{2.\ } \textcolor{green}{平行移動で新たな関数} \textcolor{green}{g} \textcolor{green}{を置いて同次化(バネのみの力による単振動の式にする)}"""),
      StepItem(tex: r"""\text{平行移動：}g(t) = f(t) - f_s \text{ とおく。}"""),
      StepItem(tex: r"""\begin{aligned}
      g''(t) &= f''(t) = -4 f(t) + 2 \\[5pt]
      &= -4(g(t) + f_s) + 2 \\[5pt]
      &= -4 g(t) - 4 \cdot \displaystyle \frac{1}{2} + 2 \\[5pt]
      &= -4 g(t)
      \end{aligned}"""),
      StepItem(tex: r"""\text{よって }g''(t) = -4 g(t) \text{（同次化完了）}"""),
      StepItem(tex: r"""\textcolor{green}{3.\ } \textcolor{green}{g} \textcolor{green}{の初期条件を求める}"""),
      StepItem(tex: r"""\begin{aligned}
      g(0) &= f(0) - f_s = 0 - \displaystyle \frac{1}{2} = -\displaystyle \frac{1}{2} \\[5pt]
      g'(0) &= f'(0) = 0
      \end{aligned}"""),
      StepItem(tex: r"""\textcolor{green}{4.\ } \textcolor{green}{公式を適用し} \textcolor{green}{g} \textcolor{green}{を求める}"""),
      StepItem(tex: r"""g''(t) = -4 g(t) \text{で、}g(0) = -\displaystyle \frac{1}{2},\ g'(0) = 0"""),
      StepItem(tex: r"""\text{公式より（}\omega = 2\text{）}"""),
      StepItem(tex: r"""\begin{aligned}
      g(t) &= g(0)\cos(2t) + \displaystyle \frac{g'(0)}{2}\sin(2t) \\[5pt]
      &= -\displaystyle \frac{1}{2}\cos(2t)
      \end{aligned}"""),
      StepItem(tex: r"""\textcolor{green}{5.\ } \textcolor{green}{g} \textcolor{green}{から} \textcolor{green}{f} \textcolor{green}{を求める}"""),
      StepItem(tex: r"""f(t) = g(t) + f_s = -\displaystyle \frac{1}{2}\cos(2t) + \displaystyle \frac{1}{2}"""),
      StepItem(tex: r"""\quad = \displaystyle \frac{1}{2}\big(1 - \cos(2t)\big)"""),
    ],
  ),


  // --- 双曲型（反発力） 数値---
  MathProblem(
    id: "9B2C3D4E-5F6G-7890-BCDE-F23456789012",
    no: 108,
    category: '二階同次・定数係数（双曲型）',
    level: '中級',
    question: r"""f''(t) = 9\,f(t),\quad f(0) = 1,\ f'(0) = 0""",
    answer: r"""\displaystyle f(t)=\displaystyle \frac{1}{2}e^{3t}+\displaystyle \frac{1}{2}e^{-3t} \text{ または } f(t)=\cosh(3t)""",
        imageAsset: '',
    equation: r"""f''(t) = 9\,f(t)""",
    conditions: r"""f(0)=1,\ f'(0)=0""",
    constants: r"""""",
    keywords: ['数値', '大学'],
        steps: [
      // StepItem(tex: r"""\text{【問題の記号と力学における記号の対応】}"""),
      // StepItem(tex: r"""\text{反発力による運動の具体例（不安定平衡点からの運動）}"""),
      // StepItem(tex: r"""mx''(t) - kx(t) = 0"""),
      // StepItem(tex: r"""\text{• } f(t) \leftrightarrow x(t) \text{（位置）}"""),
      // StepItem(tex: r"""\text{• } f'(t) \leftrightarrow v(t) \text{（速度）}"""),
      // StepItem(tex: r"""\text{• } f''(t) \leftrightarrow a(t) \text{（加速度）}"""),
      // StepItem(tex: r"""\text{• } 9 \leftrightarrow \displaystyle \frac{k}{m} \text{（反発力定数 ÷ 質量）}"""),
      // StepItem(tex: r"""\text{• } f(0)=1 \leftrightarrow x_0=1 \text{（初期位置）}"""),
      // StepItem(tex: r"""\text{• } f'(0)=0 \leftrightarrow v_0=0 \text{（初期速度）}"""),
      // StepItem(tex: r"""\text{【問題の記号と電磁気学における記号の対応】}"""),
      // StepItem(tex: r"""\text{負性抵抗回路の具体例（不安定な電気回路）}"""),
      // StepItem(tex: r"""LQ''(t) - \displaystyle \frac{Q(t)}{C} = 0"""),
      // StepItem(tex: r"""\text{• } f(t) \leftrightarrow Q(t) \text{（コンデンサに蓄えられた電荷）}"""),
      // StepItem(tex: r"""\text{• } f'(t) \leftrightarrow I(t) \text{（電流）}"""),
      // StepItem(tex: r"""\text{• } f''(t) \leftrightarrow I' \text{（電流変化率）}"""),
      // StepItem(tex: r"""\text{• } 9 \leftrightarrow \displaystyle \frac{1}{LC} \text{（固有角周波数の2乗）}"""),
      // StepItem(tex: r"""\text{• } f(0)=1 \leftrightarrow Q_0=1 \text{（コンデンサに蓄えられた初期電荷）}"""),
      // StepItem(tex: r"""\text{• } f'(0)=0 \leftrightarrow I_0=0 \text{（初期電流）}"""),
      StepItem(tex: r"""\text{【方針】}"""),
      StepItem(tex: r"""\text{保存量と双曲線パラメータで直接決定する。}"""),
      StepItem(tex: r"""\textcolor{brown}{\large{【解法】}}"""),
      StepItem(tex: r"""\text{【双曲線関数の定義】}"""),
      StepItem(tex: r"""\text{双曲線関数（ハイパボリック関数）は以下のように定義される：}"""),
      StepItem(tex: r"""\cosh x = \displaystyle \frac{e^x + e^{-x}}{2} \quad \text{（双曲線余弦関数）}"""),
      StepItem(tex: r"""\sinh x = \displaystyle \frac{e^x - e^{-x}}{2} \quad \text{（双曲線正弦関数）}"""),
      StepItem(tex: r"""\text{これらの関数は三角関数と類似の性質を持ち、} \cosh^2 x - \sinh^2 x = 1 \text{ が成り立つ。すなわち、} (\cosh x, \sinh x) \text{は双曲線} x^2 - y^2 = 1 \text{上にある。}"""), 
      StepItem(tex: r"""\text{微分公式：}"""),
      StepItem(tex: r"""(\cosh x)' = \sinh x, \quad (\sinh x)' = \cosh x"""),
      StepItem(tex: r"""\text{加法定理：}"""),
      StepItem(tex: r"""\cosh(a+b) = \cosh a \cosh b + \sinh a \sinh b"""),
      StepItem(tex: r"""\sinh(a+b) = \sinh a \cosh b + \cosh a \sinh b"""),
      StepItem(tex: r"""\textcolor{green}{1.\ } \textcolor{green}{保存量} \textcolor{green}{\displaystyle \frac{1}{2}f'(t)^2 - \displaystyle \frac{9}{2}f(t)^2} \textcolor{green}{は時間によらず一定}"""),
      StepItem(tex: r"""f''(t) = 9f(t) \text{の両辺に}f'(t)\text{ を掛ける。(こうやるとうまくいく)}"""),
      StepItem(tex: r"""\Rightarrow \ f''(t)f'(t) = 9 f(t)f'(t)"""),
      StepItem(tex: r"""\text{積の微分より}"""),
      StepItem(tex: r"""\Leftrightarrow \ \left(\displaystyle \frac{1}{2}f'(t)^2\right)' = \left(\displaystyle \frac{9}{2}f(t)^2\right)'"""),
      StepItem(tex: r"""\text{移項する：}"""),
      StepItem(tex: r"""\Leftrightarrow \ \left(\displaystyle \frac{1}{2}f'(t)^2\right)' - \left(\displaystyle \frac{9}{2}f(t)^2\right)' = 0"""),
      StepItem(tex: r"""\Leftrightarrow \ \left(\displaystyle \frac{1}{2}f'(t)^2 - \displaystyle \frac{9}{2}f(t)^2\right)' = 0"""),
      StepItem(tex: r"""\text{平衡点、時間微分が0なので、} \displaystyle  \frac{1}{2}f'(t)^2 - \displaystyle \frac{9}{2}f(t)^2 \text{は時間によらない保存量である。}"""),
      StepItem(tex: r"""\textcolor{green}{2.\ } \textcolor{green}{任意の時刻} \textcolor{green}{t} \textcolor{green}{において、} \textcolor{green}{\left(\displaystyle \frac{f'(t)}{3}\right)^2 - f(t)^2 = -1} """),
      StepItem(tex: r"""\text{初期条件} f(0)=1,\ f'(0)=0 \text{より、上段で求めた時間によらない保存量} \displaystyle \frac{1}{2}f'(t)^2 - \displaystyle \frac{9}{2}f(t)^2 \text{の値を}C\text{と置く。ここで初期条件を用いると、} """),
      StepItem(tex: r"""C = \displaystyle \frac12\cdot 0^2 - \displaystyle \frac{9}{2}\cdot 1^2"""),
      StepItem(tex: r"""\text{よって、任意の時刻} t \text{で、} """),
      StepItem(tex: r""" \displaystyle \frac{1}{2}f'(t)^2 - \displaystyle \frac{9}{2}f(t)^2 = -\displaystyle \frac{9}{2} \  \cdots (1)"""),
      StepItem(tex: r""" \text{が成り立つ。(1)の両辺を}\displaystyle \frac{9}{2}\text{で割って}"""),
      StepItem(tex: r"""\Leftrightarrow \left(\displaystyle \frac{f'(t)}{3}\right)^2 - f(t)^2 = \displaystyle \frac{-9}{9} = -1 \  \cdots (2)"""),
      StepItem(tex: r"""\textcolor{green}{3.\ } \textcolor{green}{\displaystyle \frac{f'(t)}{3} = \sinh\theta(t),\ \  f(t) = \cosh\theta(t)} \textcolor{green}{を満たす関数} \textcolor{green}{\theta(t)}\textcolor{green}{を取ることができる。}"""),
      StepItem(tex: r"""(2) より \left(\displaystyle \frac{f'(t)}{3},\, f(t)\right) \text{は常に双曲線 } x^2 - y^2 = -1 \text{ の上にある。}"""),
      StepItem(tex: r"""\text{よって、連続な双曲線パラメータ } \theta(t) \text{ を用いて下記のように表すことができる。}"""),
      StepItem(tex: r"""
      \begin{cases}
      \displaystyle \frac{f'(t)}{3}=\sinh\theta(t)\ \ \cdots (3)\\[6pt]
      f(t)=\cosh\theta(t)\ \ \cdots (4)
      \end{cases}
      """),

      StepItem(tex: r"""\textcolor{green}{4.\ } \textcolor{green}{\sinh\theta(0) = 0, \ \cosh\theta(0) = 1} \textcolor{green}{が成り立つ。}"""),
      StepItem(tex: r"""\text{(3),(4)に }t=0 \text{を代入すると、初期条件より}"""),
      StepItem(tex: r"""
      \begin{aligned}
      \quad &\begin{cases}
      \displaystyle \frac{f'(0)}{3}=\displaystyle \frac{0}{3}=0=\sinh\theta(0)\\[6pt]
      f(0)=1=\cosh\theta(0)
      \end{cases}\\[7pt]
      \Leftrightarrow & 
      \begin{cases}
      \sinh\theta(0) = 0\ \ \ \cdots (5)\\[6pt] 
      \cosh\theta(0) = 1\ \ \ \cdots (6)
      \end{cases}
      \end{aligned}
      """),
      StepItem(tex: r"""\textcolor{green}{5.\ } \textcolor{green}{\theta '(t) = 3} \textcolor{green}{が成り立つ}"""),
      StepItem(tex: r"""\text{(4)より } f(t) = \cosh\theta(t) \text{ なので、連鎖律により } f'(t) = \theta'(t)\sinh\theta(t)."""),
      StepItem(tex: r"""\text{一方、定義(3)より } \displaystyle \frac{f'(t)}{3}=\sinh\theta(t) \text{ なので } f'(t) = 3\sinh\theta(t)."""),
      StepItem(tex: r"""\text{ゆえに、 } \theta'(t)\sinh\theta(t) = 3\sinh\theta(t). \text{ ( } \sinh\theta(t)\neq0\text{ の時) }"""),
      StepItem(tex: r"""\text{係数比較により } \theta'(t)=3 \text{ が得られる。連続性から任意の } t \text{ で成立する。}"""),
      StepItem(tex: r"""\textcolor{green}{6.\ } \textcolor{green}{f(t) = \cosh(3t)} \textcolor{green}{が成り立つ}"""),
      StepItem(tex: r"""\text{(5),(6) より } \theta(t)=3t+\theta_0 \text{ ととれる。ここで } \sinh\theta_0=0,\ \cosh\theta_0=1."""),
      StepItem(tex: r"""\text{したがって、}"""),
      StepItem(tex: r"""
      \begin{aligned}
      f(t)&=\cosh(3t+\theta_0)\\[5pt]
      &=\cosh(3t)\cosh\theta_0+\sinh(3t)\sinh\theta_0\\[5pt]
      &=\cosh(3t)\cdot 1+\sinh(3t)\cdot 0\\[5pt]
      &=\cosh(3t)\\[5pt]
      &= \displaystyle \frac{e^{3t} + e^{-3t}}{2}
      \end{aligned}"""),
      // StepItem(tex: r"""\text{【力学】}"""),
      // StepItem(tex: r"""\text{• 物理においては、} mx'' - 9mx = 0 \text{ のように書かれる。これは反発力を受ける質点の運動方程式。指数関数的に発散する。}"""),
      // StepItem(tex: r"""\text{【電磁気学】}"""),
      // StepItem(tex: r"""\text{• 電磁気学においては、} LQ'' - \displaystyle \frac{Q}{C} = 0 \text{ の形でよく登場する。これは負性抵抗回路のキルヒホッフの法則であり、指数関数的に発散する。}"""),
    ],
  ),


  // --- 無減衰・非共振（LC駆動 数値） ---
  MathProblem(
    id: "B4A7301D-51FF-4FAE-B321-A02C73C38C9E",
    no: 116,
    category: '数値・二階・非斉次',
    level: '上級',
    question: r"""f''(t)+4\,f(t)=3\cos(t),\quad f(0)=0,\ f'(0)=0""",
    answer: r"""f(t)=-\cos(2t)+\cos(t)""",
    imageAsset: '',
    equation: r"""f''(t)+4\,f(t)=3\cos(t)""",
    conditions: r"""f(0)=0,\ f'(0)=0""",
    keywords: ['数値', '大学'],
    steps: [
      StepItem(tex: r"""\textcolor{brown}{\large{【力学】}}"""),
      StepItem(tex: r"""\text{• 無減衰強制振動（オフ共振駆動）}"""),
      StepItem(tex: r"""\text{• 力学においては、} mx''(t) + kx(t) = F_0\cos(t) \text{ の形でよく登場する。これは無減衰強制振動を表す。外力の角周波数 } 1 \text{ と固有角周波数 } 2 \text{ が異なる場合の解。}"""),
      StepItem(tex: r"""\textcolor{brown}{\large{【電磁気学】}}"""),
      StepItem(tex: r"""\text{• LC回路の強制振動（非共振）}"""),
      StepItem(tex: r"""\text{• 電磁気学においては、} LI'(t) + \displaystyle \frac{q(t)}{C} = V_0\cos(t) \text{ の形でよく登場する。これはLC回路の強制振動を表す。駆動周波数と共振周波数が異なる場合の電気振動。}"""),
      StepItem(tex: r"""\textcolor{brown}{\large{【問題の記号と力学における記号の対応】}}"""),
      StepItem(tex: r"""\text{無減衰強制振動:} \ mx''(t) + kx(t) = F_0\cos(t)"""),
      StepItem(tex: r"""\text{• } f(t) \leftrightarrow x(t) \text{（位置）}"""),
      StepItem(tex: r"""\text{• } f'(t) \leftrightarrow v(t) \text{（速度）}"""),
      StepItem(tex: r"""\text{• } f''(t) \leftrightarrow a(t) \text{（加速度）}"""),
      StepItem(tex: r"""\text{• } \omega_0 = 2 \leftrightarrow \sqrt{\displaystyle \frac{k}{m}} \text{（固有角周波数）}"""),
      StepItem(tex: r"""\text{• } 3 \leftrightarrow \displaystyle \frac{F_0}{m} \text{（外力振幅 ÷ 質量）}"""),
      StepItem(tex: r"""\text{• } \omega = 1 \leftrightarrow 1 \text{（外力の角周波数）}"""),
      StepItem(tex: r"""\text{• } f(0)=0 \leftrightarrow x_0=0 \text{（初期位置）}"""),
      StepItem(tex: r"""\text{• } f'(0)=0 \leftrightarrow v_0=0 \text{（初期速度）}"""),
      StepItem(tex: r"""\textcolor{brown}{\large{【問題の記号と電磁気学における記号の対応】}}"""),
      StepItem(tex: r"""\text{LC回路の強制振動:} \ LI'(t) + \displaystyle \frac{q(t)}{C} = V_0\cos(t)"""),
      StepItem(tex: r"""\text{• } f(t) \leftrightarrow q(t) \text{（電荷）}"""),
      StepItem(tex: r"""\text{• } f'(t) \leftrightarrow I(t) \text{（電流）}"""),
      StepItem(tex: r"""\text{• } f''(t) \leftrightarrow I'(t) \text{（電流変化率）}"""),
      StepItem(tex: r"""\text{• } \omega_0 = 2 \leftrightarrow \displaystyle \frac{1}{\sqrt{LC}} \text{（共振角周波数）}"""),
      StepItem(tex: r"""\text{• } 3 \leftrightarrow \displaystyle \frac{V_0}{L} \text{（電圧振幅 ÷ インダクタンス）}"""),
      StepItem(tex: r"""\text{• } \omega = 1 \leftrightarrow 1 \text{（駆動角周波数）}"""),
      StepItem(tex: r"""\text{• } f(0)=0 \leftrightarrow q_0=0 \text{（初期電荷）}"""),
      StepItem(tex: r"""\text{• } f'(0)=0 \leftrightarrow I_0=0 \text{（初期電流）}"""),
      StepItem(tex: r"""\textcolor{brown}{\large{【解法】}}"""),
      StepItem(tex: r"""\text{【方針】}"""),
      StepItem(tex: r"""\text{2階非線形微分方程式を、回転変数によって1階線形微分方程式×2本に変換し、積分で解く。}"""),
      StepItem(tex: r"""\textcolor{green}{1.\ } \textcolor{green}{回転変数を導入}"""),
      StepItem(tex: r"""\text{回転変数 } A(t), B(t) \text{ を以下のように定義する（} \omega_0 = 2 \text{）：}"""),
      StepItem(tex: r"""
      \begin{aligned}
      A(t) &\equiv f'(t)\cos(2t) + 2f(t)\sin(2t), \\[5pt]
      B(t) &\equiv f'(t)\sin(2t) - 2f(t)\cos(2t).
      \end{aligned}
      """),
      StepItem(tex: r"""\textcolor{green}{2.\ } \textcolor{green}{回転変数の微分を計算（交差項が消える）}"""),
      StepItem(tex: r"""A'(t) \text{ を計算する：}"""),
      StepItem(tex: r"""
      \begin{aligned}
      A'(t) &= f''(t)\cos(2t) - f'(t)\cdot 2\sin(2t) + 2f'(t)\sin(2t) + 4f(t)\cos(2t) \\[5pt]
      &= f''(t)\cos(2t) + 4f(t)\cos(2t) \\[5pt]
      &= \big(f''(t) + 4f(t)\big)\cos(2t)
      \end{aligned}
      """),
      StepItem(tex: r"""\text{元の微分方程式 } f''(t) + 4f(t) = 3\cos(t) \text{ より、}"""),
      StepItem(tex: r"""
      \begin{aligned}
      A'(t) &= 3\cos(t)\cos(2t)
      \end{aligned}
      """),
      StepItem(tex: r"""\text{同様に } B'(t) \text{ を計算する：}"""),
      StepItem(tex: r"""
      \begin{aligned}
      B'(t) &= f''(t)\sin(2t) + f'(t)\cdot 2\cos(2t) - 2f'(t)\cos(2t) + 4f(t)\sin(2t) \\[5pt]
      &= f''(t)\sin(2t) + 4f(t)\sin(2t) \\[5pt]
      &= \big(f''(t) + 4f(t)\big)\sin(2t) \\[5pt]
      &= 3\cos(t)\sin(2t)
      \end{aligned}
      """),
      StepItem(tex: r"""\textcolor{green}{3.\ } \textcolor{green}{初期条件から} \textcolor{green}{A(0)=B(0)=0} \textcolor{green}{が成り立つ}"""),
      StepItem(tex: r"""\text{初期条件 } f(0)=0, f'(0)=0 \text{ より、}"""),
      StepItem(tex: r"""
      \begin{aligned}
      A(0) &= f'(0)\cos(0) + 2f(0)\sin(0) = 0, \\[5pt]
      B(0) &= f'(0)\sin(0) - 2f(0)\cos(0) = 0
      \end{aligned}
      """),
      StepItem(tex: r"""\textcolor{green}{4.\ } \textcolor{green}{積分で} \textcolor{green}{A(t), B(t)} \textcolor{green}{を求める}"""),
      StepItem(tex: r"""\text{積和公式を用いて積分する。まず } A(t) \text{ から：}"""),
      StepItem(tex: r"""
      \begin{aligned}
      A(t) &= \int_0^t 3\cos(\tau)\cos(2\tau)\,d\tau \\[5pt]
      &= \frac{3}{2}\int_0^t \big(\cos(\tau-2\tau) + \cos(\tau+2\tau)\big)\,d\tau \\[5pt]
      &= \frac{3}{2}\int_0^t \big(\cos(-\tau) + \cos(3\tau)\big)\,d\tau \\[5pt]
      &= \frac{3}{2}\int_0^t \big(\cos\tau + \cos(3\tau)\big)\,d\tau \\[5pt]
      &= \frac{3}{2}\left[\sin\tau + \frac{\sin(3\tau)}{3}\right]_0^t \\[5pt]
      &= \frac{3}{2}\left(\sin t + \frac{\sin(3t)}{3}\right) \\[5pt]
      &= \frac{3}{2}\sin t + \frac{\sin(3t)}{2}
      \end{aligned}
      """),
      StepItem(tex: r"""\text{次に } B(t) \text{ を計算する：}"""),
      StepItem(tex: r"""
      \begin{aligned}
      B(t) &= \int_0^t 3\cos(\tau)\sin(2\tau)\,d\tau \\[5pt]
      &= \frac{3}{2}\int_0^t \big(\sin(2\tau+\tau) + \sin(2\tau-\tau)\big)\,d\tau \\[5pt]
      &= \frac{3}{2}\int_0^t \big(\sin(3\tau) + \sin\tau\big)\,d\tau \\[5pt]
      &= \frac{3}{2}\left[-\frac{\cos(3\tau)}{3} - \cos\tau\right]_0^t \\[5pt]
      &= \frac{3}{2}\left(-\frac{\cos(3t)}{3} - \cos t + \frac{1}{3} + 1\right) \\[5pt]
      &= \frac{3}{2}\left(\frac{1-\cos(3t)}{3} + 1 - \cos t\right) \\[5pt]
      &= \frac{1-\cos(3t) + 3(1-\cos t)}{2}\\[5pt]
      &= \frac{4 - \cos(3t) - 3\cos t}{2}
      \end{aligned}
      """),
      StepItem(tex: r"""\textcolor{green}{5.\ } \textcolor{green}{逆変換で} \textcolor{green}{f(t)} \textcolor{green}{を求める}"""),
      StepItem(tex: r"""\text{回転変数 } A(t), B(t) \text{ から } f(t) \text{ を求める逆変換は、}"""),
      StepItem(tex: r"""
      \begin{aligned}
      f(t) &= \frac{A(t)\sin(2t) - B(t)\cos(2t)}{2}
      \end{aligned}
      """),
      StepItem(tex: r"""\text{したがって、}"""),
      StepItem(tex: r"""
      \begin{aligned}
      f(t) &= \frac{1}{2}\left[\left(\frac{3}{2}\sin t + \frac{\sin(3t)}{2}\right)\sin(2t) - \left(\frac{1-\cos(3t)}{2} + \frac{3(1-\cos t)}{2}\right)\cos(2t)\right] \\[5pt]
      &= \frac{1}{2}\left[\frac{3}{2}\sin t\sin(2t) + \frac{1}{2}\sin(3t)\sin(2t) - \frac{1-\cos(3t)}{2}\cos(2t) - \frac{3(1-\cos t)}{2}\cos(2t)\right] \\[5pt]
      &= \frac{1}{4}\left[\left(3\sin t + \sin(3t)\right)\sin(2t) - \left(4 - \cos(3t) - 3\cos t\right)\cos(2t)\right]\\[5pt]
      &= \frac{1}{4}\left[3\sin t\sin(2t) + \sin(3t)\sin(2t) - \cos(2t) + \cos(3t)\cos(2t) - 3\cos(2t) + 3\cos t\cos(2t)\right]
      \end{aligned}
      """),
      StepItem(tex: r"""\text{積和公式を使って整理すると：}"""),
      StepItem(tex: r"""
      \begin{aligned}
      f(t) &= \frac{1}{4}\left[\frac{3}{2}\big(\cos t - \cos(3t)\big) + \frac{1}{2}\big(\cos t - \cos(5t)\big) - 4\cos(2t) + \frac{1}{2}\big(\cos t + \cos(5t)\big) + \frac{3}{2}\big(\cos t + \cos(3t)\big)\right] \\[5pt]
      &= \frac{1}{4}\left[\left(\frac{3}{2} + \frac{1}{2} + \frac{1}{2} + \frac{3}{2}\right)\cos t + \left(-\frac{3}{2} + \frac{3}{2}\right)\cos(3t) + \left(-\frac{1}{2} + \frac{1}{2}\right)\cos(5t) - 4\cos(2t)\right] \\[5pt]
      &= \frac{1}{4}\left[4\cos t - 4\cos(2t)\right] = \cos t - \cos(2t).
      \end{aligned}
      """),
    ],
  ),



  // --- 無減衰・共振（LC共振 数値） ---
  MathProblem(
    id: "F03213BF-4AEC-4D56-BCA8-D2D4F16E9D02",
    no: 117,
    category: '数値・二階・非斉次',
    level: '上級',
    question: r"""f''(t)+4\,f(t)=3\cos(2t),\quad f(0)=0,\ f'(0)=0""",
    answer: r"""f(t)=\displaystyle \frac{3}{4}\,t\,\sin(2t)""",
    imageAsset: '',
    equation: r"""f''(t)+4\,f(t)=3\cos(2t)""",
    conditions: r"""f(0)=0,\ f'(0)=0""",
    constants: r"""""",
    keywords: ['数値', '大学'],
    steps: [
      StepItem(tex: r"""\textcolor{brown}{\large{【力学】}}"""),
      StepItem(tex: r"""\text{• 無減衰強制振動（理想共振）}"""),
      StepItem(tex: r"""\text{• 力学においては、} mx''(t) + kx(t) = F_0\cos(2t) \text{ の形でよく登場する。これは無減衰強制振動を表す。外力の角周波数 } \omega \text{ が固有角周波数 } \omega_0 = 2 \text{ と一致する場合、振幅が時間とともに線形に増大する共振現象が起こる。}"""),
      StepItem(tex: r"""\textcolor{brown}{\large{【電磁気学】}}"""),
      StepItem(tex: r"""\text{• LC回路の強制振動（共振）}"""),
      StepItem(tex: r"""\text{• 電磁気学においては、} LI'(t) + \displaystyle \frac{q(t)}{C} = V_0\cos(2t) \text{ の形でよく登場する。これはLC回路の強制振動を表す。駆動周波数が共振周波数と一致する場合、コンデンサに蓄えられた電荷が時間とともに線形に増大する。}"""),
      StepItem(tex: r"""\textcolor{brown}{\large{【問題の記号と力学における記号の対応】}}"""),
      StepItem(tex: r"""\text{無減衰強制振動（共振）:} \ mx''(t) + kx(t) = F_0\cos(2t)"""),
      StepItem(tex: r"""\text{• } f(t) \leftrightarrow x(t) \text{（位置）}"""),
      StepItem(tex: r"""\text{• } f'(t) \leftrightarrow v(t) \text{（速度）}"""),
      StepItem(tex: r"""\text{• } f''(t) \leftrightarrow a(t) \text{（加速度）}"""),
      StepItem(tex: r"""\text{• } \omega_0 = 2 \leftrightarrow \sqrt{\displaystyle \frac{k}{m}} \text{（固有角周波数）}"""),
      StepItem(tex: r"""\text{• } 3 \leftrightarrow \displaystyle \frac{F_0}{m} \text{（外力振幅 ÷ 質量）}"""),
      StepItem(tex: r"""\text{• } f(0)=0 \leftrightarrow x_0=0 \text{（初期位置）}"""),
      StepItem(tex: r"""\text{• } f'(0)=0 \leftrightarrow v_0=0 \text{（初期速度）}"""),
      StepItem(tex: r"""\textcolor{brown}{\large{【問題の記号と電磁気学における記号の対応】}}"""),
      StepItem(tex: r"""\text{LC回路の強制振動（共振）:} \ LI'(t) + \displaystyle \frac{q(t)}{C} = V_0\cos(2t)"""),
      StepItem(tex: r"""\text{• } f(t) \leftrightarrow q(t) \text{（電荷）}"""),
      StepItem(tex: r"""\text{• } f'(t) \leftrightarrow I(t) \text{（電流）}"""),
      StepItem(tex: r"""\text{• } f''(t) \leftrightarrow I'(t) \text{（電流変化率）}"""),
      StepItem(tex: r"""\text{• } \omega_0 = 2 \leftrightarrow \displaystyle \frac{1}{\sqrt{LC}} \text{（共振角周波数）}"""),
      StepItem(tex: r"""\text{• } 3 \leftrightarrow \displaystyle \frac{V_0}{L} \text{（電圧振幅 ÷ インダクタンス）}"""),
      StepItem(tex: r"""\text{• } f(0)=0 \leftrightarrow q_0=0 \text{（初期電荷）}"""),
      StepItem(tex: r"""\text{• } f'(0)=0 \leftrightarrow I_0=0 \text{（初期電流）}"""),
      StepItem(tex: r"""\textcolor{brown}{\large{【解法】}}"""),
      StepItem(tex: r"""\text{【方針】}"""),
      StepItem(tex: r"""\text{2階非線形微分方程式を、回転変数によって1階線形微分方程式×2本に変換し、積分で解く。共振の場合（} \omega = \omega_0 = 2 \text{）。}"""),
      StepItem(tex: r"""\textcolor{green}{1.\ } \textcolor{green}{回転変数を導入}"""),
      StepItem(tex: r"""\text{回転変数 } A(t), B(t) \text{ を以下のように定義する：}"""),
      StepItem(tex: r"""
      \begin{aligned}
      A(t) &\equiv f'(t)\cos(2t) + 2f(t)\sin(2t), \\[5pt]
      B(t) &\equiv f'(t)\sin(2t) - 2f(t)\cos(2t).
      \end{aligned}
      """),
      StepItem(tex: r"""\textcolor{green}{2.\ } \textcolor{green}{回転変数の微分を計算（交差項が消える）}"""),
      StepItem(tex: r"""A'(t) \text{ を計算する：}"""),
      StepItem(tex: r"""
      \begin{aligned}
      A'(t) &= f''(t)\cos(2t) - f'(t)\cdot 2\sin(2t) + 2f'(t)\sin(2t) + 4f(t)\cos(2t) \\[5pt]
      &= f''(t)\cos(2t) + 4f(t)\cos(2t) \\[5pt]
      &= \big(f''(t) + 4f(t)\big)\cos(2t)
      \end{aligned}
      """),
      StepItem(tex: r"""\text{元の微分方程式 } f''(t) + 4f(t) = 3\cos(2t) \text{ より、}"""),
      StepItem(tex: r"""
      \begin{aligned}
      A'(t) &= 3\cos(2t)\cos(2t) = 3\cos^2(2t)
      \end{aligned}
      """),
      StepItem(tex: r"""\text{同様に } B'(t) \text{ を計算する：}"""),
      StepItem(tex: r"""
      \begin{aligned}
      B'(t) &= f''(t)\sin(2t) + f'(t)\cdot 2\cos(2t) - 2f'(t)\cos(2t) + 4f(t)\sin(2t) \\[5pt]
      &= f''(t)\sin(2t) + 4f(t)\sin(2t) \\[5pt]
      &= \big(f''(t) + 4f(t)\big)\sin(2t) \\[5pt]
      &= 3\cos(2t)\sin(2t)
      \end{aligned}
      """),
      StepItem(tex: r"""\textcolor{green}{3.\ } \textcolor{green}{初期条件から} \textcolor{green}{A(0)=B(0)=0} \textcolor{green}{が成り立つ}"""),
      StepItem(tex: r"""\text{初期条件 } f(0)=0, f'(0)=0 \text{ より、}"""),
      StepItem(tex: r"""
      \begin{aligned}
      A(0) &= f'(0)\cos(0) + 2f(0)\sin(0) = 0, \\[5pt]
      B(0) &= f'(0)\sin(0) - 2f(0)\cos(0) = 0
      \end{aligned}
      """),
      StepItem(tex: r"""\textcolor{green}{4.\ } \textcolor{green}{積分で} \textcolor{green}{A(t), B(t)} \textcolor{green}{を求める（共振極限）}"""),
      StepItem(tex: r"""\text{まず } A(t) \text{ を計算する。}"""),
      StepItem(tex: r"""
      \begin{aligned}
      A(t) &= \int_0^t 3\cos^2(2\tau)\,d\tau \\[5pt]
      &= 3\int_0^t \frac{1+\cos(4\tau)}{2}\,d\tau \\[5pt]
      &= \frac{3}{2}\left[t + \frac{\sin(4t)}{4}\right] \\[5pt]
      &= \frac{3t}{2} + \frac{3\sin(4t)}{8}
      \end{aligned}
      """),
      StepItem(tex: r"""\text{次に } B(t) \text{ を計算する：}"""),
      StepItem(tex: r"""
      \begin{aligned}
      B(t) &= \int_0^t 3\cos(2\tau)\sin(2\tau)\,d\tau \\[5pt]
      &= 3\int_0^t \frac{\sin(4\tau)}{2}\,d\tau \\[5pt]
      &= \frac{3}{2}\left[-\frac{\cos(4\tau)}{4}\right]_0^t \\[5pt]
      &= \frac{3}{8}\left(1-\cos(4t)\right).
      \end{aligned}
      """),
      StepItem(tex: r"""\textcolor{green}{5.\ } \textcolor{green}{逆変換で} \textcolor{green}{f(t)} \textcolor{green}{を求める}"""),
      StepItem(tex: r"""\text{回転変数 } A(t), B(t) \text{ から } f(t) \text{ を求める逆変換は、}"""),
      StepItem(tex: r"""
      \begin{aligned}
      f(t) &= \frac{A(t)\sin(2t) - B(t)\cos(2t)}{2}
      \end{aligned}
      """),
      StepItem(tex: r"""\text{したがって、}"""),
      StepItem(tex: r"""
      \begin{aligned}
      f(t) &= \frac{1}{2}\left[\left(\frac{3t}{2} + \frac{3\sin(4t)}{8}\right)\sin(2t) - \frac{3}{8}\left(1-\cos(4t)\right)\cos(2t)\right] \\[5pt]
      &= \frac{1}{2}\left[\frac{3t}{2}\sin(2t) + \frac{3\sin(4t)}{8}\sin(2t) - \frac{3}{8}\cos(2t) + \frac{3\cos(4t)}{8}\cos(2t)\right] \\[5pt]
      &= \frac{3t}{4}\sin(2t) + \frac{3\sin(4t)\sin(2t)}{16} - \frac{3\cos(2t)}{16} + \frac{3\cos(4t)\cos(2t)}{16}
      \end{aligned}
      """),
      StepItem(tex: r"""\textcolor{green}{6.\ } \textcolor{green}{積和公式で整理して結論へ}"""),
      StepItem(tex: r"""\text{積和公式を使って整理すると：}"""),
      StepItem(tex: r"""
      \begin{aligned}
      f(t) &= \frac{3t}{4}\sin(2t) + \frac{3}{16}\cdot\frac{1}{2}\big(\cos(2t) - \cos(6t)\big) - \frac{3\cos(2t)}{16} + \frac{3}{16}\cdot\frac{1}{2}\big(\cos(2t) + \cos(6t)\big) \\[5pt]
      &= \frac{3t}{4}\sin(2t) + \left(\frac{3}{32} - \frac{3}{16} + \frac{3}{32}\right)\cos(2t) + \left(-\frac{3}{32} + \frac{3}{32}\right)\cos(6t) \\[5pt]
      &= \frac{3t}{4}\sin(2t)
      \end{aligned}
      """),
      StepItem(tex: r"""\textcolor{brown}{\large{【力学】}}"""),
      StepItem(tex: r"""\text{無減衰強制振動（理想共振）。外力の角周波数が固有角周波数と一致する場合、振幅が時間とともに線形に増大する共振現象が起こる。}"""),
      StepItem(tex: r"""\textcolor{brown}{\large{【電磁気学】}}"""),
      StepItem(tex: r"""\text{LC回路の強制振動（共振）。駆動周波数が共振周波数と一致する場合、コンデンサに蓄えられた電荷が時間とともに線形に増大する。}"""),
    ],
  ),

];

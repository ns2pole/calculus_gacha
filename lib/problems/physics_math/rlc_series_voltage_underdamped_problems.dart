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
// RLC直列回路・印加電圧あり（減衰振動（不足減衰））
// ======================================================================
const rlcSeriesVoltageUnderdampedProblems = <MathProblem>[
  // // --- 減衰振動の強制振動（sin(Ωt)）一般 ---
  MathProblem(
  id: "07FC023A-DAD9-432A-BCD7-B90E3C25404F",
  no: 20,
  category: '一般・二階・非斉次',
  level: '上級',
  question:
  r"""\alpha f''(t)+2\beta\,f'(t)+\gamma f(t)=F\sin(\omega t),\quad \alpha>0,\ \gamma>0,\ \frac{\gamma}{\alpha}>\frac{\beta^2}{\alpha^2},\ \beta>0,\ f(0)=0,\ f'(0)=0""",
  answer:
  r"""f'(t) = \frac{F}{\sqrt{\left(\frac{\gamma}{\omega} -\alpha\omega\right)^2+4\beta^2}}\sin(\omega t + \phi),\quad \textcolor{green}{ただし、}\textcolor{green}{\phi は} \textcolor{green}{\tan \phi = \dfrac{\alpha\omega^2-\gamma}{2\beta\omega}} \textcolor{green}{を満たす角。}""",
  imageAsset: '',
  hint: r"""\text{未定係数法で特解を求めて、それを引いた関数を新たに定義し、下記の右辺0(同次方程式)の場合の公式を適用して解く。}""",
  equation: r"""\alpha f''(t)+2\beta\,f'(t)+\gamma f(t)=F\sin(\omega t) \ \ \text{の定常状態の }f'(t)""",
  conditions: r"""f(0)=0,\ f'(0)=0""",
  constants: r"""\alpha,\ \gamma,\ \beta>0,\ F,\omega:定数""",
  keywords: ['交流', 'コンデンサ', 'コイル', '抵抗', '一般'],

  steps: [
  StepItem(tex: r"""\textcolor{brown}{\large{【電磁気学】}}"""),
  StepItem(tex: r"""\text{• RLC直列交流回路について、キルヒホッフの第二法則を用いると }
  LQ''(t) + RQ'(t) + \displaystyle \frac{Q(t)}{C} = V_0\sin(\omega t) \text{が成り立つ。}"""),
  StepItem(tex: r"""\textcolor{brown}{\large{【問題の記号と電磁気学における記号の対応】}}"""),
  StepItem(tex: r"""\text{RLC直列交流回路の過渡応答:} \ LQ''(t) + RQ'(t) + \displaystyle \frac{Q(t)}{C} = V_0\sin(\omega t)"""),
  StepItem(tex: r"""\text{• } f(t) \leftrightarrow Q(t) \text{（コンデンサに蓄えられた電荷）}"""),
  StepItem(tex: r"""\text{• } f'(t) \leftrightarrow Q'(t) \text{（電流）}"""),
  StepItem(tex: r"""\text{• } f''(t) \leftrightarrow Q''(t) \text{（電流変化率）}"""),
  StepItem(
  tex:
  r"""\text{• } \alpha \leftrightarrow L \text{（インダクタンス）}""",
  ),
  StepItem(
  tex:
  r"""\text{• } 2\beta \leftrightarrow R \text{（抵抗）}""",
  ),
  StepItem(
  tex:
  r"""\text{• } \gamma \leftrightarrow \displaystyle \frac{1}{C} \text{（静電容量の逆数）}""",
  ),
  StepItem(
  tex:
  r"""\text{• } \frac{\gamma}{\alpha} \leftrightarrow \frac{1}{LC} = \omega_0^2 \text{（固有角周波数の2乗）}""",
  ),
  StepItem(
  tex:
  r"""\text{• } \sqrt{\frac{\gamma}{\alpha} - \frac{\beta^2}{\alpha^2}} \leftrightarrow \sqrt{\displaystyle \frac{1}{LC} - \left(\displaystyle \frac{R}{2L}\right)^2} \text{（減衰角周波数）}""",
  ),
  StepItem(tex: r"""\text{• } F \leftrightarrow \displaystyle V_0 \text{（電圧振幅}"""),
  StepItem(tex: r"""\text{• } \omega \leftrightarrow \omega \text{交流電圧周波数}"""),
  StepItem(
  tex:
  r"""\text{• 定常状態の }f'(t)\text{ の振幅と }F\text{ との比(インピーダンス)：} \textcolor{blue}{\displaystyle \frac{F}{f'_{max}} = \sqrt{\left(\frac {\gamma}{\omega} -\alpha\omega\right)^2+4\beta^2} \leftrightarrow  |Z| = \frac {V_0}{I_{max}} = {\sqrt{\left(\frac{1}{\omega C} - \omega L \right) ^2 + R^2}}}""",
  ),
  StepItem(
  tex:
  r"""\text{• 定常状態の }f'(t)\text{ と右辺の }F\sin(\omega t)\text{ との位相差：}\tan \phi = \frac{\omega\alpha- \frac {\gamma}{\omega}}{2\beta} \leftrightarrow \tan \phi = \frac{\omega L -\frac{1}{\omega C}}{R} \text{（電流と電圧の位相差）}""",
  ),
  StepItem(tex: r"""\text{• } f_0 = 0 \leftrightarrow Q_0 = 0 \text{（コンデンサの初期電荷）}"""),
  StepItem(tex: r"""\text{• } v_0 = 0 \leftrightarrow I_0 = 0 \text{（初期電流）}"""),
  StepItem(tex: r"""\textcolor{brown}{\large{【解法】}}"""),
  StepItem(tex: r"""\textbf{【方針】}"""),
  StepItem(
tex: r"""\text{未定係数法で特解を求めて、それを引いた関数を新たに定義し、下記の右辺0(同次方程式)の場合の公式を適用して解く。}"""),
  StepItem(
  tex:
  r"""\textcolor{blue}{微分方程式 } \textcolor{blue}{\alpha f''(t) + 2\beta f'(t) + \gamma f(t) = 0} \textcolor{blue}{ に対する初期値問題} \textcolor{blue}{f(0) = f_0,\quad f'(0) = v_0} \textcolor{blue}{の解は下記のように表される。(問題12)}"""),
  StepItem(
  tex:
  r"""\textcolor{blue}{f(t) = e^{-\frac{\beta}{\alpha} t}\left(f_0\cos\left(\sqrt{\frac{\gamma}{\alpha} - \frac{\beta^2}{\alpha^2}}\ \,t\right) + \frac{v_0 + \frac{\beta}{\alpha} f_0}{\sqrt{\frac{\gamma}{\alpha} - \frac{\beta^2}{\alpha^2}}}\sin\left(\sqrt{\frac{\gamma}{\alpha} - \frac{\beta^2}{\alpha^2}}\ \,t\right)\right)}""",
  ),
  StepItem(
  tex:
  r"""\textcolor{green}{1.\ } \textcolor{green}{\frac{F}{\sqrt{(\gamma-\alpha\omega^2)^2+4\beta^2\omega^2}}\sin(\omega t + \theta)} \textcolor{green}{ は本問の微分方程式を満たす。ただし、} \textcolor{green}{\tan \theta =\frac{2\beta\omega}{\gamma-\alpha\omega^2}}""",
  ),
  StepItem(tex: r"""\textcolor{purple}{【証明】}"""),
  StepItem(tex: r"""\text{右辺の形 }F\sin(\omega t)\text{ を参考に、方程式を満たす1つの解(特解)を}"""),
  StepItem(tex: r"""f_p(t) = A\sin(\omega t) + B\cos(\omega t) \text{の形で推定する。ただし、}A, B \text{は時間によらない定数である。}"""),
  StepItem(tex: r"""\text{まず、}f_p(t)\text{ を微分する：}"""),
  StepItem(
  tex: r"""
  \begin{aligned}
  \begin{cases}
  f_p'(t) = \omega A\cos(\omega t) - \omega B\sin(\omega t) \\[5pt]
  f_p''(t) = -\omega^2 A\sin(\omega t) - \omega^2 B\cos(\omega t)
  \end{cases}
  \end{aligned}
  """,
  ),
  StepItem(tex: r"""\text{これを }\alpha f_p''(t) + 2\beta f_p'(t) + \gamma f_p(t) = F\sin(\omega t)\cdots (1)"""),
  StepItem(tex: r"""\text{ に代入してsin,cosの係数を比較すると、}"""),
  StepItem(tex: r"""\text{cosの係数：}2\beta\omega A + (\gamma - \alpha\omega^2)B = 0"""),
  StepItem(tex: r"""\text{sinの係数：}(\gamma - \alpha\omega^2)A - 2\beta\omega B = F"""),
  StepItem(tex: r"""\text{となる。(※ (1)はtについての恒等式なので両辺のsinの係数とcosの係数を比較したら良い。)}"""),
  StepItem(
  tex:
  r"""\text{sinの係数比較の式より }B = -\frac{2\beta\omega A}{\gamma - \alpha\omega^2}\text{ を第1式に代入して、A,Bを求めると下記のようになる。}""",
  ),
  StepItem(tex: r"""\begin{aligned}
  &\ \ \ \ \ \ (\gamma - \alpha\omega^2)A - 2\beta\omega \cdot \left(-\frac{2\beta\omega A}{\gamma - \alpha\omega^2}\right) = F \\[5pt]
  &\Leftrightarrow \ \frac{(\gamma - \alpha\omega^2)^2 + 4\beta^2\omega^2}{\gamma - \alpha\omega^2}A = F \\[5pt]
  &\Leftrightarrow \ A = \frac{F(\gamma - \alpha\omega^2)}{(\gamma - \alpha\omega^2)^2 + 4\beta^2\omega^2} \\[5pt]
  &\text{よって、}\  B = -\frac{2\beta\omega F}{(\gamma - \alpha\omega^2)^2 + 4\beta^2\omega^2}\end{aligned}""",
  ),
  StepItem(tex: r"""\text{ゆえに特解は、}"""),
  StepItem(
  tex: r"""
  f_p(t) = \dfrac{F(\gamma - \alpha\omega^2)}{(\gamma - \alpha\omega^2)^2 + 4\beta^2\omega^2}\sin(\omega t) - \frac{2\beta\omega F}{(\gamma - \alpha\omega^2)^2 + 4\beta^2\omega^2}\cos(\omega t)
  """,
  ),
  StepItem(tex: r"""\textcolor{purple}{(i)\ \omega = \sqrt{\frac{\gamma}{\alpha}}} \textcolor{purple}{の場合}"""),
  StepItem(tex: r"""\text{sinの部分は係数が0になるので、}"""),
  StepItem(
  tex: r"""
  \textcolor{red}{\begin{aligned}
  f_p(t) &= - \frac{2\beta\omega F}{4\beta^2\omega^2}\cos(\omega t)\\[5pt]
  &= - \frac{F}{2\beta \omega}\cos(\omega t) \\[5pt]
  &= - \frac{F}{2\beta \omega}\sin(\omega t + \frac{\pi}{2})\\[5pt]
  &= \frac{F}{2\beta \omega}\sin\left(\omega t - \frac{\pi}{2}\right)
  \end{aligned}}
  """,
  ),
  StepItem(tex: r"""\textcolor{purple}{(ii)\  \omega \neq \sqrt{\frac{\gamma}{\alpha}}} \textcolor{purple}{の場合}"""),
  StepItem(tex: r"""\text{三角関数の合成をして、}"""),
  StepItem(
  tex:
  r"""\text{振幅：} \sqrt{\left(\frac{F(\gamma-\alpha\omega^2)}{(\gamma-\alpha\omega^2)^2+4\beta^2\omega^2}\right)^2 + \left(\frac{2\beta\omega F}{(\gamma-\alpha\omega^2)^2+4\beta^2\omega^2}\right)^2} = \frac{F}{\sqrt{(\gamma-\alpha\omega^2)^2+4\beta^2\omega^2}}""",
  ),
  StepItem(
  tex:
  r"""\text{位相角：}\theta \ ;\ \left( \tan \theta =\frac{2\beta\omega}{\gamma-\alpha\omega^2}\right) \text{ を用いて、整理すると、下記の解を得られる。}""",
  ),
  StepItem(tex: r"""\textcolor{blue}{f_p(t) = \frac{F}{\sqrt{(\gamma-\alpha\omega^2)^2+4\beta^2\omega^2}}\sin(\omega t + \theta)}""",
  ),

  StepItem(
  tex:
  r"""\textcolor{green}{3.} \textcolor{green}{f(t)} \textcolor{green}{を平行移動した関数} \textcolor{green}{g(t) = f(t) - f_p(t)} \textcolor{green}{を置く}""",
  ),
  StepItem(
  tex:
  r"""f_p(t) \text{は微分方程式の解なので、} \alpha f_p''(t) + 2\beta f_p'(t) + \gamma f_p(t) = F\sin(\omega t)\text{ を満たす。この式を本問の微分方程式と連立して引き算を行う。}""",
  ),
  StepItem(tex: r"""\text{これらを引き算すると、}"""),
  StepItem(
  tex: r"""
  \begin{aligned}
  &\quad \alpha f''(t) + 2\beta f'(t) + \gamma f(t) = F\sin(\omega t) \\
  -&\quad \alpha f_p''(t) + 2\beta f_p'(t) + \gamma f_p(t) = F\sin(\omega t) \\[5pt]
  \hline \\
  &\quad \alpha(f''(t) - f_p''(t)) + 2\beta(f'(t) - f_p'(t)) + \gamma(f(t) - f_p(t)) = 0
  \end{aligned}
  """,
  ),
  StepItem(tex: r"""\text{平行移動：} g(t) = f(t) - f_p(t) \text{ とおくと、} \alpha g''(t) + 2\beta g'(t) + \gamma g(t) = 0 """),
  StepItem(tex: r"""\textcolor{blue}{すなわち、} \textcolor{blue}{g(t)} \textcolor{blue}{ は微分方程式 } \textcolor{blue}{\alpha g''(t) + 2\beta g'(t) + \gamma g(t) = 0} \textcolor{blue}{ の解である。}"""),
  StepItem(
  tex:
  r"""\textcolor{green}{4.\ } \textcolor{green}{g(t)} \textcolor{green}{の収束性と} \textcolor{green}{f(t) = f_p(t)} \textcolor{green}{が定常状態の解であること}""",
  ),
  StepItem(tex: r"""\text{公式より、微分方程式 }\alpha g''(t) + 2\beta g'(t) + \gamma g(t) = 0\text{ の解は、}"""),
  StepItem(tex: r"""\text{減衰項 }e^{-\frac{\beta}{\alpha} t}\text{ を含む形で表される。}"""),
  StepItem(tex: r"""\text{したがって、}t \to \infty\text{ のとき、}g(t) \to 0\text{ である。}"""),
  StepItem(tex: r"""\text{よって、}f(t) = g(t) + f_p(t) \text{ より、}"""),
  StepItem(tex: r"""\text{ }t \to \infty\text{ のとき、}f(t) \to f_p(t)\text{ となる。}"""),
  StepItem(tex: r"""\text{よって、十分大きなtにおいては解を次のように近似できる。}"""),
  StepItem(
  tex: r"""
  \begin{aligned}
  \begin{cases}
  \omega = \sqrt{\frac{\gamma}{\alpha}} \text{（共振条件）のとき：} \\[5pt]
  \quad f(t) = f_p(t) = -\frac{F}{2\beta\omega}\cos(\omega t) = \frac{F}{2\beta\omega}\sin\left(\omega t - \frac{\pi}{2}\right) \\[10pt]
  \omega \neq \sqrt{\frac{\gamma}{\alpha}} \text{のとき：} \\[5pt]
  \quad f(t) = f_p(t) = \dfrac{F}{\sqrt{(\gamma-\alpha\omega^2)^2+4\beta^2\omega^2}} \sin(\omega t + \theta) \\[5pt]
  \quad \text{ただし、} \tan \theta = \frac{2\beta\omega}{\gamma-\alpha\omega^2}
  \end{cases}
  \end{aligned}
  """,
  ),
  StepItem(tex: r"""\textcolor{green}{5.\ } \textcolor{green}{定常状態の} \textcolor{green}{f'(t)} \textcolor{green}{と} \textcolor{green}{F} \textcolor{green}{との比}"""),
  StepItem(tex: r"""\text{定常状態の }f(t)\text{ を微分して、}f'(t)\text{ を求めると、答えを得られる。：}"""),
  StepItem(
  tex: r"""
  \begin{aligned}
  \begin{cases}
  \omega = \sqrt{\frac{\gamma}{\alpha}} \text{（共振条件）のとき：} \\[5pt]
  \quad f'(t) = \frac{F}{2\beta}\sin(\omega t) \\[10pt]
  \omega \neq \sqrt{\frac{\gamma}{\alpha}} \text{のとき：} \\[5pt]
  \quad \begin{aligned}
  f'(t) &= \frac{F\omega}{\sqrt{(\gamma-\alpha\omega^2)^2+4\beta^2\omega^2}}\cos(\omega t + \theta) \\[5pt]
  &= \frac{F}{\sqrt{\left(\frac{\gamma}{\omega} -\alpha\omega\right)^2+4\beta^2}}\sin\left(\omega t + \theta + \frac{\pi}{2}\right) \\[5pt]
  &\quad \text{(ただし、} \tan \theta = \frac{2\beta\omega}{\gamma-\alpha\omega^2}\text{)}\\[5pt]
  &= \frac{F}{\sqrt{\left(\frac{\gamma}{\omega} -\alpha\omega\right)^2+4\beta^2}}\sin\left(\omega t + \phi \right) \\[5pt]
  &\quad \text{(ただし、} \tan \phi = \dfrac {\alpha\omega^2-\gamma}  {2\beta\omega}\text{)}
  \end{aligned}
  \end{cases}
  \end{aligned}
  """,
  ),
  StepItem(tex: r"""\text{定常状態の }f'(t)\text{ の振幅と }F\text{ との比は、}"""),
  StepItem(
  tex: r"""
  \begin{aligned}
  \begin{cases}
  \omega = \sqrt{\frac{\gamma}{\alpha}} \text{（共振条件）のとき：} \\[5pt]
  \quad \frac{F}{f'_{max}} = 2\beta \\[10pt]
  \omega \neq \sqrt{\frac{\gamma}{\alpha}} \text{のとき：} \\[5pt]
  \quad \frac{F}{f'_{max}} = \sqrt{\left(\frac {\gamma}{\omega} -\alpha\omega\right)^2+4\beta^2}
  \end{cases}
  \end{aligned}
  """,
  ),
  StepItem(tex: r"""\text{また、定常状態の }f'(t)\text{ と右辺の }F\sin(\omega t)\text{ との位相差は、}"""),
  StepItem(
  tex: r"""
  \begin{aligned}
  \begin{cases}
  \omega = \sqrt{\frac{\gamma}{\alpha}} \text{（共振条件）のとき：} \\[5pt]
  \quad \phi = 0 \text{（同相）} \\[10pt]
  \omega \neq \sqrt{\frac{\gamma}{\alpha}} \text{のとき：} \\[5pt]
  \quad \tan \phi = \dfrac {\alpha\omega^2-\gamma}  {2\beta\omega}\text{を満たす角}\phi\text{だけずれる。}
  \end{cases}
  \end{aligned}
  """),
  StepItem(tex: r"""\textcolor{blue}{以上より結局、定常状態の }\textcolor{blue}{f'(t)} \textcolor{blue}{ は }\textcolor{blue}{\Omega} \textcolor{blue}{によらずまとめて、下記と表せる。}"""),
  StepItem(tex: r"""
  \textcolor{blue}{f'(t) = \frac{F}{\sqrt{\left(\frac{\gamma}{\omega} -\alpha\omega\right)^2+4\beta^2}}\sin\left(\omega t + \phi \right)}"""),  
  StepItem(tex: r"""\textcolor{blue}{ただし、}\textcolor{blue}{\phi }\textcolor{blue}{は }\textcolor{blue}{\tan \phi = \dfrac {\alpha\omega^2-\gamma}  {2\beta\omega}}\textcolor{blue}{を満たす角。}"""),
  ],
  ),

  // --- 減衰振動の強制振動（sin(Ωt)）数値 ---
  MathProblem(
  id: "B2C3D4E5-F6G7-8901-BCDE-F2345678901",

  no: 120,
  category: '数値・二階・非斉次',
  level: '上級',
  question: r"""f''(t)+2\,f'(t)+3\,f(t)=12\cos(3t),\quad f(0)=0,\ f'(0)=0""",
  answer:
  r"""3\sqrt{2}\cos\left(3t - \dfrac{\pi}{4}\right)""",
  imageAsset: '',
  hint: r"""\text{未定係数法で特解を求めて、それを引いた関数を新たに定義し、下記の右辺0(同次方程式)の場合の公式を適用して解く。}""",
    equation: r"""f''(t)+2\,f'(t)+3\,f(t)=12\cos(3t) \ \ \text{の定常状態の }f'(t)""",
    conditions: r"""f(0)=0,\ f'(0)=0""",
    constants: r"""""",
    keywords: ['交流', '数値', 'コンデンサ', 'コイル', '抵抗'],
  steps: [
  StepItem(tex: r"""\textcolor{brown}{\large{【電磁気学】}}"""),
  StepItem(tex: r"""\text{• RLC直列交流回路について、キルヒホッフの第二法則を用いると }
  LQ''(t) + RQ'(t) + \displaystyle \frac{Q(t)}{C} = V_0\cos(\omega t) \text{が成り立つ。}"""),
  StepItem(tex: r"""\textcolor{brown}{\large{【問題の記号と電磁気学における記号の対応】}}"""),
  StepItem(tex: r"""\text{RLC直列交流回路の過渡応答:} \ LQ''(t) + RQ'(t) + \displaystyle \frac{Q(t)}{C} = V_0\cos(\omega t)"""),
  StepItem(tex: r"""\text{• } f(t) \leftrightarrow Q(t) \text{（コンデンサに蓄えられた電荷）}"""),
  StepItem(tex: r"""\text{• } f'(t) \leftrightarrow Q'(t) \text{（電流）}"""),
  StepItem(tex: r"""\text{• } f''(t) \leftrightarrow Q''(t) \text{（電流変化率）}"""),
  StepItem(
  tex:
  r"""\text{• } \dfrac{2}{2 \cdot 1} = 1 \leftrightarrow \displaystyle \frac{R}{2L} \text{（減衰定数）}""",
  ),
  StepItem(
  tex:
  r"""\text{• } \dfrac{1}{\sqrt{1 \cdot \frac{1}{3}}} = \sqrt{3} \leftrightarrow \displaystyle \frac{1}{\sqrt{LC}} \text{（減衰定数が0の場合の固有角周波数）}""",
  ),
  StepItem(
  tex:
  r"""\text{• } \sqrt{\frac{1}{1 \cdot \frac{1}{3}} - \left(\frac{2}{2 \cdot 1}\right)^2} = \sqrt{2} \leftrightarrow \sqrt{\displaystyle \frac{1}{LC} - \left(\displaystyle \frac{R}{2L}\right)^2} \text{（減衰角周波数）}""",
  ),
  StepItem(tex: r"""\text{• } 12 \leftrightarrow V_0 \text{（電圧振幅）}"""),
  StepItem(tex: r"""\text{• } 3 \leftrightarrow \omega \text{（交流電圧周波数）}"""),
  StepItem(
  tex:
  r"""\text{• 定常状態の }f'(t)\text{ の振幅と }F\text{ との比(インピーダンス)：} \displaystyle \frac{F}{f'_{max}} = \sqrt{\left(\frac{3}{3} - 1 \cdot 3\right)^2+4 \cdot 1^2} = 2\sqrt{2} """),
  StepItem(
  tex:
  r"""\leftrightarrow  |Z| = \frac {V_0}{I_{max}} = {\sqrt{\left(\frac{1}{\omega C} - \omega L \right) ^2 + R^2}}""",
  ),
  StepItem(
  tex:
   r"""\text{• 定常状態の }f'(t)\text{ と右辺の }12\cos(3t)\text{ との位相差：}\phi = \frac{\pi}{4} \text{ 遅れ} \left( \tan \phi  = \frac{1 \cdot 3 - \frac{1}{3 \cdot \frac 1 3}}{2} = 1 \right)"""),
  StepItem(tex:r""" \leftrightarrow \tan \phi = \frac{\omega L -\frac{1}{\omega C}}{R} \text{（電流と電圧の位相差）}""",),
  StepItem(tex: r"""\text{• } 0 \leftrightarrow Q_0 \text{（初期電荷）}"""),
  StepItem(tex: r"""\text{• } 0 \leftrightarrow I_0 \text{（初期電流）}"""),
  StepItem(tex: r"""\textcolor{brown}{\large{【解法】}}"""),
  StepItem(tex: r"""\textbf{【方針】}"""),
  StepItem(tex: r"""\text{未定係数法で特解を求めて、それを引いた関数を新たに定義し、下記の右辺0(同次方程式)の場合の公式を適用して解く。}"""),
  StepItem(
  tex:
  r"""\textcolor{blue}{微分方程式 } \textcolor{blue}{f''(t) + 2\beta f'(t) + \omega_0^2 f(t) = 0} \textcolor{blue}{ に対する初期値問題} \textcolor{blue}{f(0) = f_0,\quad f'(0) = v_0} \textcolor{blue}{の解は下記のように表される。(問題12)}""",
  ),
  StepItem(
  tex:
  r"""\textcolor{blue}{f(t) = e^{-\beta t}\left(f_0\cos\left(\sqrt{\omega_0^2-\beta^2}\ \,t\right) + \frac{v_0+\beta f_0}{\sqrt{\omega_0^2-\beta^2}}\sin\left(\sqrt{\omega_0^2-\beta^2}\ \,t\right)\right)}""",
  ),
  StepItem(
  tex:
  r"""\textcolor{green}{1.\ } \textcolor{green}{特解を求める}""",
  ),
  StepItem(tex: r"""\text{右辺の形 }12\cos(3t)\text{ を参考に、方程式を満たす1つの解(特解)を}"""),
  StepItem(tex: r"""f_p(t) = A\sin(3t) + B\cos(3t) \text{の形で推定する。ただし、}A, B \text{は時間によらない定数である。}"""),
  StepItem(tex: r"""\text{まず、}f_p(t)\text{ を微分する：}"""),
  StepItem(
  tex: r"""
  \begin{aligned}
  \begin{cases}
  f_p'(t) = 3A\cos(3t) - 3B\sin(3t) \\[5pt]
  f_p''(t) = -9A\sin(3t) - 9B\cos(3t)
  \end{cases}
  \end{aligned}
  """,
  ),
      StepItem(tex: r"""\text{これを }f_p''(t) + 2f_p'(t) + 3f_p(t) = 12\cos(3t)\cdots (1)"""),
      StepItem(tex: r"""\text{ に代入してsin,cosの係数を比較する。}"""),
  StepItem(
  tex: r"""
  \begin{aligned}
  &\ \ \ \ \ f_p''(t) + 2f_p'(t) + 3f_p(t) \\[8pt]
  &= (-9A\sin(3t) - 9B\cos(3t)) + 2(3A\cos(3t) - 3B\sin(3t)) \\[5pt]
  &\quad + 3(A\sin(3t) + B\cos(3t)) \\[8pt]
  &= (-6A - 6B)\sin(3t) + (6A - 6B)\cos(3t) \\[8pt]
  &= 12\cos(3t)
  \end{aligned}
  """,
  ),
  StepItem(tex: r"""\text{両辺の係数を比較して、}"""),
  StepItem(tex: r"""\text{sinの係数：}-6A - 6B = 0"""),
  StepItem(tex: r"""\text{cosの係数：}6A - 6B = 12"""),
  StepItem(tex: r"""\text{これを解くと、}A = 1,\ B = -1"""),
  StepItem(tex: r"""\text{ゆえに特解は、}"""),
  StepItem(
  tex: r"""
  f_p(t) = \sin(3t) - \cos(3t) = \sqrt{2}\sin\left(3t - \frac{\pi}{4}\right)
  """,
  ),

  StepItem(tex:r"""\textcolor{green}{2.} \textcolor{green}{f(t)} \textcolor{green}{を平行移動した関数を} \textcolor{green}{g(t) = f(t) - f_p(t)} \textcolor{green}{と置くと、}"""),
  StepItem(tex:r"""\textcolor{green}{g(t)} \textcolor{green}{は微分方程式} \textcolor{green}{g''(t) + 2g'(t) + 3g(t) = 0} \textcolor{green}{の解である。}"""),
  StepItem(
  tex:
  r"""f_p(t) \text{は微分方程式の解なので、} f_p''(t) + 2f_p'(t) + 3f_p(t) = 12\cos(3t)\text{ を満たす。この式を本問の微分方程式と連立して引き算を行う。}""",
  ),
  StepItem(tex: r"""\text{これらを引き算すると、}"""),
  StepItem(
  tex: r"""
  \begin{aligned}
  &\quad f''(t) + 2f'(t) + 3f(t) = 12\cos(3t) \\
  -&\quad f_p''(t) + 2f_p'(t) + 3f_p(t) = 12\cos(3t) \\[5pt]
  \hline \\
  &\quad (f''(t) - f_p''(t)) + 2(f'(t) - f_p'(t)) + 3(f(t) - f_p(t)) = 0
  \end{aligned}
  """,
  ),
  StepItem(tex: r"""\text{平行移動：} g(t) = f(t) - f_p(t) \text{ とおくと、} g''(t) + 2g'(t) + 3g(t) = 0 """),
  StepItem(tex: r"""\textcolor{blue}{すなわち、} \textcolor{blue}{g(t)} \textcolor{blue}{ は微分方程式 } \textcolor{blue}{g''(t) + 2g'(t) + 3g(t) = 0} \textcolor{blue}{ の解である。}"""),
  StepItem(
  tex:
  r"""\textcolor{green}{3.\ } \textcolor{green}{g} \textcolor{green}{の初期条件を求める}""",
  ),
  StepItem(tex: r"""f_p(t) = \sqrt{2}\sin\left(3t - \frac{\pi}{4}\right)\text{ より、}"""),
  StepItem(
  tex: r"""
  \begin{aligned}
  g(0) &= f(0) - f_p(0) \\[5pt]
  &= 0 - \left(\sin(0) - \cos(0)\right) \\[5pt]
  &= 1
  \end{aligned}
  """,
  ),
  StepItem(tex: r"""\text{次に、}f_p'(t)\text{ を計算する：}"""),
  StepItem(
  tex: r"""
  \begin{aligned}
  f_p'(t) &= 3\cos(3t) + 3\sin(3t)
  \end{aligned}
  """,
  ),
  StepItem(tex: r"""\text{したがって、}"""),
  StepItem(
  tex: r"""
  \begin{aligned}
  g'(0) &= f'(0) - f_p'(0) \\[5pt]
  &= 0 - \left(3\cos(0) + 3\sin(0)\right) \\[5pt]
  &= -3
  \end{aligned}
  """,
  ),
  StepItem(
  tex:
  r"""\textcolor{green}{4.\ } \textcolor{green}{問題12の公式を適用して} \textcolor{green}{g(t)} \textcolor{green}{を求める}""",
  ),
  StepItem(tex: r"""\text{微分方程式 }g''(t) + 2g'(t) + 3g(t) = 0\text{ について、}\textcolor{blue}{方針通り、放電RLC回路の公式を適用する。}"""),
  StepItem(tex: r"""\text{問題12の公式より、}g(t) = e^{-\beta t}\left(g(0)\cos(\sqrt{\omega_0^2-\beta^2}t) + \frac{g'(0)+\beta g(0)}{\sqrt{\omega_0^2-\beta^2}}\sin(\sqrt{\omega_0^2-\beta^2}t)\right)"""),
  StepItem(
  tex: r"""
  \begin{aligned}
  g(t) &=  e^{-\beta t}\left(g(0)\cos(\sqrt{\omega_0^2-\beta^2}t) + \frac{g'(0)+\beta g(0)}{\sqrt{\omega_0^2-\beta^2}}\sin(\sqrt{\omega_0^2-\beta^2}t)\right)\\[5pt]
  &= e^{-t}\left(1 \cdot \cos(\sqrt{2}t) + \frac{-3 + 1 \cdot 1}{\sqrt{2}}\sin(\sqrt{2}t)\right) \\[5pt]
  &= e^{-t}\left(\cos(\sqrt{2}t) + \frac{-2}{\sqrt{2}}\sin(\sqrt{2}t)\right) \\[5pt]
  &= e^{-t}\left(\cos(\sqrt{2}t) - \sqrt{2}\sin(\sqrt{2}t)\right)
  \end{aligned}
  """,
  ),
  StepItem(
  tex:
  r"""\textcolor{green}{5.\ } \textcolor{green}{g(t)} \textcolor{green}{と特解を合わせて} \textcolor{green}{f(t)} \textcolor{green}{を求める}""",
  ),
  StepItem(tex: r"""
  \begin{aligned}
  f(t) &= g(t) + f_p(t)\\[5pt]
  &= e^{-t}\left(\cos(\sqrt{2}t) - \sqrt{2}\sin(\sqrt{2}t)\right) + \sqrt{2}\sin\left(3t - \frac{\pi}{4}\right)
  \end{aligned}
  """,
  ),
  StepItem(tex: r"""\text{また、}f'(t)\text{は、}"""),
  StepItem(tex: r"""
  \begin{aligned}
    f'(t) &=  \left[e^{-t}\left(\cos(\sqrt{2}t) - \sqrt{2}\sin(\sqrt{2}t)\right) + \sqrt{2}\sin\left(3t - \frac{\pi}{4}\right)\right]'\\[8pt]
    &= -e^{-t}\left(\cos(\sqrt{2}t) - \sqrt{2}\sin(\sqrt{2}t)\right) \\
    &+ \ e^{-t}\left(-\sqrt{2}\cos(\sqrt{2}t) - 2\sin(\sqrt{2}t)\right) + 3\sqrt{2}\cos\left(3t - \frac{\pi}{4}\right)\\[8pt]
    &= e^{-t}\left(\left(-1 - \sqrt{2}\right)\cos(\sqrt{2}t) + \left(-2 + \sqrt{2}\right)\sin(\sqrt{2}t)\right) \\
    &+ 3\sqrt{2}\cos\left(3t - \frac{\pi}{4}\right)
  \end{aligned}
  """,
  ),
  StepItem(
  tex:
  r"""\textcolor{green}{6.\ } \textcolor{green}{定常状態の解}""",
  ),
  StepItem(tex: r"""\text{ここで、定常状態を求める。}"""),
  StepItem(tex: r"""\text{十分時間が経った時の関数形(定常状態の解)は、}"""),
  StepItem(tex: r"""\lim_{t \to \infty} e^{-t}\left(\cos(\sqrt{2}t) - \sqrt{2}\sin(\sqrt{2}t)\right) = 0 \text{ より、}"""),
  StepItem(tex: r"""f(t) \fallingdotseq f_p(t) = \sqrt{2}\sin\left(3t - \frac{\pi}{4}\right)"""),
  StepItem(tex: r"""\text{と近似できる。また、定常状態の }f'(t)\text{ は、}"""),
  StepItem(tex: r"""
  \begin{aligned}
  \textcolor{blue}{ f'(t) \fallingdotseq f'_p(t) = \left[\sqrt{2}\sin\left(3t - \frac{\pi}{4}\right)\right]' = 3\sqrt{2}\cos\left(3t - \frac{\pi}{4}\right)}
  \end{aligned}
  """,
  ),
  StepItem(tex: r"""\textcolor{blue}{と近似できる。(これが答え。)}"""),
  StepItem(tex: r"""\textcolor{green}{7.\ } \textcolor{green}{定常状態の} \textcolor{green}{f'(t)} \textcolor{green}{と} \textcolor{green}{F} \textcolor{green}{との比}"""),
      StepItem(tex: r"""\text{定常状態の }f'(t)\text{ の振幅と }F\text{ との比は、}\frac{F}{f'_{max}} = \frac{12}{3\sqrt{2}} = 2\sqrt{2}""",),
      StepItem(tex: r"""\text{また、定常状態の }f'(t)\text{ と右辺の }12\cos(3t)\text{ との位相を比較すると、解の位相は右辺の位相よりも} \dfrac{\pi}{4}\text{ 遅れている}"""),
  ],
  ),

  // --- 臨界減衰の強制振動（sin(Ωt)）数値 ---
  MathProblem(
  id: "E32CEEE3-F0E5-44C6-838C-7BEF0531E460",

  no: 123,
  category: '数値・二階・非斉次',
  level: '上級',
  question: r"""f''(t)+2f'(t)+4f(t)=20\cos(2t),\quad f(0)=0,\ f'(0)=0""",
  answer:
  r"""10\cos(2t)""",
  imageAsset: '',
  hint: r"""\text{未定係数法で特解を求めて、それを引いた関数を新たに定義し、右辺0(同次方程式)の場合の公式（問題12）を適用して解く。ちなみにこの問題では共振条件 }\omega = \sqrt{\frac{\gamma}{\alpha}} = 2\text{ が成立している。}""",
    equation: r"""f''(t)+2f'(t)+4f(t)=20\cos(2t) \ \ \text{の定常状態の }f'(t)""",
    conditions: r"""f(0)=0,\ f'(0)=0""",
    constants: r"""""",
    keywords: ['交流', '数値', 'コンデンサ', 'コイル', '抵抗'],
  steps: [
  StepItem(tex: r"""\textcolor{brown}{\large{【電磁気学】}}"""),
  StepItem(tex: r"""\text{• RLC直列交流回路について、キルヒホッフの第二法則を用いると }
  LQ''(t) + RQ'(t) + \displaystyle \frac{Q(t)}{C} = V_0\cos(\omega_0 t) \text{が成り立つ。}\textcolor{purple}{この問題では、共振条件 }"""),
  StepItem(tex: r"""\textcolor{purple} {\omega = \omega_0 = \sqrt{\frac{1}{LC}}}\textcolor{purple}{ が成立している。}"""),
  StepItem(tex: r"""\textcolor{brown}{\large{【問題の記号と電磁気学における記号の対応】}}"""),
  StepItem(tex: r"""\text{RLC直列交流回路の過渡応答（共振）:} \ LQ''(t) + RQ'(t) + \displaystyle \frac{Q(t)}{C} = V_0\cos(\omega_0 t)"""),
  StepItem(tex: r"""\text{• } f(t) \leftrightarrow Q(t) \text{（コンデンサに蓄えられた電荷）}"""),
  StepItem(tex: r"""\text{• } f'(t) \leftrightarrow Q'(t) \text{（電流）}"""),
  StepItem(tex: r"""\text{• } f''(t) \leftrightarrow Q''(t) \text{（電流変化率）}"""),
  StepItem(
  tex:
  r"""\text{• } \dfrac{2}{2 \cdot 1} = 1 \leftrightarrow \displaystyle \frac{R}{2L} \text{（減衰定数）}""",
  ),
  StepItem(
  tex:
  r"""\text{• } \dfrac{1}{\sqrt{1 \cdot \frac{1}{4}}} = 2 \leftrightarrow \displaystyle \frac{1}{\sqrt{LC}} \text{（減衰定数が0の場合の固有角周波数）}""",
  ),
  StepItem(
  tex:
  r"""\text{• } \sqrt{\frac{1}{1 \cdot \frac{1}{4}} - \left(\frac{2}{2 \cdot 1}\right)^2} = \sqrt{3} \leftrightarrow \sqrt{\displaystyle \frac{1}{LC} - \left(\displaystyle \frac{R}{2L}\right)^2} \text{（減衰角周波数）}""",
  ),
  StepItem(tex: r"""\text{• } 20 \leftrightarrow V_0 \text{（電圧振幅）}"""),
  StepItem(tex: r"""\text{• } 2 \leftrightarrow \omega \text{（交流電圧周波数）}"""),
  StepItem(
  tex:
  r"""\text{• 定常状態の }f'(t)\text{ の振幅と }F\text{ との比(インピーダンス)：} \displaystyle \frac{F}{f'_{max}} = \sqrt{\left(\frac{4}{2} - 1 \cdot 2\right)^2+4 \cdot 1^2} = 2 """),
  StepItem(
  tex:
  r"""\leftrightarrow  |Z| = \frac {V_0}{I_{max}} = {\sqrt{\left(\frac{1}{\omega C} - \omega L \right) ^2 + R^2}}""",
  ),
  StepItem(
  tex:
   r"""\text{• 定常状態の }f'(t)\text{ と右辺の }20\cos(2t)\text{ との位相差：}\phi = 0 \text{（同相）} \left( \tan \phi  = \frac{2 \cdot 1 - \frac {1} {2 \cdot \frac{1}{4}}} {2} = 0 \right)"""),
  StepItem(tex:r""" \leftrightarrow \tan \phi = \frac{\omega L -\frac{1}{\omega C}}{R} = 0 \text{（電流と電圧の位相差）}""",),
  StepItem(tex: r"""\text{• } 0 \leftrightarrow Q_0 \text{（初期電荷）}"""),
  StepItem(tex: r"""\text{• } 0 \leftrightarrow I_0 \text{（初期電流）}"""),
  StepItem(tex: r"""\textcolor{brown}{\large{【解法】}}"""),
  StepItem(tex: r"""\textbf{【方針】}"""),
  StepItem(
  tex: r"""\text{未定係数法で特解を求めて、それを引いた関数を新たに定義し、右辺0(同次方程式)の場合の公式（問題12）を適用して解く。ちなみにこの問題では共振条件 }\omega = \sqrt{\frac{\gamma}{\alpha}} = 2\text{ が成立している。}""",
  ),
  StepItem(
  tex:
  r"""\textcolor{blue}{微分方程式 } \textcolor{blue}{f''(t) + 2\beta f'(t) + \omega_0^2 f(t) = 0} \textcolor{blue}{ に対する初期値問題} \textcolor{blue}{f(0) = f_0,\quad f'(0) = v_0} \textcolor{blue}{の解は下記のように表される。(問題12)}""",
  ),
  StepItem(
  tex:
  r"""\textcolor{blue}{f(t) = e^{-\beta t}\left(f_0\cos\left(\sqrt{\omega_0^2-\beta^2}\ \,t\right) + \frac{v_0+\beta f_0}{\sqrt{\omega_0^2-\beta^2}}\sin\left(\sqrt{\omega_0^2-\beta^2}\ \,t\right)\right)}""",
  ),
  StepItem(
  tex:
  r"""\textcolor{green}{1.\ } \textcolor{green}{特解を求める}""",
  ),
  StepItem(tex: r"""\text{右辺の形 }20\cos(2t)\text{ を参考に、方程式を満たす1つの解(特解)を}"""),
  StepItem(tex: r"""f_p(t) = A\sin(\omega t) + B\cos(\omega t) \text{の形で推定する。ただし、}A, B \text{は時間によらない定数、}\omega = 2\text{ である。}"""),
  StepItem(tex: r"""\text{まず、}f_p(t)\text{ を微分する：}"""),
  StepItem(
  tex: r"""
  \begin{aligned}
  \begin{cases}
  f_p'(t) = \omega A\cos(\omega t) - \omega B\sin(\omega t) \\[5pt]
  f_p''(t) = -\omega^2 A\sin(\omega t) - \omega^2 B\cos(\omega t)
  \end{cases}
  \end{aligned}
  """,
  ),
      StepItem(tex: r"""\text{これを }f_p''(t) + 2f_p'(t) + 4f_p(t) = 20\cos(2t)\cdots (1)"""),
      StepItem(tex: r"""\text{ に代入してsin,cosの係数を比較する。}"""),
  StepItem(
  tex: r"""
  \begin{aligned}
  f_p''(t) + 2f_p'(t) + 4f_p(t) &= (-4A\sin(2t) - 4B\cos(2t)) + 2(2A\cos(2t) - 2B\sin(2t)) \\[5pt]
  &\quad + 4(A\sin(2t) + B\cos(2t)) \\[5pt]
  &= (-4B)\sin(2t) + (4A)\cos(2t) \\[5pt]
  &= 20\cos(2t)
  \end{aligned}
  """,
  ),
  StepItem(tex: r"""\text{両辺の係数を比較して、}"""),
  StepItem(tex: r"""\text{sinの係数：}-4B = 0"""),
  StepItem(tex: r"""\text{cosの係数：}4A = 20"""),
  StepItem(tex: r"""\text{これを解くと、}A = 5,\ B = 0"""),
  StepItem(tex: r"""\text{ゆえに特解は、}"""),
  StepItem(
  tex: r"""
  f_p(t) = 5\sin(2t)
  """,
  ),

  StepItem(tex:r"""\textcolor{green}{2.} \textcolor{green}{f(t)} \textcolor{green}{を平行移動した関数を} \textcolor{green}{g(t) = f(t) - f_p(t)} \textcolor{green}{と置くと、}"""),
  StepItem(tex:r"""\textcolor{green}{g(t)} \textcolor{green}{は微分方程式} \textcolor{green}{g''(t) + 2g'(t) + 4g(t) = 0} \textcolor{green}{の解である。}"""),
  StepItem(
  tex:
  r"""f_p(t) \text{は微分方程式の解なので、} f_p''(t) + 2f_p'(t) + 4f_p(t) = 20\cos(2t)\text{ を満たす。この式を本問の微分方程式と連立して引き算を行う。}""",
  ),
  StepItem(tex: r"""\text{これらを引き算すると、}"""),
  StepItem(
  tex: r"""
  \begin{aligned}
  &\quad f''(t) + 2f'(t) + 4f(t) = 20\cos(2t) \\
  -&\quad f_p''(t) + 2f_p'(t) + 4f_p(t) = 20\cos(2t) \\[5pt]
  \hline \\
  &\quad (f''(t) - f_p''(t)) + 2(f'(t) - f_p'(t)) + 4(f(t) - f_p(t)) = 0
  \end{aligned}
  """,
  ),
  StepItem(tex: r"""\text{平行移動：} g(t) = f(t) - f_p(t) \text{ とおくと、} g''(t) + 2g'(t) + 4g(t) = 0 """),
  StepItem(tex: r"""\textcolor{blue}{すなわち、} \textcolor{blue}{g(t)} \textcolor{blue}{ は微分方程式 } \textcolor{blue}{g''(t) + 2g'(t) + 4g(t) = 0} \textcolor{blue}{ の解である。}"""),
  StepItem(
  tex:
  r"""\textcolor{green}{3.\ } \textcolor{green}{g} \textcolor{green}{の初期条件を求める}""",
  ),
  StepItem(tex: r"""f_p(t) = 5\sin(2t)\text{ より、}"""),
  StepItem(
  tex: r"""
  \begin{aligned}
  g(0) &= f(0) - f_p(0) \\[5pt]
  &= 0 - 5\sin(0) \\[5pt]
  &= 0
  \end{aligned}
  """,
  ),
  StepItem(tex: r"""\text{次に、}f_p'(t)\text{ を計算する：}"""),
  StepItem(
  tex: r"""
  \begin{aligned}
  f_p'(t) &= 5 \cdot 2\cos(2t) = 10\cos(2t)
  \end{aligned}
  """,
  ),
  StepItem(tex: r"""\text{したがって、}"""),
  StepItem(
  tex: r"""
  \begin{aligned}
  g'(0) &= f'(0) - f_p'(0) \\[5pt]
  &= 0 - 10\cos(0) \\[5pt]
  &= 0 - 10 \\[5pt]
  &= -10
  \end{aligned}
  """,
  ),
  StepItem(
  tex:
  r"""\textcolor{green}{4.\ } \textcolor{green}{問題12の公式を適用して} \textcolor{green}{g(t)} \textcolor{green}{を求める}""",
  ),
  StepItem(tex: r"""\text{微分方程式 }g''(t) + 2g'(t) + 4g(t) = 0\text{ について、}\textcolor{blue}{方針通り、放電RLC回路の公式を適用する。}"""),
  StepItem(tex: r"""\text{問題12の公式より、}g(t) = e^{-\beta t}\left(g(0)\cos(\sqrt{\omega_0^2-\beta^2}t) + \frac{g'(0)+\beta g(0)}{\sqrt{\omega_0^2-\beta^2}}\sin(\sqrt{\omega_0^2-\beta^2}t)\right)"""),
  StepItem(tex: r"""\beta = 1,\ \omega_0^2 = 4,\ g(0) = 0,\ g'(0) = -10 \quad \text{を公式に代入して、}"""), 
  StepItem(
  tex: r"""
  \begin{aligned}
  g(t) &=  e^{-\beta t}\left(g(0)\cos(\sqrt{\omega_0^2-\beta^2}t) + \frac{g'(0)+\beta g(0)}{\sqrt{\omega_0^2-\beta^2}}\sin(\sqrt{\omega_0^2-\beta^2}t)\right)\\[5pt]
  &= e^{-t}\left(0 \cdot \cos(\sqrt{3}t) + \frac{-10 + 1 \cdot 0}{\sqrt{3}}\sin(\sqrt{3}t)\right) \\[5pt]
  &= e^{-t}\left(-\frac{10}{\sqrt{3}}\sin(\sqrt{3}t)\right)
  \end{aligned}
  """,
  ),
  StepItem(
  tex:
  r"""\textcolor{green}{5.\ } \textcolor{green}{g(t)} \textcolor{green}{と特解を合わせて} \textcolor{green}{f(t)} \textcolor{green}{を求める}""",
  ),
  StepItem(tex: r"""
  \begin{aligned}
  f(t) &= g(t) + f_p(t)\\[5pt]
  &= e^{-t}\left(-\frac{10}{\sqrt{3}}\sin(\sqrt{3}t)\right) + 5\sin(2t)
  \end{aligned}
  """,
  ),
  StepItem(tex: r"""\text{また、}f'(t)\text{は、}"""),
  StepItem(tex: r"""
  \begin{aligned}
    f'(t) &=  \left[e^{-t}\left(-\frac{10}{\sqrt{3}}\sin(\sqrt{3}t)\right) + 5\sin(2t)\right]'\\[8pt]
    &= -e^{-t}\left(-\frac{10}{\sqrt{3}}\sin(\sqrt{3}t)\right) + e^{-t}\left(-\frac{10}{\sqrt{3}} \cdot \sqrt{3}\cos(\sqrt{3}t)\right) + 5 \cdot 2\cos(2t)\\[8pt]
    &= e^{-t}\left(\frac{10}{\sqrt{3}}\sin(\sqrt{3}t) - 10\cos(\sqrt{3}t)\right) + 10\cos(2t)
  \end{aligned}
  """,
  ),
  StepItem(
  tex:
  r"""\textcolor{green}{6.\ } \textcolor{green}{定常状態の解}""",
  ),
  StepItem(tex: r"""\text{ここで、定常状態を求める。}"""),
  StepItem(tex: r"""\text{十分時間が経った時の関数形(定常状態の解)は、}"""),
  StepItem(tex: r"""\lim_{t \to \infty} e^{-t}\left(-\frac{10}{\sqrt{3}}\sin(\sqrt{3}t)\right) = 0 \text{ より、}"""),
  StepItem(tex: r"""f(t) \fallingdotseq f_p(t) = 5\sin(2t)"""),
  StepItem(tex: r"""\text{と近似できる。また、定常状態の }f'(t)\text{ は、}"""),
  StepItem(tex: r"""
  \begin{aligned}
  f'(t) \fallingdotseq f'_p(t) = \left[5\sin(2t)\right]' = 10\cos(2t)
  \end{aligned}
  """,
  ),
  StepItem(tex: r"""\text{と近似できる。}"""),
  StepItem(tex: r"""\textcolor{green}{7.\ } \textcolor{green}{定常状態の} \textcolor{green}{f'(t)} \textcolor{green}{と} \textcolor{green}{F} \textcolor{green}{との比}"""),
      StepItem(tex: r"""\text{定常状態の }f'(t)\text{ の振幅と }F\text{ との比は、}\displaystyle \dfrac{F}{f'_{max}} = \frac{20}{10} = 2""",),
      StepItem(tex: r"""\text{また、定常状態の }f'(t)\text{ と右辺の }20\cos(2t)\text{ との位相を比較すると、解の位相} \omega t \text{は右辺の関数の位相} \omega t \text{と揃っている。}"""),
  ],
  ),
];


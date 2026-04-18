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
// RLC直列回路・印加電圧あり（臨界減衰）
// ======================================================================
const rlcSeriesVoltageCriticalProblems = <MathProblem>[
  MathProblem(
    id: "3ABE9F4E-68E6-4E65-BBE0-FD6CD99715DD",
    no: 21,
  category: '一般・二階・非斉次',
  level: '上級',
  question:
  r"""f''(t)+2\gamma\,f'(t)+\omega_0^2 f(t)=F\sin(\Omega t),\quad \gamma=\omega_0,\ f(0)=0,\ f'(0)=0""",
  answer:
  r"""f(t)=\frac{F}{(\gamma^2+\Omega^2)^2}\left\{e^{-\gamma t}\left(2\gamma\Omega - \Omega(3\gamma^2-\Omega^2)t\right)\right\} + \frac{F}{|Z|\Omega}\sin(\Omega t + \alpha),\quad \gamma=\omega_0,\ |Z|=\frac{\gamma^2+\Omega^2}{\Omega},\ \alpha=-\arctan\left(\frac{\gamma^2-\Omega^2}{2\gamma\Omega}\right)""",
  imageAsset: '',
  equation: r"""f''(t)+2\gamma\,f'(t)+\omega_0^2 f(t)=F\sin(\Omega t)""",
  conditions: r"""f(0)=0,\ f'(0)=0""",
  constants: r"""\gamma=\omega_0,\ F,\Omega:定数""",
  keywords: ['一般', '大学'],

  steps: [
  StepItem(tex: r"""\textcolor{brown}{\large{【力学】}}"""),
  StepItem(tex: r"""\text{• 臨界減衰系での強制振動}"""),
  StepItem(
  tex: r"""\text{• 力学においては、} mx''(t) + 2cx'(t) + kx(t) = F_0\sin(\Omega t) \text{ の形でよく登場する。これは臨界減衰系での強制振動を表す。外力 }F\sin(\Omega t)\text{ に対する応答。定常状態では、減衰項が消え、強制項と同じ周波数で振動する。}""",
  ),
  StepItem(tex: r"""\textcolor{brown}{\large{【電磁気学】}}"""),
  StepItem(tex: r"""\text{• RLC回路の強制振動（臨界減衰）}"""),
  StepItem(
  tex: r"""\text{• 電磁気学においては、} LI'(t) + RI(t) + \displaystyle \frac{q(t)}{C} = V_0\sin(\Omega t) \text{ の形でよく登場する。これはRLC回路の強制振動を表す。電流は電圧より位相差 }\alpha = -\arctan\left(\frac{\gamma^2-\Omega^2}{2\gamma\Omega}\right)\text{ で、電流振幅は }\frac{F\Omega}{\sqrt{(\gamma^2+\Omega^2)^2}}\text{ である。}""",
  ),
  StepItem(tex: r"""\textcolor{brown}{\large{【問題の記号と力学における記号の対応】}}"""),
  StepItem(tex: r"""\text{臨界減衰系での強制振動:} \ mx''(t) + 2cx'(t) + kx(t) = F_0\sin(\Omega t)"""),
  StepItem(tex: r"""\text{• } f(t) \leftrightarrow x(t) \text{（位置）}"""),
  StepItem(tex: r"""\text{• } f'(t) \leftrightarrow v(t) \text{（速度）}"""),
  StepItem(tex: r"""\text{• } f''(t) \leftrightarrow a(t) \text{（加速度）}"""),
  StepItem(
  tex:
  r"""\text{• } \gamma \leftrightarrow \displaystyle \frac{2c}{m} \text{（減衰係数）}""",
  ),
  StepItem(
  tex:
  r"""\text{• } \omega_0 \leftrightarrow \sqrt{\displaystyle \frac{k}{m}} \text{（固有角周波数）}""",
  ),
  StepItem(tex: r"""\text{• } F \leftrightarrow \displaystyle \frac{F_0}{m} \text{（外力振幅 ÷ 質量）}"""),
  StepItem(tex: r"""\text{• } \Omega \leftrightarrow \Omega \text{（外力の角周波数）}"""),
  StepItem(tex: r"""\text{• } f(0)=0 \leftrightarrow x_0=0 \text{（初期位置）}"""),
  StepItem(tex: r"""\text{• } f'(0)=0 \leftrightarrow v_0=0 \text{（初期速度）}"""),
  StepItem(tex: r"""\textcolor{brown}{\large{【問題の記号と電磁気学における記号の対応】}}"""),
  StepItem(tex: r"""\text{RLC回路の強制振動（臨界減衰）:} \ LI'(t) + RI(t) + \displaystyle \frac{q(t)}{C} = V_0\sin(\Omega t)"""),
  StepItem(tex: r"""\text{• } f(t) \leftrightarrow q(t) \text{（電荷）}"""),
  StepItem(tex: r"""\text{• } f'(t) \leftrightarrow I(t) \text{（電流）}"""),
  StepItem(tex: r"""\text{• } f''(t) \leftrightarrow I'(t) \text{（電流変化率）}"""),
  StepItem(
  tex:
  r"""\text{• } \gamma \leftrightarrow \displaystyle \frac{R}{2L} \text{（減衰係数）}""",
  ),
  StepItem(
  tex:
  r"""\text{• } \omega_0 \leftrightarrow \displaystyle \frac{1}{\sqrt{LC}} \text{（固有角周波数）}""",
  ),
  StepItem(tex: r"""\text{• } F \leftrightarrow \displaystyle \frac{V_0}{L} \text{（電圧振幅 ÷ インダクタンス）}"""),
  StepItem(tex: r"""\text{• } \Omega \leftrightarrow \Omega \text{（駆動角周波数）}"""),
  StepItem(tex: r"""\text{• } f(0)=0 \leftrightarrow q_0=0 \text{（初期電荷）}"""),
  StepItem(tex: r"""\text{• } f'(0)=0 \leftrightarrow I_0=0 \text{（初期電流）}"""),
  StepItem(tex: r"""\textcolor{brown}{\large{【解法】}}"""),
  StepItem(tex: r"""\textbf{【方針】}"""),
  StepItem(
  tex: r"""\text{未定係数法で特解を求めて、それを引いた関数を新たに定義し、同次方程式の公式（問題14）を適用して解く。}""",
  ),
  StepItem(tex: r"""\textcolor{green}{同次の場合の公式}"""),
  StepItem(
  tex:
  r"""\text{同次方程式 }f''(t) + 2\gamma f'(t) + \omega_0^2 f(t) = 0\text{ に対する初期値問題（臨界減衰：}\gamma = \omega_0\text{）}""",
  ),
  StepItem(tex: r"""f(0) = A_0,\quad f'(0) = v_0"""),
  StepItem(tex: r"""\text{の解は（問題14より）}"""),
  StepItem(
  tex: r"""f(t) = e^{-\gamma t}\left(A_0 + (v_0 + \gamma A_0)t\right)""",
  ),
  StepItem(tex: r"""\text{である。}"""), StepItem(tex: r"""\textcolor{blue}{この公式を用いて、本問を解く。}"""),
  StepItem(
  tex:
  r"""f''(t) + 2\gamma f'(t) + \omega_0^2 f(t) = F\sin(\Omega t),\quad \gamma = \omega_0""",
  ),

  StepItem(
  tex:
  r"""\textcolor{green}{1.\ } \textcolor{green}{特解を求める}""",
  ),
  StepItem(tex: r"""\text{非斉次項 }F\sin(\Omega t)\text{ より、特解を }"""),
  StepItem(tex: r"""f_p(t) = A\sin(\Omega t) + B\cos(\Omega t)"""),
  StepItem(tex: r"""\text{の形で推定する（}A, B\text{ は未定係数）。}"""),

  StepItem(tex: r"""\text{まず、}f_p(t)\text{ を微分する：}"""),
  StepItem(
  tex: r"""
  \begin{aligned}
  f_p'(t) &= \Omega A\cos(\Omega t) - \Omega B\sin(\Omega t) \\[5pt]
  f_p''(t) &= -\Omega^2 A\sin(\Omega t) - \Omega^2 B\cos(\Omega t)
  \end{aligned}
  """,
  ),
  StepItem(
  tex:
  r"""\text{これらを }f_p''(t) + 2\gamma f_p'(t) + \omega_0^2 f_p(t) = F\sin(\Omega t)\text{ に代入すると、}""",
  ),
  StepItem(tex: r"""\text{臨界減衰の条件 }\gamma = \omega_0\text{ より、}"""),
  StepItem(
  tex: r"""
  \begin{aligned}
  f_p''(t) + 2\gamma f_p'(t) + \gamma^2 f_p(t) &= (-\Omega^2 A\sin(\Omega t) - \Omega^2 B\cos(\Omega t)) \\[5pt]
  &\quad + 2\gamma(\Omega A\cos(\Omega t) - \Omega B\sin(\Omega t)) \\[5pt]
  &\quad + \gamma^2(A\sin(\Omega t) + B\cos(\Omega t)) \\[5pt]
  &= (-\Omega^2 A - 2\gamma\Omega B + \gamma^2 A)\sin(\Omega t) \\[5pt]
  &\quad + (-\Omega^2 B + 2\gamma\Omega A + \gamma^2 B)\cos(\Omega t) \\[5pt]
  &= ((\gamma^2 - \Omega^2)A - 2\gamma\Omega B)\sin(\Omega t) \\[5pt]
  &\quad + (2\gamma\Omega A + (\gamma^2 - \Omega^2)B)\cos(\Omega t) \\[5pt]
  &= F\sin(\Omega t)
  \end{aligned}
  """,
  ),

  StepItem(
  tex:
  r"""\textcolor{green}{2.\ } \textcolor{green}{係数を比較}""",
  ),
  StepItem(tex: r"""\text{両辺の係数を比較して、}"""),
  StepItem(
  tex: r"""
  \begin{cases}
  (\gamma^2 - \Omega^2)A - 2\gamma\Omega B = F \\[5pt]
  2\gamma\Omega A + (\gamma^2 - \Omega^2)B = 0
  \end{cases}
  """,
  ),
  StepItem(
  tex:
  r"""\text{第2式より }B = -\frac{2\gamma\Omega A}{\gamma^2 - \Omega^2}\text{ を第1式に代入して、}""",
  ),
  StepItem(
  tex: r"""
  \begin{aligned}
  (\gamma^2 - \Omega^2)A - 2\gamma\Omega \cdot \left(-\frac{2\gamma\Omega A}{\gamma^2 - \Omega^2}\right) &= F \\[5pt]
  (\gamma^2 - \Omega^2)A + \frac{4\gamma^2\Omega^2 A}{\gamma^2 - \Omega^2} &= F \\[5pt]
  \frac{(\gamma^2 - \Omega^2)^2 + 4\gamma^2\Omega^2}{\gamma^2 - \Omega^2}A &= F
  \end{aligned}
  """,
  ),
  StepItem(tex: r"""\text{ここで、分母を因数分解すると、}"""),
  StepItem(
  tex: r"""
  \begin{aligned}
  (\gamma^2 - \Omega^2)^2 + 4\gamma^2\Omega^2 &= \gamma^4 - 2\gamma^2\Omega^2 + \Omega^4 + 4\gamma^2\Omega^2 \\[5pt]
  &= \gamma^4 + 2\gamma^2\Omega^2 + \Omega^4 \\[5pt]
  &= (\gamma^2 + \Omega^2)^2
  \end{aligned}
  """,
  ),
  StepItem(tex: r"""\text{したがって、}"""),
  StepItem(
  tex: r"""
  \begin{aligned}
  \frac{(\gamma^2 + \Omega^2)^2}{\gamma^2 - \Omega^2}A &= F \\[5pt]
  A &= \frac{F(\gamma^2 - \Omega^2)}{(\gamma^2 + \Omega^2)^2} \\[5pt]
  B &= -\frac{2\gamma\Omega F}{(\gamma^2 + \Omega^2)^2}
  \end{aligned}
  """,
  ),
  StepItem(tex: r"""\text{特解は、}"""),
  StepItem(
  tex: r"""
  \begin{aligned}
  f_p(t) &= \frac{F}{(\gamma^2+\Omega^2)^2}\left((\gamma^2-\Omega^2)\sin(\Omega t) - 2\gamma\Omega\cos(\Omega t)\right)
  \end{aligned}
  """,
  ),

  StepItem(
  tex:
  r"""\textcolor{green}{3.\ } \textcolor{green}{平行移動で新たな関数} \textcolor{green}{g} \textcolor{green}{を置いて同次化}""",
  ),
  StepItem(tex: r"""\text{平行移動：}g(t) = f(t) - f_p(t) \text{ とおく。}"""),
  StepItem(
  tex:
  r"""\text{微分の線形性と }f_p''(t) + 2\gamma f_p'(t) + \gamma^2 f_p(t) = F\sin(\Omega t)\text{ より、}""",
  ),
  StepItem(
  tex: r"""
  \begin{aligned}
  g''(t) + 2\gamma g'(t) + \gamma^2 g(t) &= (f(t) - f_p(t))'' + 2\gamma(f(t) - f_p(t))' + \gamma^2(f(t) - f_p(t)) \\[5pt]
  &= (f''(t) + 2\gamma f'(t) + \gamma^2 f(t)) - (f_p''(t) + 2\gamma f_p'(t) + \gamma^2 f_p(t)) \\[5pt]
  &= F\sin(\Omega t) - F\sin(\Omega t) \\[5pt]
  &= 0
  \end{aligned}
  """,
  ),
  StepItem(
  tex:
  r"""\text{よって }g''(t) + 2\gamma g'(t) + \gamma^2 g(t) = 0\text{（同次化完了）}""",
  ),

  StepItem(
  tex:
  r"""\textcolor{green}{4.\ } \textcolor{green}{g} \textcolor{green}{の初期条件を求める}""",
  ),
  StepItem(
  tex: r"""
  \begin{aligned}
  g(0) &= f(0) - f_p(0) = 0 - B = -B \\[5pt]
  g'(0) &= f'(0) - f_p'(0) = 0 - \Omega A = -\Omega A
  \end{aligned}
  """,
  ),

  StepItem(
  tex:
  r"""\textcolor{green}{5.\ } \textcolor{green}{問題14の公式を適用して} \textcolor{green}{g(t)} \textcolor{green}{を求める}""",
  ),
  StepItem(
  tex:
  r"""\text{微分方程式 }g''(t) + 2\gamma g'(t) + \gamma^2 g(t) = 0\text{ について（臨界減衰）、}""",
  ),
  StepItem(tex: r"""\text{• 減衰定数：}\gamma = \omega_0"""),
  StepItem(tex: r"""\text{• 初期条件：}g(0) = -B,\quad g'(0) = -\Omega A"""),
  StepItem(tex: r"""\text{問題14の公式より、}"""),
  StepItem(
  tex: r"""
  \begin{aligned}
  g(t) &= e^{-\gamma t}\left(g(0) + (g'(0) + \gamma g(0))t\right) \\[5pt]
  &= e^{-\gamma t}\left(-B + (-\Omega A + \gamma(-B))t\right) \\[5pt]
  &= e^{-\gamma t}\left(-B - (\Omega A + \gamma B)t\right)
  \end{aligned}
  """,
  ),

  StepItem(
  tex:
  r"""\textcolor{green}{6.\ } \textcolor{green}{g(t)} \textcolor{green}{と特解を合わせて} \textcolor{green}{f(t)} \textcolor{green}{を求める}""",
  ),
  StepItem(tex: r"""\text{ }f(t) = g(t) + f_p(t)"""),
  StepItem(
  tex:
  r"""\text{ }A = \frac{F(\gamma^2 - \Omega^2)}{(\gamma^2 + \Omega^2)^2},\ B = -\frac{2\gamma\Omega F}{(\gamma^2 + \Omega^2)^2}\text{ を代入して、}""",
  ),
  StepItem(
  tex: r"""
  \begin{aligned}
  f(t) &= \frac{F}{(\gamma^2+\Omega^2)^2}\left\{e^{-\gamma t}\left(2\gamma\Omega - \Omega(3\gamma^2-\Omega^2)t\right) + (\gamma^2-\Omega^2)\sin(\Omega t) - 2\gamma\Omega\cos(\Omega t)\right\}
  \end{aligned}
  """,
  ),

  StepItem(
  tex:
  r"""\textcolor{green}{7.\ } \textcolor{green}{定常状態の解}""",
  ),
  StepItem(
  tex:
  r"""\text{時間が十分に経過すると、減衰項 }e^{-\gamma t}\text{ の項は }0\text{ に収束する。}""",
  ),
  StepItem(tex: r"""\text{定常状態の解（電荷）は、}"""),
  StepItem(
  tex: r"""
  \begin{aligned}
  Q_s(t) = f_s(t) &= \frac{F}{(\gamma^2+\Omega^2)^2}\left((\gamma^2-\Omega^2)\sin(\Omega t) - 2\gamma\Omega\cos(\Omega t)\right)
  \end{aligned}
  """,
  ),
  StepItem(
  tex:
  r"""\text{電荷振幅：}Q_0 = \sqrt{\left(\frac{F(\gamma^2-\Omega^2)}{(\gamma^2+\Omega^2)^2}\right)^2 + \left(\frac{2\gamma\Omega F}{(\gamma^2+\Omega^2)^2}\right)^2} = \frac{F}{(\gamma^2+\Omega^2)^2}\sqrt{(\gamma^2-\Omega^2)^2+4\gamma^2\Omega^2} = \frac{F}{\gamma^2+\Omega^2}""",
  ),
  StepItem(
  tex:
  r"""\text{2乗和のルートで括って、加法定理を使うと、}\tan\theta = \frac{2\gamma\Omega}{\gamma^2-\Omega^2}\text{ となる }\theta\text{ を用いて、}""",
  ),
  StepItem(
  tex: r"""
  \begin{aligned}
  Q_s(t) = f_s(t) = Q_0\sin(\Omega t + \theta) = \frac{F}{\gamma^2+\Omega^2}\sin\left(\Omega t + \arctan\left(\frac{2\gamma\Omega}{\gamma^2-\Omega^2}\right)\right)
  \end{aligned}
  """,
  ),
  StepItem(tex: r"""\text{定常状態の電流は、電荷を微分して、}"""),
  StepItem(
  tex: r"""
  \begin{aligned}
  I_s(t) = f_s'(t) &= Q_0\Omega\cos(\Omega t + \theta) = \frac{F\Omega}{\gamma^2+\Omega^2}\cos\left(\Omega t + \arctan\left(\frac{2\gamma\Omega}{\gamma^2-\Omega^2}\right)\right) \\[5pt]
  &= \frac{F\Omega}{\gamma^2+\Omega^2}\sin\left(\Omega t - \arctan\left(\frac{\gamma^2-\Omega^2}{2\gamma\Omega}\right)\right)
  \end{aligned}
  """,
  ),
  StepItem(
  tex:
  r"""\text{電流振幅：}I_0 = Q_0\Omega = \frac{F\Omega}{\gamma^2+\Omega^2}""",
  ),

  StepItem(
  tex:
  r"""\textcolor{green}{8.\ } \textcolor{green}{物理の対応}""",
  ),
  StepItem(tex: r"""\textcolor{brown}{\large{【問題の記号と電磁気学における記号の対応】}}"""),
  StepItem(tex: r"""\text{RLC直列交流回路のキルヒホッフの法則:} \ V(t) = L\frac{dI}{dt} + RI + \frac{1}{C}\int_0^t I(s)\,ds"""),
  StepItem(
  tex:
  r"""\text{電流 }I(t) = \frac{dQ}{dt}\text{ を電荷 }Q(t)\text{ で表すと、}V(t) = L\frac{d^2Q}{dt^2} + R\frac{dQ}{dt} + \frac{1}{C}Q(t)""",
  ),
  StepItem(
  tex:
  r"""\text{微分方程式 }f''(t) + 2\gamma f'(t) + \omega_0^2 f(t) = F\sin(\Omega t)\text{（臨界減衰：}\gamma = \omega_0\text{）と比較すると、各変数の対応関係は以下の通り：}""",
  ),
  StepItem(tex: r"""\text{• } f(t) \leftrightarrow Q(t) \text{（電荷）}"""),
  StepItem(
  tex:
  r"""\text{• } f'(t) \leftrightarrow I(t) = \frac{dQ}{dt} \text{（電流）}""",
  ),
  StepItem(
  tex:
  r"""\text{• } f''(t) \leftrightarrow \frac{dI}{dt} = \frac{d^2Q}{dt^2} \text{（電流変化率）}""",
  ),
  StepItem(tex: r"""\text{• } L = 1 \text{（インダクタンス）}"""),
  StepItem(tex: r"""\text{• } R = 2\gamma \text{（抵抗）}"""),
  StepItem(
  tex:
  r"""\text{• } \frac{1}{C} = \omega_0^2 = \gamma^2\text{、よって }C = \frac{1}{\gamma^2} \text{（静電容量）}""",
  ),
  StepItem(tex: r"""\text{• } V_0 = F \text{（電圧振幅）}"""),
  StepItem(tex: r"""\text{• } \omega = \Omega \text{（角周波数）}"""),
  StepItem(
  tex:
  r"""\text{• 減衰定数：}\gamma = \frac{R}{2L} = \frac{2\gamma}{2 \times 1} = \gamma""",
  ),
  StepItem(
  tex:
  r"""\text{• 固有角周波数：}\omega_0 = \sqrt{\frac{1}{LC}} = \sqrt{\frac{1}{1 \times \frac{1}{\gamma^2}}} = \gamma = \omega_0""",
  ),
  StepItem(
  tex: r"""\text{• 臨界減衰の条件：}\gamma = \omega_0\text{（減衰角周波数は }0\text{）}""",
  ),

  StepItem(
  tex:
  r"""\textcolor{green}{9.\ } \textcolor{green}{インピーダンス}""",
  ),
  StepItem(
  tex:
  r"""\text{• 誘導性リアクタンス：} X_L = \Omega L = \Omega \times 1 = \Omega""",
  ),
  StepItem(
  tex:
  r"""\text{• 容量性リアクタンス：} X_C = \frac{1}{\Omega C} = \frac{1}{\Omega \times \frac{1}{\gamma^2}} = \frac{\gamma^2}{\Omega}""",
  ),
  StepItem(
  tex:
  r"""\text{• リアクタンス：} X = X_L - X_C = \Omega - \frac{\gamma^2}{\Omega} = \frac{\Omega^2 - \gamma^2}{\Omega}""",
  ),
  StepItem(tex: r"""\text{• インピーダンスの大きさ：}"""),
  StepItem(
  tex: r"""
  \begin{aligned}
  |Z| &= \sqrt{R^2 + X^2} = \sqrt{(2\gamma)^2 + \left(\frac{\Omega^2 - \gamma^2}{\Omega}\right)^2} \\[5pt]
  &= \sqrt{4\gamma^2 + \frac{(\Omega^2 - \gamma^2)^2}{\Omega^2}} \\[5pt]
  &= \sqrt{\frac{4\gamma^2\Omega^2 + (\Omega^2 - \gamma^2)^2}{\Omega^2}} \\[5pt]
  &= \frac{\sqrt{(\gamma^2 - \Omega^2)^2 + 4\gamma^2\Omega^2}}{\Omega} \\[5pt]
  &= \frac{\gamma^2 + \Omega^2}{\Omega}
  \end{aligned}
  """,
  ),
  StepItem(
  tex:
  r"""\text{• 電流振幅：}I_0 = \frac{V_0}{|Z|} = \frac{F}{\frac{\gamma^2+\Omega^2}{\Omega}} = \frac{F\Omega}{\gamma^2+\Omega^2}\text{（節7の結果と一致）}""",
  ),

  StepItem(
  tex:
  r"""\textcolor{green}{10.\ } \textcolor{green}{位相の遅れ}""",
  ),
  StepItem(
  tex: r"""\text{電圧：}V(t) = V_0\sin(\Omega t) = F\sin(\Omega t)""",
  ),
  StepItem(
  tex:
  r"""\text{電流：}I_s(t) = I_0\sin\left(\Omega t - \arctan\left(\frac{\gamma^2-\Omega^2}{2\gamma\Omega}\right)\right) = \frac{F\Omega}{\gamma^2+\Omega^2}\sin\left(\Omega t - \arctan\left(\frac{\gamma^2-\Omega^2}{2\gamma\Omega}\right)\right)""",
  ),
  StepItem(
  tex:
  r"""\text{位相差：電流は電圧より }\alpha = \arctan\left(\frac{\gamma^2-\Omega^2}{2\gamma\Omega}\right)\text{ だけ位相が遅れている。}""",
  ),
  StepItem(
  tex:
  r"""\text{インピーダンスの位相角：}\alpha = \arctan\left(\frac{X}{R}\right) = \arctan\left(\frac{\frac{\Omega^2-\gamma^2}{\Omega}}{2\gamma}\right) = \arctan\left(\frac{\Omega^2-\gamma^2}{2\gamma\Omega}\right) = -\arctan\left(\frac{\gamma^2-\Omega^2}{2\gamma\Omega}\right)""",
  ),
  StepItem(tex: r"""\text{これは電圧と電流の位相差と一致する。}"""),

  StepItem(
  tex:
  r"""\textcolor{green}{11.\ } \textcolor{green}{消費電力、力率}""",
  ),
  StepItem(
  tex:
  r"""\text{電圧：}V(t) = F\sin(\Omega t)\text{、電流：}I(t) = \frac{F\Omega}{\gamma^2+\Omega^2}\sin\left(\Omega t - \arctan\left(\frac{\gamma^2-\Omega^2}{2\gamma\Omega}\right)\right)""",
  ),
  StepItem(
  tex:
  r"""\text{位相差：}\alpha = -\arctan\left(\frac{\gamma^2-\Omega^2}{2\gamma\Omega}\right)""",
  ),
  StepItem(
  tex:
  r"""\text{力率（パワーファクタ）：}\cos(\alpha) = \cos\left(\arctan\left(\frac{\gamma^2-\Omega^2}{2\gamma\Omega}\right)\right) = \frac{2\gamma\Omega}{\gamma^2+\Omega^2}\text{（電圧と電流の位相差の余弦）}""",
  ),
  StepItem(tex: r"""\text{実効値電圧：}"""),
  StepItem(
  tex: r"""V_{\text{rms}} = \frac{V_0}{\sqrt{2}} = \frac{F}{\sqrt{2}}""",
  ),
  StepItem(tex: r"""\text{実効値電流：}"""),
  StepItem(
  tex:
  r"""I_{\text{rms}} = \frac{I_0}{\sqrt{2}} = \frac{F\Omega}{\sqrt{2}(\gamma^2+\Omega^2)}""",
  ),
  StepItem(tex: r"""\text{抵抗での消費電力（平均）：}"""),
  StepItem(
  tex: r"""
  \begin{aligned}
  \bar{P}_R &= \frac{1}{2}RI_0^2 = \frac{1}{2} \times 2\gamma \times \left(\frac{F\Omega}{\gamma^2+\Omega^2}\right)^2 \\[5pt]
  &= \frac{\gamma F^2\Omega^2}{(\gamma^2+\Omega^2)^2}
  \end{aligned}
  """,
  ),
  StepItem(tex: r"""\text{または、インピーダンスから：}"""),
  StepItem(
  tex: r"""
  \begin{aligned}
  \bar{P} &= \frac{1}{2}\frac{V_0^2}{|Z|}\cos(\alpha) = \frac{1}{2} \times \frac{F^2}{\frac{\gamma^2+\Omega^2}{\Omega}} \times \frac{\gamma^2-\Omega^2}{\gamma^2+\Omega^2} \\[5pt]
  &= \frac{F^2\Omega(\gamma^2-\Omega^2)}{2(\gamma^2+\Omega^2)^2}
  \end{aligned}
  """,
  ),
  StepItem(tex: r"""\text{または、実効値と力率から：}"""),
  StepItem(
  tex: r"""
  \begin{aligned}
  \bar{P} &= V_{\text{rms}} I_{\text{rms}} \cos(\alpha) = \frac{V_0}{\sqrt{2}} \times \frac{I_0}{\sqrt{2}} \times \cos(\alpha) \\[5pt]
  &= \frac{1}{2}V_0 I_0 \cos(\alpha) = \frac{1}{2} \times F \times \frac{F\Omega}{\gamma^2+\Omega^2} \times \frac{\gamma^2-\Omega^2}{\gamma^2+\Omega^2} \\[5pt]
  &= \frac{F^2\Omega(\gamma^2-\Omega^2)}{2(\gamma^2+\Omega^2)^2}
  \end{aligned}
  """,
  ),

  StepItem(
  tex:
  r"""\textcolor{green}{12.\ } \textcolor{green}{補足：lossless（無損失）の場合}""",
  ),
  StepItem(
  tex:
  r"""\text{【直列回路（lossless：系列抵抗 }R \to 0\text{、すなわち }\gamma \to 0\text{）】}""",
  ),
  StepItem(
  tex:
  r"""\text{• 共振 }\Omega = \omega_0\text{：回路のインピーダンスは理想的にゼロ（短絡）になる。}""",
  ),
  StepItem(
  tex:
  r"""\text{インピーダンスの大きさ：}|Z| = \frac{\gamma^2+\Omega^2}{\Omega}\text{ において、}\gamma \to 0\text{ かつ }\Omega = \omega_0\text{ とすると、}|Z| \to \frac{\Omega^2}{\Omega} = \Omega""",
  ),
  StepItem(
  tex:
  r"""\text{ただし、臨界減衰の条件 }\gamma = \omega_0\text{ を考慮すると、}\gamma \to 0\text{ の極限では }\omega_0 \to 0\text{ となり、共振時 }\Omega = \omega_0 \to 0\text{ では }|Z| \to 0""",
  ),
  StepItem(
  tex:
  r"""\text{したがって、端子電流は理論上無限大（現実では源の内部抵抗や寄生抵抗で制限される）。}""",
  ),
  StepItem(
  tex:
  r"""\text{• 非共振 }\Omega \neq \omega_0\text{：端子に有限の（主にリアクティブな）電流が流れる。}""",
  ),
  StepItem(
  tex:
  r"""\text{インピーダンスの大きさ：}|Z| = \frac{\Omega^2}{\Omega} = \Omega\text{（}\gamma \to 0\text{ の極限）}""",
  ),
  StepItem(
  tex:
  r"""\text{電流振幅：}I_0 = \frac{F\Omega}{\Omega^2} = \frac{F}{\Omega}\text{（有限値）}""",
  ),
  StepItem(
  tex:
  r"""\text{位相差：}\alpha = -\arctan\left(\frac{\gamma^2-\Omega^2}{2\gamma\Omega}\right) \to \begin{cases} 0 & (\Omega < \omega_0) \\ -\pi & (\Omega > \omega_0) \end{cases}\text{（}\gamma \to 0\text{ の極限）}""",
  ),
  StepItem(
  tex:
  r"""\text{消費電力：}\bar{P} = \frac{\gamma F^2\Omega^2}{(\gamma^2+\Omega^2)^2} \to 0\text{（}\gamma \to 0\text{ の極限、純リアクティブ）}""",
  ),
  StepItem(
  tex:
  r"""\text{【並列回路（lossless：並列抵抗 }R_p \to \infty\text{）】}""",
  ),
  StepItem(
  tex:
  r"""\text{• 共振 }\Omega = \omega_0\text{：端子に流れる供給電流はゼロ（理想的には）。}""",
  ),
  StepItem(
  tex:
  r"""\text{並列回路では、共振時に各素子のアドミタンスが打ち消し合い、全アドミタンスがゼロになる。}""",
  ),
  StepItem(
  tex:
  r"""\text{• 非共振 }\Omega \neq \omega_0\text{：端子に有意な（ただし純リアクティブな）電流は流れる。}""",
  ),
  StepItem(
  tex:
  r"""\text{すなわち、瞬時的には流れるが平均で消費する電力はゼロ（純リアクティブ）。}""",
  ),
  ],
  ),

  // // --- 過減衰の強制振動（sin(Ωt)）一般 ---
  MathProblem(
  id: "3FA826E6-FD5D-469B-ACB8-D6FEDDF163F0",

  no: 121,
  category: '数値・二階・非斉次',
  level: '上級',
  question: r"""f''(t)+8\,f'(t)+16\,f(t)=10\sin(2t),\quad f(0)=0,\ f'(0)=0""",
  answer:
  r"""f(t)=e^{-4t}\left(\frac{2}{5}+t\right) + \frac{1}{2}\sin\left(2t + \arctan\left(-\frac{4}{3}\right)\right)""",
  imageAsset: '',
  hint: r"""\text{未定係数法で特解を求めて、それを引いた関数を新たに定義し、同次方程式の公式（問題14）を適用して解く。}""",
    equation: r"""f''(t)+8\,f'(t)+16\,f(t)=10\sin(2t)""",
    conditions: r"""f(0)=0,\ f'(0)=0""",
    keywords: ['数値', '大学'],
  steps: [
  StepItem(tex: r"""\textcolor{brown}{\large{【力学】}}"""),
  StepItem(tex: r"""\text{• 臨界減衰系での強制振動}"""),
  StepItem(
  tex: r"""\text{• 力学においては、} mx''(t) + 2cx'(t) + kx(t) = F_0\sin(2t) \text{ の形でよく登場する。これは臨界減衰系での強制振動を表す。外力 }10\sin(2t)\text{ に対する応答。定常状態では、減衰項が消え、強制項と同じ周波数で振動する。}""",
  ),
  StepItem(tex: r"""\textcolor{brown}{\large{【電磁気学】}}"""),
  StepItem(tex: r"""\text{• RLC回路の強制振動（臨界減衰）}"""),
  StepItem(
  tex: r"""\text{• 電磁気学においては、} LI'(t) + RI(t) + \displaystyle \frac{q(t)}{C} = V_0\sin(2t) \text{ の形でよく登場する。これはRLC回路の強制振動を表す。電流は電圧より位相差 }\alpha = -\arctan\left(\frac{2\gamma\Omega}{\gamma^2-\Omega^2}\right)\text{ で、電流振幅は }\frac{F\Omega}{\gamma^2+\Omega^2}\text{ である。}""",
  ),
  StepItem(tex: r"""\textcolor{brown}{\large{【問題の記号と力学における記号の対応】}}"""),
  StepItem(tex: r"""\text{臨界減衰系での強制振動:} \ mx''(t) + 2cx'(t) + kx(t) = F_0\sin(2t)"""),
  StepItem(tex: r"""\text{• } f(t) \leftrightarrow x(t) \text{（位置）}"""),
  StepItem(tex: r"""\text{• } f'(t) \leftrightarrow v(t) \text{（速度）}"""),
  StepItem(tex: r"""\text{• } f''(t) \leftrightarrow a(t) \text{（加速度）}"""),
  StepItem(
  tex:
  r"""\text{• } \gamma = 4 \leftrightarrow \displaystyle \frac{2c}{m} \text{（減衰係数）}""",
  ),
  StepItem(
  tex:
  r"""\text{• } \omega_0 = 4 \leftrightarrow \sqrt{\displaystyle \frac{k}{m}} \text{（固有角周波数）}""",
  ),
  StepItem(tex: r"""\text{• } 10 \leftrightarrow \displaystyle \frac{F_0}{m} \text{（外力振幅 ÷ 質量）}"""),
  StepItem(tex: r"""\text{• } \Omega = 2 \leftrightarrow 2 \text{（外力の角周波数）}"""),
  StepItem(tex: r"""\text{• } f(0)=0 \leftrightarrow x_0=0 \text{（初期位置）}"""),
  StepItem(tex: r"""\text{• } f'(0)=0 \leftrightarrow v_0=0 \text{（初期速度）}"""),
  StepItem(tex: r"""\textcolor{brown}{\large{【問題の記号と電磁気学における記号の対応】}}"""),
  StepItem(tex: r"""\text{RLC回路の強制振動（臨界減衰）:} \ LI'(t) + RI(t) + \displaystyle \frac{q(t)}{C} = V_0\sin(2t)"""),
  StepItem(tex: r"""\text{• } f(t) \leftrightarrow q(t) \text{（電荷）}"""),
  StepItem(tex: r"""\text{• } f'(t) \leftrightarrow I(t) \text{（電流）}"""),
  StepItem(tex: r"""\text{• } f''(t) \leftrightarrow I'(t) \text{（電流変化率）}"""),
  StepItem(
  tex:
  r"""\text{• } \gamma = 4 \leftrightarrow \displaystyle \frac{R}{2L} \text{（減衰係数）}""",
  ),
  StepItem(
  tex:
  r"""\text{• } \omega_0 = 4 \leftrightarrow \displaystyle \frac{1}{\sqrt{LC}} \text{（固有角周波数）}""",
  ),
  StepItem(tex: r"""\text{• } 10 \leftrightarrow \displaystyle \frac{V_0}{L} \text{（電圧振幅 ÷ インダクタンス）}"""),
  StepItem(tex: r"""\text{• } \Omega = 2 \leftrightarrow 2 \text{（駆動角周波数）}"""),
  StepItem(tex: r"""\text{• } f(0)=0 \leftrightarrow q_0=0 \text{（初期電荷）}"""),
  StepItem(tex: r"""\text{• } f'(0)=0 \leftrightarrow I_0=0 \text{（初期電流）}"""),
  StepItem(tex: r"""\textcolor{brown}{\large{【解法】}}"""),
  StepItem(tex: r"""\textbf{【方針】}"""),
  StepItem(
  tex:
  r"""\text{未定係数法で特解を求めて、それを引いた関数を新たに定義し、同次方程式の公式（問題14：臨界減衰）を適用して解く。}""",
  ),

  StepItem(tex: r"""\textcolor{brown}{\large{【解法】}}"""),
  StepItem(tex: r"""\textcolor{green}{同次の場合の公式}"""),
  StepItem(
  tex:
  r"""\text{微分方程式 }f''(t) + 2\gamma f'(t) + \omega_0^2 f(t) = 0\text{ に対する初期値問題（臨界減衰：}\gamma = \omega_0\text{）}""",
  ),
  StepItem(tex: r"""f(0) = A_0,\quad f'(0) = v_0"""),
  StepItem(tex: r"""\text{の解は（問題14より）}"""),
  StepItem(
  tex: r"""f(t) = e^{-\gamma t}\left(A_0 + (v_0 + \gamma A_0)t\right)""",
  ),
  StepItem(tex: r"""\text{である。}"""), StepItem(tex: r"""\textcolor{blue}{この公式を用いて、本問を解く。}"""),
  StepItem(tex: r"""f''(t) + 8f'(t) + 16f(t) = 10\sin(2t)"""),
  StepItem(
  tex:
  r"""\text{ここで、}2\gamma = 8\text{ より }\gamma = 4\text{、}\omega_0^2 = 16\text{ より }\omega_0 = 4\text{、臨界減衰の条件 }\gamma = \omega_0\text{ が満たされている。}""",
  ),

  StepItem(
  tex:
  r"""\textcolor{green}{1.\ } \textcolor{green}{特解を求める}""",
  ),
  StepItem(tex: r"""\text{非斉次項 }10\sin(2t)\text{ より、特解を }"""),
  StepItem(tex: r"""f_p(t) = A\sin(2t) + B\cos(2t)"""),
  StepItem(tex: r"""\text{の形で推定する（}A, B\text{ は未定係数）。}"""),

  StepItem(tex: r"""\text{まず、}f_p(t)\text{ を微分する：}"""),
  StepItem(
  tex: r"""
  \begin{aligned}
  f_p'(t) &= 2A\cos(2t) - 2B\sin(2t) \\[5pt]
  f_p''(t) &= -4A\sin(2t) - 4B\cos(2t)
  \end{aligned}
  """,
  ),
  StepItem(
  tex:
  r"""\text{これらを }f_p''(t) + 8f_p'(t) + 16f_p(t) = 10\sin(2t)\text{ に代入すると、}""",
  ),
  StepItem(tex: r"""\text{臨界減衰の条件 }\gamma = \omega_0 = 4\text{ より、}"""),
  StepItem(
  tex: r"""
  \begin{aligned}
  f_p''(t) + 8f_p'(t) + 16f_p(t) &= (-4A\sin(2t) - 4B\cos(2t)) \\[5pt]
  &\quad + 8(2A\cos(2t) - 2B\sin(2t)) \\[5pt]
  &\quad + 16(A\sin(2t) + B\cos(2t)) \\[5pt]
  &= (-4A - 16B + 16A)\sin(2t) + (-4B + 16A + 16B)\cos(2t) \\[5pt]
  &= (12A - 16B)\sin(2t) + (16A + 12B)\cos(2t) \\[5pt]
  &= 10\sin(2t)
  \end{aligned}
  """,
  ),

  StepItem(
  tex:
  r"""\textcolor{green}{2.\ } \textcolor{green}{係数を比較}""",
  ),
  StepItem(tex: r"""\text{両辺の係数を比較して、}"""),
  StepItem(
  tex: r"""
  \begin{cases}
  12A - 16B = 10 \\[5pt]
  16A + 12B = 0
  \end{cases}
  """,
  ),
  StepItem(tex: r"""\text{第2式より }A = -\frac{3}{4}B\text{ を第1式に代入して、}"""),
  StepItem(
  tex: r"""
  \begin{aligned}
  12 \cdot \left(-\frac{3}{4}B\right) - 16B &= 10 \\[5pt]
  -9B - 16B &= 10 \\[5pt]
  -25B &= 10 \\[5pt]
  B &= -\frac{2}{5},\quad A = \frac{3}{10}
  \end{aligned}
  """,
  ),
  StepItem(tex: r"""\text{特解は、}"""),
  StepItem(
  tex: r"""
  \begin{aligned}
  f_p(t) &= \frac{3}{10}\sin(2t) - \frac{2}{5}\cos(2t)
  \end{aligned}
  """,
  ),

  StepItem(
  tex:
  r"""\textcolor{green}{3.\ } \textcolor{green}{平行移動で新たな関数} \textcolor{green}{g} \textcolor{green}{を置いて同次化}""",
  ),
  StepItem(tex: r"""\text{平行移動：}g(t) = f(t) - f_p(t) \text{ とおく。}"""),
  StepItem(
  tex:
  r"""\text{微分の線形性と }f_p''(t) + 4f_p'(t) + 4f_p(t) = 3\sin(5t)\text{ より、}""",
  ),
  StepItem(
  tex: r"""
  \begin{aligned}
  g''(t) + 4g'(t) + 4g(t) &= (f(t) - f_p(t))'' + 4(f(t) - f_p(t))' + 4(f(t) - f_p(t)) \\[5pt]
  &= (f''(t) + 4f'(t) + 4f(t)) - (f_p''(t) + 4f_p'(t) + 4f_p(t)) \\[5pt]
  &= 3\sin(5t) - 3\sin(5t) \\[5pt]
  &= 0
  \end{aligned}
  """,
  ),
  StepItem(
  tex: r"""\text{よって }g''(t) + 4g'(t) + 4g(t) = 0\text{（同次化完了）}""",
  ),

  StepItem(
  tex:
  r"""\textcolor{green}{4.\ } \textcolor{green}{g} \textcolor{green}{の初期条件を求める}""",
  ),
  StepItem(
  tex: r"""
  \begin{aligned}
  g(0) &= f(0) - f_p(0) \\[5pt]
  &= 0 - \left(\frac{3}{10}\sin(0) - \frac{2}{5}\cos(0)\right) \\[5pt]
  &= 0 - \left(-\frac{2}{5}\right) \\[5pt]
  &= \frac{2}{5}
  \end{aligned}
  """,
  ),
  StepItem(tex: r"""\text{次に、}f_p'(t)\text{ を計算する：}"""),
  StepItem(
  tex: r"""
  \begin{aligned}
  f_p'(t) &= \frac{3}{10} \cdot 2\cos(2t) + \frac{2}{5} \cdot 2\sin(2t) \\[5pt]
  &= \frac{3}{5}\cos(2t) + \frac{4}{5}\sin(2t)
  \end{aligned}
  """,
  ),
  StepItem(tex: r"""\text{したがって、}"""),
  StepItem(
  tex: r"""
  \begin{aligned}
  g'(0) &= f'(0) - f_p'(0) \\[5pt]
  &= 0 - \left(\frac{3}{5}\cos(0) + \frac{4}{5}\sin(0)\right) \\[5pt]
  &= 0 - \frac{3}{5} \\[5pt]
  &= -\frac{3}{5}
  \end{aligned}
  """,
  ),

  StepItem(
  tex:
  r"""\textcolor{green}{5.\ } \textcolor{green}{問題14の公式を適用して} \textcolor{green}{g(t)} \textcolor{green}{を求める}""",
  ),
  StepItem(
  tex: r"""\text{同次方程式 }g''(t) + 8g'(t) + 16g(t) = 0\text{ について（臨界減衰）、}""",
  ),
  StepItem(tex: r"""\text{• 減衰定数：}\gamma = 4"""),
  StepItem(
  tex:
  r"""\text{• 初期条件：}g(0) = \frac{2}{5},\quad g'(0) = -\frac{3}{5}""",
  ),
  StepItem(tex: r"""\text{問題14の公式より、}"""),
  StepItem(
  tex: r"""
  \begin{aligned}
  g(t) &= e^{-\gamma t}\left(g(0) + (g'(0) + \gamma g(0))t\right) \\[5pt]
  &= e^{-4t}\left(\frac{2}{5} + \left(-\frac{3}{5} + 4 \cdot \frac{2}{5}\right)t\right) \\[5pt]
  &= e^{-4t}\left(\frac{2}{5} + \left(-\frac{3}{5} + \frac{8}{5}\right)t\right) \\[5pt]
  &= e^{-4t}\left(\frac{2}{5} + \frac{5}{5}t\right) \\[5pt]
  &= e^{-4t}\left(\frac{2}{5} + t\right)
  \end{aligned}
  """,
  ),

  StepItem(
  tex:
  r"""\textcolor{green}{6.\ } \textcolor{green}{g(t)} \textcolor{green}{と特解を合わせて} \textcolor{green}{f(t)} \textcolor{green}{を求める}""",
  ),
  StepItem(tex: r"""\text{ }f(t) = g(t) + f_p(t)"""),
  StepItem(
  tex: r"""
  \begin{aligned}
  f(t) &= e^{-4t}\left(\frac{2}{5} + t\right) + \frac{3}{10}\sin(2t) - \frac{2}{5}\cos(2t)
  \end{aligned}
  """,
  ),

  StepItem(
  tex:
  r"""\textcolor{green}{7.\ } \textcolor{green}{定常状態の解}""",
  ),
  StepItem(
  tex: r"""\text{時間が十分に経過すると、減衰項 }e^{-4t}\text{ の項は }0\text{ に収束する。}""",
  ),
  StepItem(tex: r"""\text{定常状態の解（電荷）は、}"""),
  StepItem(
  tex: r"""
  \begin{aligned}
  Q_s(t) = f_s(t) &= \frac{3}{10}\sin(2t) - \frac{2}{5}\cos(2t)
  \end{aligned}
  """,
  ),
  StepItem(
  tex:
  r"""\text{電荷振幅：}Q_0 = \sqrt{\left(\frac{3}{10}\right)^2 + \left(-\frac{2}{5}\right)^2} = \sqrt{\frac{9}{100} + \frac{16}{100}} = \sqrt{\frac{25}{100}} = \frac{1}{2}""",
  ),
  StepItem(
  tex:
  r"""\text{2乗和のルートで括って、加法定理を使うと、}\tan\theta = \displaystyle \frac{-\frac{2}{5}}{\frac{3}{10}} = -\frac{4}{3}\text{ となる }\theta\text{ を用いて、}""",
  ),
  StepItem(
  tex: r"""
  \begin{aligned}
  Q_s(t) = f_s(t) &= Q_0\sin(2t + \theta) = \frac{1}{2}\sin\left(2t + \arctan\left(-\frac{4}{3}\right)\right)
  \end{aligned}
  """,
  ),
  StepItem(tex: r"""\text{定常状態の電流は、電荷を微分して、}"""),
  StepItem(
  tex: r"""
  \begin{aligned}
  I_s(t) = f_s'(t) &= \frac{1}{2} \cdot 2\cos\left(2t + \arctan\left(-\frac{4}{3}\right)\right) \\[5pt]
  &= \cos\left(2t + \arctan\left(-\frac{4}{3}\right)\right) \\[5pt]
  &= \sin\left(2t + \arctan\left(-\frac{4}{3}\right) + \frac{\pi}{2}\right)
  \end{aligned}
  """,
  ),
  StepItem(
  tex:
  r"""\text{電流振幅：}I_0 = Q_0\Omega = \frac{1}{2} \times 2 = 1""",
  ),

  StepItem(
  tex:
  r"""\textcolor{green}{8.\ } \textcolor{green}{物理の対応}""",
  ),
  StepItem(tex: r"""\textcolor{brown}{\large{【問題の記号と電磁気学における記号の対応】}}"""),
  StepItem(tex: r"""\text{RLC直列交流回路のキルヒホッフの法則:} \ V(t) = L\frac{dI}{dt} + RI + \frac{1}{C}\int_0^t I(s)\,ds"""),
  StepItem(
  tex:
  r"""\text{電流 }I(t) = \frac{dQ}{dt}\text{ を電荷 }Q(t)\text{ で表すと、}V(t) = L\frac{d^2Q}{dt^2} + R\frac{dQ}{dt} + \frac{1}{C}Q(t)""",
  ),
  StepItem(
  tex:
  r"""\text{微分方程式 }f''(t) + 8f'(t) + 16f(t) = 10\sin(2t)\text{（臨界減衰：}\gamma = \omega_0 = 4\text{）と比較すると、各変数の対応関係は以下の通り：}""",
  ),
  StepItem(tex: r"""\text{• } f(t) \leftrightarrow Q(t) \text{（電荷）}"""),
  StepItem(
  tex:
  r"""\text{• } f'(t) \leftrightarrow I(t) \text{（電流、}I(t) = \frac{dQ}{dt}\text{）}""",
  ),
  StepItem(
  tex:
  r"""\text{• } f''(t) \leftrightarrow \frac{dI}{dt} \text{（電流変化率、}\frac{dI}{dt} = \frac{d^2Q}{dt^2}\text{）}""",
  ),
  StepItem(tex: r"""\text{• } L \leftrightarrow 1 \text{（インダクタンス）}"""),
  StepItem(tex: r"""\text{• } R \leftrightarrow 8 \text{（抵抗）}"""),
  StepItem(
  tex:
  r"""\text{• } \frac{1}{C} \leftrightarrow 16\text{（静電容量の逆数、}C = \frac{1}{16}\text{）}""",
  ),
  StepItem(tex: r"""\text{• } V_0 \leftrightarrow 10 \text{（電圧振幅）}"""),
  StepItem(tex: r"""\text{• } \omega \leftrightarrow 2 \text{（角周波数）}"""),
  StepItem(
  tex:
  r"""\text{• 減衰定数：}\gamma = \frac{R}{2L} = \frac{8}{2 \times 1} = 4""",
  ),
  StepItem(
  tex:
  r"""\text{• 固有角周波数：}\omega_0 = \sqrt{\frac{1}{LC}} = \sqrt{\frac{1}{1 \times \frac{1}{16}}} = 4""",
  ),
  StepItem(
  tex:
  r"""\text{• 臨界減衰の条件：}\gamma = \omega_0 = 4\text{（減衰角周波数は }0\text{）}""",
  ),

  StepItem(
  tex:
  r"""\textcolor{green}{9.\ } \textcolor{green}{インピーダンス}""",
  ),
  StepItem(tex: r"""\text{• 誘導性リアクタンス：} X_L = \omega L = 2 \times 1 = 2"""),
  StepItem(
  tex:
  r"""\text{• 容量性リアクタンス：} X_C = \frac{1}{\omega C} = \frac{1}{2 \times \frac{1}{16}} = 8""",
  ),
  StepItem(
  tex:
  r"""\text{• リアクタンス：} X = X_L - X_C = 2 - 8 = -6""",
  ),
  StepItem(tex: r"""\text{• インピーダンスの大きさ：}"""),
  StepItem(
  tex: r"""
  \begin{aligned}
  |Z| &= \sqrt{R^2 + X^2} = \sqrt{8^2 + (-6)^2} \\[5pt]
  &= \sqrt{64 + 36} = \sqrt{100} = 10
  \end{aligned}
  """,
  ),
  StepItem(
  tex:
  r"""\text{• 電流振幅：}I_0 = \frac{V_0}{|Z|} = \frac{10}{10} = 1\text{（節7の結果と一致）}""",
  ),

  StepItem(
  tex:
  r"""\textcolor{green}{10.\ } \textcolor{green}{位相の遅れ}""",
  ),
  StepItem(tex: r"""\text{電圧：}V(t) = V_0\sin(2t) = 10\sin(2t)"""),
  StepItem(
  tex:
  r"""\text{電流：}I_s(t) = \sin\left(2t + \arctan\left(-\frac{4}{3}\right) + \frac{\pi}{2}\right) = \sin\left(2t - \arctan\left(\frac{3}{4}\right)\right)""",
  ),
  StepItem(
  tex:
  r"""\text{位相差：電流は電圧より }\alpha = -\arctan\left(\frac{3}{4}\right) \fallingdotseq -36.87°\text{（電流が遅れている）。}""",
  ),
  StepItem(
  tex:
  r"""\text{インピーダンスの位相角：}\alpha = \arctan\left(\frac{X}{R}\right) = \arctan\left(\frac{-6}{8}\right) = \arctan\left(-\frac{3}{4}\right) \fallingdotseq -36.87°""",
  ),
  StepItem(tex: r"""\text{これは電流が電圧より36.87°遅れていることを示し、上記と一致する。}"""),

  StepItem(
  tex:
  r"""\textcolor{green}{11.\ } \textcolor{green}{消費電力、力率}""",
  ),
  StepItem(
  tex:
  r"""\text{電圧：}V(t) = 10\sin(2t)\text{、電流：}I(t) = \sin\left(2t - \arctan\left(\frac{3}{4}\right)\right)""",
  ),
  StepItem(
  tex:
  r"""\text{位相差：}\alpha = -\arctan\left(\frac{3}{4}\right) \fallingdotseq -36.87°\text{（電流が遅れ）}""",
  ),
  StepItem(
  tex:
  r"""\text{力率（パワーファクタ）：}\cos(\alpha) = \cos\left(\arctan\left(\frac{3}{4}\right)\right) = \frac{4}{5}\text{（電圧と電流の位相差の余弦）}""",
  ),
  StepItem(tex: r"""\text{実効値電圧：}"""),
  StepItem(
  tex: r"""V_{\text{rms}} = \frac{V_0}{\sqrt{2}} = \frac{10}{\sqrt{2}}""",
  ),
  StepItem(tex: r"""\text{実効値電流：}"""),
  StepItem(
  tex:
  r"""I_{\text{rms}} = \frac{I_0}{\sqrt{2}} = \frac{1}{\sqrt{2}}""",
  ),
  StepItem(tex: r"""\text{抵抗での消費電力（平均）：}"""),
  StepItem(
  tex: r"""
  \begin{aligned}
  \bar{P}_R &= \frac{1}{2}RI_0^2 = \frac{1}{2} \times 8 \times 1^2 \\[5pt]
  &= 4\text{ W}
  \end{aligned}
  """,
  ),
  StepItem(tex: r"""\text{または、インピーダンスから：}"""),
  StepItem(
  tex: r"""
  \begin{aligned}
  \bar{P} &= \frac{1}{2}\frac{V_0^2}{|Z|}\cos(\alpha) = \frac{1}{2} \times \frac{100}{10} \times \frac{4}{5} \\[5pt]
  &= \frac{1}{2} \times 10 \times \frac{4}{5} = 4\text{ W}
  \end{aligned}
  """,
  ),
  StepItem(tex: r"""\text{または、実効値と力率から：}"""),
  StepItem(
  tex: r"""
  \begin{aligned}
  \bar{P} &= V_{\text{rms}} I_{\text{rms}} \cos(\alpha) = \frac{V_0}{\sqrt{2}} \times \frac{I_0}{\sqrt{2}} \times \cos(\alpha) \\[5pt]
  &= \frac{1}{2}V_0 I_0 \cos(\alpha) = \frac{1}{2} \times 10 \times 1 \times \frac{4}{5} \\[5pt]
  &= 4\text{ W}
  \end{aligned}
  """,
  ),

  StepItem(tex: r"""\textcolor{brown}{\large{【力学】}}"""),
  StepItem(tex: r"""\text{臨界減衰系での強制振動。外力 }10\sin(2t)\text{ に対する応答。}"""),
  StepItem(tex: r"""\text{定常状態では、減衰項が消え、強制項と同じ周波数で振動する。}"""),
  StepItem(
  tex: r"""\text{電流は電圧より約36.87°遅れ、電流振幅は }1\text{ である。}""",
  ),
  ],
  ),
];

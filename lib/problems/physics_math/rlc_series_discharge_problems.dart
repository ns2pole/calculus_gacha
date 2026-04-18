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
// RLC直列回路・放電（同次方程式）
// ======================================================================
const rlcSeriesDischargeProblems = <MathProblem>[
  // --- 減衰振動（RLC自由 一般：不足減衰） ---
  MathProblem(
    id: "ADC1559C-5A8D-490C-9D10-8722FECF3115",
    no: 12,
  category: '二階同次・定数係数（減衰）',
  level: '上級',
  question:
  r"""f''(t) + 2\beta\,f'(t) + \omega_0^2 f(t) = 0,\quad f(0) = f_0,\ f'(0) = v_0,\ \omega_0 > \beta > 0""",
  answer:
  r"""\displaystyle f(t)=e^{-\beta t}\left( f_0\cos\left(\sqrt{\omega_0^2-\beta^2}\ \,t\right)+\displaystyle \frac{v_0+\beta f_0}{\sqrt{\omega_0^2-\beta^2}}\,\sin\left(\sqrt{\omega_0^2-\beta^2}\ \,t\right)\right)""",
  imageAsset: '',
  equation: r"""f''(t) + 2\beta\,f'(t) + \omega_0^2 f(t) = 0""",
  conditions: r"""f(0)=f_0,\ f'(0)=v_0""",
  constants: r"""\ 0< \beta < \omega_0""",
  keywords: ['一般', '電圧0', 'コンデンサ', 'コイル', '抵抗'],
  steps: [
  // StepItem(tex: r"""\text{【力学(※大学レベル)】}"""),
  // StepItem(tex: r"""\text{• 減衰振動}"""),
  // StepItem(
  // tex:
  // r"""\text{• 力学においては、} mx''(t) + 2cx'(t) + kx(t) = 0 \text{ の形でよく登場する。これは減衰自由振動を表す。}""",
  // ),
  // StepItem(
  // tex:
  // r"""\text{• 減衰定数は} \beta = \displaystyle \frac{2c}{m} \text{で、減衰角周波数は} \omega_d = \sqrt{\omega_0^2 - \beta^2} \text{で、減衰定数}\beta = \displaystyle \frac{2c}{m}\text{で指数関数的に減衰する}""",
  // ),
  // StepItem(
  // tex:
  // r"""\text{• 減衰振動の条件：} \omega_0 > \beta \Leftrightarrow \sqrt{\displaystyle \frac{k}{m}} > \displaystyle \frac{2c}{m} \Leftrightarrow c < \displaystyle \frac{\sqrt{km}}{2}""",
  // ),
  StepItem(tex: r"""\textcolor{brown}{\large{【電磁気学】}}"""),
  StepItem(tex: r"""\text{• RLC直列回路について、キルヒホッフの第二法則を用いると }
  LQ''(t) + RQ'(t) + \displaystyle \frac{Q(t)}{C} = 0 \text{が成り立つ。}"""),
  // StepItem(tex: r"""\text{【問題の記号と力学における記号の対応】}"""),
  // StepItem(tex: r"""\text{減衰振動:} \ mx''(t) + 2cx'(t) + kx(t) = 0"""),
  // StepItem(tex: r"""\text{• } f(t) \leftrightarrow x(t) \text{（位置）}"""),
  // StepItem(tex: r"""\text{• } f'(t) \leftrightarrow v(t) \text{（速度）}"""),
  // StepItem(tex: r"""\text{• } f''(t) \leftrightarrow a(t) \text{（加速度）}"""),
  // StepItem(
  // tex:
  // r"""\text{• } \beta \leftrightarrow \displaystyle \frac{2c}{m} \text{（減衰定数）}""",
  // ),
  // StepItem(
  // tex:
  // r"""\text{• } \omega_0 \leftrightarrow \sqrt{\displaystyle \frac{k}{m}} \text{（固有角周波数）}""",
  // ),
  // StepItem(tex: r"""\text{• } f_0 \leftrightarrow x_0 \text{（初期位置）}"""),
  // StepItem(tex: r"""\text{• } v_0 \leftrightarrow v_0 \text{（初期速度）}"""),
  StepItem(tex: r"""\textcolor{brown}{\large{【問題の記号と電磁気学における記号の対応】}}"""),
  StepItem(tex: r"""\text{RLC直列回路の過渡応答:} \ LQ''(t) + RQ'(t) + \displaystyle \frac{Q(t)}{C} = 0"""),
  StepItem(tex: r"""\text{• } f(t) \leftrightarrow Q(t) \text{（コンデンサに蓄えられた電荷）}"""),
  StepItem(tex: r"""\text{• } f'(t) \leftrightarrow Q'(t) \text{（電流）}"""),
  StepItem(tex: r"""\text{• } f''(t) \leftrightarrow Q''(t) \text{（電流変化率）}"""),
  StepItem(
  tex:
  r"""\text{• } \beta \leftrightarrow \displaystyle \frac{R}{2L} \text{（減衰定数）}""",
  ),
  StepItem(
  tex:
  r"""\text{• } \omega_0 \leftrightarrow \displaystyle \frac{1}{\sqrt{LC}} \text{（減衰定数が0の場合の固有角周波数）}""",
  ),
  StepItem(
  tex:
  r"""\text{• } \sqrt{\omega_0^2 - \beta^2} \leftrightarrow \sqrt{\displaystyle \frac{1}{LC} - \left(\displaystyle \frac{R}{2L}\right)^2} \text{（減衰角周波数）}""",
  ),
  StepItem(tex: r"""\text{• } f_0 \leftrightarrow Q_0 \text{（初期電荷）}"""),
  StepItem(tex: r"""\text{• } v_0 \leftrightarrow I_0 \text{（初期電流）}"""),
  StepItem(tex: r"""\textcolor{brown}{\large{【物理的意味】}}"""),
  StepItem(tex: r"""\text{• 包絡線: } e^{-\beta t} \text{ で指数的に減衰しながら振動}"""),
  StepItem(
  tex:
  r"""\text{• 振動周波数: } \sqrt{\omega_0^2 - \beta^2} \text{ （自然周波数より低い）}""",
  ),
  StepItem(tex: r"""\text{• 条件 } \omega_0 > \beta \text{ により減衰振動}"""),
  StepItem(tex: r"""\textcolor{brown}{\large{【解法】}}"""),
  StepItem(tex: r"""\textcolor{green}{f'の係数 Rが0の場合の公式}"""),
  StepItem(
  tex: r"""\text{微分方程式 } f''(t) = -\omega^2 f(t) \text{ に対する初期値問題}""",
  ),
  StepItem(tex: r"""f(0) = A_0,\quad f'(0) = v_0 \text{の解は}"""),
  StepItem(
  tex:
  r"""f(t) = A_0\cos(\omega t) + \displaystyle \frac{v_0}{\omega}\sin(\omega t) \text{である。}""",
  ),
   StepItem(tex: r"""\textcolor{blue}{この公式を用いて、本問を解く。}"""),
  StepItem(
  tex:
  r"""\textcolor{green}{1.\ } \textcolor{green}{変数変換で1階微分を消す}""",
  ),
  StepItem(tex: r"""\text{元の微分方程式の両辺に、}e^{\beta t}\text{を掛けると}"""),
  StepItem(
  tex: r"""\quad \ \ f''(t) + 2\beta f'(t) + \omega_0^2 f(t) = 0""",
  ),
  StepItem(
  tex:
  r""" \Leftrightarrow \textcolor{red}{e^{\beta t}f''(t)} + \textcolor{red}{2e^{\beta t} \beta f'(t)} +  e^{\beta t} \omega_0^2 f(t) = 0 \cdots (1)""",
  ),
  StepItem(tex: r"""\text{ここで、積の微分公式より、}"""),
  StepItem(
  tex:
  r"""\left(e^{\beta t}f(t)\right)''(t) = e^{\beta t}f''(t) + 2e^{\beta t} \beta f'(t) + e^{\beta t} \beta^2 f(t) """,
  ),
  StepItem(tex: r"""\text{が成り立つ。ゆえに、}"""),
  StepItem(tex: r"""\textcolor{red}{e^{\beta t}f''(t)} + \textcolor{red}{2e^{\beta t} \beta f'(t)} = \textcolor{blue}{\left(e^{\beta t}f(t)\right)''(t) - \beta^2 e^{\beta t}f(t)}"""),
  StepItem(tex: r"""\text{これを用いて置き換えると、}(1) \text{ は}"""),
  StepItem(
  tex:
  r"""\quad \ \textcolor{blue}{\left(e^{\beta t}f(t)\right)'' - \beta^2 e^{\beta t}f(t)} + \omega_0^2 e^{\beta t}f(t) = 0""",
  ),
  StepItem(
  tex:
  r"""\Leftrightarrow \left(e^{\beta t}f(t)\right)'' + \left(\omega_0^2 - \beta^2\right) e^{\beta t}f(t) = 0""",
  ),
  StepItem(
  tex:
  r"""\text{ここで、} g(t) = e^{\beta t} f(t) \text{ とおくと}""",
  ),
  StepItem(tex: r"""g''(t) + \left(\omega_0^2 - \beta^2\right) g(t) = 0\ \ \cdots (2)"""),
  StepItem(
  tex:
  r"""\textcolor{green}{2.\ } \textcolor{green}{公式を適用し} \textcolor{green}{g} \textcolor{green}{を求める}""",
  ),
  StepItem(tex: r"""\text{(2)は単振動の方程式なので、冒頭の公式を適用すると（}\omega = \sqrt{\omega_0^2 - \beta^2}\text{）}"""),
  StepItem(
  tex:
  r"""g(t) = g(0)\cos\left(\sqrt{\omega_0^2 - \beta^2}\ \,t\right) + \displaystyle \frac{g'(0)}{\sqrt{\omega_0^2 - \beta^2}}\sin\left(\sqrt{\omega_0^2 - \beta^2}\ \,t\right)""",
  ),
  StepItem(
  tex:
  r"""\textcolor{green}{3.\ } \textcolor{green}{g} \textcolor{green}{の初期条件を求める}""",
  ),
  StepItem(tex: r"""\text{ } g(t) = e^{\beta t} f(t) \text{ より}"""),
  StepItem(
  tex: r"""\begin{aligned}
  g(0) &= e^{\beta \cdot 0} f(0) = f_0\\[6pt]
  g'(0) &= \beta e^{\beta \cdot 0} f(0) + e^{\beta \cdot 0} f'(0) = \beta f_0 + v_0
  \end{aligned}""",
  ),
  StepItem(
  tex:
  r"""\textcolor{green}{4.\ } \textcolor{green}{g} \textcolor{green}{を求める}""",
  ),
  StepItem(tex: r"""\text{公式に代入すると}"""),
  StepItem(
  tex:
  r"""g(t) = f_0\cos\left(\sqrt{\omega_0^2 - \beta^2}\ \,t\right) + \displaystyle \frac{v_0 + \beta f_0}{\sqrt{\omega_0^2 - \beta^2}}\sin\left(\sqrt{\omega_0^2 - \beta^2}\ \,t\right)""",
  ),
  StepItem(
  tex:
  r"""\textcolor{green}{5.\ } \textcolor{green}{g} \textcolor{green}{から} \textcolor{green}{f} \textcolor{green}{を求める}""",
  ),
  StepItem(
  tex:
  r"""\text{ } g(t) = e^{\beta t} f(t) \text{ より、} f(t) = e^{-\beta t} g(t)""",
  ),
  StepItem(tex: r"""\text{よって}"""),
  StepItem(
  tex:
  r"""f(t) = e^{-\beta t}\left(f_0\cos\left(\sqrt{\omega_0^2 - \beta^2}\ \,t\right) + \displaystyle \frac{v_0 + \beta f_0}{\sqrt{\omega_0^2 - \beta^2}}\sin\left(\sqrt{\omega_0^2 - \beta^2}\ \,t\right)\right)""",
  ),
  ],
  ),

  // --- 過減衰（RLC自由：過減衰）一般 ---
  MathProblem(
    id: "7336BB06-1577-4C05-8048-358FE98E59A8",
  no: 13,
  category: '二階同次・定数係数（減衰）',
  level: '上級',
  question:
  r"""f''(t) + 2\gamma\,f'(t) + \omega_0^2 f(t) = 0,\quad f(0) = f_0,\ f'(0) = v_0""",
  answer:
  r"""\displaystyle f(t)=\displaystyle \frac{f_0\omega_h+(v_0+\gamma f_0)}{2\omega_h}e^{(-\gamma+\omega_h)t}+\displaystyle \frac{f_0\omega_h-(v_0+\gamma f_0)}{2\omega_h}e^{(-\gamma-\omega_h)t},\quad \omega_h:=\sqrt{\gamma^2-\omega_0^2}""",
  imageAsset: '',
  equation: r"""f''(t) + 2\gamma\,f'(t) + \omega_0^2 f(t) = 0""",
  conditions: r"""f(0)=f_0,\ f'(0)=v_0""",
  constants: r"""\gamma>0,\ \omega_0>0,\ \gamma>\omega_0""",
  keywords: ['一般', '大学'],
  hint: r"""\text{減衰項 } 2\gamma f' \text{ を消去するため、} e^{\gamma t} \text{ を両辺に掛けて変数変換し、無減衰の双曲線型方程式に帰着させる。}""",
  steps: [
  StepItem(tex: r"""\textcolor{brown}{\large{【力学】}}"""),
  StepItem(tex: r"""\text{• 過減衰の運動}"""),
  StepItem(
  tex:
  r"""\text{• 力学においては、} mx''(t) + 2cx'(t) + kx(t) = 0 \text{ の形でよく登場する。これは過減衰自由振動を表す。}""",
  ),
  StepItem(tex: r"""\textcolor{brown}{\large{【電磁気学】}}"""),
  StepItem(tex: r"""\text{• RLC回路の過減衰応答}"""),
  StepItem(
  tex:
  r"""\text{• 電磁気学においては、} LI'(t) + RI(t) + \displaystyle \frac{q(t)}{C} = 0 \text{ の形でよく登場する。これはRLC回路のキルヒホッフの法則を表す。}""",
  ),
  StepItem(tex: r"""\textcolor{brown}{\large{【問題の記号と力学における記号の対応】}}"""),
  StepItem(tex: r"""\text{過減衰の運動:} \ mx''(t) + 2cx'(t) + kx(t) = 0"""),
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
  StepItem(
  tex:
  r"""\text{• } \omega_h \leftrightarrow \sqrt{\displaystyle \frac{b^2}{4m^2} - \displaystyle \frac{k}{m}} \text{（過減衰角周波数）}""",
  ),
  StepItem(tex: r"""\text{• } f_0 \leftrightarrow x_0 \text{（初期位置）}"""),
  StepItem(tex: r"""\text{• } v_0 \leftrightarrow v_0 \text{（初期速度）}"""),
  StepItem(tex: r"""\textcolor{brown}{\large{【問題の記号と電磁気学における記号の対応】}}"""),
  StepItem(tex: r"""\text{RLC回路の過減衰応答:} \ Lq''(t) + Rq'(t) + \displaystyle \frac{q(t)}{C} = 0"""),
  StepItem(tex: r"""\text{• } f(t) \leftrightarrow q(t) \text{（電荷）}"""),
  StepItem(tex: r"""\text{• } f'(t) \leftrightarrow I(t) \text{（電流）}"""),
  StepItem(tex: r"""\text{• } f''(t) \leftrightarrow I' \text{（電流変化率）}"""),
  StepItem(
  tex:
  r"""\text{• } \gamma \leftrightarrow \displaystyle \frac{R}{2L} \text{（減衰係数）}""",
  ),
  StepItem(
  tex:
  r"""\text{• } \omega_0 \leftrightarrow \displaystyle \frac{1}{\sqrt{LC}} \text{（固有角周波数）}""",
  ),
  StepItem(
  tex:
  r"""\text{• } \omega_h \leftrightarrow \sqrt{\displaystyle \frac{R^2}{4L^2} - \displaystyle \frac{1}{LC}} \text{（過減衰角周波数）}""",
  ),
  StepItem(tex: r"""\text{• } f_0 \leftrightarrow q_0 \text{（初期電荷）}"""),
  StepItem(tex: r"""\text{• } v_0 \leftrightarrow I_0 \text{（初期電流）}"""),
  StepItem(tex: r"""\textcolor{brown}{\large{【解法】}}"""),
  StepItem(tex: r"""\textbf{【方針】}"""),
  StepItem(
  tex:
  r"""\text{減衰項 } 2\gamma f' \text{ を消去するため、} e^{\gamma t} \text{ を両辺に掛けて変数変換し、無減衰の双曲線型方程式に帰着させる。}""",
  ),
  StepItem(tex: r"""\text{同値変形の手順：}"""),
  StepItem(tex: r"""\text{1. } e^{\gamma t} \text{ を両辺に掛ける}"""),
  StepItem(tex: r"""\text{2. } (e^{\gamma t}f(t))'' \text{ の形に変形}"""),
  StepItem(tex: r"""\text{3. } y(t) = e^{\gamma t}f(t) \text{ と変数変換}"""),
  StepItem(
  tex: r"""\text{4. 双曲線型方程式 } y'' - \omega_h^2 y = 0 \text{ に帰着}""",
  ),

  StepItem(tex: r"""\textcolor{brown}{\large{【解法】}}"""),
  StepItem(tex: r"""f''(t) + 2\gamma f'(t) + \omega_0^2 f(t) = 0"""),
  StepItem(tex: r"""\text{変数変換：}y(t) = e^{\gamma t} f(t)\text{ とおくと、}"""),
  StepItem(
  tex:
  r"""\Leftrightarrow \ y''(t) - \omega_h^2 y(t) = 0 \quad (\omega_h = \sqrt{\gamma^2 - \omega_0^2})""",
  ),
  StepItem(tex: r"""\text{一般解：}"""),
  StepItem(
  tex:
  r"""\Leftrightarrow \ y(t) = C_1 e^{\omega_h t} + C_2 e^{-\omega_h t}""",
  ),
  StepItem(tex: r"""\text{初期条件を適用：}"""),
  StepItem(
  tex:
  r"""\Leftrightarrow \ C_1 = \displaystyle \frac{f_0\omega_h + (v_0 + \gamma f_0)}{2\omega_h}, \quad C_2 = \displaystyle \frac{f_0\omega_h - (v_0 + \gamma f_0)}{2\omega_h}""",
  ),
  StepItem(tex: r"""\text{元の変数に戻す：}"""),
  StepItem(
  tex:
  r"""\Leftrightarrow \ f(t) = \displaystyle \frac{f_0\omega_h + (v_0 + \gamma f_0)}{2\omega_h}e^{(-\gamma + \omega_h)t} + \displaystyle \frac{f_0\omega_h - (v_0 + \gamma f_0)}{2\omega_h}e^{(-\gamma - \omega_h)t}""",
  ),
  StepItem(tex: r"""\textcolor{brown}{\large{【力学】}}"""),
  StepItem(
  tex:
  r"""\text{• 力学においては、} mx''(t) + cx'(t) + kx(t) = 0 \text{ の形でよく登場する。これは過減衰運動を表す。}""",
  ),
  StepItem(tex: r"""\textcolor{brown}{\large{【電磁気学】}}"""),
  StepItem(
  tex:
  r"""\text{RLC 回路の過渡応答（過減衰）。減衰定数 }\gamma = \displaystyle \frac{R}{2L}\text{で指数関数的に収束する。}""",
  ),
  StepItem(
  tex:
  r"""\text{電磁気学においては、} Lq''(t) + Rq'(t) + \displaystyle \frac{q(t)}{C} = 0 \text{ の形でよく登場する。これはRLC回路の過減衰を表す。}""",
  ),
  StepItem(
  tex:
  r"""\text{インピーダンスの大きさは} |Z| = \sqrt{R^2 + \left(\omega L - \displaystyle \frac{1}{\omega C}\right)^2}\text{で、位相遅れ角}\alpha\text{は、}\alpha = \arctan\left(\displaystyle \frac{\omega L - \displaystyle \frac{1}{\omega C}}{R}\right)\text{となる。}""",
  ),
  StepItem(
  tex:
  r"""\text{共振周波数は}\omega_0 = \displaystyle \frac{1}{\sqrt{LC}}\text{で、}\gamma > \omega_0\text{のとき過減衰となる。}""",
  ),
  ],
  ),

  // --- 臨界減衰（RLC自由：臨界減衰） 一般---
  MathProblem(
    id: "0B9BFE1C-6950-40C5-BBAC-776B7F1E855F",
  no: 14,
  category: '二階同次・定数係数（減衰）',
  level: '上級',
  question:
  r"""f''(t) + 2\gamma\,f'(t) + \omega_0^2 f(t) = 0,\quad f(0) = A_0,\ f'(0) = v_0""",
  answer:
  r"""\displaystyle f(t)=e^{-\gamma t}\Bigl( A_0+(v_0+\gamma A_0)t\Bigr)""",
  imageAsset: '',
  hint: r"""\text{速度項 } 2\gamma f' \text{ を置換で消去して無減衰形に帰着し、そこからは単振動の標準公式を用いる。}""",
  equation: r"""f''(t) + 2\gamma\,f'(t) + \omega_0^2 f(t) = 0""",
  conditions: r"""f(0)=A_0,\ f'(0)=v_0""",
  constants: r"""\gamma>0,\ \omega_0>0,\ \gamma=\omega_0""",
  keywords: ['一般', '大学'],
  steps: [
  StepItem(tex: r"""\textcolor{brown}{\large{【力学】}}"""),
  StepItem(tex: r"""\text{• 減衰自由振動（臨界減衰）}"""),
  StepItem(
  tex:
  r"""\text{• 力学においては、} mx''(t) + 2cx'(t) + kx(t) = 0 \text{ の形でよく登場する。これは臨界減衰自由振動を表す。包絡は } e^{-\gamma t} \text{。}""",
  ),
  StepItem(tex: r"""\textcolor{brown}{\large{【電磁気学】}}"""),
  StepItem(tex: r"""\text{• RLC回路の過渡応答（臨界減衰）}"""),
  StepItem(
  tex:
  r"""\text{• 電磁気学においては、} LI'(t) + RI(t) + \displaystyle \frac{q(t)}{C} = 0 \text{ の形でよく登場する。これはRLC回路のキルヒホッフの法則を表す。} R,\ L,\ C(正の定数)\ \gamma=\omega_0=\sqrt{\tfrac{1}{LC}}\text{。}""",
  ),
  StepItem(tex: r"""\textcolor{brown}{\large{【問題の記号と力学における記号の対応】}}"""),
  StepItem(tex: r"""\text{臨界減衰の運動:} \ mx''(t) + 2cx'(t) + kx(t) = 0"""),
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
  StepItem(tex: r"""\text{• } A_0 \leftrightarrow x_0 \text{（初期位置）}"""),
  StepItem(tex: r"""\text{• } v_0 \leftrightarrow v_0 \text{（初期速度）}"""),
  StepItem(tex: r"""\textcolor{brown}{\large{【問題の記号と電磁気学における記号の対応】}}"""),
  StepItem(tex: r"""\text{RLC回路の臨界減衰応答:} \ Lq''(t) + Rq'(t) + \displaystyle \frac{q(t)}{C} = 0"""),
  StepItem(tex: r"""\text{• } f(t) \leftrightarrow q(t) \text{（電荷）}"""),
  StepItem(tex: r"""\text{• } f'(t) \leftrightarrow I(t) \text{（電流）}"""),
  StepItem(tex: r"""\text{• } f''(t) \leftrightarrow I' \text{（電流変化率）}"""),
  StepItem(
  tex:
  r"""\text{• } \gamma \leftrightarrow \displaystyle \frac{R}{2L} \text{（減衰係数）}""",
  ),
  StepItem(
  tex:
  r"""\text{• } \omega_0 \leftrightarrow \displaystyle \frac{1}{\sqrt{LC}} \text{（固有角周波数）}""",
  ),
  StepItem(tex: r"""\text{• } A_0 \leftrightarrow q_0 \text{（初期電荷）}"""),
  StepItem(tex: r"""\text{• } v_0 \leftrightarrow I_0 \text{（初期電流）}"""),
  StepItem(tex: r"""\textcolor{brown}{\large{【解法】}}"""),
  StepItem(tex: r"""\text{【方針】}"""),
  StepItem(
  tex:
  r"""\text{速度項 } 2\gamma f' \text{ を置換で消去して無減衰形に帰着し、そこからは単振動の標準公式を用いる。}""",
  ),

  StepItem(tex: r"""\textbf{1. 一次項の除去}"""),
  StepItem(tex: r"""\textbf{1.1 両辺に}e^{\gamma t}\text{をかける}"""),
  StepItem(
  tex:
  r"""f''+2\gamma f'+\omega_0^2 f=0 \quad \Leftrightarrow\quad e^{\gamma t}(f''+2\gamma f'+\omega_0^2 f)=0""",
  ),
  StepItem(tex: r"""\textbf{1.2 積の微分公式の適用}"""),
  StepItem(
  tex:
  r"""\text{積の微分公式 } (e^{\gamma t}f)'=e^{\gamma t}(f'+\gamma f) \text{ より}""",
  ),
  StepItem(
  tex:
  r"""\text{ } (e^{\gamma t}f)''=e^{\gamma t}(f''+2\gamma f'+\gamma^2 f) \text{ なので}""",
  ),
  StepItem(
  tex:
  r"""e^{\gamma t}(f''+2\gamma f'+\omega_0^2 f)=(e^{\gamma t}f)''-(\gamma^2-\omega_0^2)(e^{\gamma t}f)=0""",
  ),
  StepItem(tex: r"""\textbf{1.3 変数変換}"""),
  StepItem(
  tex: r"""y(t):=e^{\gamma t}f(t) \text{ とおくと } y''=0 \quad \cdots (1)""",
  ),
  StepItem(
  tex:
  r"""\textbf{1.4 臨界減衰の特徴} \quad \gamma=\omega_0 \text{ より } \gamma^2-\omega_0^2=0 \text{ である。}""",
  ),

  StepItem(tex: r"""\textbf{2. 線形関数の標準公式の適用}"""),
  StepItem(tex: r"""\textbf{2.1 標準公式}"""),
  StepItem(
  tex:
  r"""\text{ } y''=0 \quad \Rightarrow\quad y(t)=y(0)+y'(0)t \quad \text{（公式）。}""",
  ),
  StepItem(tex: r"""\textbf{2.2 初期値の写像}"""),
  StepItem(
  tex:
  r"""\text{ } y=e^{\gamma t}f \text{ なので } y(0)=A_0,\ y'(0)=v_0+\gamma A_0 \quad \cdots (2)""",
  ),
  StepItem(tex: r"""\textbf{2.3 公式への代入}"""),
  StepItem(
  tex:
  r"""\text{(1) より } y''=0 \text{ とし、(2) を代入すると } y(t)=A_0+(v_0+\gamma A_0)t""",
  ),
  StepItem(tex: r"""\textbf{2.4 元の変数へ戻して解を得る}"""),
  StepItem(
  tex: r"""\text{ } 
  \begin{aligned}
  f(t)&=e^{-\gamma t}y(t)\\[6pt]
  &=e^{-\gamma t}\Bigl( A_0+(v_0+\gamma A_0)t\Bigr)
  \end{aligned}
  """,
  ),

  // StepItem(tex: r"""\textbf{3. 検算（丁寧版）}"""),
  // StepItem(tex: r"""\textbf{(i) 方程式の確認}"""),
  // StepItem(tex: r"""f=e^{-\gamma t}y,\quad f'=e^{-\gamma t}(y'-\gamma y),\quad f''=e^{-\gamma t}(y''-2\gamma y'+\gamma^2 y)"""),
  // StepItem(tex: r"""f''+2\gamma f'+\omega_0^2 f=e^{-\gamma t}\bigl[y''-(\gamma^2-\omega_0^2)y\bigr]=e^{-\gamma t}(y''-0\cdot y)=0"""),
  // StepItem(tex: r"""\textbf{(ii) 初期条件の確認}"""),
  // StepItem(tex: r"""f(0)=y(0)=A_0,\quad f'(0)=y'(0)-\gamma y(0)=(v_0+\gamma A_0)-\gamma A_0=v_0 \quad \text{で一致。}"""),
  // StepItem(tex: r"""\textbf{(iii) エネルギー減衰の確認}"""),
  // StepItem(tex: r"""\text{擬エネルギー } E=\tfrac12 f'(t)^2+\tfrac12 \omega_0^2 f(t)^2 \text{ に対し } E'=f'f''+\omega_0^2 f f'=-2\gamma\,f'(t)^2\le 0 \quad \text{。包絡 } e^{-\gamma t} \text{ と整合。}"""),
  ],
  ),

  //   // --- 減衰振動（RLC自由 数値：不足減衰） ---
  MathProblem(
    id: "1D342CB8-24CD-40BB-A3EA-06BB6AFC1845",
  no: 112,
  category: '二階同次・定数係数（減衰）',
  level: '上級',
  question: r"""f''(t) + 6\,f'(t) + 10\,f(t) = 0,\quad f(0) = 1,\ f'(0) = 2""",
  answer:
  r"""\displaystyle f(t)=e^{-3t}\left(\cos(t)+5\sin(t)\right)""",
  imageAsset: '',
  equation: r"""f''(t) + 6\,f'(t) + 10\,f(t) = 0""",
  conditions: r"""f(0)=1,\ f'(0)=2""",
  keywords: ['数値', '電圧0', 'コンデンサ', 'コイル', '抵抗'],
  steps: [
  StepItem(tex: r"""\textcolor{brown}{\large{【電磁気学】}}"""),
  StepItem(tex: r"""\text{• RLC直列回路について、キルヒホッフの第二法則を用いると }
  LQ''(t) + RQ'(t) + \displaystyle \frac{Q(t)}{C} = 0 \text{が成り立つ。}"""),
  StepItem(tex: r"""\textcolor{brown}{\large{【問題の記号と電磁気学における記号の対応】}}"""),
  StepItem(tex: r"""\text{RLC直列回路の過渡応答:} \ LQ''(t) + RQ'(t) + \displaystyle \frac{Q(t)}{C} = 0"""),
  StepItem(tex: r"""\text{• } f(t) \leftrightarrow Q(t) \text{（コンデンサに蓄えられた電荷）}"""),
  StepItem(tex: r"""\text{• } f'(t) \leftrightarrow Q'(t) \text{（電流）}"""),
  StepItem(tex: r"""\text{• } f''(t) \leftrightarrow Q''(t) \text{（電流変化率）}"""),
  StepItem(
  tex:
  r"""\text{• } \dfrac {6} {2 \cdot 1} = 3 \leftrightarrow \displaystyle \frac{R}{2L} \text{（減衰定数）}""",
  ),
  StepItem(
  tex:
  r"""\text{• } \dfrac {1}{\sqrt{1 \cdot \frac {1} {10}}} = \sqrt{10} \leftrightarrow \displaystyle \frac{1}{\sqrt{LC}} \text{（減衰定数が0の場合の固有角周波数）}""",
  ),
  StepItem(
  tex:
  r"""\text{• } \sqrt{\frac {1} {1 \cdot \frac {1} {10}} -  \left(\frac {6} {2 \cdot 1}\right) ^2} = 1 \leftrightarrow \sqrt{\displaystyle \frac{1}{LC} - \left(\displaystyle \frac{R}{2L}\right)^2} \text{（減衰角周波数）}""",
  ),
  StepItem(tex: r"""\text{• } 1 \leftrightarrow Q_0 \text{（初期電荷）}"""),
  StepItem(tex: r"""\text{• } 2 \leftrightarrow I_0 \text{（初期電流）}"""),
  StepItem(tex: r"""\textcolor{brown}{\large{【物理的意味】}}"""),
  StepItem(tex: r"""\text{• 包絡線: } e^{-\frac {6} {2 \cdot 1} t} = e^{-3t} \text{ で指数的に減衰しながら振動}"""),
  StepItem(
  tex:
  r"""\text{• 振動周波数: } \sqrt{10 -  \left(\frac {6} {2 \cdot 1}\right) ^2} = 1 \text{ （自然周波数}\sqrt{10}\text{より低い）}""",
  ),
  StepItem(tex: r"""\text{• 条件 }\sqrt{10} > \dfrac {6} {2 \cdot 1} = 3 \text{ により減衰振動}"""),
  StepItem(tex: r"""\textcolor{brown}{\large{【解法】}}"""),
  StepItem(tex: r"""\textcolor{green}{f'の係数 Rが0の場合の公式}"""),
  StepItem(
  tex: r"""\text{微分方程式 } f''(t) = -\omega^2 f(t) \text{ に対する初期値問題}""",
  ),
  StepItem(tex: r"""f(0) = A_0,\quad f'(0) = v_0 \text{の解は}"""),
  StepItem(
  tex:
  r"""f(t) = A_0\cos(\omega t) + \displaystyle \frac{v_0}{\omega}\sin(\omega t) \text{である。}""",
  ),
  StepItem(tex: r"""\textcolor{blue}{この公式を用いて、本問を解く。}"""),
  StepItem(
  tex:
  r"""\textcolor{green}{1.\ } \textcolor{green}{変数変換で1階微分を消す}""",
  ),
  StepItem(tex: r"""\text{元の微分方程式 }f''(t) + 6f'(t) + 10f(t) = 0\text{ の両辺に、}e^{3t}\text{を掛けると}"""),
  StepItem(
  tex:
  r""" \Leftrightarrow \textcolor{red}{e^{3t}f''(t)} + \textcolor{red}{6e^{3t} f'(t)} +  10e^{3t} f(t) = 0 \cdots (1)""",
  ),
  StepItem(tex: r"""\text{ここで、積の微分公式より、}"""),
  StepItem(
  tex:
  r"""\left(e^{3t}f(t)\right)''(t) = e^{3t}f''(t) + 6e^{3t} f'(t) + 9e^{3t} f(t) """,
  ),
  StepItem(tex: r"""\text{が成り立つ。ゆえに、}"""),
  StepItem(tex: r"""\textcolor{red}{e^{3t}f''(t)} + \textcolor{red}{6e^{3t} f'(t)} = \textcolor{blue}{\left(e^{3t}f(t)\right)''(t) - 9e^{3t}f(t)}"""),
  StepItem(tex: r"""\text{これを用いて置き換えると、}(1) \text{ は}"""),
  StepItem(
  tex:
  r"""\quad \ \textcolor{blue}{\left(e^{3t}f(t)\right)'' - 9e^{3t}f(t)} + 10e^{3t}f(t) = 0""",
  ),
  StepItem(
  tex:
  r"""\Leftrightarrow \left(e^{3t}f(t)\right)'' + e^{3t}f(t) = 0""",
  ),
  StepItem(
  tex:
  r"""\text{ここで、} g(t) = e^{3t} f(t) \text{ とおくと}""",
  ),
  StepItem(tex: r"""g''(t) + g(t) = 0\ \ \cdots (2)"""),
  StepItem(
  tex:
  r"""\textcolor{green}{2.\ } \textcolor{green}{公式を適用し} \textcolor{green}{g} \textcolor{green}{を求める}""",
  ),
  StepItem(tex: r"""\text{(2)は単振動の方程式なので、冒頭の公式を適用すると（}\omega = 1\text{）}"""),
  StepItem(
  tex:
  r"""g(t) = g(0)\cos(t) + \displaystyle \frac{g'(0)}{1}\sin(t) = g(0)\cos(t) + g'(0)\sin(t)""",
  ),
  StepItem(
  tex:
  r"""\textcolor{green}{3.\ } \textcolor{green}{g} \textcolor{green}{の初期条件を求める}""",
  ),
  StepItem(tex: r"""\text{ } g(t) = e^{3t} f(t) \text{ より}"""),
  StepItem(
  tex: r"""\begin{aligned}
  g(0) &= e^{0} f(0) = 1\\[6pt]
  g'(0) &= 3e^{0} f(0) + e^{0} f'(0) = 3 \cdot 1 + 2 = 5
  \end{aligned}""",
  ),
  StepItem(
  tex:
  r"""\textcolor{green}{4.\ } \textcolor{green}{g} \textcolor{green}{を求める}""",
  ),
  StepItem(tex: r"""\text{公式に代入すると}"""),
  StepItem(
  tex:
  r"""g(t) = 1 \cdot \cos(t) + 5 \cdot \sin(t) = \cos(t) + 5\sin(t)""",
  ),
  StepItem(
  tex:
  r"""\textcolor{green}{5.\ } \textcolor{green}{g} \textcolor{green}{から} \textcolor{green}{f} \textcolor{green}{を求める}""",
  ),
  StepItem(
  tex:
  r"""\text{ } g(t) = e^{3t} f(t) \text{ より、} f(t) = e^{-3t} g(t)""",
  ),
  StepItem(tex: r"""\text{よって}"""),
  StepItem(
  tex:
  r"""f(t) = e^{-3t}\left(\cos(t) + 5\sin(t)\right)""",
  ),
  ],
  ),

  //   // --- 過減衰（RLC自由 数値：過減衰） 数値---
  MathProblem(
    id: "965D1819-D776-42C7-84DB-BDF8D5354E74",
  no: 113,
  category: '二階同次・定数係数（減衰）',
  level: '上級',
  question:
  r"""f''(t) + 10\,f'(t) + 9\,f(t) = 0,\quad f(0) = 2,\ f'(0) = 1""",
  answer: r"""\displaystyle f(t)=\dfrac{19}{8}e^{-t}-\dfrac{3}{8}e^{-9t}""",
  imageAsset: '',
  equation: r"""f''(t) + 10\,f'(t) + 9\,f(t) = 0""",
  conditions: r"""f(0)=2,\ f'(0)=1""",
  keywords: ['数値', '大学'],
  hint: r"""\text{速度項 } 10f' \text{ を置換で消去して無減衰形に帰着し、そこからは単振動の標準公式を用いる。}""",
  steps: [
  StepItem(tex: r"""\textcolor{brown}{\large{【力学】}}"""),
  StepItem(tex: r"""\text{• 過減衰の運動}"""),
  StepItem(
  tex:
  r"""\text{• 力学においては、} mx''(t) + 2cx'(t) + kx(t) = 0 \text{ の形でよく登場する。これは過減衰自由振動を表す。包絡は } e^{-5t}\text{。}""",
  ),
  StepItem(tex: r"""\textcolor{brown}{\large{【電磁気学】}}"""),
  StepItem(tex: r"""\text{• RLC回路の過減衰応答}"""),
  StepItem(
  tex:
  r"""\text{• 電磁気学においては、} LI'(t) + RI(t) + \displaystyle \frac{q(t)}{C} = 0 \text{ の形でよく登場する。これはRLC回路のキルヒホッフの法則を表す。} R=10,\ L=1,\ C=\tfrac{1}{9},\ \omega_h=\sqrt{\bigl(\tfrac{R}{2L}\bigr)^2-\tfrac{1}{LC}}=\sqrt{5^2-3^2}=4\text{。}""",
  ),
  StepItem(tex: r"""\textcolor{brown}{\large{【問題の記号と力学における記号の対応】}}"""),
  StepItem(tex: r"""\text{過減衰の運動:} \ mx''(t) + 2cx'(t) + kx(t) = 0"""),
  StepItem(tex: r"""\text{• } f(t) \leftrightarrow x(t) \text{（位置）}"""),
  StepItem(tex: r"""\text{• } f'(t) \leftrightarrow v(t) \text{（速度）}"""),
  StepItem(tex: r"""\text{• } f''(t) \leftrightarrow a(t) \text{（加速度）}"""),
  StepItem(
  tex:
  r"""\text{• } \gamma \leftrightarrow \displaystyle \frac{2c}{m} \text{（減衰係数、}\gamma = 5\text{）}""",
  ),
  StepItem(
  tex:
  r"""\text{• } \omega_0 \leftrightarrow \sqrt{\displaystyle \frac{k}{m}} \text{（固有角周波数、}\omega_0 = 3\text{）}""",
  ),
  StepItem(
  tex:
  r"""\text{• } \omega_h \leftrightarrow \sqrt{\displaystyle \frac{b^2}{4m^2} - \displaystyle \frac{k}{m}} \text{（過減衰角周波数、}\omega_h = 4\text{）}""",
  ),
  StepItem(tex: r"""\text{• } f(0) \leftrightarrow x_0 \text{（初期位置、}f(0) = 2\text{）}"""),
  StepItem(tex: r"""\text{• } f'(0) \leftrightarrow v_0 \text{（初期速度、}f'(0) = 1\text{）}"""),
  StepItem(tex: r"""\textcolor{brown}{\large{【問題の記号と電磁気学における記号の対応】}}"""),
  StepItem(tex: r"""\text{RLC回路の過減衰応答:} \ Lq''(t) + Rq'(t) + \displaystyle \frac{q(t)}{C} = 0"""),
  StepItem(tex: r"""\text{• } f(t) \leftrightarrow q(t) \text{（電荷）}"""),
  StepItem(tex: r"""\text{• } f'(t) \leftrightarrow I(t) \text{（電流）}"""),
  StepItem(tex: r"""\text{• } f''(t) \leftrightarrow I' \text{（電流変化率）}"""),
  StepItem(
  tex:
  r"""\text{• } \gamma \leftrightarrow \displaystyle \frac{R}{2L} \text{（減衰係数、}\gamma = 5\text{）}""",
  ),
  StepItem(
  tex:
  r"""\text{• } \omega_0 \leftrightarrow \displaystyle \frac{1}{\sqrt{LC}} \text{（固有角周波数、}\omega_0 = 3\text{）}""",
  ),
  StepItem(
  tex:
  r"""\text{• } \omega_h \leftrightarrow \sqrt{\displaystyle \frac{R^2}{4L^2} - \displaystyle \frac{1}{LC}} \text{（過減衰角周波数、}\omega_h = 4\text{）}""",
  ),
  StepItem(tex: r"""\text{• } f(0) \leftrightarrow q_0 \text{（初期電荷、}f(0) = 2\text{）}"""),
  StepItem(tex: r"""\text{• } f'(0) \leftrightarrow I_0 \text{（初期電流、}f'(0) = 1\text{）}"""),
  StepItem(tex: r"""\textcolor{brown}{\large{【解法】}}"""),
  StepItem(tex: r"""\text{【方針】}"""),
  StepItem(
  tex:
  r"""\text{速度項 } 10f' \text{ を置換で消去して無減衰形に帰着し、そこからは単振動の標準公式を用いる。}""",
  ),

  StepItem(tex: r"""\textbf{1. 一次項の除去}"""),
  StepItem(tex: r"""\textbf{1.1 両辺に}e^{5t}\text{をかける}"""),
  StepItem(
  tex:
  r"""f''+10f'+9f=0 \quad \Leftrightarrow\quad e^{5t}(f''+10f'+9f)=0""",
  ),
  StepItem(tex: r"""\textbf{1.2 積の微分公式の適用}"""),
  StepItem(tex: r"""\text{積の微分公式 } (e^{5t}f)'=e^{5t}(f'+5f) \text{ より}"""),
  StepItem(
  tex: r"""\text{ } (e^{5t}f)''=e^{5t}(f''+10f'+25f) \text{ なので}""",
  ),
  StepItem(
  tex:
  r"""e^{5t}(f''+10f'+9f)=(e^{5t}f)''-(25-9)(e^{5t}f)=(e^{5t}f)''-16(e^{5t}f)=0""",
  ),
  StepItem(tex: r"""\textbf{1.3 変数変換}"""),
  StepItem(
  tex: r"""y(t):=e^{5t}f(t) \text{ とおくと } y''-16\,y=0 \quad \cdots (1)""",
  ),
  StepItem(
  tex:
  r"""\textbf{1.4 記号の導入} \quad \omega_h:=\sqrt{5^2-3^2}=4\ (正の定数) \text{ とおく（オーバーダンピング）。}""",
  ),

  StepItem(tex: r"""\textbf{2. 指数関数の標準公式の適用}"""),
  StepItem(tex: r"""\textbf{2.1 標準公式}"""),
  StepItem(
  tex:
  r"""\text{ } y''-16 y=0 \quad \Rightarrow\quad y(t)=C_1 e^{4t}+C_2 e^{-4t} \quad \text{（公式）。}""",
  ),
  StepItem(tex: r"""\textbf{2.2 初期値の写像}"""),
  StepItem(
  tex:
  r"""\text{ } y=e^{5t}f \text{ なので } y(0)=2,\ y'(0)=1+5\cdot 2=11 \quad \cdots (2)""",
  ),
  StepItem(tex: r"""\textbf{2.3 係数の決定}"""),
  StepItem(tex: r"""\text{初期条件 } y(0)=2,\ y'(0)=11 \text{ より}"""),
  StepItem(tex: r"""\text{ } y(0)=C_1+C_2=2,\quad y'(0)=4C_1-4C_2=11"""),
  StepItem(
  tex:
  r"""\text{ } C_1=\dfrac{2+\dfrac{11}{4}}{2}=\dfrac{19}{8},\quad C_2=\dfrac{2-\dfrac{11}{4}}{2}=-\dfrac{3}{8}""",
  ),
  StepItem(
  tex: r"""\text{ } y(t)=\dfrac{19}{8}e^{4t}-\dfrac{3}{8}e^{-4t}""",
  ),
  StepItem(tex: r"""\textbf{2.4 元の変数へ戻して解を得る}"""),
  StepItem(
  tex: r"""\text{ } 
  \begin{aligned}
  f(t)&=e^{-5t}y(t)\\[6pt]
  &=e^{-5t}\Bigl(\dfrac{19}{8}e^{4t}-\dfrac{3}{8}e^{-4t}\Bigr)\\[6pt]
  &=\dfrac{19}{8}e^{-t}-\dfrac{3}{8}e^{-9t}
  \end{aligned}
  """,
  ),

  // StepItem(tex: r"""\textbf{3. 検算（丁寧版）}"""),
  // StepItem(tex: r"""\textbf{(i) 方程式の確認}"""),
  // StepItem(tex: r"""f=e^{-2t}y,\quad f'=e^{-2t}(y'-2y),\quad f''=e^{-2t}(y''-4y'+4y)"""),
  // StepItem(tex: r"""f''+4f'+2f=e^{-2t}\bigl[y''-(4-2)y\bigr]=e^{-2t}(y''-2 y)=0"""),
  // StepItem(tex: r"""\textbf{(ii) 初期条件の確認}"""),
  // StepItem(tex: r"""f(0)=y(0)=1,\quad f'(0)=y'(0)-2y(0)=2-2\cdot 1=0 \quad \text{で一致。}"""),
  // StepItem(tex: r"""\textbf{(iii) エネルギー減衰の確認}"""),
  // StepItem(tex: r"""\text{擬エネルギー } E=\tfrac12 f'(t)^2+\tfrac12 \cdot 2 f(t)^2 \text{ に対し } E'=f'f''+2 f f'=-4\,f'(t)^2\le 0 \quad \text{。包絡 } e^{-2t} \text{ と整合。}"""),
  ],
  ),

  //   // --- 臨界減衰（RLC自由 数値：臨界減衰） 数値---
  MathProblem(
    id: "75BB6EAE-4EB6-4F88-9A4D-F56E759E706D",
  no: 114,
  category: '二階同次・定数係数（減衰）',
  level: '上級',
  question: r"""f''(t) + 4\,f'(t) + 4\,f(t) = 0,\quad f(0) = 1,\ f'(0) = 2""",
  answer: r"""\displaystyle f(t)=e^{-2t}(1+4t)""",
  imageAsset: '',
  equation: r"""f''(t) + 4\,f'(t) + 4\,f(t) = 0""",
  conditions: r"""f(0)=1,\ f'(0)=2""",
  keywords: ['数値','大学'],
  steps: [
  StepItem(tex: r"""\textcolor{brown}{\large{【力学】}}"""),
  StepItem(tex: r"""\text{• 減衰自由振動（臨界減衰）}"""),
  StepItem(
  tex:
  r"""\text{• 力学においては、} mx''(t) + 2cx'(t) + kx(t) = 0 \text{ の形でよく登場する。これは臨界減衰自由振動を表す。包絡は } e^{-2t}\text{。}""",
  ),
  StepItem(tex: r"""\textcolor{brown}{\large{【電磁気学】}}"""),
  StepItem(tex: r"""\text{• RLC回路の過渡応答（臨界減衰）}"""),
  StepItem(
  tex:
  r"""\text{• 電磁気学においては、} LI'(t) + RI(t) + \displaystyle \frac{q(t)}{C} = 0 \text{ の形でよく登場する。これはRLC回路のキルヒホッフの法則を表す。} R=4,\ L=1,\ C=\tfrac{1}{4},\ \gamma=\omega_0=\sqrt{\tfrac{1}{LC}}=2\text{。}""",
  ),
  StepItem(tex: r"""\textcolor{brown}{\large{【問題の記号と力学における記号の対応】}}"""),
  StepItem(tex: r"""\text{臨界減衰の運動:} \ mx''(t) + 2cx'(t) + kx(t) = 0"""),
  StepItem(tex: r"""\text{• } f(t) \leftrightarrow x(t) \text{（位置）}"""),
  StepItem(tex: r"""\text{• } f'(t) \leftrightarrow v(t) \text{（速度）}"""),
  StepItem(tex: r"""\text{• } f''(t) \leftrightarrow a(t) \text{（加速度）}"""),
  StepItem(
  tex:
  r"""\text{• } \gamma \leftrightarrow \displaystyle \frac{2c}{m} \text{（減衰係数、}\gamma = 2\text{）}""",
  ),
  StepItem(
  tex:
  r"""\text{• } \omega_0 \leftrightarrow \sqrt{\displaystyle \frac{k}{m}} \text{（固有角周波数、}\omega_0 = 2\text{）}""",
  ),
  StepItem(tex: r"""\text{• } f(0) \leftrightarrow x_0 \text{（初期位置、}f(0) = 1\text{）}"""),
  StepItem(tex: r"""\text{• } f'(0) \leftrightarrow v_0 \text{（初期速度、}f'(0) = 2\text{）}"""),
  StepItem(tex: r"""\textcolor{brown}{\large{【問題の記号と電磁気学における記号の対応】}}"""),
  StepItem(tex: r"""\text{RLC回路の臨界減衰応答:} \ Lq''(t) + Rq'(t) + \displaystyle \frac{q(t)}{C} = 0"""),
  StepItem(tex: r"""\text{• } f(t) \leftrightarrow q(t) \text{（電荷）}"""),
  StepItem(tex: r"""\text{• } f'(t) \leftrightarrow I(t) \text{（電流）}"""),
  StepItem(tex: r"""\text{• } f''(t) \leftrightarrow I' \text{（電流変化率）}"""),
  StepItem(
  tex:
  r"""\text{• } \gamma \leftrightarrow \displaystyle \frac{R}{2L} \text{（減衰係数、}\gamma = 2\text{）}""",
  ),
  StepItem(
  tex:
  r"""\text{• } \omega_0 \leftrightarrow \displaystyle \frac{1}{\sqrt{LC}} \text{（固有角周波数、}\omega_0 = 2\text{）}""",
  ),
  StepItem(tex: r"""\text{• } f(0) \leftrightarrow q_0 \text{（初期電荷、}f(0) = 1\text{）}"""),
  StepItem(tex: r"""\text{• } f'(0) \leftrightarrow I_0 \text{（初期電流、}f'(0) = 2\text{）}"""),
  StepItem(tex: r"""\textcolor{brown}{\large{【解法】}}"""),
  StepItem(tex: r"""\text{【方針】}"""),
  StepItem(
  tex: r"""\text{速度項 } 4f' \text{ を置換で消去して無減衰形に帰着し、そこからは単振動の標準公式を用いる。}""",
  ),

  StepItem(tex: r"""\textbf{1. 一次項の除去}"""),
  StepItem(tex: r"""\textbf{1.1 両辺に}e^{2t}\text{をかける}"""),
  StepItem(
  tex:
  r"""f''+4f'+4f=0 \quad \Leftrightarrow\quad e^{2t}(f''+4f'+4f)=0""",
  ),
  StepItem(tex: r"""\textbf{1.2 積の微分公式の適用}"""),
  StepItem(tex: r"""\text{積の微分公式 } (e^{2t}f)'=e^{2t}(f'+2f) \text{ より}"""),
  StepItem(tex: r"""\text{ } (e^{2t}f)''=e^{2t}(f''+4f'+4f) \text{ なので}"""),
  StepItem(tex: r"""e^{2t}(f''+4f'+4f)=(e^{2t}f)''-(4-4)(e^{2t}f)=0"""),
  StepItem(tex: r"""\textbf{1.3 変数変換}"""),
  StepItem(
  tex: r"""y(t):=e^{2t}f(t) \text{ とおくと } y''=0 \quad \cdots (1)""",
  ),
  StepItem(
  tex:
  r"""\textbf{1.4 臨界減衰の特徴} \quad \gamma=2=\omega_0=2 \text{ より } \gamma^2-\omega_0^2=4-4=0 \text{ である。}""",
  ),

  StepItem(tex: r"""\textbf{2. 線形関数の標準公式の適用}"""),
  StepItem(tex: r"""\textbf{2.1 標準公式}"""),
  StepItem(
  tex:
  r"""\text{ } y''=0 \quad \Rightarrow\quad y(t)=y(0)+y'(0)t \quad \text{（公式）。}""",
  ),
  StepItem(tex: r"""\textbf{2.2 初期値の写像}"""),
  StepItem(
  tex:
  r"""\text{ } y=e^{2t}f \text{ なので } y(0)=1,\ y'(0)=2+2\cdot 1=4 \quad \cdots (2)""",
  ),
  StepItem(tex: r"""\textbf{2.3 公式への代入}"""),
  StepItem(
  tex: r"""\text{(1) より } y''=0 \text{ とし、(2) を代入すると } y(t)=1+4t""",
  ),
  StepItem(tex: r"""\textbf{2.4 元の変数へ戻して解を得る}"""),
  StepItem(
  tex: r"""\text{ } \begin{aligned}
  f(t)&=e^{-2t}y(t)\\[6pt]
  &=e^{-2t}\Bigl( 1+4t\Bigr)
  \end{aligned}""",
  ),

  // StepItem(tex: r"""\textbf{3. 検算（丁寧版）}"""),
  // StepItem(tex: r"""\textbf{(i) 方程式の確認}"""),
  // StepItem(tex: r"""f=e^{-2t}y,\quad f'=e^{-2t}(y'-2y),\quad f''=e^{-2t}(y''-4y'+4y)"""),
  // StepItem(tex: r"""f''+4f'+4f=e^{-2t}\bigl[y''-(4-4)y\bigr]=e^{-2t}(y''-0\cdot y)=0"""),
  // StepItem(tex: r"""\textbf{(ii) 初期条件の確認}"""),
  // StepItem(tex: r"""f(0)=y(0)=1,\quad f'(0)=y'(0)-2y(0)=4-2\cdot 1=2 \quad \text{で一致。}"""),
  // StepItem(tex: r"""\textbf{(iii) エネルギー減衰の確認}"""),
  // StepItem(tex: r"""\text{擬エネルギー } E=\tfrac12 f'(t)^2+\tfrac12 \cdot 4 f(t)^2 \text{ に対し } E'=f'f''+4 f f'=-4\,f'(t)^2\le 0 \quad \text{。包絡 } e^{-2t} \text{ と整合。}"""),
  ],
  ),
];

// trigonometric_limits.dart
// 三角関数極限問題集（5問）


import '../../models/math_problem.dart';
import '../../models/step_item.dart';

const mean_value_theorem_limit = <MathProblem>[
  MathProblem(
  id: "9D8F2E21-0F37-4C8B-A5B4-7A4F2B3A0C11",
  no: 1,
  category: '平均値の定理の極限',
  level: '中級',
  question: r"""\displaystyle \lim_{x\to 0}\frac{\cos x-\cos x^2}{x-x^2}""",
  answer: r"""\displaystyle 0""",
  steps: [
    StepItem(tex: r"""\color{black}\textbf{【方針】}"""),
    StepItem(tex: r"""\color{black}\cos\text{ に平均値の定理を使う。}"""),

    StepItem(tex: r"""\color{black}\textbf{【平均値の定理】}"""),
    StepItem(tex: r"""\color{black}\text{関数 }f\text{ が区間 }[a,b]\text{ で連続、}a\text{ と }b\text{ の間で微分可能なら、}"""),
    StepItem(tex: r"""\color{black}f(b)-f(a)=f'(c)(b-a)\text{ となる実数 }c\text{ が }a\text{ と }b\text{ の間に存在する。}"""),

    StepItem(tex: r"""\color{black}\textbf{【適用】}"""),
    StepItem(tex: r"""\color{black}f(t)=\cos t\text{ とおくと }f'(t)=-\sin t\text{。}"""),
    StepItem(tex: r"""\color{black}\text{ }a=x^2,\ b=x\text{ として平均値の定理を用いる。}"""),
    StepItem(tex: r"""\color{black}\text{すると }"""),
    StepItem(tex: r"""\color{black}\cos x-\cos x^2 = (-\sin c)(x-x^2)\text{ となる実数 }c\text{ が }x\text{ と }x^2\text{ の間に存在する。}"""),

    StepItem(tex: r"""\color{black}\textbf{【よって】}"""),
    StepItem(tex: r"""\color{black}\frac{\cos x-\cos x^2}{x-x^2}=-\sin c"""),

    StepItem(tex: r"""\color{black}\textbf{【左右からの確認】}"""),
    StepItem(tex: r"""\color{black}\text{(1) }x>0\text{ のとき }x^2\text{ は }x\text{ より小さいので、}c\text{ は }x^2\text{ と }x\text{ の間にある。}"""),
    StepItem(tex: r"""\color{black}\text{(2) }x<0\text{ のとき }x\text{ は }x^2\text{ より小さいので、}c\text{ は }x\text{ と }x^2\text{ の間にある。}"""),
    StepItem(tex: r"""\color{black}\text{どちらの場合も }x\to0\text{ なら }x^2\to0\text{ なので、}c\text{ も }0\text{ に近づく。}"""),

    StepItem(tex: r"""\color{black}\sin\text{ は連続だから }-\sin c\to-\sin0=0"""),
    StepItem(tex: r"""\color{black}\boxed{\displaystyle \lim_{x\to0}\frac{\cos x-\cos x^2}{x-x^2}=0}"""),
  ],
),

MathProblem(
  id: "C2A4D7E9-8C31-4B67-9D1C-7B1F9F4D2C22",
  no: 16,
  category: '1/xの積分型極限',
  level: '中級',
  question: r"""\displaystyle \lim_{x\to 0}\frac{1}{x}\int_{0}^{x}\sqrt{1+\cos^{3}t}\,dt""",
  answer: r"""\displaystyle \sqrt{2}""",
  steps: [
    StepItem(tex: r"""\color{black}\textbf{【解答（定理を使う）】}"""),
    StepItem(tex: r"""\color{black}g(t)=\sqrt{1+\cos^{3}t}\text{ とおく。}"""),
    StepItem(tex: r"""\color{black}\text{ }g\text{ は }t=0\text{ の近くで連続である。}"""),

    StepItem(tex: r"""\color{black}\text{積分の平均値の定理より、}"""),
    StepItem(tex: r"""\color{black}\int_{0}^{x}g(t)\,dt = g(\xi)\,x\text{ となる実数 }\xi\text{ が }0\text{ と }x\text{ の間に存在する。}"""),

    StepItem(tex: r"""\color{black}\Rightarrow\ \frac{1}{x}\int_{0}^{x}\sqrt{1+\cos^{3}t}\,dt=\sqrt{1+\cos^{3}\xi}"""),
    StepItem(tex: r"""\color{black}x\to0\text{ のとき }\xi\text{ は }0\text{ と }x\text{ の間にあるので、}\xi\to0\text{。}"""),
    StepItem(tex: r"""\color{black}\cos\text{ は連続だから }\cos\xi\to1"""),
    StepItem(tex: r"""\color{black}\Rightarrow 1+\cos^{3}\xi\to2\Rightarrow \sqrt{1+\cos^{3}\xi}\to\sqrt2"""),
    StepItem(tex: r"""\color{black}\boxed{\displaystyle \lim_{x\to0}\frac{1}{x}\int_{0}^{x}\sqrt{1+\cos^{3}t}\,dt=\sqrt2}"""),

    StepItem(tex: r"""\color{black}\textbf{【補足：積分の平均値の定理（証明）】}"""),
    StepItem(tex: r"""\color{black}\text{ }x>0\text{ の場合で示す。（}x<0\text{ も同様に成り立つ。）}"""),
    StepItem(tex: r"""\color{black}\text{関数 }g\text{ は }[0,x]\text{ で連続だから、最大値と最小値をとる。}"""),
    StepItem(tex: r"""\color{black}\text{最小値を }m,\ \text{最大値を }M\text{ とおく。すると }m\le g(t)\le M\ (0\le t\le x)."""),
    StepItem(tex: r"""\color{black}\text{両辺を }0\text{ から }x\text{ まで積分すると}"""),
    StepItem(tex: r"""\color{black}\int_{0}^{x}m\,dt\le \int_{0}^{x}g(t)\,dt\le \int_{0}^{x}M\,dt"""),
    StepItem(tex: r"""\color{black}\Rightarrow mx\le \int_{0}^{x}g(t)\,dt\le Mx"""),
    StepItem(tex: r"""\color{black}\Rightarrow m\le \frac{1}{x}\int_{0}^{x}g(t)\,dt\le M"""),
    StepItem(tex: r"""\color{black}\text{ここで }g\text{ は連続なので、値は }m\text{ から }M\text{ まで連続的に動く。}"""),
    StepItem(tex: r"""\color{black}\text{したがって }\frac{1}{x}\int_{0}^{x}g(t)\,dt\text{ と等しくなる }g(\xi)\text{ が存在する。}"""),
    StepItem(tex: r"""\color{black}\text{すなわち }\int_{0}^{x}g(t)\,dt=g(\xi)x\text{ となる実数 }\xi\text{ が }0\text{ と }x\text{ の間に存在する。}"""),
  ],
),


];

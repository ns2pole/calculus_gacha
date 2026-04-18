import numpy as np
import matplotlib.pyplot as plt

# xの範囲
x = np.linspace(-2, 3, 500)
y = np.abs(x)

# グラフ描画
plt.figure(figsize=(4,3))
plt.plot(x, y, color='blue', label='y=|x|')

# 塗りつぶし範囲（x=-1からx=2）
x_fill = np.linspace(-1, 2, 500)
y_fill = np.abs(x_fill)
plt.fill_between(x_fill, 0, y_fill, color='blue', alpha=0.2)

# 軸ラベル
plt.xlabel('x')
plt.ylabel('y')
plt.title('y=|x|')

# 余白調整
plt.tight_layout()

# 画像保存
plt.savefig('abs_function.png', dpi=150)
plt.show()


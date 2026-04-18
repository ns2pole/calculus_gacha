// lib/widgets/congruence_card.dart
// 合同方程式問題カードウィジェット

import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import '../../problems/congruence_equations/congruence_equations.dart';
import '../gacha/physics_math_case_display.dart' show PhysicsMathCaseDisplay;

/// 合同方程式問題カード
class CongruenceCard extends StatelessWidget {
  final CongruenceProblem problem;
  final bool isSelected;
  final bool isFlipped; // カードがめくられているか
  final VoidCallback? onTap;
  final double? fixedWidth; // 固定幅（指定された場合はこれを使用）
  final double? fixedHeight; // 固定高さ（指定された場合はこれを使用）

  const CongruenceCard({
    Key? key,
    required this.problem,
    this.isSelected = false,
    this.isFlipped = false,
    this.onTap,
    this.fixedWidth,
    this.fixedHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 縦5横4の比率でカードサイズを計算
    // 固定サイズが指定されている場合はそれを使用
    final double cardWidth;
    final double cardHeight;
    
    if (fixedWidth != null && fixedHeight != null) {
      cardWidth = fixedWidth!;
      cardHeight = fixedHeight!;
    } else {
      // スマホの場合は画面幅に応じて調整、PCの場合は固定サイズ
      final screenWidth = MediaQuery.of(context).size.width;
      final isSmallScreen = screenWidth < 600;
      
      cardWidth = isSmallScreen 
          ? (screenWidth - 32) / 3 - 8  // 画面幅からpadding(16*2)を引いて3で割り、マージン(8*2)を引く
          : 150.0;
      cardHeight = cardWidth * 5 / 4;
    }
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: cardWidth,
        height: cardHeight,
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: isFlipped
              ? (isSelected ? Colors.grey.shade300 : Colors.white)
              : Colors.red.shade700,
          border: Border.all(
            color: isFlipped
                ? (isSelected ? Colors.grey.shade600 : Colors.grey.shade300)
                : Colors.red.shade900,
            width: isSelected ? 3 : 2,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: isFlipped
            ? (isSelected
                ? // 選択時はグレーで中身を見せない
                  Container(
                      color: Colors.grey.shade300,
                      child: Align(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.check_circle,
                          color: Colors.grey.shade600,
                          size: 40,
                        ),
                      ),
                    )
                : // 非選択時のみ中身を表示
                  Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // 数式表示（大きく、手書き風）
                          Expanded(
                            child: Center(
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: _buildQuestionDisplay(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ))
            : Stack(
                children: [
                  _buildCardBack(),
                  if (isSelected)
                    Positioned.fill(
                      child: Container(
                        color: Colors.black.withOpacity(0.3),
                        child: const Center(
                          child: Icon(
                            Icons.check_circle,
                            color: Colors.white,
                            size: 50,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
      ),
    );
  }

  /// 問題の表示を構築（equationとconditionsがある場合はcases形式で表示）
  Widget _buildQuestionDisplay() {
    // equationとconditionsがある場合はcases形式で表示
    if (problem.equation != null && problem.conditions != null) {
      return PhysicsMathCaseDisplay(
        equation: problem.equation!,
        conditions: problem.conditions!,
        fontSize: 24,
      );
    }
    
    // 通常の表示
    return Math.tex(
      problem.question,
      textStyle: const TextStyle(
        fontSize: 28,
        fontFamily: 'serif',
      ),
      mathStyle: MathStyle.display,
    );
  }

  /// カードの裏面（トランプの柄）
  Widget _buildCardBack() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.red.shade800,
            Colors.red.shade600,
          ],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          // トランプの柄パターン
          Positioned.fill(
            child: CustomPaint(
              painter: _CardBackPainter(),
            ),
          ),
          // 中央の装飾
          Center(
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
              ),
              child: const Icon(
                Icons.calculate,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// カードの裏面を描画するPainter
class _CardBackPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    // 斜めのストライプパターン
    final path = Path();
    for (double i = -size.height; i < size.width + size.height; i += 20) {
      path.moveTo(i, 0);
      path.lineTo(i + size.height, size.height);
      path.lineTo(i + size.height + 5, size.height);
      path.lineTo(i + 5, 0);
      path.close();
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}


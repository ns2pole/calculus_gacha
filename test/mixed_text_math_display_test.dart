import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:joymath/pages/common/common.dart';
import 'package:joymath/pages/common/mixed_text_math_pipeline.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Future<void> pumpMixedText(
    WidgetTester tester,
    String text, {
    double width = 360,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: width,
            child: MixedTextMath(
              preprocessAiChatMathText(text),
              plainTextOnMathError: true,
              labelStyle: const TextStyle(fontSize: 16),
              mathStyle: const TextStyle(fontSize: 18),
              displayInlineFractions: true,
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  /// TAB-corrupted `\text` (as Gemini JSON.parse would produce).
  String tabCorruptText(String latexText) {
    const tab = '\t';
    return latexText.replaceAll(r'\text', tab + 'ext');
  }

  group('MixedTextMath display regressions', () {
    const rlcQuestion =
        r'\alpha f^{\prime\prime}(t)+2\beta\,f^{\prime}(t)+\gamma f(t)=F\sin(\omega t) \ \ \text{の定常状態の }f^{\prime}(t),\quad f(0)=0,\ f^{\prime}(0)=0';

    testWidgets('RLC preview: Japanese in \\text and no raw \\prime leak', (
      tester,
    ) async {
      await pumpMixedText(tester, rlcQuestion);
      expect(find.textContaining(r'\prime\prime}(t)+2'), findsNothing);
      expect(find.textContaining('の定常状態'), findsOneWidget);
    });

    const msg19 =
        r'はい、ではイメージしてみましょう。 まず、$y = \theta$ のグラフは、原点 $(0,0)$ を通る傾き $1$ の直線ですね。'
        r' 次に、$y = \text{sin } \theta$ のグラフは、波のような形をしています。'
        r' この「ぴったり重なる」という様子が、$\frac{\text{sin } \theta}{\theta}$ の値が $1$ に近づく、ということを視覚的に示しています。';

    testWidgets('msg19: inline \\text in \$ survives without math error fallback', (
      tester,
    ) async {
      await pumpMixedText(tester, msg19);
      expect(find.textContaining('イメージ'), findsOneWidget);
      expect(find.textContaining('ぴったり重なる'), findsOneWidget);
      // Corrupted TAB+ext would surface as broken TeX in plain fallback.
      expect(find.textContaining('ext{sin'), findsNothing);
    });

    testWidgets('msg19 after TAB corruption: preprocess repair then clean render', (
      tester,
    ) async {
      await pumpMixedText(tester, tabCorruptText(msg19));
      expect(find.textContaining('ext{sin'), findsNothing);
      expect(find.textContaining('イメージ'), findsOneWidget);
    });

    testWidgets(r'\text-only Japanese without \$ renders 日本語 span', (
      tester,
    ) async {
      await pumpMixedText(tester, r'条件: \text{の定常状態の } を求めます。');
      expect(find.textContaining('の定常状態'), findsOneWidget);
      expect(find.textContaining(r'\text{'), findsNothing);
    });

    testWidgets('dollar-only frac without \\text still renders', (tester) async {
      await pumpMixedText(tester, r'例: $\frac{\sin \theta}{\theta}$ です。');
      expect(find.textContaining(r'\frac'), findsNothing);
      expect(find.textContaining('例:'), findsOneWidget);
    });

    testWidgets('double-escaped JSON \\frac collapses and renders', (tester) async {
      await pumpMixedText(
        tester,
        r'$$\frac{1}{n^{3}}\cdot \frac{n(n+1)(2n+1)}{6}$$',
      );
      expect(find.textContaining(r'\\frac'), findsNothing);
    });
  });
}

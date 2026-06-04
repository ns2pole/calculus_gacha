import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:joymath/pages/common/common.dart';
import 'package:joymath/pages/common/mixed_text_math_pipeline.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  /// Same shape as [GachaPage._buildAiChatQuestionText] for 07FC023A-… (equation + conditions).
  const questionText =
      r'\alpha f^{\prime\prime}(t)+2\beta\,f^{\prime}(t)+\gamma f(t)=F\sin(\omega t) \ \ \text{の定常状態の }f^{\prime}(t),\quad f(0)=0,\ f^{\prime}(0)=0';

  testWidgets('AI chat problem preview: no raw \\prime fallback after \\text split', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 360,
            child: MixedTextMath(
              preprocessAiChatMathText(questionText),
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

    expect(find.textContaining(r'\prime\prime}(t)+2'), findsNothing);
    expect(find.textContaining('の定常状態'), findsOneWidget);
  });
}

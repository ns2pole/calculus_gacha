import 'package:ai_chat_kit/src/widgets/user_chat_message_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Firestore 2026-06-03 user messages', () {
    test('half-angle follow-up needs custom renderer', () {
      const text =
          r'なぜ $1-\cos x$ を $2\sin^2\left(\frac{x}{2}\right)$ に変形するのですか？';
      expect(userChatTextNeedsCustomRenderer(text), isTrue);
    });

    test('lim sin/x formula follow-up needs custom renderer', () {
      const text =
          r'$\displaystyle \lim_{x\to 0}\frac{\sin x}{x}=1$ の公式についてもう少し詳しく教えてください。';
      expect(userChatTextNeedsCustomRenderer(text), isTrue);
    });

    test('buildUserChatMessageBody delegates to textRenderer when needed', () {
      const text =
          r'なぜ $1-\cos x$ を $2\sin^2\left(\frac{x}{2}\right)$ に変形するのですか？';
      var rendererCalled = false;

      buildUserChatMessageBody(
        text: text,
        textRenderer: (value) {
          rendererCalled = true;
          expect(value, text);
          return const Text('rendered-math');
        },
      );

      expect(rendererCalled, isTrue);
    });

    test('RED: user bubble must wire textRenderer (currently plain Text only)', () {
      expect(aiChatUserBubbleUsesTextRenderer, isTrue);
    });
  });
}

import 'package:ai_chat_kit/src/locale/ai_chat_api_locale.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AiChatApiLocale', () {
    test('maps Japanese UI to ja', () {
      expect(
        AiChatApiLocale.forApp(const Locale('ja')),
        AiChatApiLocale.ja,
      );
    });

    test('maps English UI to en', () {
      expect(
        AiChatApiLocale.forApp(const Locale('en')),
        AiChatApiLocale.en,
      );
    });

    test('maps non-ja languages to en', () {
      expect(
        AiChatApiLocale.forApp(const Locale('fr')),
        AiChatApiLocale.en,
      );
    });
  });
}

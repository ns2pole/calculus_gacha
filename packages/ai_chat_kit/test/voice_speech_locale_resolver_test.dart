import 'package:ai_chat_kit/src/voice/voice_speech_locale_resolver.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('VoiceSpeechLocaleResolver', () {
    test('prefers ja_JP when UI is Japanese', () {
      expect(
        VoiceSpeechLocaleResolver.resolve(
          appLocale: const Locale('ja'),
          availableLocaleIds: ['en_US', 'ja_JP', 'fr_FR'],
        ),
        'ja_JP',
      );
    });

    test('prefers en_US when UI is English', () {
      expect(
        VoiceSpeechLocaleResolver.resolve(
          appLocale: const Locale('en'),
          availableLocaleIds: ['ja_JP', 'en_GB', 'en_US'],
        ),
        'en_US',
      );
    });

    test('matches hyphenated locale ids from Android', () {
      expect(
        VoiceSpeechLocaleResolver.resolve(
          appLocale: const Locale('ja'),
          availableLocaleIds: ['en-US', 'ja-JP'],
        ),
        'ja-JP',
      );
    });

    test('falls back to any locale with the same language code', () {
      expect(
        VoiceSpeechLocaleResolver.resolve(
          appLocale: const Locale('en'),
          availableLocaleIds: ['ja_JP', 'en_NZ'],
        ),
        'en_NZ',
      );
    });

    test('returns null when device has no matching language', () {
      expect(
        VoiceSpeechLocaleResolver.resolve(
          appLocale: const Locale('ja'),
          availableLocaleIds: ['en_US', 'fr_FR'],
        ),
        isNull,
      );
    });

    test('returns null when device reports no locales', () {
      expect(
        VoiceSpeechLocaleResolver.resolve(
          appLocale: const Locale('ja'),
          availableLocaleIds: const [],
        ),
        isNull,
      );
    });
  });
}

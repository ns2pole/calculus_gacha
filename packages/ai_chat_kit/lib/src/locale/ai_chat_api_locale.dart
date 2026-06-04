import 'package:flutter/widgets.dart';

/// Backend `locale` field (`ja` | `en`) aligned with the host app's UI language.
///
/// Only `ja` maps to Japanese; every other [Locale.languageCode] maps to English.
class AiChatApiLocale {
  const AiChatApiLocale._();

  static const ja = 'ja';
  static const en = 'en';

  static String forApp(Locale appLocale) {
    return appLocale.languageCode.toLowerCase() == ja ? ja : en;
  }
}

import 'package:flutter/widgets.dart';

/// Picks a [speech_to_text] `localeId` that matches the host app's UI [Locale].
///
/// JoyMath normalizes UI to `ja` or `en`; this resolver prefers region-specific
/// ids when the device reports them (e.g. `ja_JP`, `en_US`) and falls back to any
/// available locale with the same language code.
class VoiceSpeechLocaleResolver {
  const VoiceSpeechLocaleResolver._();

  static const _preferredIdsByLanguage = <String, List<String>>{
    'ja': ['ja_JP', 'ja-JP', 'ja'],
    'en': ['en_US', 'en_GB', 'en-AU', 'en-CA', 'en'],
  };

  /// Returns a device-supported locale id, or `null` if none match (OS default).
  static String? resolve({
    required Locale appLocale,
    required Iterable<String> availableLocaleIds,
  }) {
    final available = availableLocaleIds.toList(growable: false);
    if (available.isEmpty) return null;

    final language = appLocale.languageCode.toLowerCase();
    final preferred = _preferredIdsByLanguage[language] ?? [language];

    for (final candidate in preferred) {
      if (available.contains(candidate)) return candidate;
    }

    final byNormalizedId = <String, String>{
      for (final id in available) _normalizeLocaleId(id): id,
    };
    for (final candidate in preferred) {
      final match = byNormalizedId[_normalizeLocaleId(candidate)];
      if (match != null) return match;
    }

    for (final id in available) {
      if (_languageCodeOf(id) == language) return id;
    }

    return null;
  }

  static String _normalizeLocaleId(String id) =>
      id.replaceAll('-', '_').toLowerCase();

  static String _languageCodeOf(String id) {
    final separatorIndex = id.indexOf('_');
    if (separatorIndex >= 0) {
      return id.substring(0, separatorIndex).toLowerCase();
    }
    final dashIndex = id.indexOf('-');
    if (dashIndex >= 0) {
      return id.substring(0, dashIndex).toLowerCase();
    }
    return id.toLowerCase();
  }
}

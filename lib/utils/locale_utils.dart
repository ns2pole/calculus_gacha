import 'package:flutter/widgets.dart';

/// UI 言語の割り当て: `ja` のみ日本語、それ以外は英語リソースを使う。
Locale normalizeAppLocale(Locale? locale) {
  final lang = locale?.languageCode.toLowerCase();
  return lang == 'ja' ? const Locale('ja') : const Locale('en');
}

/// [MaterialApp.localeResolutionCallback] 用。
///
/// Flutter 3.32 以降は `supportedLocales` が `Iterable<Locale>` で渡される。
/// Web では [PlatformDispatcher.locales] がブラウザの言語優先（`Accept-Language` 順）に相当する。
/// [deviceLocale] が来ない場合も、そのリストで `ja` を先に拾えるようにする。
Locale? resolveAppLocale(Locale? deviceLocale, Iterable<Locale> supportedLocales) {
  final candidates = <Locale>[
    if (deviceLocale != null) deviceLocale,
    ...WidgetsBinding.instance.platformDispatcher.locales,
  ];

  for (final loc in candidates) {
    final resolved = normalizeAppLocale(loc);
    for (final s in supportedLocales) {
      if (s.languageCode == resolved.languageCode) {
        return resolved;
      }
    }
  }
  return const Locale('en');
}

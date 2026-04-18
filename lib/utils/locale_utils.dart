import 'package:flutter/widgets.dart';

/// App-wide locale policy:
/// - Japanese (`ja`) -> Japanese UI
/// - Any other language (e.g. `fr`, `de`, `zh`) -> English UI
///
/// Keep this logic in ONE place and reuse it from both UI and service layers.
Locale normalizeAppLocale(Locale? systemLocale) {
  final lang = systemLocale?.languageCode.toLowerCase();
  return lang == 'ja' ? const Locale('ja') : const Locale('en');
}



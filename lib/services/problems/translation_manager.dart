import '../../models/problem_translation.dart';
import '../../problems/translations/en/integrals_en.dart';
import '../../problems/translations/en/limits_en.dart';
import '../../problems/translations/en/factorization_en.dart';
import '../../problems/translations/en/indeterminate_equations_en.dart';
import '../../problems/translations/en/sequences_en.dart';
import '../../problems/translations/en/trig_exp_log_equations_en.dart';
import '../../problems/translations/en/physics_math_en.dart';
import '../../problems/translations/en/congruence_equations_en.dart';

/// Central manager for problem translations across different locales.
class TranslationManager {
  /// Base translation sources per locale.
  ///
  /// We intentionally keep **separate maps** (instead of spreading them into one map),
  /// because some problem IDs may be duplicated across different problem sets.
  /// In that case, callers can provide `expectedStepsLength` and we select the
  /// translation whose `steps.length` matches the current problem.
  static final Map<String, List<Map<String, ProblemTranslation>>> _translationSources = {
    'en': [
      integralsTranslationsEn,
      limitsTranslationsEn,
      factorizationTranslationsEn,
      indeterminateEquationsTranslationsEn,
      sequencesTranslationsEn,
      trigExpLogEquationsTranslationsEn,
      physicsMathTranslationsEn,
      congruenceEquationsTranslationsEn,
    ],
    'ja': [
      // Japanese is the default, but could be added here if needed for override.
    ],
  };

  /// Runtime overrides (registered dynamically).
  static final Map<String, Map<String, ProblemTranslation>> _overrides = {
    'en': {},
    'ja': {},
  };

  static String _normalizeLocale(String locale) {
    // Accept "en", "en-US", "en_US" etc and normalize to "en" / "en-us" form.
    final trimmed = locale.trim();
    if (trimmed.isEmpty) return 'en';
    return trimmed.replaceAll('_', '-').toLowerCase();
  }

  static String _baseLanguage(String locale) {
    final norm = _normalizeLocale(locale);
    final idx = norm.indexOf('-');
    return idx >= 0 ? norm.substring(0, idx) : norm;
  }

  /// Registers a map of translations for a specific locale.
  static void registerTranslations(String locale, Map<String, ProblemTranslation> translations) {
    final norm = _normalizeLocale(locale);
    _overrides.putIfAbsent(norm, () => {});
    _overrides[norm]!.addAll(translations);
  }

  static Iterable<ProblemTranslation> _candidates(String locale, String id) sync* {
    final norm = _normalizeLocale(locale);
    final base = _baseLanguage(norm);
    final seenLocales = <String>{};

    for (final loc in [norm, base, 'en']) {
      if (!seenLocales.add(loc)) continue;

      final override = _overrides[loc]?[id];
      if (override != null) {
        yield override;
      }

      final sources = _translationSources[loc];
      if (sources == null) continue;
      for (final m in sources) {
        final t = m[id];
        if (t != null) yield t;
      }
    }
  }

  /// Retrieves a translation for a given locale and problem ID.
  ///
  /// If `expectedStepsLength` is provided, we prefer a translation whose
  /// `steps.length` matches it. This makes translation selection robust even
  /// when an ID is duplicated across different problem sets.
  static ProblemTranslation? getTranslation(
    String locale,
    String id, {
    int? expectedStepsLength,
  }) {
    final list = _candidates(locale, id).toList(growable: false);
    if (list.isEmpty) return null;

    if (expectedStepsLength != null) {
      for (final t in list) {
        final steps = t.steps;
        if (steps != null && steps.length == expectedStepsLength) return t;
      }
    }

    // Fallback to the first candidate (most specific locale first).
    return list.first;
  }
}

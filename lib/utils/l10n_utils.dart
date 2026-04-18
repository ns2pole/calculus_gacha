import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../models/math_problem.dart';
import '../models/step_item.dart';
import '../services/problems/translation_manager.dart';

// Temporary keyword-level translation for Physics-math (ODE gacha).
// This is an emergency patch to avoid JP fragments leaking into English UI.
// Keep it small and easy to delete later.
String _replacePhysicsMathKeywordsEn(String input) {
  return input
      // "steady-state of ..." label used in some equation fields
      .replaceAll(r'\text{の定常状態の }', r'\text{steady-state }')
      // constants labels (JP)
      .replaceAll('：正の定数', r': positive \ constant')
      .replaceAll(':正の定数', r': positive \ constant')
      .replaceAll('：定数', r': constant')
      .replaceAll(':定数', r': constant');
}

extension MathProblemLocalization on MathProblem {
  String? getLocalizedEquation(BuildContext context) {
    final langCode = Localizations.localeOf(context).languageCode;
    final e = equation;
    if (e == null) return null;
    return langCode == 'en' ? _replacePhysicsMathKeywordsEn(e) : e;
  }

  String getLocalizedCategory(BuildContext context) {
    final localeTag = Localizations.localeOf(context).toLanguageTag();
    final translation =
        TranslationManager.getTranslation(localeTag, id, expectedStepsLength: steps.length);
    if (translation?.category != null) {
      return translation!.category!;
    }

    // Default translations for common category names (when translation files don't override).
    // Note: categories are stored as JP strings in problem data; we map them to AppLocalizations
    // so any future locale can be added via ARB without code changes.
    final l10n = AppLocalizations.of(context)!;
    switch (category) {
      case '合同方程式':
        return l10n.category_congruence;
      case '不定方程式':
        return l10n.category_indeterminate;
      case '因数分解':
        return l10n.category_factorization;
      case '漸化式':
        return l10n.category_recurrence;
      case '極限':
        return l10n.category_limits;
      case '積分':
        return l10n.category_integrals;
      case '物理数学':
        return l10n.category_physics_math;
    }

    return category;
  }

  String getLocalizedLevel(BuildContext context) {
    final localeTag = Localizations.localeOf(context).toLanguageTag();
    final translation =
        TranslationManager.getTranslation(localeTag, id, expectedStepsLength: steps.length);
    if (translation?.level != null) {
      return translation!.level!;
    }

    // Default translations for common level names via AppLocalizations
    final l10n = AppLocalizations.of(context)!;
    switch (level) {
      case '初級':
        return l10n.easy;
      case '中級':
        return l10n.mid;
      case '上級':
        return l10n.advanced;
      case '発展':
        return l10n.expert;
    }
    return level;
  }

  String getLocalizedQuestion(BuildContext context) {
    final localeTag = Localizations.localeOf(context).toLanguageTag();
    final translation =
        TranslationManager.getTranslation(localeTag, id, expectedStepsLength: steps.length);
    if (translation?.question != null) {
      return translation!.question!;
    }
    return question;
  }

  String getLocalizedAnswer(BuildContext context) {
    final localeTag = Localizations.localeOf(context).toLanguageTag();
    final translation =
        TranslationManager.getTranslation(localeTag, id, expectedStepsLength: steps.length);
    if (translation?.answer != null) {
      return translation!.answer!;
    }
    return answer;
  }

  String? getLocalizedHint(BuildContext context) {
    final langCode = Localizations.localeOf(context).languageCode;
    final localeTag = Localizations.localeOf(context).toLanguageTag();
    final translation =
        TranslationManager.getTranslation(localeTag, id, expectedStepsLength: steps.length);
    final tHint = translation?.hint;
    if (tHint != null && tHint.trim().isNotEmpty) {
      return tHint;
    }

    // Avoid leaking JP-only hints into non-Japanese UI.
    // If a problem doesn't have an English hint translation yet, show an English
    // fallback message (instead of the JP hint body).
    if (langCode != 'ja') {
      final base = hint;
      if (base == null || base.trim().isEmpty) return null;
      return r'\text{Hint is not available in English yet.}';
    }

    return hint;
  }

  String? getLocalizedShortExplanation(BuildContext context) {
    final localeTag = Localizations.localeOf(context).toLanguageTag();
    final translation =
        TranslationManager.getTranslation(localeTag, id, expectedStepsLength: steps.length);
    if (translation?.shortExplanation != null) {
      return translation!.shortExplanation!;
    }
    return shortExplanation;
  }

  String? getLocalizedConditions(BuildContext context) {
    final localeTag = Localizations.localeOf(context).toLanguageTag();
    final langCode = Localizations.localeOf(context).languageCode;
    final translation =
        TranslationManager.getTranslation(localeTag, id, expectedStepsLength: steps.length);
    if (translation?.conditions != null) {
      final t = translation!.conditions!;
      return langCode == 'en' ? _replacePhysicsMathKeywordsEn(t) : t;
    }
    final c = conditions;
    if (c == null) return null;
    return langCode == 'en' ? _replacePhysicsMathKeywordsEn(c) : c;
  }

  String? getLocalizedConstants(BuildContext context) {
    final localeTag = Localizations.localeOf(context).toLanguageTag();
    final langCode = Localizations.localeOf(context).languageCode;
    final translation =
        TranslationManager.getTranslation(localeTag, id, expectedStepsLength: steps.length);
    if (translation?.constants != null) {
      final t = translation!.constants!;
      return langCode == 'en' ? _replacePhysicsMathKeywordsEn(t) : t;
    }
    final c = constants;
    if (c == null) return null;
    return langCode == 'en' ? _replacePhysicsMathKeywordsEn(c) : c;
  }

  List<String> getLocalizedKeywords(BuildContext context) {
    final localeTag = Localizations.localeOf(context).toLanguageTag();
    final translation =
        TranslationManager.getTranslation(localeTag, id, expectedStepsLength: steps.length);
    if (translation?.keywords != null) {
      return translation!.keywords!;
    }
    return keywords.map((k) => getLocalizedKeyword(context, k)).toList();
  }

  /// New method to get a fully localized problem (wrapped)
  List<StepItem> getLocalizedSteps(BuildContext context) {
    final langCode = Localizations.localeOf(context).languageCode;
    final localeTag = Localizations.localeOf(context).toLanguageTag();
    final translation =
        TranslationManager.getTranslation(localeTag, id, expectedStepsLength: steps.length);

    // Use translated steps ONLY when the number of steps exactly matches the original.
    // This intentionally surfaces incomplete translations (missing or merged lines).
    if (langCode != 'ja' &&
        translation?.steps != null &&
        translation!.steps!.length == steps.length) {
      final tSteps = translation.steps!;
      return List.generate(steps.length, (i) {
        return StepItem(
          tex: tSteps[i],
          imageAsset: steps[i].imageAsset,
        );
      });
    }

    // Fallback to existing logic
    return steps.map((s) => StepItem(
      tex: s.getLocalizedTex(context),
      imageAsset: s.imageAsset,
    )).toList();
  }

  /// Localize `detailedExplanation` (a separate field from `steps`).
  ///
  /// This is used by some gacha/pages that store the long explanation in
  /// `detailedExplanation` instead of `steps`. In that case, we interpret
  /// `ProblemTranslation.steps` as the translation source for `detailedExplanation`
  /// and require length match (same policy as `getLocalizedSteps`).
  List<StepItem>? getLocalizedDetailedExplanation(BuildContext context) {
    final base = detailedExplanation;
    if (base == null) return null;

    final langCode = Localizations.localeOf(context).languageCode;
    final localeTag = Localizations.localeOf(context).toLanguageTag();
    final translation =
        TranslationManager.getTranslation(localeTag, id, expectedStepsLength: base.length);

    if (langCode != 'ja' &&
        translation?.steps != null &&
        translation!.steps!.length == base.length) {
      final tSteps = translation.steps!;
      return List.generate(base.length, (i) {
        return StepItem(
          tex: tSteps[i],
          imageAsset: base[i].imageAsset,
        );
      });
    }

    // Fallback: keep the original but apply small automatic tag translations.
    return base
        .map((s) => StepItem(
              tex: s.getLocalizedTex(context),
              imageAsset: s.imageAsset,
            ))
        .toList(growable: false);
  }
}

String getLocalizedKeyword(BuildContext context, String keyword) {
  final l10n = AppLocalizations.of(context)!;
  switch (keyword) {
    case '数値':
      return l10n.keyword_numerical;
    case '一般':
      return l10n.keyword_general;
    case '等加速度直線運動':
      return l10n.keyword_uam;
    case '空気抵抗':
      return l10n.keyword_air_resistance;
    case '単振動':
      return l10n.keyword_shm;
    case '直流':
      return l10n.keyword_dc;
    case '交流':
      return l10n.keyword_ac;
    case '電圧0':
      return l10n.keyword_voltage0;
    case 'コンデンサ':
      return l10n.keyword_capacitor;
    case 'コイル':
      return l10n.keyword_inductor;
    case '抵抗':
      return l10n.keyword_resistor;
    case 'その他':
      return l10n.keyword_other;
    case '共振':
      return l10n.keyword_resonance;
    case '一階斉次':
      return l10n.keyword_firstOrderHomogeneous;
    case '斉次':
      return l10n.keyword_homogeneous;
    case '非斉次':
      return l10n.keyword_nonHomogeneous;
    case '大学':
      return l10n.keyword_university;
    default:
      return keyword;
  }
}

extension StepItemLocalization on StepItem {
  String getLocalizedTex(BuildContext context) {
    final langCode = Localizations.localeOf(context).languageCode;
    
    // Automatic simple translations for common TeX text tags
    String result = tex;
    if (langCode == 'en') {
      result = result.replaceAll('【ポイント】', '[Key Points]');
      result = result.replaceAll('【解説】', '[Explanation]');
      result = result.replaceAll('【計算】', '[Calculation]');
      result = result.replaceAll('【方針】', '[Strategy]');
      result = result.replaceAll('【補足】', '[Supplement]');
      // Physics-math (ODE gacha) common JP keywords (exception: allow replaceAll here)
      result = _replacePhysicsMathKeywordsEn(result);
      // The following are common phrases in math problems
      result = result.replaceAll('とみなして', 'assuming');
      result = result.replaceAll('を用いる', 'use');
      result = result.replaceAll('の置換で', 'substituting');
      result = result.replaceAll('を求める', 'find');
      result = result.replaceAll('代入して', 'substitute');
      result = result.replaceAll('評価する', 'evaluate');
    }
    return result;
  }
}


String getLocalizedLoginMethod(BuildContext context, String? method) {
  final l10n = AppLocalizations.of(context)!;
  if (method == null) return '';
  switch (method) {
    case 'email':
      return l10n.auth_methodEmail;
    case 'phone':
      return l10n.auth_methodPhone;
    case 'google':
      return l10n.auth_methodGoogle;
    case 'apple':
      return l10n.auth_methodApple;
    default:
      return method;
  }
}

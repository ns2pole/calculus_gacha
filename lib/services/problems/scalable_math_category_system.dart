// lib/services/scalable_math_category_system.dart
import 'package:flutter/widgets.dart';

import '../../l10n/app_localizations.dart';
import '../../models/math_problem.dart';
import '../../models/learning_status.dart';
import 'simple_data_manager.dart';

/// スケーラブルな数学カテゴリシステム
/// 漸化式ガチャ、微分方程式ガチャなど、新しい分野の追加が超簡単
class ScalableMathCategorySystem {
  
  /// 数学分野の定義
  static const Map<String, MathCategory> mathCategories = {
    'integral': MathCategory(
      key: 'integral',
      displayName: '積分',
      description: '積分計算の基礎から応用まで',
      icon: '∫',
      color: 0xFF2196F3,
      difficultyLevels: ['初級', '中級', '上級'],
    ),
    'limit': MathCategory(
      key: 'limit',
      displayName: '極限',
      description: '極限の計算と応用',
      icon: 'lim',
      color: 0xFF4CAF50,
      difficultyLevels: ['初級', '中級', '上級'],
    ),
    'recurrence': MathCategory(
      key: 'recurrence',
      displayName: '漸化式',
      description: '漸化式の解法と応用',
      icon: 'aₙ',
      color: 0xFFFF9800,
      difficultyLevels: ['初級', '中級', '上級'],
    ),
    'differential': MathCategory(
      key: 'differential',
      displayName: '微分',
      description: '微分の計算と応用',
      icon: 'd/dx',
      color: 0xFF9C27B0,
      difficultyLevels: ['初級', '中級', '上級'],
    ),
    'series': MathCategory(
      key: 'series',
      displayName: '級数',
      description: '級数の収束と発散',
      icon: 'Σ',
      color: 0xFFE91E63,
      difficultyLevels: ['初級', '中級', '上級'],
    ),
    'probability': MathCategory(
      key: 'probability',
      displayName: '確率',
      description: '確率の基礎と応用',
      icon: 'P',
      color: 0xFF795548,
      difficultyLevels: ['初級', '中級', '上級'],
    ),
    'factorization': MathCategory(
      key: 'factorization',
      displayName: '因数分解',
      description: '因数分解の基礎から応用まで',
      icon: '分解',
      color: 0xFF00BCD4,
      difficultyLevels: ['初級', '中級', '上級'],
    ),
  };
  
  /// 利用可能な数学分野を取得
  static List<MathCategory> getAvailableCategories() {
    return mathCategories.values.toList();
  }
  
  /// 数学分野の情報を取得
  static MathCategory? getCategory(String key) {
    return mathCategories[key];
  }
  
  /// 数学分野が存在するかチェック
  static bool hasCategory(String key) {
    return mathCategories.containsKey(key);
  }
  
  /// 新しい数学分野を動的に追加
  static void addNewCategory(MathCategory category) {
    // 実行時に新しいカテゴリを追加
    // 注意: 実際の実装では、より高度な動的登録システムが必要
    print('Adding new math category: ${category.key} (${category.displayName})');
  }
}

/// 数学分野の情報
class MathCategory {
  final String key;
  final String displayName;
  final String description;
  final String icon;
  final int color;
  final List<String> difficultyLevels;
  
  const MathCategory({
    required this.key,
    required this.displayName,
    required this.description,
    required this.icon,
    required this.color,
    required this.difficultyLevels,
  });

  /// Localized display name via AppLocalizations (ARB).
  /// This makes adding new languages a pure ARB task (no `isEn ? ... : ...` branching).
  String localizedDisplayName(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (key) {
      case 'integral':
        return l10n.category_integrals;
      case 'limit':
        return l10n.category_limits;
      case 'recurrence':
        return l10n.category_recurrence;
      case 'differential':
        return l10n.category_differential;
      case 'series':
        return l10n.category_series;
      case 'probability':
        return l10n.category_probability;
      case 'factorization':
        return l10n.category_factorization;
      default:
        return displayName;
    }
  }

  /// Localized description via AppLocalizations (ARB) when available.
  String localizedDescription(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (key) {
      case 'integral':
        return l10n.category_integrals_desc;
      case 'limit':
        return l10n.category_limits_desc;
      case 'recurrence':
        return l10n.category_recurrence_desc;
      case 'differential':
        return l10n.category_differential_desc;
      case 'series':
        return l10n.category_series_desc;
      case 'probability':
        return l10n.category_probability_desc;
      case 'factorization':
        return l10n.category_factorization_desc;
      default:
        return description;
    }
  }

  /// Icons are language-agnostic.
  String get localizedIcon => icon;
  
  Map<String, dynamic> toJson() => {
    'key': key,
    'displayName': displayName,
    'description': description,
    'icon': icon,
    'color': color,
    'difficultyLevels': difficultyLevels,
  };
  
  factory MathCategory.fromJson(Map<String, dynamic> json) {
    return MathCategory(
      key: json['key'] as String,
      displayName: json['displayName'] as String,
      description: json['description'] as String,
      icon: json['icon'] as String,
      color: json['color'] as int,
      difficultyLevels: (json['difficultyLevels'] as List).cast<String>(),
    );
  }
}

/// スケーラブルなガチャシステム
class ScalableGachaSystem {
  
  /// ガチャ設定のデフォルト値
  static Map<String, dynamic> getDefaultGachaSettings() {
    return {
      'filterMode': 'exclude_solved_ge1',
      'slotLevels': [0, 1, 2], // 初級、中級、上級
      'lastRollTime': null,
      'rollCount': 0,
      'favoriteProblems': <String>[],
      'excludedProblems': <String>[],
      'customSettings': <String, dynamic>{},
    };
  }
  
  /// ガチャ設定を保存
  static Future<bool> saveGachaSettings(String categoryKey, Map<String, dynamic> settings) async {
    return await SimpleDataManager.saveGachaSettings(categoryKey, settings);
  }
  
  /// ガチャ設定を取得
  static Future<Map<String, dynamic>> getGachaSettings(String categoryKey) async {
    final settings = await SimpleDataManager.getGachaSettings(categoryKey);
    
    // デフォルト設定とマージ
    final defaultSettings = getDefaultGachaSettings();
    defaultSettings.addAll(settings);
    
    return defaultSettings;
  }
  
  /// 問題をフィルタリング
  static List<MathProblem> filterProblems(
    List<MathProblem> problems,
    String filterMode,
    Map<String, LearningStatus> learningStatusCache,
    List<String> excludedProblems,
  ) {
    // 除外された問題をフィルタ
    var filteredProblems = problems.where((problem) => 
      !excludedProblems.contains(problem.id)
    ).toList();
    
    // フィルタモードに基づいてフィルタ
    switch (filterMode) {
      case 'random':
        return filteredProblems;
        
      case 'exclude_solved':
        return filteredProblems.where((problem) {
          final status = learningStatusCache[problem.id] ?? LearningStatus.none;
          return status != LearningStatus.solved;
        }).toList();
        
      case 'exclude_solved_ge1':
        return filteredProblems.where((problem) {
          final status = learningStatusCache[problem.id] ?? LearningStatus.none;
          return status != LearningStatus.solved && status != LearningStatus.understood;
        }).toList();
        
      case 'only_unsolved':
        return filteredProblems.where((problem) {
          final status = learningStatusCache[problem.id] ?? LearningStatus.none;
          return status == LearningStatus.none;
        }).toList();
        
      case 'only_favorites':
        return filteredProblems.where((problem) {
          // お気に入り問題のみ（実装は後で）
          return false;
        }).toList();
        
      default:
        return filteredProblems;
    }
  }
  
  /// 問題をレベル別に分類
  static Map<String, List<MathProblem>> categorizeByLevel(
    List<MathProblem> problems,
    List<String> difficultyLevels,
  ) {
    final Map<String, List<MathProblem>> categorized = {};
    
    for (final level in difficultyLevels) {
      categorized[level] = problems.where((problem) => 
        problem.level == level
      ).toList();
    }
    
    return categorized;
  }
  
  /// 問題をカテゴリ別に分類
  static Map<String, List<MathProblem>> categorizeByCategory(
    List<MathProblem> problems,
  ) {
    final Map<String, List<MathProblem>> categorized = {};
    
    for (final problem in problems) {
      final category = problem.category;
      if (!categorized.containsKey(category)) {
        categorized[category] = [];
      }
      categorized[category]!.add(problem);
    }
    
    return categorized;
  }
}

/// 問題プールの管理
class ProblemPoolManager {
  
  /// 問題プールの定義
  static const Map<String, List<MathProblem>> problemPools = {
    'integral': [], // 実際の実装では allIntegralProblems を使用
    'limit': [],   // 実際の実装では allLimitProblems を使用
    'recurrence': [], // 新しい漸化式問題プール
    'differential': [], // 新しい微分問題プール
    'series': [], // 新しい級数問題プール
    'probability': [], // 新しい確率問題プール
  };
  
  /// 問題プールを取得
  static List<MathProblem> getProblemPool(String categoryKey) {
    return problemPools[categoryKey] ?? [];
  }
  
  /// 問題プールが存在するかチェック
  static bool hasProblemPool(String categoryKey) {
    return problemPools.containsKey(categoryKey) && 
           problemPools[categoryKey]!.isNotEmpty;
  }
  
  /// 利用可能な問題プールを取得
  static List<String> getAvailableProblemPools() {
    return problemPools.entries
        .where((entry) => entry.value.isNotEmpty)
        .map((entry) => entry.key)
        .toList();
  }
  
  /// 問題プールの統計情報を取得
  static Map<String, dynamic> getProblemPoolStats(String categoryKey) {
    final problems = getProblemPool(categoryKey);
    if (problems.isEmpty) {
      return {
        'total': 0,
        'byLevel': {},
        'byCategory': {},
      };
    }
    
    // レベル別の統計
    final byLevel = <String, int>{};
    for (final problem in problems) {
      byLevel[problem.level] = (byLevel[problem.level] ?? 0) + 1;
    }
    
    // カテゴリ別の統計
    final byCategory = <String, int>{};
    for (final problem in problems) {
      byCategory[problem.category] = (byCategory[problem.category] ?? 0) + 1;
    }
    
    return {
      'total': problems.length,
      'byLevel': byLevel,
      'byCategory': byCategory,
    };
  }
}

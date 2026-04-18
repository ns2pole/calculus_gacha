// lib/services/auto_gacha_page_generator.dart
import 'package:flutter/material.dart';
import '../../models/math_problem.dart';
import '../../models/learning_status.dart';
import '../problems/scalable_math_category_system.dart';
import '../problems/simple_data_manager.dart';
import '../../pages/gacha/gacha_page.dart';
import '../../l10n/app_localizations.dart';

/// 自動ガチャページ生成器
/// 新しい数学分野のガチャページを自動生成
class AutoGachaPageGenerator {
  /// ガチャページを生成
  static Widget generateGachaPage(String categoryKey) {
    return DynamicGachaPage(categoryKey: categoryKey);
  }
  
  /// エラーページを生成
  static Widget _buildErrorPage(String message) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(message, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // ホームページに戻る
              },
              child: const Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
  
  /// 利用可能なガチャページの一覧を生成
  static List<Widget> generateAllGachaPages() {
    final List<Widget> pages = [];
    
    for (final category in ScalableMathCategorySystem.getAvailableCategories()) {
      if (ProblemPoolManager.hasProblemPool(category.key)) {
        pages.add(generateGachaPage(category.key));
      }
    }
    
    return pages;
  }
  
  /// ガチャページのルートを生成
  static Map<String, Widget> generateGachaRoutes() {
    final Map<String, Widget> routes = {};
    
    for (final category in ScalableMathCategorySystem.getAvailableCategories()) {
      if (ProblemPoolManager.hasProblemPool(category.key)) {
        routes['/${category.key}_gacha'] = generateGachaPage(category.key);
      }
    }
    
    return routes;
  }
}

/// 動的ガチャページ
class DynamicGachaPage extends StatefulWidget {
  final String categoryKey;
  
  const DynamicGachaPage({
    Key? key,
    required this.categoryKey,
  }) : super(key: key);
  
  @override
  State<DynamicGachaPage> createState() => _DynamicGachaPageState();
}

class _DynamicGachaPageState extends State<DynamicGachaPage> {
  late final String _categoryKey;
  late final MathCategory? _category;
  late final List<MathProblem> _problemPool;
  late final Map<String, LearningStatus> _learningStatusCache;
  
  @override
  void initState() {
    super.initState();
    _categoryKey = widget.categoryKey;
    _category = ScalableMathCategorySystem.getCategory(_categoryKey);
    _problemPool = ProblemPoolManager.getProblemPool(_categoryKey);
    _learningStatusCache = {};
    _loadLearningStatusCache();
  }
  
  Future<void> _loadLearningStatusCache() async {
    for (final problem in _problemPool) {
      final status = await SimpleDataManager.getLearningRecord(problem);
      _learningStatusCache[problem.id] = status;
    }
    if (mounted) {
      setState(() {});
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (_category == null) {
      return _buildErrorPage('Unknown category: $_categoryKey');
    }
    
    if (_problemPool.isEmpty) {
      return _buildErrorPage('No problems available for ${_category.localizedDisplayName(context)}');
    }
    
    return GachaPage(
      problemPool: _problemPool,
      title: '${_category.localizedDisplayName(context)} ${l10n.gachaSuffix}',
      prefsPrefix: _categoryKey,
    );
  }
  
  Widget _buildErrorPage(String message) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.errorTitle)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(message, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(l10n.auth_backButton),
            ),
          ],
        ),
      ),
    );
  }
}

/// ガチャページのファクトリー
class GachaPageFactory {
  
  /// ガチャページを作成
  static Widget createGachaPage(String categoryKey) {
    return DynamicGachaPage(categoryKey: categoryKey);
  }
  
  /// 利用可能なガチャページの一覧を取得
  static List<Map<String, dynamic>> getAvailableGachaPages(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final List<Map<String, dynamic>> pages = [];
    
    for (final category in ScalableMathCategorySystem.getAvailableCategories()) {
      if (ProblemPoolManager.hasProblemPool(category.key)) {
        pages.add({
          'key': category.key,
          'title': '${category.localizedDisplayName(context)} ${l10n.gachaSuffix}',
          'description': category.localizedDescription(context),
          'icon': category.localizedIcon,
          'color': Color(category.color),
          'problemCount': ProblemPoolManager.getProblemPool(category.key).length,
        });
      }
    }
    
    return pages;
  }
  
  /// ガチャページの統計情報を取得
  static Map<String, dynamic> getGachaPageStats(String categoryKey) {
    final category = ScalableMathCategorySystem.getCategory(categoryKey);
    if (category == null) {
      return {'error': 'Unknown category'};
    }
    
    final problemPool = ProblemPoolManager.getProblemPool(categoryKey);
    final stats = ProblemPoolManager.getProblemPoolStats(categoryKey);
    
    return {
      'category': category.toJson(),
      'problemCount': problemPool.length,
      'stats': stats,
    };
  }
}

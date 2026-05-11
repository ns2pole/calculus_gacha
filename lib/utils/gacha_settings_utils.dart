// lib/utils/gacha_settings_utils.dart
// ガチャ設定の読み込み/保存に関する共通ユーティリティ関数

import 'package:shared_preferences/shared_preferences.dart';
import '../pages/common/aggregation_mode.dart';
import '../services/problems/exclusion_logic.dart';
import '../services/problems/simple_data_manager.dart';
import '../managers/timer_manager.dart';

/// ガチャ設定を読み込む
class GachaSettingsLoader {
  /// 除外モードを読み込む
  static Future<ExclusionMode> loadExclusionMode(String prefsPrefix) async {
    final key = '${prefsPrefix}_gacha_exclusion_mode';
    final exclusionIndex = await SimpleDataManager.getOtherSettingValue(key) as int?;

    if (exclusionIndex != null && 
        exclusionIndex >= 0 && 
        exclusionIndex < ExclusionMode.values.length) {
      return ExclusionMode.values[exclusionIndex];
    }
    return ExclusionMode.none;
  }

  /// 集計モードを読み込む
  static Future<AggregationMode> loadAggregationMode(String prefsPrefix) async {
    // ガチャ設定から読み込む
    final settings = await SimpleDataManager.getGachaSettings(prefsPrefix);
    final aggregationIndex = settings['aggregationMode'] as int?;
    
    // 後方互換性: 古いキーからも読み込む（移行期間中）
    if (aggregationIndex == null) {
      final prefs = await SharedPreferences.getInstance();
      final oldKey = '${prefsPrefix}_gacha_aggregation_mode';
      final oldValue = prefs.getInt(oldKey);
      if (oldValue != null && oldValue >= 0 && oldValue < AggregationMode.values.length) {
        // 古いキーから値を取得した場合、ガチャ設定に移行
        await GachaSettingsSaver.saveAggregationMode(prefsPrefix, AggregationMode.values[oldValue]);
        return AggregationMode.values[oldValue];
      }
    }
    
    if (aggregationIndex != null && 
        aggregationIndex >= 0 && 
        aggregationIndex < AggregationMode.values.length) {
      return AggregationMode.values[aggregationIndex];
    }
    return AggregationMode.latest1;
  }

  /// 選択枚数を読み込む
  static Future<int> loadMaxSelections(String prefsPrefix, {int defaultValue = 2}) async {
    final key = '${prefsPrefix}_gacha_max_selections';
    final maxSelections = await SimpleDataManager.getOtherSettingValue(key) as int?;

    if (maxSelections != null && maxSelections >= 1 && maxSelections <= 3) {
      return maxSelections;
    }
    return defaultValue;
  }

  /// タイマー設定を読み込む
  static Future<void> loadTimerSettings(TimerManager timerManager, String prefsPrefix) async {
    await timerManager.loadTimerSettings(prefsPrefix);
  }

  /// タイマーの初期時間を設定（選択枚数に基づく）
  static Future<void> initializeTimerBasedOnSelection(
    String prefsPrefix,
    int maxSelections,
    TimerManager timerManager,
  ) async {
    final timerSettings = await SimpleDataManager.getGachaSettings(prefsPrefix);
    if (timerSettings['timerMinutes'] == null) {
      final settings = await SimpleDataManager.getGachaSettings(prefsPrefix);
      settings['timerMinutes'] = maxSelections;
      settings['remainingSeconds'] = maxSelections * 60;
      await SimpleDataManager.saveGachaSettings(prefsPrefix, settings);
      await timerManager.loadTimerSettings(prefsPrefix);
    }
  }
}

/// ガチャ設定を保存する
class GachaSettingsSaver {
  /// 除外モードを保存
  static Future<void> saveExclusionMode(String prefsPrefix, ExclusionMode mode) async {
    final key = '${prefsPrefix}_gacha_exclusion_mode';
    await SimpleDataManager.saveOtherSettingValue(key, mode.index);
  }

  /// 集計モードを保存
  static Future<void> saveAggregationMode(String prefsPrefix, AggregationMode mode) async {
    // ガチャ設定として保存
    final settings = await SimpleDataManager.getGachaSettings(prefsPrefix);
    settings['aggregationMode'] = mode.index;
    await SimpleDataManager.saveGachaSettings(prefsPrefix, settings);
    
    // 後方互換性: 古いキーにも保存（移行期間中）
    final prefs = await SharedPreferences.getInstance();
    final oldKey = '${prefsPrefix}_gacha_aggregation_mode';
    await prefs.setInt(oldKey, mode.index);
  }

  /// 選択枚数を保存
  static Future<void> saveMaxSelections(String prefsPrefix, int maxSelections) async {
    final key = '${prefsPrefix}_gacha_max_selections';
    await SimpleDataManager.saveOtherSettingValue(key, maxSelections);
  }

  // 単位ガチャ関連の設定保存は削除（別アプリへ移行）
}





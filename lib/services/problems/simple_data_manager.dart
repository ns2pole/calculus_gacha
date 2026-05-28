// lib/services/simple_data_manager.dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/math_problem.dart';
import '../../models/learning_status.dart';
import '../../pages/common/problem_status.dart';
import '../payment/revenuecat_service.dart';
import '../payment/iap_secondary_products_config.dart';
import '../auth/cloud_sync_preference_service.dart';
import '../auth/firebase_auth_service.dart';
import '../auth/firestore_learning_service.dart';
import '../auth/firestore_settings_service.dart';
import '../../utils/app_logger.dart';

/// シンプルで拡張可能なデータ管理システム
/// 現在の必要最小限のデータ + 将来の拡張に対応
class SimpleDataManager {
  /// SharedPreferences key prefix for this app.
  static const String _namespace = 'joymath_simple';

  // メモリ保持用の計算用紙データ（アプリ終了まで保持、画面遷移しても消えない）
  static final Map<String, List<dynamic>> _scratchPaperMemory = {};

  static const String _version = '1.0.0';
  static const String _versionKey = '$_namespace/version';
  static const String _lastUserIdKey = '$_namespace/last_user_id';

  // ============================================================================
  // in-memory cache (hot paths: problem list filtering, slot rendering)
  // ============================================================================
  static final Map<String, List<Map<String, dynamic>>> _learningHistoryCache =
      {};
  static final Map<String, Map<String, dynamic>> _learningDataCache = {};
  static final Map<String, Map<String, dynamic>> _cloudLearningDataCache = {};
  static final Map<String, Map<String, dynamic>> _cloudGachaSettingsCache = {};
  static Map<String, dynamic>? _cloudUserSettingsCache;
  static final Map<String, Map<String, dynamic>> _cloudOtherSettingsCache = {};
  static Future<void>? _webCloudSyncFuture;
  static String? _webCloudReadyUserId;
  static String? _cloudLearningReadyUserId;
  static DateTime? _cloudLearningLastFetchedAt;
  static String? _cloudSettingsReadyUserId;
  static DateTime? _cloudSettingsLastFetchedAt;
  static bool _hasPendingLearningSync = false;
  static bool _hasPendingSettingsSync = false;
  static const int _learningSlotCount = 3;
  static const Duration _cloudLearningCacheTtl = Duration(seconds: 5);
  static const Duration _cloudSettingsCacheTtl = Duration(seconds: 5);

  static Future<bool> _isCloudSyncEnabled() async {
    if (!FirebaseAuthService.isAuthenticated) return false;
    return CloudSyncPreferenceService.isEnabledForUser(
      FirebaseAuthService.userId,
    );
  }

  /// Clears in-memory cloud caches when the user disables cloud sync.
  static void clearCloudCaches() {
    _clearCloudLearningCache();
    _clearCloudSettingsCache();
    _webCloudReadyUserId = null;
    _webCloudSyncFuture = null;
  }

  static Future<bool> ensureWebCloudSyncReady({bool force = false}) async {
    if (!FirebaseAuthService.isAuthenticated ||
        FirebaseAuthService.userId == null) {
      _webCloudReadyUserId = null;
      _clearCloudLearningCache();
      _clearCloudSettingsCache();
      return false;
    }

    if (!await _isCloudSyncEnabled()) {
      clearCloudCaches();
      return false;
    }

    final userId = FirebaseAuthService.userId!;
    if (!force &&
        _webCloudReadyUserId == userId &&
        _webCloudSyncFuture == null) {
      return true;
    }

    if (_webCloudSyncFuture != null) {
      await _webCloudSyncFuture;
      if (!force && _webCloudReadyUserId == userId) {
        return true;
      }
    }

    _webCloudSyncFuture = () async {
      try {
        final learningReady = await _ensureCloudLearningStateCurrent(
          force: force,
        );
        final settingsReady = await _ensureCloudSettingsStateCurrent(
          force: force,
        );
        if (!learningReady || !settingsReady) {
          throw StateError('Cloud sync warm-up did not complete');
        }
      } finally {
        if (FirebaseAuthService.userId == userId) {
          _webCloudReadyUserId = userId;
        }
        _webCloudSyncFuture = null;
      }
    }();

    try {
      await _webCloudSyncFuture;
      return true;
    } catch (_) {
      if (FirebaseAuthService.userId == userId) {
        _webCloudReadyUserId = null;
      }
      return false;
    }
  }

  static void _cacheLearningDataForProblem(
    String problemId,
    Map<String, dynamic> data,
  ) {
    final normalizedData = Map<String, dynamic>.from(data);
    _learningDataCache[problemId] = normalizedData;
    _learningHistoryCache[problemId] = _normalizeLearningHistoryList(
      normalizedData['history'] as List? ?? const [],
    );
  }

  static void _cacheCloudLearningDataForProblem(
    String problemId,
    Map<String, dynamic> data,
  ) {
    _cloudLearningDataCache[problemId] = _normalizeLearningData(
      problemId: problemId,
      raw: data,
    );
  }

  static void _clearCloudLearningCache() {
    _cloudLearningDataCache.clear();
    _cloudLearningReadyUserId = null;
    _cloudLearningLastFetchedAt = null;
  }

  static void _clearCloudSettingsCache() {
    _cloudGachaSettingsCache.clear();
    _cloudUserSettingsCache = null;
    _cloudOtherSettingsCache.clear();
    _cloudSettingsReadyUserId = null;
    _cloudSettingsLastFetchedAt = null;
  }

  static void _clearLearningCaches() {
    _learningHistoryCache.clear();
    _learningDataCache.clear();
    _clearCloudLearningCache();
  }

  static String _otherSettingMetaKey(String key) =>
      '$_namespace/other_setting_meta/${Uri.encodeComponent(key)}';

  static Map<String, dynamic> _normalizeTimestampedSettingsMap(
    Map<String, dynamic>? raw, {
    Map<String, dynamic> defaults = const {},
  }) {
    final normalized = Map<String, dynamic>.from(defaults);
    if (raw != null) {
      normalized.addAll(raw);
    }
    normalized['lastUpdated'] =
        _normalizeTimeString(normalized['lastUpdated']) ??
        DateTime.now().toIso8601String();
    return normalized;
  }

  static Map<String, dynamic> _mergeLatestTimestampedData({
    Map<String, dynamic>? localData,
    Map<String, dynamic>? cloudData,
    Map<String, dynamic> defaults = const {},
  }) {
    final normalizedLocal = localData == null
        ? null
        : _normalizeTimestampedSettingsMap(localData, defaults: defaults);
    final normalizedCloud = cloudData == null
        ? null
        : _normalizeTimestampedSettingsMap(cloudData, defaults: defaults);

    if (normalizedLocal == null) {
      return normalizedCloud ?? _normalizeTimestampedSettingsMap(defaults);
    }
    if (normalizedCloud == null) {
      return normalizedLocal;
    }

    final localUpdated = _parseTimestamp(
      normalizedLocal['lastUpdated'] as String?,
    );
    final cloudUpdated = _parseTimestamp(
      normalizedCloud['lastUpdated'] as String?,
    );

    if (localUpdated != null && cloudUpdated != null) {
      return localUpdated.isAfter(cloudUpdated)
          ? normalizedLocal
          : normalizedCloud;
    }
    if (localUpdated != null) {
      return normalizedLocal;
    }
    return normalizedCloud;
  }

  static bool _areTimestampedSettingsEquivalent(
    Map<String, dynamic>? left,
    Map<String, dynamic>? right, {
    Map<String, dynamic> defaults = const {},
  }) {
    final normalizedLeft = _normalizeTimestampedSettingsMap(
      left,
      defaults: defaults,
    );
    final normalizedRight = _normalizeTimestampedSettingsMap(
      right,
      defaults: defaults,
    );
    return json.encode(normalizedLeft) == json.encode(normalizedRight);
  }

  static Future<void> _saveLocalTimestampedSettingsMap(
    String key,
    Map<String, dynamic> data, {
    Map<String, dynamic> defaults = const {},
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final normalized = _normalizeTimestampedSettingsMap(
      data,
      defaults: defaults,
    );
    await prefs.setString(key, json.encode(normalized));
  }

  static Future<Map<String, dynamic>> _loadLocalTimestampedSettingsMap(
    String key, {
    Map<String, dynamic> defaults = const {},
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(key);
    if (raw != null) {
      try {
        final decoded = json.decode(raw);
        if (decoded is Map<String, dynamic>) {
          return _normalizeTimestampedSettingsMap(decoded, defaults: defaults);
        }
      } catch (_) {}
    }
    return _normalizeTimestampedSettingsMap(defaults, defaults: defaults);
  }

  static Future<void> _saveLocalOtherSettingEntry(
    String key,
    dynamic value, {
    String? lastUpdated,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    if (value == null) {
      await prefs.remove(key);
      await prefs.remove(_otherSettingMetaKey(key));
      return;
    }

    if (value is int) {
      await prefs.setInt(key, value);
    } else if (value is String) {
      await prefs.setString(key, value);
    } else if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is double) {
      await prefs.setDouble(key, value);
    } else if (value is List<String>) {
      await prefs.setString(key, json.encode(value));
    } else if (value is List) {
      await prefs.setString(key, json.encode(value));
    } else if (value is Map<String, dynamic>) {
      await prefs.setString(key, json.encode(value));
    } else {
      await prefs.setString(key, json.encode(value));
    }

    await prefs.setString(
      _otherSettingMetaKey(key),
      lastUpdated ?? DateTime.now().toIso8601String(),
    );
  }

  static Future<Map<String, dynamic>?> _loadLocalOtherSettingEntry(
    String key,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.get(key);
    if (value == null) {
      return null;
    }

    dynamic normalizedValue = value;
    if (value is String) {
      try {
        normalizedValue = json.decode(value);
      } catch (_) {
        normalizedValue = value;
      }
    }

    final lastUpdated = prefs.getString(_otherSettingMetaKey(key));
    return {'key': key, 'value': normalizedValue, 'lastUpdated': lastUpdated};
  }

  static Map<String, dynamic>? _mergeLatestOtherSettingEntry({
    Map<String, dynamic>? localEntry,
    Map<String, dynamic>? cloudEntry,
  }) {
    if (localEntry == null)
      return cloudEntry == null ? null : Map<String, dynamic>.from(cloudEntry);
    if (cloudEntry == null) {
      final normalized = Map<String, dynamic>.from(localEntry);
      normalized['lastUpdated'] =
          _normalizeTimeString(normalized['lastUpdated']) ??
          DateTime.now().toIso8601String();
      return normalized;
    }

    final normalizedLocal = Map<String, dynamic>.from(localEntry);
    normalizedLocal['lastUpdated'] =
        _normalizeTimeString(normalizedLocal['lastUpdated']) ??
        DateTime.now().toIso8601String();
    final normalizedCloud = Map<String, dynamic>.from(cloudEntry);
    normalizedCloud['lastUpdated'] =
        _normalizeTimeString(normalizedCloud['lastUpdated']) ??
        DateTime.now().toIso8601String();

    final localUpdated = _parseTimestamp(
      normalizedLocal['lastUpdated'] as String?,
    );
    final cloudUpdated = _parseTimestamp(
      normalizedCloud['lastUpdated'] as String?,
    );
    if (localUpdated != null && cloudUpdated != null) {
      return localUpdated.isAfter(cloudUpdated)
          ? normalizedLocal
          : normalizedCloud;
    }
    if (localUpdated != null) {
      return normalizedLocal;
    }
    return normalizedCloud;
  }

  static Map<String, dynamic> _defaultLearningData(String problemId) {
    final now = DateTime.now().toIso8601String();
    return {
      'problemId': problemId,
      'latestStatus': 'none',
      'history': List.generate(
        _learningSlotCount,
        (_) => <String, dynamic>{'status': 'none', 'time': null},
      ),
      'lastUpdated': now,
    };
  }

  static String? _normalizeTimeString(dynamic value) {
    if (value is String && value.isNotEmpty) {
      return value;
    }
    if (value is DateTime) {
      return value.toIso8601String();
    }
    return null;
  }

  static DateTime? _parseTimestamp(String? value) {
    if (value == null || value.isEmpty) return null;
    try {
      return DateTime.parse(value);
    } catch (_) {
      return null;
    }
  }

  static List<Map<String, dynamic>> _extractMeaningfulLearningHistory(
    List? history,
  ) {
    final normalized = _normalizeLearningHistoryList(history);
    final meaningful = normalized
        .where((item) {
          final status = item['status'] as String? ?? 'none';
          final time = item['time'] as String?;
          return status != 'none' && time != null && time.isNotEmpty;
        })
        .map((item) => Map<String, dynamic>.from(item))
        .toList();

    meaningful.sort((a, b) {
      final timeA = a['time'] as String? ?? '';
      final timeB = b['time'] as String? ?? '';
      return timeA.compareTo(timeB);
    });
    return meaningful;
  }

  static List<Map<String, dynamic>> _buildLearningHistorySlots(
    List<Map<String, dynamic>> entries,
  ) {
    final slots = List.generate(
      _learningSlotCount,
      (_) => <String, dynamic>{'status': 'none', 'time': null},
    );
    final recentEntries = entries.length <= _learningSlotCount
        ? entries
        : entries.sublist(entries.length - _learningSlotCount);

    for (var i = 0; i < recentEntries.length; i++) {
      slots[i] = Map<String, dynamic>.from(recentEntries[i]);
    }
    return slots;
  }

  static String _deriveLatestStatus(List<Map<String, dynamic>> slots) {
    for (var i = slots.length - 1; i >= 0; i--) {
      final status = slots[i]['status'] as String? ?? 'none';
      if (status != 'none') {
        return status;
      }
    }
    return 'none';
  }

  static bool _isClearedLearningData(Map<String, dynamic> data) {
    final meaningfulHistory = _extractMeaningfulLearningHistory(
      data['history'] as List?,
    );
    final latestStatus = data['latestStatus'] as String? ?? 'none';
    return meaningfulHistory.isEmpty && latestStatus == 'none';
  }

  static String _resolveLastUpdated({
    required List<Map<String, dynamic>> meaningfulHistory,
    String? explicitLastUpdated,
  }) {
    if (meaningfulHistory.isNotEmpty) {
      return meaningfulHistory.last['time'] as String;
    }
    final normalizedExplicit = _normalizeTimeString(explicitLastUpdated);
    if (normalizedExplicit != null) {
      return normalizedExplicit;
    }
    return DateTime.now().toIso8601String();
  }

  static Map<String, dynamic> _normalizeLearningData({
    required String problemId,
    Map<String, dynamic>? raw,
  }) {
    if (raw == null) {
      return _defaultLearningData(problemId);
    }

    final meaningfulHistory = _extractMeaningfulLearningHistory(
      raw['history'] as List?,
    );
    final slots = _buildLearningHistorySlots(meaningfulHistory);
    return {
      'problemId': raw['problemId'] as String? ?? problemId,
      'latestStatus': _deriveLatestStatus(slots),
      'history': slots,
      'lastUpdated': _resolveLastUpdated(
        meaningfulHistory: meaningfulHistory,
        explicitLastUpdated: raw['lastUpdated'] as String?,
      ),
    };
  }

  static Map<String, dynamic> _mergeLearningData({
    required String problemId,
    Map<String, dynamic>? localData,
    Map<String, dynamic>? cloudData,
  }) {
    final normalizedLocal = localData == null
        ? null
        : _normalizeLearningData(problemId: problemId, raw: localData);
    final normalizedCloud = cloudData == null
        ? null
        : _normalizeLearningData(problemId: problemId, raw: cloudData);

    if (normalizedLocal == null) {
      return normalizedCloud ?? _defaultLearningData(problemId);
    }
    if (normalizedCloud == null) {
      return normalizedLocal;
    }

    final localUpdated = _parseTimestamp(
      normalizedLocal['lastUpdated'] as String?,
    );
    final cloudUpdated = _parseTimestamp(
      normalizedCloud['lastUpdated'] as String?,
    );

    if (_isClearedLearningData(normalizedLocal) &&
        (cloudUpdated == null ||
            (localUpdated != null && !localUpdated.isBefore(cloudUpdated)))) {
      return normalizedLocal;
    }
    if (_isClearedLearningData(normalizedCloud) &&
        (localUpdated == null ||
            (cloudUpdated != null && !cloudUpdated.isBefore(localUpdated)))) {
      return normalizedCloud;
    }

    final mergedByTime = <String, Map<String, dynamic>>{};
    for (final entry in _extractMeaningfulLearningHistory(
      normalizedCloud['history'] as List?,
    )) {
      final time = entry['time'] as String?;
      if (time != null && time.isNotEmpty) {
        mergedByTime[time] = Map<String, dynamic>.from(entry);
      }
    }
    for (final entry in _extractMeaningfulLearningHistory(
      normalizedLocal['history'] as List?,
    )) {
      final time = entry['time'] as String?;
      if (time != null && time.isNotEmpty) {
        mergedByTime.putIfAbsent(time, () => Map<String, dynamic>.from(entry));
      }
    }

    final mergedEntries = mergedByTime.values.toList()
      ..sort((a, b) {
        final timeA = a['time'] as String? ?? '';
        final timeB = b['time'] as String? ?? '';
        return timeA.compareTo(timeB);
      });

    final slots = _buildLearningHistorySlots(mergedEntries);
    final mergedUpdatedCandidates = <DateTime>[
      if (localUpdated != null) localUpdated,
      if (cloudUpdated != null) cloudUpdated,
      if (mergedEntries.isNotEmpty)
        _parseTimestamp(mergedEntries.last['time'] as String?) ??
            DateTime.fromMillisecondsSinceEpoch(0),
    ];
    mergedUpdatedCandidates.sort();
    final mergedLastUpdated = mergedUpdatedCandidates.isNotEmpty
        ? mergedUpdatedCandidates.last.toIso8601String()
        : DateTime.now().toIso8601String();

    return {
      'problemId': problemId,
      'latestStatus': _deriveLatestStatus(slots),
      'history': slots,
      'lastUpdated': mergedLastUpdated,
    };
  }

  static bool _areLearningDataEquivalent(
    Map<String, dynamic>? left,
    Map<String, dynamic>? right,
    String problemId,
  ) {
    final normalizedLeft = left == null
        ? _defaultLearningData(problemId)
        : _normalizeLearningData(problemId: problemId, raw: left);
    final normalizedRight = right == null
        ? _defaultLearningData(problemId)
        : _normalizeLearningData(problemId: problemId, raw: right);
    return json.encode(normalizedLeft) == json.encode(normalizedRight);
  }

  static Future<void> _saveLocalLearningData(
    String problemId,
    Map<String, dynamic> data,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final normalized = _normalizeLearningData(problemId: problemId, raw: data);
    final key = '$_namespace/learning/$problemId';
    await prefs.setString(key, json.encode(normalized));
    _cacheLearningDataForProblem(problemId, normalized);
  }

  static Future<bool> _ensureCloudLearningStateCurrent({
    bool force = false,
  }) async {
    if (!FirebaseAuthService.isAuthenticated ||
        FirebaseAuthService.userId == null) {
      _clearCloudLearningCache();
      return false;
    }

    if (!await _isCloudSyncEnabled()) {
      _clearCloudLearningCache();
      return false;
    }

    if (await isAccountSwitched()) {
      await syncOnAccountSwitch();
      return await _syncFromFirestore(force: false);
    }

    final shouldPushLocal = force || _hasPendingLearningSync;
    if (shouldPushLocal) {
      await syncLocalDataToFirestore(force: true);
    }
    return await _syncFromFirestore(force: force || shouldPushLocal);
  }

  static bool _isSettingsCacheFresh() {
    return _cloudSettingsLastFetchedAt != null &&
        DateTime.now().difference(_cloudSettingsLastFetchedAt!) <
            _cloudSettingsCacheTtl;
  }

  static Map<String, dynamic>? _normalizeOtherSettingEntry(
    Map<String, dynamic>? entry,
  ) {
    if (entry == null) return null;
    final normalized = Map<String, dynamic>.from(entry);
    normalized['lastUpdated'] =
        _normalizeTimeString(normalized['lastUpdated']) ??
        DateTime.now().toIso8601String();
    return normalized;
  }

  static bool _areOtherSettingEntriesEquivalent(
    Map<String, dynamic>? left,
    Map<String, dynamic>? right,
  ) {
    final normalizedLeft = _normalizeOtherSettingEntry(left);
    final normalizedRight = _normalizeOtherSettingEntry(right);
    return json.encode(normalizedLeft) == json.encode(normalizedRight);
  }

  static Future<Set<String>> _collectTrackedOtherSettingKeys(
    SharedPreferences prefs,
  ) async {
    final keys = <String>{
      'integral_gacha_exclusion_mode',
      'limit_gacha_exclusion_mode',
      'sequence_gacha_exclusion_mode',
      'integral_gacha_max_selections',
      'limit_gacha_max_selections',
      'sequence_gacha_max_selections',
      _selectedFreeGachasKey,
      ..._cloudOtherSettingsCache.keys,
    };

    for (final key in prefs.getKeys()) {
      if (key.endsWith('_aggregation_mode_v1') ||
          key.endsWith('_gacha_exclusion_mode') ||
          key.endsWith('_gacha_max_selections')) {
        keys.add(key);
      }
      if (key.startsWith('$_namespace/other_setting_meta/')) {
        keys.add(Uri.decodeComponent(key.split('/').last));
      }
    }

    return keys;
  }

  static Future<bool> _syncSettingsFromFirestore({bool force = false}) async {
    try {
      final userId = FirebaseAuthService.userId;
      if (userId == null) {
        _clearCloudSettingsCache();
        return false;
      }
      if (!force &&
          _cloudSettingsReadyUserId == userId &&
          _isSettingsCacheFresh()) {
        return true;
      }

      final results = await Future.wait([
        FirestoreSettingsService.getAllGachaSettings(userId: userId),
        FirestoreSettingsService.getUserSettings(userId: userId),
        FirestoreSettingsService.getAllOtherSettingEntries(userId: userId),
      ]).timeout(const Duration(seconds: 10));

      final gachaSettings = results[0] as Map<String, Map<String, dynamic>>;
      final userSettings = results[1];
      final otherSettings = results[2] as Map<String, Map<String, dynamic>>;

      _clearCloudSettingsCache();
      for (final entry in gachaSettings.entries) {
        _cloudGachaSettingsCache[entry.key] = _normalizeTimestampedSettingsMap(
          entry.value,
          defaults: _getDefaultGachaSettings(),
        );
      }
      if (userSettings != null) {
        _cloudUserSettingsCache = _normalizeTimestampedSettingsMap(
          userSettings,
        );
      }
      for (final entry in otherSettings.entries) {
        final normalized = _normalizeOtherSettingEntry(entry.value);
        if (normalized != null) {
          _cloudOtherSettingsCache[entry.key] = normalized;
        }
      }

      _cloudSettingsReadyUserId = userId;
      _cloudSettingsLastFetchedAt = DateTime.now();
      return true;
    } catch (e) {
      AppLogger.error('Firestoreからの設定取得に失敗しました', error: e);
      return false;
    }
  }

  static Future<bool> _ensureCloudSettingsStateCurrent({
    bool force = false,
  }) async {
    if (!FirebaseAuthService.isAuthenticated ||
        FirebaseAuthService.userId == null) {
      _clearCloudSettingsCache();
      return false;
    }

    if (!await _isCloudSyncEnabled()) {
      _clearCloudSettingsCache();
      return false;
    }

    if (await isAccountSwitched()) {
      await syncOnAccountSwitch();
      return await _syncSettingsFromFirestore(force: false);
    }

    final shouldPushLocal = force || _hasPendingSettingsSync;
    if (shouldPushLocal) {
      await syncLocalSettingsToFirestore(force: true);
    }
    return await _syncSettingsFromFirestore(force: force || shouldPushLocal);
  }

  static List<Map<String, dynamic>> _normalizeLearningHistoryList(
    List? history,
  ) {
    return (history ?? const []).whereType<Map>().map((item) {
      final status = item['status'];
      final time = item['time'];
      String normalizedStatus;
      switch (status) {
        case 'solved':
          normalizedStatus = 'solved';
          break;
        case 'understood':
          normalizedStatus = 'understood';
          break;
        case 'failed':
          normalizedStatus = 'failed';
          break;
        default:
          normalizedStatus = 'none';
      }
      return {'status': normalizedStatus, 'time': time is String ? time : null};
    }).toList();
  }

  // ============================================================================
  // 初期化とバージョン管理
  // ============================================================================

  /// システムの初期化
  static Future<bool> initialize() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final currentVersion = prefs.getString(_versionKey);

      if (currentVersion != _version) {
        AppLogger.info('SimpleDataManagerを初期化中', details: 'バージョン: $_version');

        // バージョンを更新
        await prefs.setString(_versionKey, _version);

        AppLogger.success('SimpleDataManagerの初期化が完了しました');
      }

      if (!FirebaseAuthService.isAuthenticated) {
        _clearCloudLearningCache();
        _clearCloudSettingsCache();
        _webCloudReadyUserId = null;
        return true;
      }

      final userId = FirebaseAuthService.userId;
      if (userId == null) {
        _clearCloudLearningCache();
        _clearCloudSettingsCache();
        _webCloudReadyUserId = null;
        return true;
      }

      if (await isAccountSwitched()) {
        await syncOnAccountSwitch();
        return true;
      }

      if (await _isCloudSyncEnabled()) {
        await _ensureCloudLearningStateCurrent(force: true);
        await _ensureCloudSettingsStateCurrent(force: true);
      } else {
        clearCloudCaches();
      }
      await setLastUserId(userId);

      return true;
    } catch (e) {
      AppLogger.error('SimpleDataManagerの初期化に失敗しました', error: e);
      return false;
    }
  }

  /// Firestoreから学習データを取得してメモリキャッシュを更新
  static Future<bool> _syncFromFirestore({bool force = false}) async {
    try {
      final userId = FirebaseAuthService.userId;
      if (userId == null) {
        _clearCloudLearningCache();
        return false;
      }
      final cacheIsFresh =
          _cloudLearningLastFetchedAt != null &&
          DateTime.now().difference(_cloudLearningLastFetchedAt!) <
              _cloudLearningCacheTtl;
      if (!force && _cloudLearningReadyUserId == userId && cacheIsFresh) {
        return true;
      }

      final firestoreRecords =
          await FirestoreLearningService.getAllLearningRecords(
            userId: userId,
          ).timeout(const Duration(seconds: 10));

      _clearCloudLearningCache();
      for (final entry in firestoreRecords.entries) {
        _cacheCloudLearningDataForProblem(entry.key, entry.value);
      }
      _cloudLearningReadyUserId = userId;
      _cloudLearningLastFetchedAt = DateTime.now();
      return true;
    } catch (e) {
      AppLogger.error('Firestoreからの学習データ取得に失敗しました', error: e);
      return false;
    }
  }

  /// ローカル設定をFirestoreに同期（認証時に呼び出す）
  static Future<void> syncLocalSettingsToFirestore({bool force = false}) async {
    try {
      if (!FirebaseAuthService.isAuthenticated) {
        return;
      }
      if (!await _isCloudSyncEnabled()) {
        return;
      }

      final userId = FirebaseAuthService.userId;
      if (userId == null) {
        return;
      }
      if (!force && !_hasPendingSettingsSync) {
        return;
      }

      final prefs = await SharedPreferences.getInstance();
      final gachaKeys = prefs
          .getKeys()
          .where(
            (key) =>
                key.startsWith('$_namespace/gacha/') &&
                key != '$_namespace/gacha',
          )
          .toList();

      final cloudReady = await _syncSettingsFromFirestore(force: true);
      if (!cloudReady) {
        return;
      }

      var allSynced = true;
      var wroteAny = false;

      for (final key in gachaKeys) {
        final dataString = prefs.getString(key);
        if (dataString == null) continue;

        try {
          final decoded = json.decode(dataString);
          if (decoded is! Map<String, dynamic>) {
            allSynced = false;
            continue;
          }

          final gachaType = key.replaceFirst('$_namespace/gacha/', '');
          final localSettings = _normalizeTimestampedSettingsMap(
            decoded,
            defaults: _getDefaultGachaSettings(),
          );
          final cloudSettings = _cloudGachaSettingsCache[gachaType];
          final mergedSettings = _mergeLatestTimestampedData(
            localData: localSettings,
            cloudData: cloudSettings,
            defaults: _getDefaultGachaSettings(),
          );

          if (_areTimestampedSettingsEquivalent(
            cloudSettings,
            mergedSettings,
            defaults: _getDefaultGachaSettings(),
          )) {
            continue;
          }

          final success = await FirestoreSettingsService.saveGachaSettings(
            userId: userId,
            gachaType: gachaType,
            settings: mergedSettings,
          );
          if (!success) {
            allSynced = false;
            continue;
          }

          _cloudGachaSettingsCache[gachaType] = mergedSettings;
          wroteAny = true;
        } catch (e) {
          print('Error syncing gacha settings $key to Firestore: $e');
          allSynced = false;
        }
      }

      final userSettingsKey = '$_namespace/user_settings';
      final userSettingsString = prefs.getString(userSettingsKey);
      if (userSettingsString != null) {
        try {
          final decoded = json.decode(userSettingsString);
          if (decoded is! Map<String, dynamic>) {
            allSynced = false;
          } else {
            final localSettings = _normalizeTimestampedSettingsMap(decoded);
            final cloudSettings = _cloudUserSettingsCache;
            final mergedSettings = _mergeLatestTimestampedData(
              localData: localSettings,
              cloudData: cloudSettings,
            );

            if (!_areTimestampedSettingsEquivalent(
              cloudSettings,
              mergedSettings,
            )) {
              final success = await FirestoreSettingsService.saveUserSettings(
                userId: userId,
                settings: mergedSettings,
              );
              if (!success) {
                allSynced = false;
              } else {
                _cloudUserSettingsCache = mergedSettings;
                wroteAny = true;
              }
            }
          }
        } catch (e) {
          print('Error syncing user settings to Firestore: $e');
          allSynced = false;
        }
      }

      final otherSettingKeys = await _collectTrackedOtherSettingKeys(prefs);
      for (final settingKey in otherSettingKeys) {
        try {
          final localEntry = await _loadLocalOtherSettingEntry(settingKey);
          final cloudEntry = _cloudOtherSettingsCache[settingKey];
          final mergedEntry = _mergeLatestOtherSettingEntry(
            localEntry: localEntry,
            cloudEntry: cloudEntry,
          );

          if (mergedEntry == null ||
              _areOtherSettingEntriesEquivalent(cloudEntry, mergedEntry)) {
            continue;
          }

          final success = await FirestoreSettingsService.saveOtherSetting(
            userId: userId,
            key: settingKey,
            value: mergedEntry['value'],
            lastUpdated: mergedEntry['lastUpdated'] as String?,
          );
          if (!success) {
            allSynced = false;
            continue;
          }

          _cloudOtherSettingsCache[settingKey] = mergedEntry;
          wroteAny = true;
        } catch (e) {
          print('Error syncing other setting $settingKey to Firestore: $e');
          allSynced = false;
        }
      }

      if (allSynced) {
        _hasPendingSettingsSync = false;
      }
      if (wroteAny) {
        _cloudSettingsReadyUserId = null;
      }
    } catch (e) {
      print('Error syncing local settings to Firestore: $e');
    }
  }

  /// ローカルデータをクラウドへマージして同期する
  static Future<void> syncLocalDataToFirestore({bool force = false}) async {
    try {
      if (!FirebaseAuthService.isAuthenticated) {
        return;
      }
      if (!await _isCloudSyncEnabled()) {
        return;
      }

      final userId = FirebaseAuthService.userId;
      if (userId == null) {
        return;
      }
      if (!force && !_hasPendingLearningSync) {
        return;
      }

      final prefs = await SharedPreferences.getInstance();
      final learningKeys = prefs
          .getKeys()
          .where(
            (key) =>
                key.startsWith('$_namespace/learning/') &&
                key != '$_namespace/learning',
          )
          .toList();

      if (learningKeys.isEmpty) {
        _hasPendingLearningSync = false;
        return;
      }

      final cloudReady = await _syncFromFirestore(force: true);
      if (!cloudReady) {
        return;
      }

      var allSynced = true;
      var wroteAny = false;

      for (final key in learningKeys) {
        final dataString = prefs.getString(key);
        if (dataString == null) {
          continue;
        }

        try {
          final decoded = json.decode(dataString);
          if (decoded is! Map<String, dynamic>) {
            allSynced = false;
            continue;
          }

          final problemId = key.replaceFirst('$_namespace/learning/', '');
          final localData = _normalizeLearningData(
            problemId: problemId,
            raw: decoded,
          );
          final cloudData = _cloudLearningDataCache[problemId];
          final mergedData = _mergeLearningData(
            problemId: problemId,
            localData: localData,
            cloudData: cloudData,
          );

          if (_areLearningDataEquivalent(cloudData, mergedData, problemId)) {
            continue;
          }

          final success = await FirestoreLearningService.saveLearningRecord(
            userId: userId,
            problemId: problemId,
            data: mergedData,
          );
          if (!success) {
            allSynced = false;
            continue;
          }

          _cacheCloudLearningDataForProblem(problemId, mergedData);
          wroteAny = true;
        } catch (e) {
          print('Error syncing local learning data for $key: $e');
          allSynced = false;
        }
      }

      if (allSynced) {
        _hasPendingLearningSync = false;
      }
      if (wroteAny) {
        _cloudLearningReadyUserId = null;
      }
    } catch (e) {
      print('Error syncing local data to Firestore: $e');
    }
  }

  /// ログイン後や手動同期時に、ローカルをクラウドへマージしてから表示用クラウドデータを更新する
  static Future<bool> performCloudSync({bool force = true}) async {
    final userId = FirebaseAuthService.userId;
    if (!FirebaseAuthService.isAuthenticated || userId == null) {
      return false;
    }

    if (!await _isCloudSyncEnabled()) {
      clearCloudCaches();
      return false;
    }

    if (await isAccountSwitched()) {
      await syncOnAccountSwitch();
      return true;
    }

    final learningReady = await _ensureCloudLearningStateCurrent(force: force);
    final settingsReady = await _ensureCloudSettingsStateCurrent(force: force);
    await setLastUserId(userId);
    return learningReady && settingsReady;
  }

  // ============================================================================
  // 学習記録管理（シンプル版）
  // ============================================================================

  static String _statusKeyFromValue(dynamic status) {
    if (status is LearningStatus) {
      return status.key;
    }
    if (status is ProblemStatus) {
      return status.name;
    }
    if (status is String) {
      return status;
    }
    return 'none';
  }

  /// 学習記録を保存
  static Future<bool> saveLearningRecord(
    MathProblem problem,
    dynamic status,
  ) async {
    try {
      final existingData = await _getLearningData(problem);
      final entries = _extractMeaningfulLearningHistory(
        existingData['history'] as List?,
      );
      final statusKey = _statusKeyFromValue(status);
      if (statusKey != 'none') {
        entries.add({
          'status': statusKey,
          'time': DateTime.now().toIso8601String(),
        });
      }

      final data = _normalizeLearningData(
        problemId: problem.id,
        raw: {
          'problemId': problem.id,
          'history': entries,
          'lastUpdated': DateTime.now().toIso8601String(),
        },
      );

      await _saveLocalLearningData(problem.id, data);
      final hadPendingBefore = _hasPendingLearningSync;
      _hasPendingLearningSync = true;

      if (FirebaseAuthService.isAuthenticated) {
        final cloudReady = await _ensureCloudLearningStateCurrent(force: true);
        if (cloudReady && !hadPendingBefore) {
          _hasPendingLearningSync = false;
        }
      }

      return true;
    } catch (e) {
      print('Error saving learning record: $e');
      return false;
    }
  }

  /// 学習記録を取得
  static Future<LearningStatus> getLearningRecord(MathProblem problem) async {
    try {
      if (FirebaseAuthService.isAuthenticated) {
        final cloudReady = await _ensureCloudLearningStateCurrent();
        if (cloudReady) {
          final cloudData =
              _cloudLearningDataCache[problem.id] ??
              _defaultLearningData(problem.id);
          final statusKey = cloudData['latestStatus'] as String?;
          return statusKey != null
              ? LearningStatusExtension.fromKey(statusKey)
              : LearningStatus.none;
        }
      }

      final localData = await _getLearningData(problem);
      final statusKey = localData['latestStatus'] as String?;
      return statusKey != null
          ? LearningStatusExtension.fromKey(statusKey)
          : LearningStatus.none;
    } catch (e) {
      print('Error getting learning record: $e');
      return LearningStatus.none;
    }
  }

  /// 学習記録の履歴を取得
  static Future<List<Map<String, dynamic>>> getLearningHistory(
    MathProblem problem,
  ) async {
    try {
      if (FirebaseAuthService.isAuthenticated) {
        final cloudReady = await _ensureCloudLearningStateCurrent();
        if (cloudReady) {
          final cloudData =
              _cloudLearningDataCache[problem.id] ??
              _defaultLearningData(problem.id);
          return _normalizeLearningHistoryList(cloudData['history'] as List?);
        }
      }

      final cached = _learningHistoryCache[problem.id];
      if (cached != null) {
        return cached;
      }

      final localData = await _getLearningData(problem);
      final history = _normalizeLearningHistoryList(
        localData['history'] as List?,
      );
      _learningHistoryCache[problem.id] = history;
      return history;
    } catch (e) {
      print('Error getting learning history: $e');
      return [];
    }
  }

  /// 複数問題の履歴を一括取得
  static Future<Map<String, List<Map<String, dynamic>>>> getLearningHistoryMap(
    Iterable<String> problemIds,
  ) async {
    final ids = problemIds.toSet();
    if (ids.isEmpty) return {};

    if (FirebaseAuthService.isAuthenticated) {
      final cloudReady = await _ensureCloudLearningStateCurrent();
      if (cloudReady) {
        final out = <String, List<Map<String, dynamic>>>{};
        for (final id in ids) {
          final cloudData =
              _cloudLearningDataCache[id] ?? _defaultLearningData(id);
          out[id] = _normalizeLearningHistoryList(
            cloudData['history'] as List?,
          );
        }
        return out;
      }
    }

    final prefs = await SharedPreferences.getInstance();
    final out = <String, List<Map<String, dynamic>>>{};

    for (final id in ids) {
      // 既にメモリにあるものは再利用
      final cached = _learningHistoryCache[id];
      if (cached != null) {
        out[id] = cached;
        continue;
      }

      final key = '$_namespace/learning/$id';
      final dataString = prefs.getString(key);
      if (dataString == null) {
        _learningHistoryCache[id] = const [];
        out[id] = const [];
        continue;
      }

      try {
        final decoded = json.decode(dataString);
        if (decoded is Map<String, dynamic>) {
          final normalized = _normalizeLearningData(
            problemId: id,
            raw: decoded,
          );
          final history = _normalizeLearningHistoryList(
            normalized['history'] as List?,
          );
          _learningHistoryCache[id] = history;
          out[id] = history;
        } else {
          _learningHistoryCache[id] = const [];
          out[id] = const [];
        }
      } catch (_) {
        _learningHistoryCache[id] = const [];
        out[id] = const [];
      }
    }

    return out;
  }

  /// 学習記録の履歴を保存
  static Future<bool> saveLearningHistory(
    MathProblem problem,
    List<Map<String, dynamic>> history,
  ) async {
    try {
      final normalizedHistory = history.map((entry) {
        return {
          'status': _statusKeyFromValue(entry['status']),
          'time': _normalizeTimeString(entry['time']),
        };
      }).toList();

      final data = _normalizeLearningData(
        problemId: problem.id,
        raw: {
          'problemId': problem.id,
          'history': normalizedHistory,
          'lastUpdated': DateTime.now().toIso8601String(),
        },
      );

      await _saveLocalLearningData(problem.id, data);
      final hadPendingBefore = _hasPendingLearningSync;
      _hasPendingLearningSync = true;

      if (FirebaseAuthService.isAuthenticated) {
        final cloudReady = await _ensureCloudLearningStateCurrent(force: true);
        if (cloudReady && !hadPendingBefore) {
          _hasPendingLearningSync = false;
        }
      }

      return true;
    } catch (e) {
      print('Error saving learning history: $e');
      return false;
    }
  }

  /// 学習記録をクリア（全スロットをnoneにする）
  /// 完全に削除するのではなく、全てnoneの状態で保存する
  /// これにより、次回ログイン時にFirestoreからデータが復活することを防ぐ
  static Future<bool> clearLearningHistory(MathProblem problem) async {
    try {
      // 全てnoneのスロットを作成
      const slotCount = 3;
      final emptyHistory = List.generate(
        slotCount,
        (i) => <String, dynamic>{'status': 'none', 'time': null},
      );

      // saveLearningHistoryを使って全てnoneの状態で保存
      // これにより、ローカルとFirestoreの両方にnoneの状態が保存される
      final success = await saveLearningHistory(problem, emptyHistory);

      if (success) {
        print(
          'Successfully cleared learning history (set all slots to none) for problem ${problem.id}',
        );
      } else {
        print(
          'Warning: Failed to clear learning history for problem ${problem.id}',
        );
      }

      return success;
    } catch (e) {
      print('Error clearing learning history: $e');
      return false;
    }
  }

  /// 学習データを取得（内部メソッド）
  static Future<Map<String, dynamic>> _getLearningData(
    MathProblem problem,
  ) async {
    try {
      final cached = _learningDataCache[problem.id];
      if (cached != null) {
        return _normalizeLearningData(problemId: problem.id, raw: cached);
      }

      final prefs = await SharedPreferences.getInstance();
      final key = '$_namespace/learning/${problem.id}';
      final dataString = prefs.getString(key);

      if (dataString != null) {
        final decoded = json.decode(dataString);
        if (decoded is Map<String, dynamic>) {
          final m = _normalizeLearningData(
            problemId: problem.id,
            raw: Map<String, dynamic>.from(decoded),
          );
          _learningDataCache[problem.id] = m;
          return Map<String, dynamic>.from(m);
        }
      }

      final d = _defaultLearningData(problem.id);
      _learningDataCache[problem.id] = d;
      return Map<String, dynamic>.from(d);
    } catch (e) {
      print('Error getting learning data: $e');
      final d = _defaultLearningData(problem.id);
      _learningDataCache[problem.id] = d;
      return Map<String, dynamic>.from(d);
    }
  }

  // ============================================================================
  // ガチャ管理（シンプル版）
  // ============================================================================

  /// ガチャ設定を保存
  /// 注意: ログイン前の場合はローカルのみに保存される
  /// ログイン後は syncLocalSettingsToFirestore() で同期される
  static Future<bool> saveGachaSettings(
    String gachaType,
    Map<String, dynamic> settings,
  ) async {
    try {
      final key = '$_namespace/gacha/$gachaType';
      final defaultSettings = _getDefaultGachaSettings();
      final now = DateTime.now().toIso8601String();
      final mergedLocal = _normalizeTimestampedSettingsMap(
        settings,
        defaults: defaultSettings,
      );
      mergedLocal['updatedAt'] = now;
      mergedLocal['lastUpdated'] = now;
      await _saveLocalTimestampedSettingsMap(
        key,
        mergedLocal,
        defaults: defaultSettings,
      );

      final hadPendingBefore = _hasPendingSettingsSync;
      _hasPendingSettingsSync = true;
      if (FirebaseAuthService.isAuthenticated) {
        final cloudReady = await _ensureCloudSettingsStateCurrent(force: true);
        if (cloudReady && !hadPendingBefore) {
          _hasPendingSettingsSync = false;
        }
      }

      return true;
    } catch (e) {
      print('Error saving gacha settings: $e');
      return false;
    }
  }

  /// ガチャ設定を取得
  /// ローカルデータを優先して即座に返し、バックグラウンドでFirestoreと同期
  static Future<Map<String, dynamic>> getGachaSettings(String gachaType) async {
    try {
      final key = '$_namespace/gacha/$gachaType';
      if (FirebaseAuthService.isAuthenticated) {
        final cloudReady = await _ensureCloudSettingsStateCurrent();
        if (cloudReady) {
          return _cloudGachaSettingsCache[gachaType] ??
              _normalizeTimestampedSettingsMap(
                null,
                defaults: _getDefaultGachaSettings(),
              );
        }
      }

      return await _loadLocalTimestampedSettingsMap(
        key,
        defaults: _getDefaultGachaSettings(),
      );
    } catch (e) {
      print('Error getting gacha settings: $e');
      return _getDefaultGachaSettings();
    }
  }

  /// デフォルトガチャ設定
  static Map<String, dynamic> _getDefaultGachaSettings() {
    return {
      'filterMode': 'exclude_solved_ge1',
      'slotLevels': [0, 1, 2],
      'rollCount': 0,
      'lastRollTime': null,
      'aggregationMode': 0, // AggregationMode.latest1 (デフォルト)
      'createdAt': DateTime.now().toIso8601String(),
      'updatedAt': DateTime.now().toIso8601String(),
    };
  }

  // ============================================================================
  // データ移行管理
  // ============================================================================

  // ============================================================================
  // 将来の拡張用メソッド（プレースホルダー）
  // ============================================================================

  /// 新しいガチャタイプの設定を保存
  static Future<bool> saveNewGachaType(
    String gachaType,
    Map<String, dynamic> settings,
  ) async {
    // 将来の拡張用
    return await saveGachaSettings(gachaType, settings);
  }

  /// ユーザー設定を保存（将来の拡張用）
  static Future<bool> saveUserSettings(Map<String, dynamic> settings) async {
    try {
      final key = '$_namespace/user_settings';
      final settingsWithTimestamp = Map<String, dynamic>.from(settings);
      settingsWithTimestamp['lastUpdated'] = DateTime.now().toIso8601String();
      await _saveLocalTimestampedSettingsMap(key, settingsWithTimestamp);

      final hadPendingBefore = _hasPendingSettingsSync;
      _hasPendingSettingsSync = true;
      if (FirebaseAuthService.isAuthenticated) {
        final cloudReady = await _ensureCloudSettingsStateCurrent(force: true);
        if (cloudReady && !hadPendingBefore) {
          _hasPendingSettingsSync = false;
        }
      }

      return true;
    } catch (e) {
      print('Error saving user settings: $e');
      return false;
    }
  }

  /// ユーザー設定を取得（将来の拡張用）
  /// ローカルデータを優先して即座に返し、バックグラウンドでFirestoreと同期
  static Future<Map<String, dynamic>> getUserSettings() async {
    try {
      final key = '$_namespace/user_settings';
      if (FirebaseAuthService.isAuthenticated) {
        final cloudReady = await _ensureCloudSettingsStateCurrent();
        if (cloudReady) {
          return _cloudUserSettingsCache ??
              _normalizeTimestampedSettingsMap(const {});
        }
      }

      return await _loadLocalTimestampedSettingsMap(key);
    } catch (e) {
      print('Error getting user settings: $e');
      return {};
    }
  }

  // ============================================================================
  // 有料オプション管理
  // ============================================================================

  /// 有料オプションの購入状態を取得
  /// RevenueCatから購入状態を確認し、SharedPreferencesにも保存（冗長性のため）
  /// ローカルデータを優先して即座に返し、バックグラウンドでFirestoreと同期
  static Future<bool> isPremiumPurchased() async {
    try {
      // まずローカルデータを即座に取得（遅延なし）
      final prefs = await SharedPreferences.getInstance();
      bool localPurchased =
          prefs.getBool('$_namespace/premium_purchased') ?? false;

      // RevenueCatから購入状態を確認（信頼できるソース）
      try {
        final isPurchased =
            await RevenueCatService.isFactorizationOptionPurchased();
        // RevenueCatの状態をSharedPreferencesにも保存（冗長性）
        await prefs.setBool('$_namespace/premium_purchased', isPurchased);
        localPurchased = isPurchased;
        // 注意: Pro購入情報はFirebaseにバックアップしない（RevenueCatで管理）
      } catch (e) {
        print('Error checking RevenueCat purchase status: $e');
        // RevenueCatの確認に失敗した場合、ローカルデータを使用
      }

      // 注意: Pro購入情報はFirebaseから取得しない（RevenueCatで管理）

      return localPurchased;
    } catch (e) {
      print('Error checking premium purchase: $e');
      return false;
    }
  }

  /// 有料オプションの購入状態を設定
  /// SharedPreferencesに保存（RevenueCatの状態と同期）
  /// Firestoreにも同時に保存
  static Future<bool> setPremiumPurchased(bool purchased) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final now = DateTime.now().toIso8601String();

      // ローカルに即座に保存（UXを下げない）
      await prefs.setBool('$_namespace/premium_purchased', purchased);
      await prefs.setString('$_namespace/premium_purchased_last_updated', now);

      // 注意: Pro購入情報はFirebaseにバックアップしない（RevenueCatで管理）

      return true;
    } catch (e) {
      print('Error setting premium purchase: $e');
      return false;
    }
  }

  // ============================================================================
  // データの一括操作
  // ============================================================================

  /// 全データをエクスポート
  static Future<Map<String, dynamic>> exportAllData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final allKeys = prefs.getKeys();
      final appKeys = allKeys
          .where((key) => key.startsWith(_namespace))
          .toList();

      final Map<String, dynamic> exportData = {};
      for (final key in appKeys) {
        final value = prefs.getString(key);
        if (value != null) {
          exportData[key] = value;
        }
      }

      return exportData;
    } catch (e) {
      print('Error exporting data: $e');
      return {};
    }
  }

  /// 全データをクリア
  static Future<bool> clearAllData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final allKeys = prefs.getKeys();
      final appKeys = allKeys
          .where(
            (key) =>
                key.startsWith(_namespace) ||
                key.startsWith('joymath_gacha_state') ||
                key == 'history_map',
          )
          .toList();

      for (final key in appKeys) {
        await prefs.remove(key);
      }
      _clearLearningCaches();
      _clearCloudSettingsCache();
      _hasPendingLearningSync = false;
      _hasPendingSettingsSync = false;
      _webCloudReadyUserId = null;
      _webCloudSyncFuture = null;
      _scratchPaperMemory.clear();
      return true;
    } catch (e) {
      print('Error clearing data: $e');
      return false;
    }
  }

  /// デバッグ用：全キーを表示
  static Future<void> debugPrintAllKeys() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final allKeys = prefs.getKeys();
      final appKeys = allKeys
          .where((key) => key.startsWith(_namespace))
          .toList();

      print('=== SimpleDataManager Keys ===');
      for (final key in appKeys) {
        print('  $key');
      }
      print('===============================');
    } catch (e) {
      print('Error printing keys: $e');
    }
  }

  // ============================================================================
  // アカウント切り替え管理
  // ============================================================================

  /// 最後にログインしたユーザーIDを取得
  static Future<String?> getLastUserId() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_lastUserIdKey);
    } catch (e) {
      print('Error getting last user ID: $e');
      return null;
    }
  }

  /// 最後にログインしたユーザーIDを保存
  static Future<void> setLastUserId(String userId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_lastUserIdKey, userId);
    } catch (e) {
      print('Error setting last user ID: $e');
    }
  }

  /// アカウント切り替えを検知（前のユーザーIDと現在のユーザーIDを比較）
  static Future<bool> isAccountSwitched() async {
    try {
      final lastUserId = await getLastUserId();
      final currentUserId = FirebaseAuthService.userId;

      // 前のユーザーIDが存在し、現在のユーザーIDと異なる場合はアカウント切り替え
      if (lastUserId != null &&
          currentUserId != null &&
          lastUserId != currentUserId) {
        print('Account switched detected: $lastUserId -> $currentUserId');
        return true;
      }

      return false;
    } catch (e) {
      print('Error checking account switch: $e');
      return false;
    }
  }

  /// アカウント固有のローカルデータをクリア（学習記録、設定など）
  /// バージョン情報や移行フラグは保持
  static Future<bool> clearAccountSpecificData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final allKeys = prefs.getKeys();

      // クリアするキーのパターン
      final patternsToClear = [
        '$_namespace/learning/', // 学習記録
        '$_namespace/gacha/', // ガチャ設定
        '$_namespace/user_settings', // ユーザー設定
        '$_namespace/firestore_sync_completed_', // 同期完了フラグ
      ];

      // 保持するキー（バージョン情報、最後のユーザーID）
      final keysToKeep = [_versionKey, _lastUserIdKey];

      int clearedCount = 0;

      for (final key in allKeys) {
        // 保持するキーはスキップ
        if (keysToKeep.contains(key)) {
          continue;
        }

        // クリア対象のパターンに一致するキーを削除
        bool shouldClear = false;
        for (final pattern in patternsToClear) {
          if (key.startsWith(pattern)) {
            shouldClear = true;
            break;
          }
        }

        // その他の設定キーもクリア（integral_gacha_exclusion_modeなど）
        if (!shouldClear && key.startsWith(_namespace)) {
          // 名前空間内のその他のキーもクリア（ただし、保持するキーは除く）
          if (!keysToKeep.contains(key)) {
            shouldClear = true;
          }
        }

        if (shouldClear) {
          await prefs.remove(key);
          clearedCount++;
        }
      }

      print('Cleared $clearedCount account-specific data keys');
      _clearLearningCaches();
      _clearCloudSettingsCache();
      _webCloudReadyUserId = null;
      _hasPendingLearningSync = false;
      _hasPendingSettingsSync = false;
      return true;
    } catch (e) {
      print('Error clearing account-specific data: $e');
      return false;
    }
  }

  /// アカウント切り替え時のデータ同期処理
  /// 前のアカウントのローカルデータをクリアし、新しいアカウントのFirestoreデータを取得
  static Future<void> syncOnAccountSwitch() async {
    try {
      final currentUserId = FirebaseAuthService.userId;
      if (currentUserId == null) {
        print('No current user, skipping account switch sync');
        return;
      }

      await clearAccountSpecificData();
      if (await _isCloudSyncEnabled()) {
        await _syncFromFirestore(force: true);
        await _syncSettingsFromFirestore(force: true);
      } else {
        clearCloudCaches();
      }
      await setLastUserId(currentUserId);

      print('Account switch sync completed');
    } catch (e) {
      print('Error in account switch sync: $e');
    }
  }

  static Future<dynamic> getOtherSettingValue(String key) async {
    try {
      if (FirebaseAuthService.isAuthenticated) {
        final cloudReady = await _ensureCloudSettingsStateCurrent();
        if (cloudReady) {
          return _cloudOtherSettingsCache[key]?['value'];
        }
      }

      final localEntry = await _loadLocalOtherSettingEntry(key);
      return localEntry?['value'];
    } catch (e) {
      print('Error getting other setting value for $key: $e');
      return null;
    }
  }

  static Future<bool> saveOtherSettingValue(String key, dynamic value) async {
    try {
      await _saveLocalOtherSettingEntry(
        key,
        value,
        lastUpdated: DateTime.now().toIso8601String(),
      );

      final hadPendingBefore = _hasPendingSettingsSync;
      _hasPendingSettingsSync = true;
      if (FirebaseAuthService.isAuthenticated) {
        final cloudReady = await _ensureCloudSettingsStateCurrent(force: true);
        if (cloudReady && !hadPendingBefore) {
          _hasPendingSettingsSync = false;
        }
      }

      return true;
    } catch (e) {
      print('Error saving other setting value for $key: $e');
      return false;
    }
  }

  // ============================================================================
  // 無料で履歴管理可能なガチャ選択機能
  // ============================================================================

  static const String _selectedFreeGachasKey =
      '$_namespace/selected_free_gachas';

  /// 選択された無料ガチャのリストを取得
  static Future<List<String>> getSelectedFreeGachas() async {
    try {
      final value = await getOtherSettingValue(_selectedFreeGachasKey);
      if (value is List) {
        return value.cast<String>();
      }
      return [];
    } catch (e) {
      print('Error getting selected free gachas: $e');
      return [];
    }
  }

  /// 選択された無料ガチャを保存
  /// 注意: 全てのガチャが無料で利用可能なため、この関数は互換性のために残されています
  /// ログイン後は syncLocalSettingsToFirestore() で同期される
  static Future<bool> saveSelectedFreeGachas(List<String> prefsPrefixes) async {
    try {
      await saveOtherSettingValue(_selectedFreeGachasKey, prefsPrefixes);
      print('Saved selected free gachas: $prefsPrefixes');
      return true;
    } catch (e) {
      print('Error saving selected free gachas: $e');
      return false;
    }
  }

  /// 既に無料ガチャが選択済みかどうかを確認
  static Future<bool> hasSelectedFreeGachas() async {
    try {
      final selected = await getSelectedFreeGachas();
      return selected.isNotEmpty;
    } catch (e) {
      print('Error checking if free gachas are selected: $e');
      return false;
    }
  }

  /// 指定されたガチャが無料で履歴管理可能かどうかを確認
  /// 全てのガチャが無料で履歴管理可能
  static Future<bool> isFreeGachaEnabled(String prefsPrefix) async {
    // 全てのガチャが無料で履歴管理可能
    return true;
  }

  /// 学習履歴オプションの購入状態を確認（RevenueCatServiceのラッパー）
  static Future<bool> isLearningHistoryOptionPurchased() async {
    if (!kEnableLearningHistoryAndStoreKitDiagnostics) {
      return false;
    }
    try {
      return await RevenueCatService.isLearningHistoryOptionPurchased();
    } catch (e) {
      print('Error checking learning history option purchase: $e');
      return false;
    }
  }

  // ============================================================================
  // 計算用紙データ
  // ============================================================================

  /// 計算用紙データを保存（メモリのみ）
  static void saveScratchData(String key, List<dynamic> data) {
    _scratchPaperMemory[key] = data;
  }

  /// 計算用紙データを取得（メモリのみ）
  static List<dynamic>? getScratchData(String key) {
    return _scratchPaperMemory[key];
  }

  /// 計算用紙データをクリア（メモリのみ）
  static void clearScratchData(String key) {
    _scratchPaperMemory.remove(key);
  }
}

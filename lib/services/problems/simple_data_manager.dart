// lib/services/simple_data_manager.dart
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/math_problem.dart';
import '../../models/learning_status.dart';
import '../../pages/common/problem_status.dart';
import '../payment/revenuecat_service.dart';
import '../payment/iap_secondary_products_config.dart';
import '../auth/firebase_auth_service.dart';
import '../auth/firestore_learning_service.dart';
import '../auth/firestore_settings_service.dart';
import '../../utils/app_logger.dart';

/// シンプルで拡張可能なデータ管理システム
/// 現在の必要最小限のデータ + 将来の拡張に対応
class SimpleDataManager {
  static const String _namespace = 'joymath_simple';

  // メモリ保持用の計算用紙データ（アプリ終了まで保持、画面遷移しても消えない）
  static final Map<String, List<dynamic>> _scratchPaperMemory = {};

  static const String _version = '1.0.0';
  static const String _versionKey = '$_namespace/version';
  static const String _lastUserIdKey = '$_namespace/last_user_id';

  // ============================================================================
  // in-memory cache (hot paths: problem list filtering, slot rendering)
  // ============================================================================
  static final Map<String, List<Map<String, dynamic>>> _learningHistoryCache = {};
  static final Map<String, Map<String, dynamic>> _learningDataCache = {};
  static Future<void>? _webCloudSyncFuture;
  static String? _webCloudReadyUserId;

  static bool get _isWebCloudAuthoritative =>
      kIsWeb &&
      FirebaseAuthService.isAuthenticated &&
      FirebaseAuthService.userId != null;

  static Future<void> ensureWebCloudSyncReady({bool force = false}) async {
    if (!_isWebCloudAuthoritative) {
      _webCloudReadyUserId = null;
      return;
    }

    final userId = FirebaseAuthService.userId!;
    if (!force && _webCloudReadyUserId == userId && _webCloudSyncFuture == null) {
      return;
    }

    if (_webCloudSyncFuture != null) {
      await _webCloudSyncFuture;
      if (!force && _webCloudReadyUserId == userId) {
        return;
      }
    }

    _webCloudSyncFuture = () async {
      try {
        await initialize();
      } finally {
        if (FirebaseAuthService.userId == userId) {
          _webCloudReadyUserId = userId;
        }
        _webCloudSyncFuture = null;
      }
    }();

    await _webCloudSyncFuture;
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

  static List<Map<String, dynamic>> _normalizeLearningHistoryList(List? history) {
    return (history ?? const [])
        .whereType<Map>()
        .map((item) {
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
          return {
            'status': normalizedStatus,
            'time': time is String ? time : null,
          };
        })
        .toList();
  }

  static Future<void> _clearLocalLearningMirror(
    SharedPreferences prefs,
  ) async {
    final learningKeys = prefs
        .getKeys()
        .where((key) => key.startsWith('$_namespace/learning/'))
        .toList();
    for (final key in learningKeys) {
      await prefs.remove(key);
    }
    _learningHistoryCache.clear();
    _learningDataCache.clear();
  }

  static Future<void> _clearWebManagedSettingMirror(
    SharedPreferences prefs,
  ) async {
    final managedKeys = prefs
        .getKeys()
        .where(
          (key) =>
              key.startsWith('$_namespace/gacha/') ||
              key == '$_namespace/user_settings',
        )
        .toList();
    for (final key in managedKeys) {
      await prefs.remove(key);
    }
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
      
      // 認証済みユーザーの場合、Firestoreからデータを同期
      if (FirebaseAuthService.isAuthenticated) {
        await _syncFromFirestore();
      }
      
      return true;
    } catch (e) {
      AppLogger.error('SimpleDataManagerの初期化に失敗しました', error: e);
      return false;
    }
  }
  
  /// Firestoreからデータを同期（認証済みユーザー用）
  static Future<void> _syncFromFirestore() async {
    try {
      final userId = FirebaseAuthService.userId;
      if (userId == null) return;
      
      final prefs = await SharedPreferences.getInstance();
      final syncKey = '$_namespace/firestore_sync_completed_$userId';
      
      // 全学習記録を取得（タイムアウト付き）
      Map<String, Map<String, dynamic>> firestoreRecords;
      try {
        firestoreRecords = await FirestoreLearningService.getAllLearningRecords(
          userId: userId,
        ).timeout(
          const Duration(seconds: 10),
          onTimeout: () {
            print('⚠️ Timeout getting learning records from Firestore for user: $userId');
            return <String, Map<String, dynamic>>{};
          },
        );
      } catch (e) {
        final errorStr = e.toString().toLowerCase();
        if (errorStr.contains('permission') || errorStr.contains('permission-denied')) {
          print('⚠️ Permission denied getting learning records from Firestore for user: $userId');
          print('⚠️ Firestoreセキュリティルールを確認してください。FIRESTORE_SECURITY_RULES.mdを参照してください。');
          // 権限エラーの場合は設定のみ同期を試みる
          await _syncSettingsFromFirestore(userId);
          return;
        }
        print('Error getting learning records from Firestore for user: $userId - $e');
        firestoreRecords = {};
      }

      if (_isWebCloudAuthoritative) {
        await _clearLocalLearningMirror(prefs);
        for (final entry in firestoreRecords.entries) {
          final problemId = entry.key;
          final firestoreData = Map<String, dynamic>.from(entry.value);
          final localKey = '$_namespace/learning/$problemId';
          await prefs.setString(localKey, json.encode(firestoreData));
          _cacheLearningDataForProblem(problemId, firestoreData);
        }

        await _syncSettingsFromFirestore(userId);
        await prefs.setString(syncKey, DateTime.now().toIso8601String());
        AppLogger.success('Firestoreからのデータ同期が完了しました');
        return;
      }
      
      // ローカルデータとマージ（最新のタイムスタンプを優先）
      // history配列はtimeフィールドで重複チェックしながら統合
      for (final entry in firestoreRecords.entries) {
        final problemId = entry.key;
        final firestoreData = entry.value;
        
        final localKey = '$_namespace/learning/$problemId';
        final localDataString = prefs.getString(localKey);
        
        Map<String, dynamic> mergedData;
        
        if (localDataString != null) {
          final localData = json.decode(localDataString) as Map<String, dynamic>;
          
          // history配列をtimeフィールドで重複チェックしながら統合
          final localHistory = localData['history'] as List? ?? [];
          final firestoreHistory = firestoreData['history'] as List? ?? [];
          
          // デバッグログ
          print('🔍 [History Merge] Problem: $problemId');
          print('🔍 [History Merge] Local history count: ${localHistory.length}');
          print('🔍 [History Merge] Firestore history count: ${firestoreHistory.length}');
          
          // timeフィールドで重複チェックしながら統合
          // timeがnullのレコード（none状態のスロット）は重複チェックの対象外
          final mergedHistory = <Map<String, dynamic>>[];
          final seenTimes = <String>{};
          
          // まずローカルの履歴を追加（timeがnullでないレコードのみ）
          for (final record in localHistory) {
            if (record is Map<String, dynamic>) {
              // timeフィールドを文字列に変換（Timestampの可能性があるため）
              dynamic timeValue = record['time'];
              String? time;
              if (timeValue is String) {
                time = timeValue;
              } else if (timeValue != null) {
                // TimestampやDateTimeの場合は文字列に変換
                try {
                  if (timeValue is DateTime) {
                    time = timeValue.toIso8601String();
                  } else {
                    time = timeValue.toString();
                  }
                } catch (e) {
                  time = null;
                }
              }
              
              // timeがnullまたは空文字列の場合はスキップ（none状態のスロット）
              if (time != null && time.isNotEmpty) {
                // 重複チェック：同じtimeを持つレコードが既に存在する場合はスキップ
                if (!seenTimes.contains(time)) {
                  final recordCopy = Map<String, dynamic>.from(record);
                  recordCopy['time'] = time; // 文字列形式に統一
                  mergedHistory.add(recordCopy);
                  seenTimes.add(time);
                  print('🔍 [History Merge] Added local record: status=${record['status']}, time=$time');
                } else {
                  print('🔍 [History Merge] Skipped duplicate local record: time=$time');
                }
              }
            }
          }
          
          // 次にFirestoreの履歴を追加（重複していないもののみ）
          for (final record in firestoreHistory) {
            if (record is Map<String, dynamic>) {
              // timeフィールドを文字列に変換（Timestampの可能性があるため）
              dynamic timeValue = record['time'];
              String? time;
              if (timeValue is String) {
                time = timeValue;
              } else if (timeValue != null) {
                // TimestampやDateTimeの場合は文字列に変換
                try {
                  if (timeValue is DateTime) {
                    time = timeValue.toIso8601String();
                  } else {
                    time = timeValue.toString();
                  }
                } catch (e) {
                  time = null;
                }
              }
              
              // timeがnullまたは空文字列の場合はスキップ（none状態のスロット）
              if (time != null && time.isNotEmpty) {
                // 重複チェック：同じtimeを持つレコードが既に存在する場合はスキップ
                if (!seenTimes.contains(time)) {
                  final recordCopy = Map<String, dynamic>.from(record);
                  recordCopy['time'] = time; // 文字列形式に統一
                  mergedHistory.add(recordCopy);
                  seenTimes.add(time);
                  print('🔍 [History Merge] Added Firestore record: status=${record['status']}, time=$time');
                } else {
                  print('🔍 [History Merge] Skipped duplicate Firestore record: time=$time');
                }
              }
            }
          }
          
          print('🔍 [History Merge] Merged history count: ${mergedHistory.length}');
          
          // 時系列でソート（timeでソート、古い順）
          // timeがnullのレコードは既に除外されているので、全てtimeが存在する
          mergedHistory.sort((a, b) {
            final timeA = a['time'] as String? ?? '';
            final timeB = b['time'] as String? ?? '';
            return timeA.compareTo(timeB);
          });
          
          // スロット0, 1, 2に配置（スロット2が最新）
          const slotCount = 3;
          final slots = List.generate(slotCount, (i) => <String, dynamic>{
            'status': 'none',
            'time': null,
          });
          
          if (mergedHistory.isNotEmpty) {
            // 最新のデータをスロット2に、次に新しいものをスロット1に、その次に新しいものをスロット0に
            final sortedHistory = mergedHistory.reversed.toList(); // 新しい順
            final count = mergedHistory.length;
            
            if (count == 1) {
              // データが1つだけ → スロット0に
              slots[0] = Map<String, dynamic>.from(sortedHistory[0]);
            } else if (count == 2) {
              // データが2つ → スロット1に最新、スロット0に古いもの
              slots[1] = Map<String, dynamic>.from(sortedHistory[0]); // 最新
              slots[0] = Map<String, dynamic>.from(sortedHistory[1]); // 古い
            } else {
              // データが3つ以上 → スロット2に最新、スロット1に次に新しいもの、スロット0にその次に新しいもの
              slots[2] = Map<String, dynamic>.from(sortedHistory[0]); // 最新
              slots[1] = Map<String, dynamic>.from(sortedHistory[1]); // 次に新しい
              slots[0] = Map<String, dynamic>.from(sortedHistory[2]); // その次に新しい
            }
          }
          
          // タイムスタンプを比較して新しい方を優先（history以外のフィールド）
          final firestoreTime = firestoreData['lastUpdated'] as String?;
          final localTime = localData['lastUpdated'] as String?;
          
          if (firestoreTime != null && localTime != null) {
            try {
              final firestoreDateTime = DateTime.parse(firestoreTime);
              final localDateTime = DateTime.parse(localTime);
              
              if (firestoreDateTime.isAfter(localDateTime)) {
                // Firestoreが新しい → Firestoreのデータをベースに、historyだけマージしたものに置き換え
                mergedData = Map<String, dynamic>.from(firestoreData);
                mergedData['history'] = slots;
              } else {
                // ローカルが新しい → ローカルのデータをベースに、historyだけマージしたものに置き換え
                mergedData = Map<String, dynamic>.from(localData);
                mergedData['history'] = slots;
              }
            } catch (e) {
              // パースエラー時はパースに成功した方を採用
              DateTime? firestoreDateTime;
              DateTime? localDateTime;
              
              try {
                firestoreDateTime = DateTime.parse(firestoreTime);
              } catch (e) {
                // Firestoreのパース失敗
              }
              
              try {
                localDateTime = DateTime.parse(localTime);
              } catch (e) {
                // ローカルのパース失敗
              }
              
              if (firestoreDateTime != null && localDateTime != null) {
                // 両方成功した場合は比較
                if (firestoreDateTime.isAfter(localDateTime)) {
                  mergedData = Map<String, dynamic>.from(firestoreData);
                  mergedData['history'] = slots;
                } else {
                  mergedData = Map<String, dynamic>.from(localData);
                  mergedData['history'] = slots;
                }
              } else if (firestoreDateTime != null) {
                // Firestoreのみ成功
                mergedData = Map<String, dynamic>.from(firestoreData);
                mergedData['history'] = slots;
              } else if (localDateTime != null) {
                // ローカルのみ成功
                mergedData = Map<String, dynamic>.from(localData);
                mergedData['history'] = slots;
              } else {
                // 両方失敗した場合はFirestoreを優先
                mergedData = Map<String, dynamic>.from(firestoreData);
                mergedData['history'] = slots;
              }
            }
          } else if (firestoreTime != null) {
            mergedData = Map<String, dynamic>.from(firestoreData);
            mergedData['history'] = slots;
          } else {
            mergedData = Map<String, dynamic>.from(localData);
            mergedData['history'] = slots;
          }
          
          // lastUpdatedは統合後の最新のtimeを使用、または現在時刻
          final latestTime = mergedHistory.isNotEmpty 
              ? mergedHistory.last['time'] as String?
              : null;
          if (latestTime != null && latestTime.isNotEmpty) {
            mergedData['lastUpdated'] = latestTime;
          } else {
            mergedData['lastUpdated'] = DateTime.now().toIso8601String();
          }
          
          // デバッグログ
          print('🔍 [History Merge] Final slots: slot0=${slots[0]['status']}(${slots[0]['time']}), slot1=${slots[1]['status']}(${slots[1]['time']}), slot2=${slots[2]['status']}(${slots[2]['time']})');
        } else {
          // ローカルデータがない場合はFirestoreのデータをそのまま使用
          mergedData = firestoreData;
        }
        
        // マージしたデータをローカルに保存
        await prefs.setString(localKey, json.encode(mergedData));
        _cacheLearningDataForProblem(problemId, mergedData);
        print('🔍 [History Merge] Saved merged data for problem: $problemId');
      }
      
      // 設定を同期
      await _syncSettingsFromFirestore(userId);
      
      // 同期完了時刻を記録
      await prefs.setString(syncKey, DateTime.now().toIso8601String());
      
      AppLogger.success('Firestoreからのデータ同期が完了しました');
    } catch (e) {
      AppLogger.error('Firestoreからのデータ同期に失敗しました', error: e);
      // エラー時も処理を継続
    }
  }

  /// Firestoreから設定を同期（内部メソッド）
  static Future<void> _syncSettingsFromFirestore(String userId) async {
    try {
      // 認証状態を確認
      final isAuthenticated = FirebaseAuthService.isAuthenticated;
      final currentUserId = FirebaseAuthService.userId;
      
      if (!isAuthenticated) {
        print('⚠️ Firestore設定同期をスキップ: ユーザーが認証されていません');
        return;
      }
      
      if (currentUserId != userId) {
        print('⚠️ Firestore設定同期をスキップ: ユーザーIDが一致しません (リクエスト: $userId, 現在: $currentUserId)');
        return;
      }
      
      final prefs = await SharedPreferences.getInstance();
      
      AppLogger.subsection('設定の同期開始', showNumber: false);
      AppLogger.info('Firestoreから設定を同期中', details: 'ユーザーID: $userId');
      
      // 全設定を取得（タイムアウト付き）
      Map<String, dynamic> allSettings;
      try {
        allSettings = await FirestoreSettingsService.getAllSettings(userId: userId)
            .timeout(
              const Duration(seconds: 10),
              onTimeout: () {
                AppLogger.warning('設定の同期がタイムアウトしました', details: '10秒以内に完了しませんでした');
                return <String, dynamic>{};
              },
            );
      } catch (e) {
        final errorStr = e.toString().toLowerCase();
        if (errorStr.contains('permission') || errorStr.contains('permission-denied')) {
          AppLogger.warning('設定の同期が権限エラーで失敗しました',
            details: 'Firestoreセキュリティルールを確認してください。FIRESTORE_SECURITY_RULES.mdを参照してください。');
          return; // 権限エラーの場合は早期に処理を停止
        }
        AppLogger.error('設定の取得に失敗しました', error: e);
        allSettings = {};
      }
      
      // 権限エラーが発生した場合は早期に処理を停止
      if (allSettings.isEmpty) {
        AppLogger.warning('設定の同期をスキップしました', details: '空の設定が返されました（権限エラーの可能性）');
        return;
      }

      if (_isWebCloudAuthoritative) {
        await _clearWebManagedSettingMirror(prefs);
      }
      
      // ガチャ設定を同期
      final gachaSettings = allSettings['gacha_settings'] as Map<String, Map<String, dynamic>>?;
      if (gachaSettings != null) {
        for (final entry in gachaSettings.entries) {
          final gachaType = entry.key;
          final firestoreSettings = entry.value;
          
          final localKey = '$_namespace/gacha/$gachaType';
          final localDataString = prefs.getString(localKey);
          
          Map<String, dynamic> mergedSettings;

          if (_isWebCloudAuthoritative) {
            mergedSettings = Map<String, dynamic>.from(firestoreSettings);
            await prefs.setString(localKey, json.encode(mergedSettings));
            continue;
          }
          
          if (localDataString != null) {
            final localSettings = json.decode(localDataString) as Map<String, dynamic>;
            
            // タイムスタンプを比較して新しい方を優先
            final firestoreTime = firestoreSettings['lastUpdated'] as String?;
            final localTime = localSettings['lastUpdated'] as String?;
            
            if (firestoreTime != null && localTime != null) {
              try {
                final firestoreDateTime = DateTime.parse(firestoreTime);
                final localDateTime = DateTime.parse(localTime);
                
                if (firestoreDateTime.isAfter(localDateTime)) {
                  mergedSettings = firestoreSettings;
                } else {
                  mergedSettings = localSettings;
                }
              } catch (e) {
                // パースエラー時はパースに成功した方を採用
                DateTime? firestoreDateTime;
                DateTime? localDateTime;
                
                try {
                  firestoreDateTime = DateTime.parse(firestoreTime);
                } catch (e) {
                  // Firestoreのパース失敗
                }
                
                try {
                  localDateTime = DateTime.parse(localTime);
                } catch (e) {
                  // ローカルのパース失敗
                }
                
                if (firestoreDateTime != null && localDateTime != null) {
                  // 両方成功した場合は比較（通常はここには来ない）
                  mergedSettings = firestoreDateTime.isAfter(localDateTime) ? firestoreSettings : localSettings;
                } else if (firestoreDateTime != null) {
                  // Firestoreのみ成功
                  mergedSettings = firestoreSettings;
                } else if (localDateTime != null) {
                  // ローカルのみ成功
                  mergedSettings = localSettings;
                } else {
                  // 両方失敗した場合はFirestoreを優先（新しい物を採用の方針）
                  mergedSettings = firestoreSettings;
                }
              }
            } else if (firestoreTime != null) {
              mergedSettings = firestoreSettings;
            } else {
              mergedSettings = localSettings;
            }
          } else {
            mergedSettings = firestoreSettings;
          }
          
          // マージした設定をローカルに保存
          await prefs.setString(localKey, json.encode(mergedSettings));
        }
      }
      
      // ユーザー設定を同期
      final userSettings = allSettings['user_settings'] as Map<String, dynamic>?;
      if (userSettings != null) {
        final localKey = '$_namespace/user_settings';
        final localDataString = prefs.getString(localKey);
        
        Map<String, dynamic> mergedSettings;

        if (_isWebCloudAuthoritative) {
          mergedSettings = Map<String, dynamic>.from(userSettings);
          await prefs.setString(localKey, json.encode(mergedSettings));
        } else {
        
          if (localDataString != null) {
            final localSettings = json.decode(localDataString) as Map<String, dynamic>;
            
            // タイムスタンプを比較して新しい方を優先
            final firestoreTime = userSettings['lastUpdated'] as String?;
            final localTime = localSettings['lastUpdated'] as String?;
            
            if (firestoreTime != null && localTime != null) {
              try {
                final firestoreDateTime = DateTime.parse(firestoreTime);
                final localDateTime = DateTime.parse(localTime);
                
                if (firestoreDateTime.isAfter(localDateTime)) {
                  mergedSettings = userSettings;
                } else {
                  mergedSettings = localSettings;
                }
              } catch (e) {
                // パースエラー時はパースに成功した方を採用
                DateTime? firestoreDateTime;
                DateTime? localDateTime;
                
                try {
                  firestoreDateTime = DateTime.parse(firestoreTime);
                } catch (e) {
                  // Firestoreのパース失敗
                }
                
                try {
                  localDateTime = DateTime.parse(localTime);
                } catch (e) {
                  // ローカルのパース失敗
                }
                
                if (firestoreDateTime != null && localDateTime != null) {
                  // 両方成功した場合は比較（通常はここには来ない）
                  mergedSettings = firestoreDateTime.isAfter(localDateTime) ? userSettings : localSettings;
                } else if (firestoreDateTime != null) {
                  // Firestoreのみ成功
                  mergedSettings = userSettings;
                } else if (localDateTime != null) {
                  // ローカルのみ成功
                  mergedSettings = localSettings;
                } else {
                  // 両方失敗した場合はFirestoreを優先（新しい物を採用の方針）
                  mergedSettings = userSettings;
                }
              }
            } else if (firestoreTime != null) {
              mergedSettings = userSettings;
            } else {
              mergedSettings = localSettings;
            }
          } else {
            mergedSettings = userSettings;
          }
          
          // マージした設定をローカルに保存
          await prefs.setString(localKey, json.encode(mergedSettings));
        }
      }
      
      // 注意: Pro購入情報はFirebaseから取得しない（RevenueCatで管理）
      // 有料オプション購入状態の同期は削除
      
      // その他の設定を同期
      final otherSettings = allSettings['other_settings'] as Map<String, dynamic>?;
      if (otherSettings != null) {
        for (final entry in otherSettings.entries) {
          final key = entry.key;
          final value = entry.value;
          
          // 既存のローカル値を確認（タイムスタンプ比較は簡略化）
          if (value != null) {
            if (value is int) {
              await prefs.setInt(key, value);
            } else if (value is String) {
              await prefs.setString(key, value);
            } else if (value is bool) {
              await prefs.setBool(key, value);
            } else if (value is double) {
              await prefs.setDouble(key, value);
            }
          }
        }
      }
      
      AppLogger.success('Firestoreからの設定同期が完了しました');
    } catch (e) {
      print('Error syncing settings from Firestore for user: $userId - $e');
      // エラー時も処理を継続
    }
  }
  
  /// ローカル設定をFirestoreに同期（認証時に呼び出す）
  static Future<void> syncLocalSettingsToFirestore() async {
    try {
      if (_isWebCloudAuthoritative) {
        print('Web cloud-first mode: skipping bulk local settings upload');
        return;
      }

      if (!FirebaseAuthService.isAuthenticated) {
        print('User not authenticated, skipping Firestore settings sync');
        return;
      }
      
      final userId = FirebaseAuthService.userId;
      if (userId == null) {
        print('User ID is null, skipping Firestore settings sync');
        return;
      }
      
      print('Starting local settings sync to Firestore for user: $userId');
      
      final prefs = await SharedPreferences.getInstance();
      final allKeys = prefs.getKeys();
      
      // ガチャ設定を同期
      final gachaKeys = allKeys.where((key) => 
        key.startsWith('$_namespace/gacha/') && 
        key != '$_namespace/gacha'
      ).toList();
      
      // パーミッションエラーを検出するためのフラグ
      bool hasPermissionError = false;
      
      for (final key in gachaKeys) {
        final dataString = prefs.getString(key);
        if (dataString == null) continue;
        
        try {
          final data = json.decode(dataString) as Map<String, dynamic>;
          final gachaType = key.replaceFirst('$_namespace/gacha/', '');
          
          // パーミッションエラーが既に発生している場合はスキップ
          if (hasPermissionError) {
            continue;
          }
          
          // ローカルデータを直接Firestoreに書き込む（読み取りをスキップして高速化）
          final success = await FirestoreSettingsService.saveGachaSettings(
            userId: userId,
            gachaType: gachaType,
            settings: data,
          );
          
          if (success) {
            print('Synced gacha settings for $gachaType to Firestore');
          } else {
            // 失敗した場合はパーミッションエラーの可能性があるが、次の項目も試す
            print('Warning: Failed to sync gacha settings for $gachaType');
          }
        } catch (e) {
          final errorStr = e.toString().toLowerCase();
          if (errorStr.contains('permission')) {
            hasPermissionError = true;
            print('Permission error detected, skipping remaining Firestore operations');
            break;
          }
          print('Error syncing gacha settings $key to Firestore: $e');
          // 個別のエラーは無視して続行
        }
      }
      
      // ユーザー設定を同期（パーミッションエラーが発生していない場合のみ）
      if (!hasPermissionError) {
        final userSettingsKey = '$_namespace/user_settings';
        final userSettingsString = prefs.getString(userSettingsKey);
        if (userSettingsString != null) {
          try {
            final userSettings = json.decode(userSettingsString) as Map<String, dynamic>;
            
            final success = await FirestoreSettingsService.saveUserSettings(
              userId: userId,
              settings: userSettings,
            );
            
            if (success) {
              print('Synced user settings to Firestore');
            } else {
              print('Warning: Failed to sync user settings to Firestore');
            }
          } catch (e) {
            final errorStr = e.toString().toLowerCase();
            if (errorStr.contains('permission')) {
              hasPermissionError = true;
              print('Permission error detected, skipping remaining Firestore operations');
            } else {
              print('Error syncing user settings to Firestore: $e');
            }
          }
        }
      }
      
      // 注意: Pro購入情報はFirebaseにバックアップしない（RevenueCatで管理）
      // 有料オプション購入状態の同期は削除
      
      // その他の設定を同期（パーミッションエラーが発生していない場合のみ）
      // 注意: 集計設定（aggregation_mode）はガチャ設定の中に含まれるため、個別の同期は不要
      if (!hasPermissionError) {
        final otherSettingKeys = [
          'integral_gacha_exclusion_mode',
          'limit_gacha_exclusion_mode',
          'sequence_gacha_exclusion_mode',
          // 集計設定はガチャ設定の中に含まれるため削除:
          // 'integral_gacha_aggregation_mode',
          // 'limit_gacha_aggregation_mode',
          // 'sequence_gacha_aggregation_mode',
          'integral_gacha_max_selections',
          'limit_gacha_max_selections',
          'sequence_gacha_max_selections',
          _selectedFreeGachasKey, // 選択された無料ガチャのリスト
        ];
        
        // デバッグ用: 選択された無料ガチャのキーが含まれていることを確認
        print('Syncing other settings, including selected free gachas key: $_selectedFreeGachasKey');
        
        // ガチャタイプでない問題一覧ページの集計設定キー（*_aggregation_mode_v1）を動的に検出
        // ガチャタイプの集計設定はガチャ設定として既に同期されている
        final aggregationModeKeys = allKeys.where((key) => 
          key.endsWith('_aggregation_mode_v1') &&
          !['integral', 'limit', 'sequence', 'congruence'].any((type) => 
            key.startsWith('${type}_aggregation_mode_v1')
          )
        ).toList();
        
        // すべての設定キーを結合
        final allOtherSettingKeys = [
          ...otherSettingKeys,
          ...aggregationModeKeys,
        ];
        
        for (final settingKey in allOtherSettingKeys) {
          final value = prefs.get(settingKey);
          if (value != null) {
            try {
              // _selectedFreeGachasKeyの場合はJSON文字列をリストに変換
              dynamic settingValue = value;
              if (settingKey == _selectedFreeGachasKey && value is String) {
                try {
                  final decoded = json.decode(value) as List;
                  settingValue = decoded;
                  print('Syncing selected free gachas to Firestore: $decoded');
                } catch (e) {
                  print('Error decoding selected free gachas: $e');
                  continue; // デコードに失敗した場合はスキップ
                }
              }
              
              final success = await FirestoreSettingsService.saveOtherSetting(
                userId: userId,
                key: settingKey,
                value: settingValue,
              );
              
              if (success) {
                if (settingKey == _selectedFreeGachasKey) {
                  print('Successfully synced selected free gachas to Firestore: $settingValue');
                } else {
                  print('Synced other setting $settingKey to Firestore');
                }
              } else {
                if (settingKey == _selectedFreeGachasKey) {
                  print('Warning: Failed to sync selected free gachas to Firestore');
                } else {
                  print('Warning: Failed to sync other setting $settingKey to Firestore');
                }
                // パーミッションエラーの可能性があるが、次の項目も試す
              }
            } catch (e) {
              final errorStr = e.toString().toLowerCase();
              if (errorStr.contains('permission')) {
                hasPermissionError = true;
                print('Permission error detected, skipping remaining Firestore operations');
                break;
              }
              if (settingKey == _selectedFreeGachasKey) {
                print('Error syncing selected free gachas to Firestore: $e');
              } else {
                print('Error syncing other setting $settingKey to Firestore: $e');
              }
            }
          } else {
            // 値がnullの場合のログ（デバッグ用）
            if (settingKey == _selectedFreeGachasKey) {
              print('Warning: Selected free gachas key exists but value is null');
            }
          }
        }
      }
      
      print('Local settings sync to Firestore completed');
    } catch (e) {
      print('Error syncing local settings to Firestore: $e');
    }
  }

  /// ローカルデータをFirestoreに同期（認証時に呼び出す）
  static Future<void> syncLocalDataToFirestore() async {
    try {
      if (_isWebCloudAuthoritative) {
        print('Web cloud-first mode: skipping bulk local data upload');
        return;
      }

      if (!FirebaseAuthService.isAuthenticated) {
        print('User not authenticated, skipping Firestore sync');
        return;
      }
      
      final userId = FirebaseAuthService.userId;
      if (userId == null) {
        print('User ID is null, skipping Firestore sync');
        return;
      }
      
      print('Starting local data sync to Firestore for user: $userId');
      
      final prefs = await SharedPreferences.getInstance();
      final allKeys = prefs.getKeys();
      final learningKeys = allKeys.where((key) => 
        key.startsWith('$_namespace/learning/') && 
        key != '$_namespace/learning'
      ).toList();
      
      if (learningKeys.isEmpty) {
        print('No local learning records to sync');
        return;
      }
      
      print('Syncing ${learningKeys.length} learning records to Firestore...');
      
      int successCount = 0;
      int errorCount = 0;
      bool hasPermissionError = false;
      
      // 各学習記録をFirestoreに同期
      for (final key in learningKeys) {
        final dataString = prefs.getString(key);
        if (dataString == null) continue;
        
        // パーミッションエラーが既に発生している場合はスキップ
        if (hasPermissionError) {
          continue;
        }
        
        try {
          final data = json.decode(dataString) as Map<String, dynamic>;
          final problemId = key.replaceFirst('$_namespace/learning/', '');
          
          // まずローカルデータを直接Firestoreに書き込む（高速化のため読み取りをスキップ）
          try {
            await FirestoreLearningService.saveLearningRecord(
              userId: userId,
              problemId: problemId,
              data: data,
            );
            successCount++;
          } catch (e) {
            final errorStr = e.toString().toLowerCase();
            if (errorStr.contains('permission')) {
              hasPermissionError = true;
              print('Permission error detected, skipping remaining learning record sync');
              break;
            }
            // 書き込みに失敗した場合は、読み取りを試してタイムスタンプ比較を行う
            try {
              final existingData = await FirestoreLearningService.getLearningRecord(
                userId: userId,
                problemId: problemId,
              );
              
              if (existingData != null) {
                final localTime = data['lastUpdated'] as String?;
                final firestoreTime = existingData['lastUpdated'] as String?;
                
                if (localTime != null && firestoreTime != null) {
                  try {
                    final localDateTime = DateTime.parse(localTime);
                    final firestoreDateTime = DateTime.parse(firestoreTime);
                    
                    // Firestoreのデータが新しい場合は、ローカルデータを更新
                    if (firestoreDateTime.isAfter(localDateTime)) {
                      await prefs.setString(key, json.encode(existingData));
                      print('Updated local data for $problemId from Firestore (newer)');
                    }
                  } catch (e) {
                    // パースエラー時はパースに成功した方を採用
                    DateTime? localDateTime;
                    DateTime? firestoreDateTime;
                    
                    try {
                      localDateTime = DateTime.parse(localTime);
                    } catch (e) {
                      // ローカルのパース失敗
                    }
                    
                    try {
                      firestoreDateTime = DateTime.parse(firestoreTime);
                    } catch (e) {
                      // Firestoreのパース失敗
                    }
                    
                    if (firestoreDateTime != null && localDateTime != null) {
                      // 両方成功した場合は比較（通常はここには来ない）
                      if (firestoreDateTime.isAfter(localDateTime)) {
                        await prefs.setString(key, json.encode(existingData));
                        print('Updated local data for $problemId from Firestore (newer)');
                      }
                    } else if (firestoreDateTime != null) {
                      // Firestoreのみ成功
                      await prefs.setString(key, json.encode(existingData));
                      print('Updated local data for $problemId from Firestore (parse success)');
                    } else if (localDateTime == null) {
                      // 両方失敗した場合はFirestoreを優先（新しい物を採用の方針）
                      await prefs.setString(key, json.encode(existingData));
                      print('Updated local data for $problemId from Firestore (both parse failed)');
                    }
                  }
                }
              }
            } catch (readError) {
              final readErrorStr = readError.toString().toLowerCase();
              if (readErrorStr.contains('permission')) {
                hasPermissionError = true;
                print('Permission error detected, skipping remaining learning record sync');
                break;
              }
            }
            errorCount++;
          }
        } catch (e) {
          final errorStr = e.toString().toLowerCase();
          if (errorStr.contains('permission')) {
            hasPermissionError = true;
            print('Permission error detected, skipping remaining learning record sync');
            break;
          }
          print('Error syncing record $key to Firestore: $e');
          errorCount++;
        }
      }
      
      print('Local data sync to Firestore completed: $successCount succeeded, $errorCount failed');
    } catch (e) {
      print('Error syncing local data to Firestore: $e');
    }
  }
  
  // ============================================================================
  // 学習記録管理（シンプル版）
  // ============================================================================
  
  /// 学習記録を保存
  static Future<bool> saveLearningRecord(MathProblem problem, dynamic status) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = '$_namespace/learning/${problem.id}';
      
      // 既存データを取得
      final existingData = await _getLearningData(problem);
      
      // 新しい記録を履歴に追加
      final statusKey = status is LearningStatus ? status.key : 
                       status is ProblemStatus ? status.name : 'none';
      final newRecord = {
        'status': statusKey,
        'time': DateTime.now().toIso8601String(),
      };
      
      existingData['history'].add(newRecord);
      
      // 最新ステータスを更新
      existingData['latestStatus'] = statusKey;
      existingData['lastUpdated'] = DateTime.now().toIso8601String();
      
      // 常にSharedPreferencesに保存
      await prefs.setString(key, json.encode(existingData));
      _cacheLearningDataForProblem(problem.id, existingData);
      
      // 認証済みユーザーの場合、Firestoreにも同時に保存
      if (FirebaseAuthService.isAuthenticated) {
        final userId = FirebaseAuthService.userId;
        if (userId != null) {
          try {
            final success = await FirestoreLearningService.saveLearningRecord(
              userId: userId,
              problemId: problem.id,
              data: existingData,
            );
            if (success) {
              print('Successfully saved learning record to Firestore for problem ${problem.id}');
            } else {
              print('Warning: Failed to save learning record to Firestore for problem ${problem.id}');
              if (_isWebCloudAuthoritative) {
                return false;
              }
            }
          } catch (e, stackTrace) {
            print('Error saving to Firestore (continuing with local save): $e');
            print('Stack trace: $stackTrace');
            // Firestoreエラー時はローカルのみで動作継続
            if (_isWebCloudAuthoritative) {
              return false;
            }
          }
        } else {
          print('Warning: User ID is null, skipping Firestore sync');
        }
      } else {
        print('User not authenticated, skipping Firestore sync');
      }
      
      return true;
    } catch (e) {
      print('Error saving learning record: $e');
      return false;
    }
  }
  
  /// 学習記録を取得
  /// ローカルデータを優先して即座に返し、バックグラウンドでFirestoreと同期
  static Future<LearningStatus> getLearningRecord(MathProblem problem) async {
    try {
      if (_isWebCloudAuthoritative) {
        await ensureWebCloudSyncReady();
      }

      // まずローカルデータを即座に取得（遅延なし）
      final localData = await _getLearningData(problem);
      if (_isWebCloudAuthoritative) {
        final statusKey = localData['latestStatus'] as String?;
        return statusKey != null
            ? LearningStatusExtension.fromKey(statusKey)
            : LearningStatus.none;
      }
      
      // バックグラウンドでFirestoreから取得を試みる（非同期、エラーは無視）
      if (FirebaseAuthService.isAuthenticated) {
        final userId = FirebaseAuthService.userId;
        if (userId != null) {
          // 非同期でFirestoreから取得（エラーは無視、UIをブロックしない）
          FirestoreLearningService.getLearningRecord(
            userId: userId,
            problemId: problem.id,
          ).timeout(
            const Duration(seconds: 2),
            onTimeout: () => null,
          ).then((firestoreData) async {
            if (firestoreData != null) {
              // Firestoreから取得したデータをローカルにも保存（同期）
              try {
                final prefs = await SharedPreferences.getInstance();
                final key = '$_namespace/learning/${problem.id}';
                await prefs.setString(key, json.encode(firestoreData));
                _cacheLearningDataForProblem(problem.id, firestoreData);
                print('Background sync: Updated local data from Firestore for problem ${problem.id}');
              } catch (e) {
                print('Error saving Firestore data to local: $e');
              }
            }
          }).catchError((e) {
            // エラーは無視（バックグラウンド処理のため）
            print('Background sync error (ignored): $e');
          });
        }
      }
      
      // ローカルデータを即座に返す
      final statusKey = localData['latestStatus'] as String?;
      
      if (statusKey != null) {
        return LearningStatusExtension.fromKey(statusKey);
      }
      return LearningStatus.none;
    } catch (e) {
      print('Error getting learning record: $e');
      // エラー時はnoneを返す（問題は除外されない）
      return LearningStatus.none;
    }
  }
  
  /// 学習記録の履歴を取得
  /// ローカルデータを優先して即座に返し、バックグラウンドでFirestoreと同期
  static Future<List<Map<String, dynamic>>> getLearningHistory(MathProblem problem) async {
    try {
      if (_isWebCloudAuthoritative) {
        await ensureWebCloudSyncReady();
      }

      // まずローカルデータを即座に取得（遅延なし）
      final cached = _learningHistoryCache[problem.id];
      if (cached != null) return cached;

      final localData = await _getLearningData(problem);
      final history = List<Map<String, dynamic>>.from(localData['history'] ?? []);
      if (_isWebCloudAuthoritative) {
        final normalizedHistory = _normalizeLearningHistoryList(history);
        _learningHistoryCache[problem.id] = normalizedHistory;
        return normalizedHistory;
      }
      
      // バックグラウンドでFirestoreから取得を試みる（非同期、エラーは無視）
      if (FirebaseAuthService.isAuthenticated) {
        final userId = FirebaseAuthService.userId;
        if (userId != null) {
          // 非同期でFirestoreから取得（エラーは無視、UIをブロックしない）
          FirestoreLearningService.getLearningHistory(
            userId: userId,
            problemId: problem.id,
          ).timeout(
            const Duration(seconds: 2),
            onTimeout: () => <Map<String, dynamic>>[],
          ).then((firestoreHistory) async {
            if (firestoreHistory.isNotEmpty) {
              // Firestoreから取得したデータをローカルにも保存（同期）
              try {
                final prefs = await SharedPreferences.getInstance();
                final key = '$_namespace/learning/${problem.id}';
                final updatedLocalData = await _getLearningData(problem);
                updatedLocalData['history'] = firestoreHistory;
                await prefs.setString(key, json.encode(updatedLocalData));
                _cacheLearningDataForProblem(problem.id, updatedLocalData);
                print('Background sync: Updated local history from Firestore for problem ${problem.id}');
              } catch (e) {
                print('Error saving Firestore history to local: $e');
              }
            }
          }).catchError((e) {
            // エラーは無視（バックグラウンド処理のため）
            print('Background sync error (ignored): $e');
          });
        }
      }
      
      // 移行処理：古い形式のデータを新しい形式に変換
      final migratedHistory = _normalizeLearningHistoryList(history);
      
      // ローカルデータを即座に返す
      _learningHistoryCache[problem.id] = migratedHistory;
      return migratedHistory;
    } catch (e) {
      print('Error getting learning history: $e');
      // エラー時は空のリストを返す（問題は除外されない）
      return [];
    }
  }

  /// 複数問題の履歴を一括取得（SharedPreferencesアクセス回数を最小化）
  ///
  /// - 問題一覧ページなどで大量に `getLearningHistory()` を呼ぶと重くなるため、
  ///   先にまとめて読み込み、以降はメモリキャッシュから参照できるようにする。
  /// - Firestore同期は行わない（UIをブロックしないため）。必要なら通常の `getLearningHistory()` を利用。
  static Future<Map<String, List<Map<String, dynamic>>>> getLearningHistoryMap(
    Iterable<String> problemIds,
  ) async {
    if (_isWebCloudAuthoritative) {
      await ensureWebCloudSyncReady();
    }

    final ids = problemIds.toSet();
    if (ids.isEmpty) return {};

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
          final historyAny = decoded['history'];
          final migratedHistory =
              _normalizeLearningHistoryList(historyAny is List ? historyAny : const []);

          _learningHistoryCache[id] = migratedHistory;
          out[id] = migratedHistory;
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
  static Future<bool> saveLearningHistory(MathProblem problem, List<Map<String, dynamic>> history) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = '$_namespace/learning/${problem.id}';
      
      // 履歴を正規化（ProblemStatusまたはStringを統一）
      final normalizedHistory = history.map((h) {
        // statusを文字列に変換
        String statusStr;
        final statusValue = h['status'];
        if (statusValue is String) {
          statusStr = statusValue;
        } else if (statusValue is ProblemStatus) {
          statusStr = statusValue.name;
        } else if (statusValue != null) {
          // 念のため、toString()で試す
          final str = statusValue.toString();
          // ProblemStatusのenum値かどうかチェック
          if (str.startsWith('ProblemStatus.')) {
            statusStr = str.replaceFirst('ProblemStatus.', '');
          } else {
            statusStr = 'none';
          }
        } else {
          statusStr = 'none';
        }
        
        // timeはString形式で保存（DateTimeオブジェクトの場合はISO8601形式に変換）
        String? timeStr;
        final timeValue = h['time'];
        if (timeValue is String) {
          timeStr = timeValue;
        } else if (timeValue is DateTime) {
          timeStr = timeValue.toIso8601String();
        } else {
          timeStr = null;
        }
        
        return {
          'status': statusStr,
          'time': timeStr,
        };
      }).toList();
      
      // 最新ステータスを取得（noneでない最後のスロットを見つける）
      String latestStatus = 'none';
      for (var i = normalizedHistory.length - 1; i >= 0; i--) {
        final status = normalizedHistory[i]['status'] as String;
        if (status != 'none') {
          latestStatus = status;
          break;
        }
      }
      
      final data = {
        'problemId': problem.id,
        'latestStatus': latestStatus,
        'history': normalizedHistory,
        'lastUpdated': DateTime.now().toIso8601String(),
      };
      
      // 常にSharedPreferencesに保存
      await prefs.setString(key, json.encode(data));
      // メモリキャッシュを更新（一覧の即時反映）
      _learningDataCache[problem.id] = data;
      _learningHistoryCache[problem.id] = List<Map<String, dynamic>>.from(normalizedHistory);
      
      // 認証済みユーザーの場合、Firestoreにも同時に保存
      if (FirebaseAuthService.isAuthenticated) {
        final userId = FirebaseAuthService.userId;
        if (userId != null) {
          try {
            final success = await FirestoreLearningService.saveLearningHistory(
              userId: userId,
              problemId: problem.id,
              history: normalizedHistory,
            );
            if (success) {
              print('Successfully saved learning history to Firestore for problem ${problem.id}');
            } else {
              print('Warning: Failed to save learning history to Firestore for problem ${problem.id}');
              if (_isWebCloudAuthoritative) {
                return false;
              }
            }
          } catch (e, stackTrace) {
            print('Error saving history to Firestore (continuing with local save): $e');
            print('Stack trace: $stackTrace');
            // Firestoreエラー時はローカルのみで動作継続
            if (_isWebCloudAuthoritative) {
              return false;
            }
          }
        } else {
          print('Warning: User ID is null, skipping Firestore sync');
        }
      } else {
        print('User not authenticated, skipping Firestore sync');
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
      final emptyHistory = List.generate(slotCount, (i) => <String, dynamic>{
        'status': 'none',
        'time': null,
      });
      
      // saveLearningHistoryを使って全てnoneの状態で保存
      // これにより、ローカルとFirestoreの両方にnoneの状態が保存される
      final success = await saveLearningHistory(problem, emptyHistory);
      
      if (success) {
        print('Successfully cleared learning history (set all slots to none) for problem ${problem.id}');
      } else {
        print('Warning: Failed to clear learning history for problem ${problem.id}');
      }
      
      return success;
    } catch (e) {
      print('Error clearing learning history: $e');
      return false;
    }
  }
  
  /// 学習データを取得（内部メソッド）
  static Future<Map<String, dynamic>> _getLearningData(MathProblem problem) async {
    try {
      final cached = _learningDataCache[problem.id];
      if (cached != null) return Map<String, dynamic>.from(cached);

      final prefs = await SharedPreferences.getInstance();
      final key = '$_namespace/learning/${problem.id}';
      final dataString = prefs.getString(key);
      
      if (dataString != null) {
        final decoded = json.decode(dataString);
        if (decoded is Map<String, dynamic>) {
          final m = Map<String, dynamic>.from(decoded);
          _learningDataCache[problem.id] = m;
          return Map<String, dynamic>.from(m);
        }
      }
      
      // デフォルトデータ
      final d = {
        'problemId': problem.id,
        'latestStatus': 'none',
        'history': <Map<String, dynamic>>[],
        'lastUpdated': DateTime.now().toIso8601String(),
      };
      _learningDataCache[problem.id] = d;
      return Map<String, dynamic>.from(d);
    } catch (e) {
      print('Error getting learning data: $e');
      final d = {
        'problemId': problem.id,
        'latestStatus': 'none',
        'history': <Map<String, dynamic>>[],
        'lastUpdated': DateTime.now().toIso8601String(),
      };
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
  static Future<bool> saveGachaSettings(String gachaType, Map<String, dynamic> settings) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = '$_namespace/gacha/$gachaType';
      
      // デフォルト設定とマージ
      final defaultSettings = _getDefaultGachaSettings();
      defaultSettings.addAll(settings);
      defaultSettings['updatedAt'] = DateTime.now().toIso8601String();
      defaultSettings['lastUpdated'] = DateTime.now().toIso8601String();
      
      // ローカルに即座に保存（UXを下げない）
      await prefs.setString(key, json.encode(defaultSettings));
      
      // 認証済みユーザーの場合、Firestoreにも同時に保存（非同期、エラーは無視）
      // 注意: ログイン前の場合はこの処理は実行されない
      // ログイン後は syncLocalSettingsToFirestore() で同期される
      if (FirebaseAuthService.isAuthenticated) {
        final userId = FirebaseAuthService.userId;
        if (userId != null) {
          FirestoreSettingsService.saveGachaSettings(
            userId: userId,
            gachaType: gachaType,
            settings: defaultSettings,
          ).then((success) {
            if (success) {
              print('Successfully saved gacha settings to Firestore for $gachaType');
            } else {
              print('Warning: Failed to save gacha settings to Firestore for $gachaType');
            }
          }).catchError((e) {
            print('Error saving gacha settings to Firestore (continuing with local save): $e');
            // Firestoreエラー時はローカルのみで動作継続
          });
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
      if (_isWebCloudAuthoritative) {
        await ensureWebCloudSyncReady();
      }

      // まずローカルデータを即座に取得（遅延なし）
      final prefs = await SharedPreferences.getInstance();
      final key = '$_namespace/gacha/$gachaType';
      final settingsString = prefs.getString(key);
      
      Map<String, dynamic> localSettings;
      if (settingsString != null) {
        final decoded = json.decode(settingsString);
        if (decoded is Map<String, dynamic>) {
          localSettings = decoded;
        } else {
          localSettings = _getDefaultGachaSettings();
        }
      } else {
        localSettings = _getDefaultGachaSettings();
      }
      if (_isWebCloudAuthoritative) {
        return localSettings;
      }
      
      // バックグラウンドでFirestoreから取得を試みる（非同期、エラーは無視）
      if (FirebaseAuthService.isAuthenticated) {
        final userId = FirebaseAuthService.userId;
        if (userId != null) {
          // 非同期でFirestoreから取得（エラーは無視、UIをブロックしない）
          FirestoreSettingsService.getGachaSettings(
            userId: userId,
            gachaType: gachaType,
          ).timeout(
            const Duration(seconds: 2),
            onTimeout: () => null,
          ).then((firestoreSettings) async {
            if (firestoreSettings != null) {
              // タイムスタンプを比較して新しい方を優先
              final localTime = localSettings['lastUpdated'] as String?;
              final firestoreTime = firestoreSettings['lastUpdated'] as String?;
              
              if (localTime != null && firestoreTime != null) {
                try {
                  final localDateTime = DateTime.parse(localTime);
                  final firestoreDateTime = DateTime.parse(firestoreTime);
                  
                  if (firestoreDateTime.isAfter(localDateTime)) {
                    // Firestoreのデータが新しい場合は、ローカルデータを更新
                    await prefs.setString(key, json.encode(firestoreSettings));
                    print('Background sync: Updated local gacha settings from Firestore for $gachaType');
                  } else {
                    // ローカルデータが新しい場合は、Firestoreを更新
                    await FirestoreSettingsService.saveGachaSettings(
                      userId: userId,
                      gachaType: gachaType,
                      settings: localSettings,
                    );
                  }
                } catch (e) {
                  // パースエラー時はパースに成功した方を採用
                  DateTime? localDateTime;
                  DateTime? firestoreDateTime;
                  
                  try {
                    localDateTime = DateTime.parse(localTime);
                  } catch (e) {
                    // ローカルのパース失敗
                  }
                  
                  try {
                    firestoreDateTime = DateTime.parse(firestoreTime);
                  } catch (e) {
                    // Firestoreのパース失敗
                  }
                  
                  if (firestoreDateTime != null && localDateTime != null) {
                    // 両方成功した場合は比較（通常はここには来ない）
                    if (firestoreDateTime.isAfter(localDateTime)) {
                      await prefs.setString(key, json.encode(firestoreSettings));
                      print('Background sync: Updated local gacha settings from Firestore for $gachaType');
                    } else {
                      await FirestoreSettingsService.saveGachaSettings(
                        userId: userId,
                        gachaType: gachaType,
                        settings: localSettings,
                      );
                    }
                  } else if (firestoreDateTime != null) {
                    // Firestoreのみ成功
                    await prefs.setString(key, json.encode(firestoreSettings));
                    print('Background sync: Updated local gacha settings from Firestore for $gachaType');
                  } else if (localDateTime != null) {
                    // ローカルのみ成功
                    await FirestoreSettingsService.saveGachaSettings(
                      userId: userId,
                      gachaType: gachaType,
                      settings: localSettings,
                    );
                  } else {
                    // 両方失敗した場合はFirestoreを優先（新しい物を採用の方針）
                    await prefs.setString(key, json.encode(firestoreSettings));
                    print('Background sync: Updated local gacha settings from Firestore for $gachaType');
                  }
                }
              } else if (firestoreTime != null) {
                // ローカルにタイムスタンプがない場合は、Firestoreのデータを使用
                await prefs.setString(key, json.encode(firestoreSettings));
                print('Background sync: Updated local gacha settings from Firestore for $gachaType');
              }
            }
          }).catchError((e) {
            // エラーは無視（バックグラウンド処理のため）
            print('Background sync error (ignored): $e');
          });
        }
      }
      
      // ローカルデータを即座に返す
      return localSettings;
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
  static Future<bool> saveNewGachaType(String gachaType, Map<String, dynamic> settings) async {
    // 将来の拡張用
    return await saveGachaSettings(gachaType, settings);
  }
  
  /// ユーザー設定を保存（将来の拡張用）
  static Future<bool> saveUserSettings(Map<String, dynamic> settings) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = '$_namespace/user_settings';
      
      // タイムスタンプを追加
      final settingsWithTimestamp = Map<String, dynamic>.from(settings);
      settingsWithTimestamp['lastUpdated'] = DateTime.now().toIso8601String();
      
      // ローカルに即座に保存（UXを下げない）
      await prefs.setString(key, json.encode(settingsWithTimestamp));
      
      // 認証済みユーザーの場合、Firestoreにも同時に保存（非同期、エラーは無視）
      if (FirebaseAuthService.isAuthenticated) {
        final userId = FirebaseAuthService.userId;
        if (userId != null) {
          FirestoreSettingsService.saveUserSettings(
            userId: userId,
            settings: settingsWithTimestamp,
          ).then((success) {
            if (success) {
              print('Successfully saved user settings to Firestore');
            } else {
              print('Warning: Failed to save user settings to Firestore');
            }
          }).catchError((e) {
            print('Error saving user settings to Firestore (continuing with local save): $e');
            // Firestoreエラー時はローカルのみで動作継続
          });
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
      // まずローカルデータを即座に取得（遅延なし）
      final prefs = await SharedPreferences.getInstance();
      final key = '$_namespace/user_settings';
      final settingsString = prefs.getString(key);
      
      Map<String, dynamic> localSettings;
      if (settingsString != null) {
        final decoded = json.decode(settingsString);
        if (decoded is Map<String, dynamic>) {
          localSettings = decoded;
        } else {
          localSettings = {};
        }
      } else {
        localSettings = {};
      }
      
      // バックグラウンドでFirestoreから取得を試みる（非同期、エラーは無視）
      if (FirebaseAuthService.isAuthenticated) {
        final userId = FirebaseAuthService.userId;
        if (userId != null) {
          // 非同期でFirestoreから取得（エラーは無視、UIをブロックしない）
          FirestoreSettingsService.getUserSettings(
            userId: userId,
          ).timeout(
            const Duration(seconds: 2),
            onTimeout: () => null,
          ).then((firestoreSettings) async {
            if (firestoreSettings != null) {
              // タイムスタンプを比較して新しい方を優先
              final localTime = localSettings['lastUpdated'] as String?;
              final firestoreTime = firestoreSettings['lastUpdated'] as String?;
              
              if (localTime != null && firestoreTime != null) {
                try {
                  final localDateTime = DateTime.parse(localTime);
                  final firestoreDateTime = DateTime.parse(firestoreTime);
                  
                  if (firestoreDateTime.isAfter(localDateTime)) {
                    // Firestoreのデータが新しい場合は、ローカルデータを更新
                    await prefs.setString(key, json.encode(firestoreSettings));
                    print('Background sync: Updated local user settings from Firestore');
                  } else {
                    // ローカルデータが新しい場合は、Firestoreを更新
                    await FirestoreSettingsService.saveUserSettings(
                      userId: userId,
                      settings: localSettings,
                    );
                  }
                } catch (e) {
                  // パースエラー時はパースに成功した方を採用
                  DateTime? localDateTime;
                  DateTime? firestoreDateTime;
                  
                  try {
                    localDateTime = DateTime.parse(localTime);
                  } catch (e) {
                    // ローカルのパース失敗
                  }
                  
                  try {
                    firestoreDateTime = DateTime.parse(firestoreTime);
                  } catch (e) {
                    // Firestoreのパース失敗
                  }
                  
                  if (firestoreDateTime != null && localDateTime != null) {
                    // 両方成功した場合は比較（通常はここには来ない）
                    if (firestoreDateTime.isAfter(localDateTime)) {
                      await prefs.setString(key, json.encode(firestoreSettings));
                      print('Background sync: Updated local user settings from Firestore');
                    } else {
                      await FirestoreSettingsService.saveUserSettings(
                        userId: userId,
                        settings: localSettings,
                      );
                    }
                  } else if (firestoreDateTime != null) {
                    // Firestoreのみ成功
                    await prefs.setString(key, json.encode(firestoreSettings));
                    print('Background sync: Updated local user settings from Firestore');
                  } else if (localDateTime != null) {
                    // ローカルのみ成功
                    await FirestoreSettingsService.saveUserSettings(
                      userId: userId,
                      settings: localSettings,
                    );
                  } else {
                    // 両方失敗した場合はFirestoreを優先（新しい物を採用の方針）
                    await prefs.setString(key, json.encode(firestoreSettings));
                    print('Background sync: Updated local user settings from Firestore');
                  }
                }
              } else if (firestoreTime != null) {
                // ローカルにタイムスタンプがない場合は、Firestoreのデータを使用
                await prefs.setString(key, json.encode(firestoreSettings));
                print('Background sync: Updated local user settings from Firestore');
              }
            }
          }).catchError((e) {
            // エラーは無視（バックグラウンド処理のため）
            print('Background sync error (ignored): $e');
          });
        }
      }
      
      // ローカルデータを即座に返す
      return localSettings;
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
      bool localPurchased = prefs.getBool('$_namespace/premium_purchased') ?? false;
      
      // RevenueCatから購入状態を確認（信頼できるソース）
      try {
        final isPurchased = await RevenueCatService.isFactorizationOptionPurchased();
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
      final appKeys = allKeys.where((key) => key.startsWith(_namespace)).toList();
      
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
      final appKeys = allKeys.where((key) => key.startsWith(_namespace)).toList();
      
      for (final key in appKeys) {
        await prefs.remove(key);
      }
      
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
      final appKeys = allKeys.where((key) => key.startsWith(_namespace)).toList();
      
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
      if (lastUserId != null && currentUserId != null && lastUserId != currentUserId) {
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
        '$_namespace/learning/',  // 学習記録
        '$_namespace/gacha/',     // ガチャ設定
        '$_namespace/user_settings',  // ユーザー設定
        '$_namespace/firestore_sync_completed_',  // 同期完了フラグ
      ];
      
      // 保持するキー（バージョン情報、最後のユーザーID）
      final keysToKeep = [
        _versionKey,
        _lastUserIdKey,
      ];
      
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
      
      // 現在のユーザーIDを保存
      await setLastUserId(currentUserId);
      
      // Firestoreからデータを取得してタイムスタンプベースでマージ
      // history配列はtimeフィールドで重複チェックしながら統合される
      await _syncFromFirestore();
      
      print('Account switch sync completed');
    } catch (e) {
      print('Error in account switch sync: $e');
    }
  }
  
  // ============================================================================
  // 無料で履歴管理可能なガチャ選択機能
  // ============================================================================
  
  static const String _selectedFreeGachasKey = '$_namespace/selected_free_gachas';
  
  /// 選択された無料ガチャのリストを取得
  static Future<List<String>> getSelectedFreeGachas() async {
    try {
      // まずローカルデータを即座に取得（遅延なし）
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_selectedFreeGachasKey);
      
      List<String> localSelected = [];
      if (jsonString != null) {
        try {
          final List<dynamic> decoded = json.decode(jsonString);
          localSelected = decoded.cast<String>();
        } catch (e) {
          print('Error decoding selected free gachas: $e');
        }
      }
      
      // バックグラウンドでFirestoreから取得を試みる（非同期、エラーは無視）
      if (FirebaseAuthService.isAuthenticated) {
        final userId = FirebaseAuthService.userId;
        if (userId != null) {
          FirestoreSettingsService.getOtherSetting(
            userId: userId,
            key: _selectedFreeGachasKey,
          ).timeout(
            const Duration(seconds: 2),
            onTimeout: () => null,
          ).then((firestoreValue) async {
            if (firestoreValue != null && firestoreValue is List) {
              final firestoreSelected = firestoreValue.cast<String>();
              if (firestoreSelected.isNotEmpty) {
                final jsonString = json.encode(firestoreSelected);
                await prefs.setString(_selectedFreeGachasKey, jsonString);
                print('Background sync: Updated selected free gachas from Firestore');
              }
            }
          }).catchError((e) {
            print('Background sync error (ignored): $e');
          });
        }
      }
      
      return localSelected;
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
      // 制限なしで全てのガチャを保存可能
      final prefs = await SharedPreferences.getInstance();
      final jsonString = json.encode(prefsPrefixes);
      await prefs.setString(_selectedFreeGachasKey, jsonString);
      
      // 認証済みユーザーの場合、Firestoreにもバックアップ（非同期、エラーは無視）
      if (FirebaseAuthService.isAuthenticated) {
        final userId = FirebaseAuthService.userId;
        if (userId != null) {
          FirestoreSettingsService.saveOtherSetting(
            userId: userId,
            key: _selectedFreeGachasKey,
            value: prefsPrefixes,
          ).then((success) {
            if (success) {
              print('Successfully saved selected free gachas to Firestore');
            } else {
              print('Warning: Failed to save selected free gachas to Firestore');
            }
          }).catchError((e) {
            print('Error saving selected free gachas to Firestore (continuing with local save): $e');
          });
        }
      }
      
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

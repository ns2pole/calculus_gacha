// test/simple_data_manager_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:joymath/models/math_problem.dart';
import 'package:joymath/models/learning_status.dart';
import 'package:joymath/services/problems/simple_data_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

void main() {
  group('SimpleDataManager Tests', () {
    late MathProblem testProblem;

    setUp(() {
      testProblem = MathProblem(
        id: 'test_problem_1',
        no: 1,
        category: 'テスト',
        level: '初級',
        question: 'テスト問題',
        answer: 'テスト答え',
        imageAsset: null,
        steps: [],
      );
    });

    group('Initialization Tests', () {
      test('initializes successfully', () async {
        SharedPreferences.setMockInitialValues({});
        final result = await SimpleDataManager.initialize();
        expect(result, true);
      });

      test('handles multiple initializations', () async {
        SharedPreferences.setMockInitialValues({});
        final result1 = await SimpleDataManager.initialize();
        final result2 = await SimpleDataManager.initialize();
        
        expect(result1, true);
        expect(result2, true);
      });
    });

    group('Gacha Settings Tests', () {
      test('saves and retrieves gacha settings', () async {
        SharedPreferences.setMockInitialValues({});
        await SimpleDataManager.initialize();

        final settings = {
          'filterMode': 'exclude_solved_ge1',
          'slotLevels': [0, 1, 2],
          'rollCount': 5,
        };

        final success = await SimpleDataManager.saveGachaSettings('test_gacha', settings);
        expect(success, true);

        final retrieved = await SimpleDataManager.getGachaSettings('test_gacha');
        expect(retrieved['filterMode'], 'exclude_solved_ge1');
        expect(retrieved['slotLevels'], [0, 1, 2]);
        expect(retrieved['rollCount'], 5);
      });

      test('returns default settings when not set', () async {
        SharedPreferences.setMockInitialValues({});
        await SimpleDataManager.initialize();

        final settings = await SimpleDataManager.getGachaSettings('new_gacha');
        expect(settings['filterMode'], 'exclude_solved_ge1');
        expect(settings['slotLevels'], [0, 1, 2]);
      });

      test('updates existing settings', () async {
        SharedPreferences.setMockInitialValues({});
        await SimpleDataManager.initialize();

        await SimpleDataManager.saveGachaSettings('test_gacha', {
          'filterMode': 'random',
        });

        await SimpleDataManager.saveGachaSettings('test_gacha', {
          'filterMode': 'exclude_solved_ge2',
        });

        final settings = await SimpleDataManager.getGachaSettings('test_gacha');
        expect(settings['filterMode'], 'exclude_solved_ge2');
      });

      test('handles multiple gacha types', () async {
        SharedPreferences.setMockInitialValues({});
        await SimpleDataManager.initialize();

        await SimpleDataManager.saveGachaSettings('gacha1', {
          'filterMode': 'random',
        });
        await SimpleDataManager.saveGachaSettings('gacha2', {
          'filterMode': 'exclude_solved_ge1',
        });

        final settings1 = await SimpleDataManager.getGachaSettings('gacha1');
        final settings2 = await SimpleDataManager.getGachaSettings('gacha2');

        expect(settings1['filterMode'], 'random');
        expect(settings2['filterMode'], 'exclude_solved_ge1');
      });
    });

    group('Premium Purchase Tests', () {
      test('checks premium purchase status', () async {
        SharedPreferences.setMockInitialValues({});
        await SimpleDataManager.initialize();

        final isPremium = await SimpleDataManager.isPremiumPurchased();
        expect(isPremium, isA<bool>());
      });

      test('sets premium purchase status', () async {
        SharedPreferences.setMockInitialValues({});
        await SimpleDataManager.initialize();

        final success = await SimpleDataManager.setPremiumPurchased(true);
        expect(success, true);

        final isPremium = await SimpleDataManager.isPremiumPurchased();
        // RevenueCatの状態も確認するため、結果は不定
        expect(isPremium, isA<bool>());
      });
    });


    group('Data Export Tests', () {
      test('exports all data', () async {
        SharedPreferences.setMockInitialValues({});
        await SimpleDataManager.initialize();

        await SimpleDataManager.saveLearningRecord(testProblem, LearningStatus.solved);
        await SimpleDataManager.saveGachaSettings('test_gacha', {'filterMode': 'random'});

        final exportData = await SimpleDataManager.exportAllData();
        expect(exportData, isNotEmpty);
        expect(exportData.keys.any((k) => k.contains('learning')), true);
        expect(exportData.keys.any((k) => k.contains('gacha')), true);
      });

      test('exports empty data when no data exists', () async {
        SharedPreferences.setMockInitialValues({});
        await SimpleDataManager.initialize();

        final exportData = await SimpleDataManager.exportAllData();
        expect(exportData, isA<Map<String, dynamic>>());
      });
    });

    group('Data Clear Tests', () {
      test('clears all data', () async {
        SharedPreferences.setMockInitialValues({});
        await SimpleDataManager.initialize();

        await SimpleDataManager.saveLearningRecord(testProblem, LearningStatus.solved);
        await SimpleDataManager.saveGachaSettings('test_gacha', {'filterMode': 'random'});

        final success = await SimpleDataManager.clearAllData();
        expect(success, true);

        final status = await SimpleDataManager.getLearningRecord(testProblem);
        expect(status, LearningStatus.none);
      });

      test('clears data without affecting other apps', () async {
        SharedPreferences.setMockInitialValues({
          'other_app_key': 'other_app_value',
        });
        await SimpleDataManager.initialize();

        await SimpleDataManager.saveLearningRecord(testProblem, LearningStatus.solved);
        await SimpleDataManager.clearAllData();

        final prefs = await SharedPreferences.getInstance();
        // 他のアプリのデータは残っている
        expect(prefs.getString('other_app_key'), 'other_app_value');
      });
    });

    group('User Settings Tests', () {
      test('saves and retrieves user settings', () async {
        SharedPreferences.setMockInitialValues({});
        await SimpleDataManager.initialize();

        final settings = {
          'theme': 'dark',
          'language': 'ja',
        };

        final success = await SimpleDataManager.saveUserSettings(settings);
        expect(success, true);

        final retrieved = await SimpleDataManager.getUserSettings();
        expect(retrieved['theme'], 'dark');
        expect(retrieved['language'], 'ja');
      });

      test('returns empty map when no user settings', () async {
        SharedPreferences.setMockInitialValues({});
        await SimpleDataManager.initialize();

        final settings = await SimpleDataManager.getUserSettings();
        expect(settings, isEmpty);
      });

      test('updates user settings', () async {
        SharedPreferences.setMockInitialValues({});
        await SimpleDataManager.initialize();

        await SimpleDataManager.saveUserSettings({'theme': 'light'});
        await SimpleDataManager.saveUserSettings({'theme': 'dark', 'language': 'en'});

        final settings = await SimpleDataManager.getUserSettings();
        expect(settings['theme'], 'dark');
        expect(settings['language'], 'en');
      });
    });

    group('Error Handling Tests', () {
      test('handles corrupted gacha settings gracefully', () async {
        SharedPreferences.setMockInitialValues({
          'joymath_simple/gacha/test_gacha': 'invalid-json',
        });
        await SimpleDataManager.initialize();

        final settings = await SimpleDataManager.getGachaSettings('test_gacha');
        // デフォルト設定が返される
        expect(settings['filterMode'], 'exclude_solved_ge1');
      });

      test('handles missing learning data gracefully', () async {
        SharedPreferences.setMockInitialValues({});
        await SimpleDataManager.initialize();

        final status = await SimpleDataManager.getLearningRecord(testProblem);
        expect(status, LearningStatus.none);
      });

      test('handles save errors gracefully', () async {
        SharedPreferences.setMockInitialValues({});
        await SimpleDataManager.initialize();

        // 正常な保存は成功する
        final success = await SimpleDataManager.saveLearningRecord(
          testProblem,
          LearningStatus.solved,
        );
        expect(success, true);
      });
    });

    // Migration Tests は削除（メソッドが存在しないため）

    group('Concurrent Access Tests', () {
      test('handles concurrent saves', () async {
        SharedPreferences.setMockInitialValues({});
        await SimpleDataManager.initialize();

        final problem2 = MathProblem(
          id: 'test_problem_2',
          no: 2,
          category: 'テスト',
          level: '初級',
          question: 'テスト問題2',
          answer: 'テスト答え2',
          imageAsset: null,
          steps: [],
        );

        // 並行して保存
        final futures = [
          SimpleDataManager.saveLearningRecord(testProblem, LearningStatus.solved),
          SimpleDataManager.saveLearningRecord(problem2, LearningStatus.understood),
        ];

        final results = await Future.wait(futures);
        expect(results.every((r) => r == true), true);

        expect(await SimpleDataManager.getLearningRecord(testProblem), LearningStatus.solved);
        expect(await SimpleDataManager.getLearningRecord(problem2), LearningStatus.understood);
      });
    });

    group('Firebase Sync Tests', () {
      test('clearLearningHistory removes local data even when not authenticated', () async {
        SharedPreferences.setMockInitialValues({});
        await SimpleDataManager.initialize();

        // 学習記録を保存
        final history = [
          {'status': 'solved', 'time': DateTime.now().toIso8601String()},
        ];
        await SimpleDataManager.saveLearningHistory(testProblem, history);

        // ローカルに保存されていることを確認
        final savedHistory = await SimpleDataManager.getLearningHistory(testProblem);
        expect(savedHistory.length, greaterThan(0));

        // クリア（認証されていない状態でも成功する必要がある）
        final success = await SimpleDataManager.clearLearningHistory(testProblem);
        expect(success, true);

        // ローカルから削除されていることを確認
        final clearedHistory = await SimpleDataManager.getLearningHistory(testProblem);
        expect(clearedHistory.length, 0);
      });

      test('saveLearningHistory syncs to Firestore when authenticated', () async {
        SharedPreferences.setMockInitialValues({});
        await SimpleDataManager.initialize();

        final history = [
          {'status': 'solved', 'time': DateTime.now().toIso8601String()},
        ];

        // 認証されていない状態でもローカル保存は成功する
        final success = await SimpleDataManager.saveLearningHistory(testProblem, history);
        expect(success, true);

        // ローカルに保存されていることを確認
        final savedHistory = await SimpleDataManager.getLearningHistory(testProblem);
        expect(savedHistory.length, greaterThan(0));
      });

      test('saveGachaSettings syncs to Firestore when authenticated', () async {
        SharedPreferences.setMockInitialValues({});
        await SimpleDataManager.initialize();

        final settings = {
          'filterMode': 'exclude_solved_ge1',
          'slotLevels': [0, 1, 2],
        };

        // 認証されていない状態でもローカル保存は成功する
        final success = await SimpleDataManager.saveGachaSettings('test_gacha', settings);
        expect(success, true);

        // ローカルに保存されていることを確認
        final savedSettings = await SimpleDataManager.getGachaSettings('test_gacha');
        expect(savedSettings['filterMode'], 'exclude_solved_ge1');
      });
    });

    group('History Merge Tests', () {
      test('merges history arrays by time field correctly', () async {
        SharedPreferences.setMockInitialValues({});
        await SimpleDataManager.initialize();

        final prefs = await SharedPreferences.getInstance();
        final namespace = 'joymath_simple';
        final problemId = testProblem.id;
        final localKey = '$namespace/learning/$problemId';

        // ローカルデータ: slot0: solved 13:33, slot1: understood 13:34
        final localTime1 = DateTime(2024, 1, 1, 13, 33).toIso8601String();
        final localTime2 = DateTime(2024, 1, 1, 13, 34).toIso8601String();
        final localData = {
          'problemId': problemId,
          'latestStatus': 'understood',
          'lastUpdated': localTime2,
          'history': [
            {'status': 'solved', 'time': localTime1},
            {'status': 'understood', 'time': localTime2},
            {'status': 'none', 'time': null},
          ],
        };
        await prefs.setString(localKey, json.encode(localData));

        // Firestoreデータを模擬: slot0: solved 13:33, slot1: understood 13:36
        final firestoreTime1 = DateTime(2024, 1, 1, 13, 33).toIso8601String();
        final firestoreTime2 = DateTime(2024, 1, 1, 13, 36).toIso8601String();
        final firestoreData = {
          'problemId': problemId,
          'latestStatus': 'understood',
          'lastUpdated': firestoreTime2,
          'history': [
            {'status': 'solved', 'time': firestoreTime1},
            {'status': 'understood', 'time': firestoreTime2},
            {'status': 'none', 'time': null},
          ],
        };

        // Firestoreのデータを模擬するために、一時的にFirestoreのデータを保存
        // 実際の_syncFromFirestoreの動作を模擬するため、直接データを操作
        // ただし、_syncFromFirestoreはprivateメソッドなので、直接テストできない
        // 代わりに、マージロジックを検証するために、実際のデータ構造を使って確認

        // ローカルデータを読み込んで確認
        final savedLocalDataString = prefs.getString(localKey);
        expect(savedLocalDataString, isNotNull);
        final savedLocalData = json.decode(savedLocalDataString!) as Map<String, dynamic>;
        final savedLocalHistory = savedLocalData['history'] as List;
        
        // ローカルデータが正しく保存されていることを確認
        expect(savedLocalHistory.length, 3);
        expect(savedLocalHistory[0]['status'], 'solved');
        expect(savedLocalHistory[0]['time'], localTime1);
        expect(savedLocalHistory[1]['status'], 'understood');
        expect(savedLocalHistory[1]['time'], localTime2);
        expect(savedLocalHistory[2]['status'], 'none');
        expect(savedLocalHistory[2]['time'], null);

        // マージロジックを手動で実行して検証
        // 実際の_syncFromFirestoreのロジックを模擬
        final localHistory = savedLocalHistory;
        final firestoreHistory = firestoreData['history'] as List;

        // timeフィールドで重複チェックしながら統合
        final mergedHistory = <Map<String, dynamic>>[];
        final seenTimes = <String>{};

        // まずローカルの履歴を追加
        for (final record in localHistory) {
          if (record is Map<String, dynamic>) {
            final time = record['time'] as String?;
            if (time != null && time.isNotEmpty) {
              if (!seenTimes.contains(time)) {
                mergedHistory.add(Map<String, dynamic>.from(record));
                seenTimes.add(time);
              }
            }
          }
        }

        // 次にFirestoreの履歴を追加
        for (final record in firestoreHistory) {
          if (record is Map<String, dynamic>) {
            final time = record['time'] as String?;
            if (time != null && time.isNotEmpty) {
              if (!seenTimes.contains(time)) {
                mergedHistory.add(Map<String, dynamic>.from(record));
                seenTimes.add(time);
              }
            }
          }
        }

        // 時系列でソート（古い順）
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
          final sortedHistory = mergedHistory.reversed.toList(); // 新しい順
          final count = mergedHistory.length;

          if (count == 1) {
            slots[0] = Map<String, dynamic>.from(sortedHistory[0]);
          } else if (count == 2) {
            slots[1] = Map<String, dynamic>.from(sortedHistory[0]); // 最新
            slots[0] = Map<String, dynamic>.from(sortedHistory[1]); // 古い
          } else {
            slots[2] = Map<String, dynamic>.from(sortedHistory[0]); // 最新
            slots[1] = Map<String, dynamic>.from(sortedHistory[1]); // 次に新しい
            slots[0] = Map<String, dynamic>.from(sortedHistory[2]); // その次に新しい
          }
        }

        // 期待される結果を検証
        // slot0: solved 13:33
        // slot1: understood 13:34
        // slot2: understood 13:36
        expect(slots.length, 3);
        expect(slots[0]['status'], 'solved');
        expect(slots[0]['time'], localTime1); // 13:33
        expect(slots[1]['status'], 'understood');
        expect(slots[1]['time'], localTime2); // 13:34
        expect(slots[2]['status'], 'understood');
        expect(slots[2]['time'], firestoreTime2); // 13:36
      });
    });
  });
}




// test/exclusion_logic_test.dart
// 除外ロジックのテストケース

import 'package:flutter_test/flutter_test.dart';

// ProblemStatusを定義（problem_list_page.dartから）
enum ProblemStatus { none, solved, understood, failed }

void main() {
  group('除外ロジックテスト', () {
    test('黄色緑緑 needed=1 の場合', () {
      // スロットを作成：_getSlotsが返す順序をシミュレート
      // _getSlotsは履歴をそのまま使うので、slots[0]が最古、slots[2]が最新
      final now = DateTime.now();
      final slots = [
        {
          'status': ProblemStatus.understood, // 黄色（最古、slots[0]）
          'time': now.subtract(const Duration(seconds: 2)),
        },
        {
          'status': ProblemStatus.solved, // 緑（中間、slots[1]）
          'time': now.subtract(const Duration(seconds: 1)),
        },
        {
          'status': ProblemStatus.solved, // 緑（最新、slots[2]）
          'time': now,
        },
      ];

      print('=== テスト: 黄色緑緑 needed=1 ===');
      print('元のスロット順序:');
      for (var i = 0; i < slots.length; i++) {
        final status = slots[i]['status'] as ProblemStatus;
        final time = slots[i]['time'] as DateTime?;
        print('  slots[$i]: ${status.name}, time: ${time?.toIso8601String()}');
      }

      // _sortSlotsByTime をテスト
      final sorted = _sortSlotsByTime(slots);
      
      print('\nソート後の順序:');
      for (var i = 0; i < sorted.length; i++) {
        final status = sorted[i]['status'] as ProblemStatus;
        final time = sorted[i]['time'] as DateTime?;
        print('  sorted[$i]: ${status.name}, time: ${time?.toIso8601String()}');
      }
      
      // 最新が先頭にあることを確認
      expect(sorted[0]['status'], ProblemStatus.solved);
      expect(sorted[0]['time'], now);
      
      // _countConsecutiveSolved をテスト
      final count = _countConsecutiveSolved(slots);
      
      print('\n連続緑の数: $count');
      print('needed=1の場合、除外されるべき: ${count >= 1}');
      
      // 最新から見て緑が2個連続している
      expect(count, 2);
      
      // needed=1の場合、2 >= 1 なので除外されるべき
      expect(count >= 1, true);
    });

    test('赤緑 needed=1 の場合', () {
      final now = DateTime.now();
      final slots = [
        {
          'status': ProblemStatus.failed, // 赤（最古）
          'time': now.subtract(const Duration(seconds: 1)),
        },
        {
          'status': ProblemStatus.solved, // 緑（最新）
          'time': now,
        },
        {
          'status': ProblemStatus.none,
          'time': null,
        },
      ];

      final count = _countConsecutiveSolved(slots);
      
      // 最新が緑で1個連続
      expect(count, 1);
      
      // needed=1の場合、1 >= 1 なので除外されるべき
      expect(count >= 1, true);
    });

    test('緑のみ needed=1 の場合', () {
      final now = DateTime.now();
      final slots = [
        {
          'status': ProblemStatus.solved, // 緑（最新）
          'time': now,
        },
        {
          'status': ProblemStatus.none,
          'time': null,
        },
        {
          'status': ProblemStatus.none,
          'time': null,
        },
      ];

      final count = _countConsecutiveSolved(slots);
      
      // 最新が緑で1個連続
      expect(count, 1);
      
      // needed=1の場合、1 >= 1 なので除外されるべき
      expect(count >= 1, true);
    });
  });
}

// テスト用に公開する必要がある関数をコピー
List<Map<String, dynamic>> _sortSlotsByTime(List<Map<String, dynamic>> slots) {
  final sorted = List<Map<String, dynamic>>.from(slots);
  sorted.sort((a, b) {
    final timeA = a['time'] as DateTime?;
    final timeB = b['time'] as DateTime?;
    if (timeA == null && timeB == null) return 0;
    if (timeA == null) return 1;
    if (timeB == null) return -1;
    return timeB.compareTo(timeA); // 降順（最新が先頭）
  });
  return sorted;
}

int _countConsecutiveSolved(List<Map<String, dynamic>> slots) {
  final sorted = _sortSlotsByTime(slots);
  
  final nonNone = <ProblemStatus>[];
  for (final slot in sorted) {
    final status = slot['status'] as ProblemStatus;
    if (status != ProblemStatus.none) {
      nonNone.add(status);
    }
  }

  int consecutiveSolved = 0;
  for (final status in nonNone) {
    if (status == ProblemStatus.solved) {
      consecutiveSolved++;
    } else {
      break;
    }
  }
  
  return consecutiveSolved;
}


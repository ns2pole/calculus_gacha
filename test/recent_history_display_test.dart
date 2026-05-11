import 'package:flutter_test/flutter_test.dart';
import 'package:joymath/services/problems/exclusion_logic.dart';

void main() {
  group('recentHistoryRecordsNewestFirstLeft', () {
    test('single attempt in first slot — newest is left', () {
      final h = [
        {'status': 'solved', 'time': '2026-01-01T10:00:00.000Z'},
        {'status': 'none', 'time': null},
        {'status': 'none', 'time': null},
      ];
      final one = recentHistoryRecordsNewestFirstLeft(h, displayCount: 1);
      expect(one.length, 1);
      expect(one.first['status'], 'solved');

      final three = recentHistoryRecordsNewestFirstLeft(h, displayCount: 3);
      expect(three.length, 3);
      expect(three[0]['status'], 'solved');
      expect(three[1]['status'], 'none');
      expect(three[2]['status'], 'none');
    });

    test('three filled slots — oldest→newest storage becomes newest-first row', () {
      final h = [
        {'status': 'failed', 'time': '2026-01-01T10:00:00.000Z'},
        {'status': 'understood', 'time': '2026-01-02T10:00:00.000Z'},
        {'status': 'solved', 'time': '2026-01-03T10:00:00.000Z'},
      ];
      final row = recentHistoryRecordsNewestFirstLeft(h, displayCount: 3);
      expect(row[0]['status'], 'solved');
      expect(row[1]['status'], 'understood');
      expect(row[2]['status'], 'failed');
    });

    test('same timestamps preserve storage order (no time sort)', () {
      final t = '2026-01-01T12:00:00.000Z';
      final h = [
        {'status': 'failed', 'time': t},
        {'status': 'solved', 'time': t},
      ];
      final row = recentHistoryRecordsNewestFirstLeft(h, displayCount: 2);
      expect(row[0]['status'], 'solved');
      expect(row[1]['status'], 'failed');
    });

    test('truncates to last storageSlotCount when longer than 3', () {
      final h = [
        {'status': 'failed', 'time': '2026-01-01T10:00:00.000Z'},
        {'status': 'understood', 'time': '2026-01-02T10:00:00.000Z'},
        {'status': 'solved', 'time': '2026-01-03T10:00:00.000Z'},
        {'status': 'failed', 'time': '2026-01-04T10:00:00.000Z'},
      ];
      final row = recentHistoryRecordsNewestFirstLeft(h, displayCount: 3);
      // 末尾3スロットは understood → solved → failed（左から埋まる順）。表示は最新が左。
      expect(row[0]['status'], 'failed');
      expect(row[1]['status'], 'solved');
      expect(row[2]['status'], 'understood');
    });

    test('all none yields padded none row', () {
      final h = [
        {'status': 'none', 'time': null},
        {'status': 'none', 'time': null},
      ];
      final row = recentHistoryRecordsNewestFirstLeft(h, displayCount: 2);
      expect(row.every((e) => e['status'] == 'none'), true);
    });
  });
}

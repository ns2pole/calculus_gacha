import 'package:flutter_test/flutter_test.dart';
import 'package:joymath/models/ai_tutor_usage_snapshot.dart';

void main() {
  group('AiTutorUsageSnapshot', () {
    test('parses composite free and pass usage from API JSON', () {
      final snapshot = AiTutorUsageSnapshot.fromJson({
        'tier': 'free',
        'period': 'monthly',
        'count': 5,
        'limit': 515,
        'remaining': 510,
        'totalRemaining': 510,
        'free': {
          'count': 5,
          'limit': 15,
          'remaining': 10,
          'periodKey': '2026/06',
        },
        'passes': [
          {
            'passId': 'pass-a',
            'purchasedAt': '2026-06-01T00:00:00.000Z',
            'expiresAt': '2027-06-01T00:00:00.000Z',
            'used': 0,
            'limit': 500,
            'remaining': 500,
          },
        ],
      });

      expect(snapshot.totalRemaining, 510);
      expect(snapshot.freeRemaining, 10);
      expect(snapshot.freeLimit, 15);
      expect(snapshot.hasPasses, isTrue);
      expect(snapshot.passRemaining, 500);
      expect(snapshot.passLimit, 500);
    });

    test('totalRemaining falls back to remaining field', () {
      final snapshot = AiTutorUsageSnapshot.fromJson({
        'tier': 'free',
        'period': 'monthly',
        'count': 0,
        'limit': 15,
        'remaining': 15,
      });

      expect(snapshot.totalRemaining, 15);
      expect(snapshot.freeRemaining, 15);
      expect(snapshot.hasPasses, isFalse);
    });
  });
}

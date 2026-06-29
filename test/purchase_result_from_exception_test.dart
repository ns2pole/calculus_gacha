import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import 'package:joymath/services/payment/purchase_result_from_exception.dart';
import 'package:joymath/services/payment/revenuecat_service.dart';

void main() {
  group('purchaseResultFromException', () {
    test('returns cancelled when user dismisses billing sheet', () {
      final exception = PlatformException(
        code: PurchasesErrorCode.purchaseCancelledError.index.toString(),
        message: 'Purchase was cancelled.',
      );

      final result = purchaseResultFromException(exception);

      expect(result, isNotNull);
      expect(result!.success, isFalse);
      expect(result.cancelled, isTrue);
      expect(result.error, 'Purchase cancelled');
    });

    test('returns network error result without cancelled flag', () {
      final exception = PlatformException(
        code: PurchasesErrorCode.networkError.index.toString(),
        message: 'Network error.',
      );

      final result = purchaseResultFromException(exception);

      expect(result, isNotNull);
      expect(result!.success, isFalse);
      expect(result.cancelled, isFalse);
      expect(result.error, contains('Network error'));
    });

    test('returns null for non-platform exceptions so caller can fall back', () {
      expect(purchaseResultFromException(Exception('offerings unavailable')), isNull);
    });
  });

  group('shouldShowPurchaseFailureMessage', () {
    test('does not show toast when purchase was cancelled', () {
      expect(
        shouldShowPurchaseFailureMessage(
          PurchaseResult(success: false, cancelled: true),
        ),
        isFalse,
      );
    });

    test('shows toast for real purchase failures', () {
      expect(
        shouldShowPurchaseFailureMessage(
          PurchaseResult(
            success: false,
            error: 'Product not found: ai_tutor_one_year_500yen_consumable',
          ),
        ),
        isTrue,
      );
    });

    test('does not show toast for successful purchase', () {
      expect(
        shouldShowPurchaseFailureMessage(PurchaseResult(success: true)),
        isFalse,
      );
    });
  });
}

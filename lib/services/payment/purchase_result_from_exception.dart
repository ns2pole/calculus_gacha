import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import 'revenuecat_service.dart';

/// Maps RevenueCat purchase exceptions to [PurchaseResult].
///
/// Returns `null` when the caller should continue with fallback purchase paths.
PurchaseResult? purchaseResultFromException(Object error) {
  if (error is! PlatformException) {
    return null;
  }

  final errorCode = PurchasesErrorHelper.getErrorCode(error);
  switch (errorCode) {
    case PurchasesErrorCode.purchaseCancelledError:
      return PurchaseResult(
        success: false,
        error: 'Purchase cancelled',
        cancelled: true,
      );
    case PurchasesErrorCode.networkError:
      return PurchaseResult(
        success: false,
        error: 'Network error. Please check your connection.',
      );
    case PurchasesErrorCode.purchaseNotAllowedError:
      return PurchaseResult(success: false, error: 'Purchase not allowed');
    case PurchasesErrorCode.purchaseInvalidError:
      return PurchaseResult(success: false, error: 'Invalid purchase');
    default:
      return null;
  }
}

/// Whether the purchase dialog should show a failure SnackBar.
bool shouldShowPurchaseFailureMessage(PurchaseResult result) {
  return !result.success && !result.cancelled;
}

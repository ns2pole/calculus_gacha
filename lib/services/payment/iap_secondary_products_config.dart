// lib/services/payment/iap_secondary_products_config.dart
//
// Master switch for optional IAP integrations that are not the primary
// (factorization) product. When disabled, no RevenueCat calls are made for
// these SKUs and StoreKit diagnostic MethodChannel hooks are skipped.
//
// To re-enable learning-history IAP + debug StoreKit listing/tests: set the
// const below to `true` (single-line change).

/// When `true`, wires up learning-history RevenueCat checks/prices/purchases
/// and allows [RevenueCatService] StoreKit diagnostic helpers to hit native code.
const bool kEnableLearningHistoryAndStoreKitDiagnostics = false;

/// Store / RevenueCat identifiers for the learning-history option (inactive unless
/// [kEnableLearningHistoryAndStoreKitDiagnostics] is `true`).
abstract final class LearningHistoryIapIds {
  static const String productId = 'Learning_history_option_500yen';
  static const String entitlementId = 'learning_history_option';
}

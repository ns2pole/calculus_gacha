import 'package:ai_chat_kit/ai_chat_kit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../services/auth/cloud_sync_preference_service.dart';
import '../../services/auth/firebase_auth_service.dart';
import '../../services/payment/ai_tutor_entitlement_sync_service.dart';
import '../../services/payment/revenuecat_service.dart';
import 'joymath_ai_tutor_purchase_dialog.dart';

String joymathRestoreSyncFailureMessage(
  AppLocalizations l10n,
  AiTutorEntitlementSyncResult result,
) {
  return switch (result.failureReason) {
    AiTutorEntitlementSyncFailureReason.endpointNotConfigured =>
      l10n.aiTutorRestoreFailureSyncNotConfigured,
    AiTutorEntitlementSyncFailureReason.notSignedIn =>
      l10n.aiTutorRestoreFailureNotSignedIn,
    AiTutorEntitlementSyncFailureReason.serverRejected =>
      l10n.aiTutorRestoreFailureServerRejected(result.detail ?? ''),
    AiTutorEntitlementSyncFailureReason.inactive =>
      l10n.aiTutorRestoreFailureInactive,
    AiTutorEntitlementSyncFailureReason.timeout =>
      l10n.aiTutorRestoreFailureSyncTimeout,
    AiTutorEntitlementSyncFailureReason.unexpected =>
      l10n.aiTutorRestoreFailureUnexpected(result.detail ?? ''),
    null => l10n.aiTutorRestoreFailureSyncUnknown,
  };
}

Future<AiChatUpgradeResult> joymathPurchaseAiTutor(BuildContext context) async {
  final l10n = AppLocalizations.of(context)!;

  final price =
      await RevenueCatService.getAiTutorPassPrice() ?? l10n.defaultPrice;
  if (!context.mounted) return const AiChatUpgradeResult.cancelled();

  final purchased = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => JoymathAiTutorPurchaseDialog(price: price),
  );

  if (purchased == true) {
    return const AiChatUpgradeResult(success: true);
  }
  return const AiChatUpgradeResult.cancelled();
}
Future<AiChatUpgradeResult> joymathRestoreAiTutor(BuildContext context) async {
  final l10n = AppLocalizations.of(context)!;
  final usesAppleSignIn =
      !kIsWeb && defaultTargetPlatform == TargetPlatform.iOS;

  await FirebaseAuthService.signOut();
  await RevenueCatService.logOutCurrentUser();

  final credential = usesAppleSignIn
      ? await FirebaseAuthService.signInWithApple()
      : await FirebaseAuthService.signInWithGoogle();
  if (credential == null) return const AiChatUpgradeResult.cancelled();

  final uid = credential.user?.uid;
  if (uid != null) {
    await CloudSyncPreferenceService.refreshForUser(uid);
  }

  await RevenueCatService.syncCurrentFirebaseUser();
  final restored = await RevenueCatService.restoreAiTutorPass();
  if (!restored) {
    return AiChatUpgradeResult(
      success: false,
      userMessage: l10n.aiTutorRestoreFailureNoPurchase,
    );
  }

  final syncResult =
      await AiTutorEntitlementSyncService.syncAfterPurchaseOrRestoreDetailed();
  if (syncResult.active) {
    return AiChatUpgradeResult(
      success: true,
      userMessage: l10n.aiTutorRestoreSuccessVerified,
    );
  }

  return AiChatUpgradeResult(
    success: false,
    userMessage: joymathRestoreSyncFailureMessage(l10n, syncResult),
  );
}

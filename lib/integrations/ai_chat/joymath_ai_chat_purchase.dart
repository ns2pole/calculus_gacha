import 'package:ai_chat_kit/ai_chat_kit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../services/auth/cloud_sync_preference_service.dart';
import '../../services/auth/firebase_auth_service.dart';
import '../../services/payment/ai_tutor_entitlement_sync_service.dart';
import '../../services/payment/purchase_result_from_exception.dart';
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

  final confirmed = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => JoymathAiTutorPurchaseDialog(price: price),
  );

  if (confirmed != true) {
    return const AiChatUpgradeResult.cancelled();
  }

  try {
    await RevenueCatService.syncCurrentFirebaseUser();
    final result = await RevenueCatService.purchaseAiTutorPass();
    if (!context.mounted) return const AiChatUpgradeResult.cancelled();

    if (result.success) {
      final syncResult =
          await AiTutorEntitlementSyncService.syncAfterPurchaseOrRestoreDetailed();
      if (!context.mounted) return const AiChatUpgradeResult.cancelled();

      if (syncResult.active) {
        await _showAiTutorPurchaseSuccessDialog(context);
        return const AiChatUpgradeResult(success: true);
      }

      return AiChatUpgradeResult(
        success: false,
        userMessage: joymathRestoreSyncFailureMessage(l10n, syncResult),
      );
    }

    if (!shouldShowPurchaseFailureMessage(result)) {
      return const AiChatUpgradeResult.cancelled();
    }
    return AiChatUpgradeResult(
      success: false,
      userMessage: l10n.purchaseFailed(
        result.error ?? l10n.unknownError,
      ),
    );
  } catch (e) {
    if (!context.mounted) return const AiChatUpgradeResult.cancelled();
    return AiChatUpgradeResult(
      success: false,
      userMessage: l10n.purchaseFailed(e.toString()),
    );
  }
}

Future<void> _showAiTutorPurchaseSuccessDialog(BuildContext context) async {
  final l10n = AppLocalizations.of(context)!;
  final theme = Theme.of(context);

  await showDialog<void>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(24, 32, 24, 8),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check_circle,
            size: 72,
            color: Colors.green.shade600,
          ),
          const SizedBox(height: 20),
          Text(
            l10n.purchaseComplete,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            l10n.aiTutorPurchaseSuccess,
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        FilledButton(
          onPressed: () => Navigator.of(dialogContext).pop(),
          child: Text(l10n.ok),
        ),
      ],
    ),
  );
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

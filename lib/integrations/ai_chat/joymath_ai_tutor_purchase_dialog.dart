import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../services/auth/cloud_sync_preference_service.dart';
import '../../services/auth/firebase_auth_service.dart';
import '../../services/payment/ai_tutor_entitlement_sync_service.dart';
import '../../services/payment/revenuecat_service.dart';
import '../../widgets/legal/iap_product_info_section.dart';
import '../../widgets/legal/legal_notice_footer.dart';
import 'joymath_ai_chat_purchase.dart';

class JoymathAiTutorPurchaseDialog extends StatefulWidget {
  final String price;

  const JoymathAiTutorPurchaseDialog({super.key, required this.price});

  @override
  State<JoymathAiTutorPurchaseDialog> createState() =>
      _JoymathAiTutorPurchaseDialogState();
}

class _JoymathAiTutorPurchaseDialogState
    extends State<JoymathAiTutorPurchaseDialog> {
  bool _isProcessing = false;
  bool _isSigningInBeforePurchase = false;

  bool get _usesAppleSignIn =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.iOS;

  String _platformBillingBenefitText(AppLocalizations l10n) {
    if (!kIsWeb) {
      switch (defaultTargetPlatform) {
        case TargetPlatform.android:
          return l10n.aiTutorPurchaseBenefitPlatformBilling('Google Play');
        case TargetPlatform.iOS:
        case TargetPlatform.macOS:
          return l10n.aiTutorPurchaseBenefitPlatformBilling('App Store');
        default:
          break;
      }
    }
    return l10n.aiTutorPurchaseBenefitPlatformBillingAny;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isAuthenticated = FirebaseAuthService.isAuthenticated;
    final signInButtonText = _usesAppleSignIn
        ? l10n.aiTutorSignInWithAppleToPurchase
        : l10n.aiTutorSignInWithGoogleToPurchase;

    return AlertDialog(
      contentPadding: const EdgeInsets.fromLTRB(24, 28, 24, 16),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IapProductInfoSection(
            productName: l10n.aiTutorPurchaseProductName,
            price: widget.price,
            duration: l10n.aiTutorPurchaseDurationValue,
          ),
          const SizedBox(height: 14),
          _BenefitRow(text: l10n.aiTutorPurchaseBenefitMonthlyLimit),
          const SizedBox(height: 8),
          _BenefitRow(text: _platformBillingBenefitText(l10n)),
          const SizedBox(height: 14),
          const LegalNoticeFooter(),
          if (_isProcessing) ...[
            const SizedBox(height: 16),
            Row(
              children: [
                const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    _isSigningInBeforePurchase
                        ? l10n.aiTutorSignInInProgress
                        : l10n.aiTutorPurchaseInProgress,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        FilledButton(
          onPressed: _isProcessing
              ? null
              : (isAuthenticated ? _purchase : _signInAndPurchase),
          child: Text(isAuthenticated ? l10n.purchase : signInButtonText),
        ),
        TextButton(
          onPressed: _isProcessing
              ? null
              : () => Navigator.of(context).pop(false),
          child: Text(l10n.cancel),
        ),
      ],
    );
  }

  Future<void> _purchase() async {
    setState(() {
      _isProcessing = true;
      _isSigningInBeforePurchase = false;
    });
    try {
      await RevenueCatService.syncCurrentFirebaseUser();
      final result = await RevenueCatService.purchaseAiTutorSubscription();
      if (!mounted) return;
      setState(() {
        _isProcessing = false;
        _isSigningInBeforePurchase = false;
      });
      if (result.success) {
        final syncResult = await AiTutorEntitlementSyncService
            .syncAfterPurchaseOrRestoreDetailed();
        if (!mounted) return;
        if (syncResult.active) {
          Navigator.of(context).pop(true);
          return;
        }
        _showError(joymathRestoreSyncFailureMessage(
          AppLocalizations.of(context)!,
          syncResult,
        ));
        return;
      }
      if (result.cancelled) return;
      _showError(
        AppLocalizations.of(context)!
            .purchaseFailed(result.error ?? AppLocalizations.of(context)!.unknownError),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isProcessing = false;
        _isSigningInBeforePurchase = false;
      });
      _showError(
        AppLocalizations.of(context)!.purchaseFailed(e.toString()),
      );
    }
  }

  Future<void> _signInAndPurchase() async {
    final l10n = AppLocalizations.of(context)!;
    setState(() {
      _isProcessing = true;
      _isSigningInBeforePurchase = true;
    });

    try {
      final credential = _usesAppleSignIn
          ? await FirebaseAuthService.signInWithApple()
          : await FirebaseAuthService.signInWithGoogle();
      if (!mounted) return;
      if (credential == null) {
        setState(() {
          _isProcessing = false;
          _isSigningInBeforePurchase = false;
        });
        return;
      }

      final uid = credential.user?.uid;
      if (uid != null) {
        await CloudSyncPreferenceService.refreshForUser(uid);
      }

      await RevenueCatService.syncCurrentFirebaseUser();
      if (!mounted) return;
      setState(() {
        _isProcessing = false;
        _isSigningInBeforePurchase = false;
      });
      await _purchase();
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isProcessing = false;
        _isSigningInBeforePurchase = false;
      });
      _showError(
        '${_usesAppleSignIn ? l10n.auth_appleSignInFailed : l10n.auth_googleSignInFailed}: $e',
      );
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}

class _BenefitRow extends StatelessWidget {
  final String text;

  const _BenefitRow({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.check_circle,
          size: 18,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ],
    );
  }
}

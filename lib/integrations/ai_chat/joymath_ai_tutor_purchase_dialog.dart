import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../services/auth/cloud_sync_preference_service.dart';
import '../../services/auth/firebase_auth_service.dart';
import '../../services/payment/revenuecat_service.dart';
import '../../widgets/legal/iap_product_info_section.dart';
import '../../widgets/legal/legal_notice_footer.dart';

class JoymathAiTutorPurchaseDialog extends StatefulWidget {
  final String price;

  const JoymathAiTutorPurchaseDialog({super.key, required this.price});

  @override
  State<JoymathAiTutorPurchaseDialog> createState() =>
      _JoymathAiTutorPurchaseDialogState();
}

class _JoymathAiTutorPurchaseDialogState
    extends State<JoymathAiTutorPurchaseDialog> {
  bool _isSigningIn = false;

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
          _BenefitRow(text: l10n.aiTutorPurchaseBenefitPassLimit),
          const SizedBox(height: 8),
          _BenefitRow(text: _platformBillingBenefitText(l10n)),
          const SizedBox(height: 14),
          const LegalNoticeFooter(),
          if (_isSigningIn) ...[
            const SizedBox(height: 16),
            Row(
              children: [
                const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                const SizedBox(width: 10),
                Expanded(child: Text(l10n.aiTutorSignInInProgress)),
              ],
            ),
          ],
        ],
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        FilledButton(
          onPressed: _isSigningIn
              ? null
              : (isAuthenticated ? _confirmPurchase : _signInAndConfirm),
          child: Text(isAuthenticated ? l10n.purchase : signInButtonText),
        ),
        TextButton(
          onPressed: _isSigningIn
              ? null
              : () => Navigator.of(context).pop(false),
          child: Text(l10n.cancel),
        ),
      ],
    );
  }

  void _confirmPurchase() {
    Navigator.of(context).pop(true);
  }

  Future<void> _signInAndConfirm() async {
    final l10n = AppLocalizations.of(context)!;
    setState(() => _isSigningIn = true);

    try {
      final credential = _usesAppleSignIn
          ? await FirebaseAuthService.signInWithApple()
          : await FirebaseAuthService.signInWithGoogle();
      if (!mounted) return;
      if (credential == null) {
        setState(() => _isSigningIn = false);
        return;
      }

      final uid = credential.user?.uid;
      if (uid != null) {
        await CloudSyncPreferenceService.refreshForUser(uid);
      }

      await RevenueCatService.syncCurrentFirebaseUser();
      if (!mounted) return;
      Navigator.of(context).pop(true);
    } catch (e) {
      if (!mounted) return;
      setState(() => _isSigningIn = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${_usesAppleSignIn ? l10n.auth_appleSignInFailed : l10n.auth_googleSignInFailed}: $e',
          ),
        ),
      );
    }
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

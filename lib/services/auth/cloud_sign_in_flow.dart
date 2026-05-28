import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../services/problems/simple_data_manager.dart';
import '../../utils/l10n_utils.dart';
import 'cloud_sync_preference_service.dart';
import 'firebase_auth_service.dart';

/// Platform-native sign-in when the user taps the cloud icon while logged out.
class CloudSignInFlow {
  CloudSignInFlow._();

  static bool get usesAppleSignIn =>
      !kIsWeb && defaultTargetPlatform == TargetPlatform.iOS;

  /// Starts Google (Android/Web) or Apple (iOS) sign-in. Returns true on success.
  static Future<bool> signIn(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final shouldEnableCloud = await _confirmCloudSignIn(context, l10n);
    if (!shouldEnableCloud) {
      return false;
    }

    try {
      final userCredential = usesAppleSignIn
          ? await FirebaseAuthService.signInWithApple()
          : await FirebaseAuthService.signInWithGoogle();

      if (userCredential == null) {
        return false;
      }

      final uid = userCredential.user?.uid;
      if (uid != null) {
        await CloudSyncPreferenceService.setEnabled(uid, true);
        await CloudSyncPreferenceService.refreshForUser(uid);
      }

      _syncDataInBackground();

      if (!context.mounted) return true;

      final loginMethod = FirebaseAuthService.loginMethod;
      final localizedMethod = getLocalizedLoginMethod(
        context,
        loginMethod ?? (usesAppleSignIn ? 'apple' : 'google'),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.auth_emailSignInSuccess(localizedMethod)),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );
      return true;
    } catch (e) {
      if (!context.mounted) return false;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            usesAppleSignIn
                ? l10n.auth_appleSignInFailed
                : '${l10n.auth_googleSignInFailed}: $e',
          ),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
      return false;
    }
  }

  static Future<bool> _confirmCloudSignIn(
    BuildContext context,
    AppLocalizations l10n,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(l10n.syncWithCloud),
          content: Text(l10n.auth_cloudSyncDescription),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(l10n.auth_backButton),
            ),
            FilledButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: Text(l10n.auth_signInButton),
            ),
          ],
        );
      },
    );
    return confirmed == true;
  }

  static Future<void> _syncDataInBackground() async {
    try {
      await Future.delayed(const Duration(seconds: 2));

      int waitCount = 0;
      const maxWaitCount = 10;
      while (!FirebaseAuthService.isAuthenticated && waitCount < maxWaitCount) {
        await Future.delayed(const Duration(milliseconds: 100));
        waitCount++;
      }

      if (!FirebaseAuthService.isAuthenticated) {
        return;
      }

      final uid = FirebaseAuthService.userId;
      if (!await CloudSyncPreferenceService.isEnabledForUser(uid)) {
        return;
      }

      await Future.delayed(Duration.zero);
      await SimpleDataManager.isAccountSwitched();
      await Future.delayed(const Duration(milliseconds: 50));
      await SimpleDataManager.performCloudSync(force: true);
    } catch (_) {
      // Background sync failures are non-blocking for the UI.
    }
  }
}

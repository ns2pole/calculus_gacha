import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../services/auth/account_deletion_service.dart';
import '../../services/auth/firebase_auth_service.dart';

class AccountDeletionFlow {
  AccountDeletionFlow._();

  static Future<bool> show(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await _showConfirmationDialog(context, l10n);
    if (confirmed != true || !context.mounted) {
      return false;
    }

    final reauthenticated = await _reauthenticate(context, l10n);
    if (!reauthenticated || !context.mounted) {
      return false;
    }

    try {
      await _runWithProgress(
        context,
        l10n.accountDeletionDeleting,
        AccountDeletionService.deleteCurrentAccount,
      );
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.accountDeletionSuccess),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 3),
          ),
        );
      }
      return true;
    } catch (e) {
      if (context.mounted) {
        await _showErrorDialog(
          context,
          l10n.accountDeletionFailed,
          _toUserMessage(l10n, e),
          _toTechnicalLog(e),
        );
      }
      return false;
    }
  }

  static Future<bool?> _showConfirmationDialog(
    BuildContext context,
    AppLocalizations l10n,
  ) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.accountDeletionDialogTitle),
        content: SingleChildScrollView(
          child: Text(l10n.accountDeletionDialogMessage),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text(l10n.accountDeletionConfirmButton),
          ),
        ],
      ),
    );
  }

  static Future<bool> _reauthenticate(
    BuildContext context,
    AppLocalizations l10n,
  ) async {
    final method = FirebaseAuthService.loginMethod;
    try {
      switch (method) {
        case 'email':
          final password = await _showPasswordDialog(context, l10n);
          if (password == null || !context.mounted) return false;
          await _runWithProgress(
            context,
            l10n.accountDeletionReauthenticating,
            () => FirebaseAuthService.reauthenticateWithEmailPassword(
              password: password,
            ),
          );
          return true;
        case 'google':
          final confirmed = await _showProviderDialog(
            context,
            l10n,
            l10n.accountDeletionGoogleReauthMessage,
          );
          if (confirmed != true || !context.mounted) return false;
          await _runWithProgress(
            context,
            l10n.accountDeletionReauthenticating,
            FirebaseAuthService.reauthenticateWithGoogle,
          );
          return true;
        case 'apple':
          final confirmed = await _showProviderDialog(
            context,
            l10n,
            l10n.accountDeletionAppleReauthMessage,
          );
          if (confirmed != true || !context.mounted) return false;
          await _runWithProgress(
            context,
            l10n.accountDeletionReauthenticating,
            FirebaseAuthService.reauthenticateWithApple,
          );
          return true;
        case 'phone':
          return _showPhoneDialog(context, l10n);
        default:
          return true;
      }
    } catch (e) {
      if (context.mounted) {
        await _showErrorDialog(
          context,
          l10n.accountDeletionReauthFailed,
          _toUserMessage(l10n, e),
          _toTechnicalLog(e),
        );
      }
      return false;
    }
  }

  static Future<String?> _showPasswordDialog(
    BuildContext context,
    AppLocalizations l10n,
  ) {
    final controller = TextEditingController();
    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.accountDeletionReauthTitle),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.accountDeletionPasswordMessage),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              obscureText: true,
              decoration: InputDecoration(
                labelText: l10n.accountDeletionPasswordLabel,
              ),
              onSubmitted: (_) {
                final value = controller.text.trim();
                if (value.isNotEmpty) {
                  Navigator.of(context).pop(value);
                }
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () {
              final value = controller.text.trim();
              if (value.isNotEmpty) {
                Navigator.of(context).pop(value);
              }
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text(l10n.accountDeletionContinueButton),
          ),
        ],
      ),
    ).whenComplete(controller.dispose);
  }

  static Future<bool?> _showProviderDialog(
    BuildContext context,
    AppLocalizations l10n,
    String message,
  ) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.accountDeletionReauthTitle),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text(l10n.accountDeletionContinueButton),
          ),
        ],
      ),
    );
  }

  static Future<bool> _showPhoneDialog(
    BuildContext context,
    AppLocalizations l10n,
  ) async {
    final phoneNumber = FirebaseAuthService.userPhoneNumber;
    if (phoneNumber == null || phoneNumber.isEmpty) {
      throw StateError(l10n.accountDeletionPhoneUnavailable);
    }

    final smsController = TextEditingController();
    String? verificationId;
    String? errorMessage;
    bool isSending = false;
    bool isVerifying = false;
    bool codeSent = false;

    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: !isSending && !isVerifying,
      builder: (dialogContext) => StatefulBuilder(
        builder: (dialogContext, setState) {
          Future<void> sendCode() async {
            setState(() {
              isSending = true;
              errorMessage = null;
            });
            await FirebaseAuthService.verifyPhoneNumber(
              phoneNumber: phoneNumber,
              codeSent: (id) {
                setState(() {
                  verificationId = id;
                  codeSent = true;
                  isSending = false;
                });
              },
              verificationFailed: (error) {
                setState(() {
                  errorMessage = error;
                  isSending = false;
                });
              },
              codeAutoRetrievalTimeout: (id) {
                verificationId = id;
              },
              verificationCompletedCredential: (credential) async {
                await FirebaseAuthService.reauthenticateWithPhoneCredential(
                  credential,
                );
                if (dialogContext.mounted) {
                  Navigator.of(dialogContext).pop(true);
                }
              },
            );
          }

          Future<void> verifyCode() async {
            final id = verificationId;
            final code = smsController.text.trim();
            if (id == null || code.isEmpty) {
              setState(() {
                errorMessage = l10n.accountDeletionSmsCodeRequired;
              });
              return;
            }

            setState(() {
              isVerifying = true;
              errorMessage = null;
            });
            try {
              await FirebaseAuthService.reauthenticateWithPhoneNumber(
                verificationId: id,
                smsCode: code,
              );
              if (dialogContext.mounted) {
                Navigator.of(dialogContext).pop(true);
              }
            } catch (e) {
              setState(() {
                errorMessage = _toUserMessage(l10n, e);
                isVerifying = false;
              });
            }
          }

          return AlertDialog(
            title: Text(l10n.accountDeletionReauthTitle),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.accountDeletionPhoneMessage(phoneNumber)),
                  const SizedBox(height: 16),
                  if (codeSent)
                    TextField(
                      controller: smsController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: l10n.auth_smsCodeLabel,
                        hintText: l10n.auth_smsCodeHint,
                      ),
                    ),
                  if (errorMessage != null) ...[
                    const SizedBox(height: 12),
                    Text(
                      errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: isSending || isVerifying
                    ? null
                    : () => Navigator.of(dialogContext).pop(false),
                child: Text(l10n.cancel),
              ),
              if (!codeSent)
                TextButton(
                  onPressed: isSending ? null : sendCode,
                  child: isSending
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(l10n.auth_sendSmsCodeButton),
                )
              else
                TextButton(
                  onPressed: isVerifying ? null : verifyCode,
                  style: TextButton.styleFrom(foregroundColor: Colors.red),
                  child: isVerifying
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(l10n.accountDeletionContinueButton),
                ),
            ],
          );
        },
      ),
    );

    smsController.dispose();
    return result == true;
  }

  static Future<void> _runWithProgress(
    BuildContext context,
    String message,
    Future<void> Function() action,
  ) async {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Row(
          children: [
            const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 3),
            ),
            const SizedBox(width: 16),
            Expanded(child: Text(message)),
          ],
        ),
      ),
    );

    try {
      await action();
    } finally {
      if (context.mounted) {
        Navigator.of(context, rootNavigator: true).pop();
      }
    }
  }

  static Future<void> _showErrorDialog(
    BuildContext context,
    String title,
    String message, [
    String? technicalLog,
  ]) {
    final l10n = AppLocalizations.of(context)!;
    return showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(message),
              if (technicalLog != null && technicalLog.isNotEmpty) ...[
                const SizedBox(height: 12),
                Text(
                  'Log',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(height: 6),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: SelectableText(
                    technicalLog,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.ok),
          ),
        ],
      ),
    );
  }

  static String _toUserMessage(AppLocalizations l10n, Object error) {
    if (error is AccountDeletionException) {
      final details = <String>[
        if (error.statusCode != null) 'HTTP ${error.statusCode}',
        if (error.code.isNotEmpty) 'code: ${error.code}',
      ];
      if (details.isEmpty) {
        return error.message;
      }
      return '${error.message}\n(${details.join(', ')})';
    }
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'wrong-password':
        case 'invalid-credential':
        case 'invalid-verification-code':
          return l10n.accountDeletionReauthInvalidCredential;
        case 'too-many-requests':
          return l10n.auth_tooManyRequests;
        case 'network-request-failed':
          return l10n.accountDeletionNetworkError;
      }
      final message = error.message;
      if (message != null && message.trim().isNotEmpty) {
        return '$message\n(code: ${error.code})';
      }
      return '${l10n.accountDeletionFailedMessage}\n(code: ${error.code})';
    }
    if (error is StateError) {
      return error.message;
    }
    final raw = error.toString().trim();
    if (raw.isNotEmpty) {
      return raw;
    }
    return l10n.accountDeletionFailedMessage;
  }

  static String _toTechnicalLog(Object error) {
    if (error is AccountDeletionException) {
      final parts = <String>[
        'type: AccountDeletionException',
        'code: ${error.code}',
        if (error.statusCode != null) 'http_status: ${error.statusCode}',
        'message: ${error.message}',
      ];
      return parts.join('\n');
    }
    if (error is FirebaseAuthException) {
      final parts = <String>[
        'type: FirebaseAuthException',
        'code: ${error.code}',
        if (error.message != null && error.message!.isNotEmpty)
          'message: ${error.message}',
      ];
      return parts.join('\n');
    }
    if (error is StateError) {
      return 'type: StateError\nmessage: ${error.message}';
    }
    return 'type: ${error.runtimeType}\nraw: $error';
  }
}

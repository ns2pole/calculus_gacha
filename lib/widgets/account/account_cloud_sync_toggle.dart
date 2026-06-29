import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../services/auth/cloud_sync_preference_service.dart';
import '../../services/auth/firebase_auth_service.dart';
import '../../services/problems/simple_data_manager.dart';

/// Builds a popup menu row with the cloud sync on/off switch.
PopupMenuItem<String> buildAccountCloudSyncMenuItem() {
  return PopupMenuItem<String>(
    enabled: false,
    padding: EdgeInsets.zero,
    child: const AccountCloudSyncToggle(),
  );
}

/// Builds a popup menu row to trigger manual cloud sync (when sync is enabled).
PopupMenuItem<String>? buildAccountCloudSyncSyncMenuItem(BuildContext context) {
  if (!CloudSyncPreferenceService.enabledListenable.value) {
    return null;
  }
  final l10n = AppLocalizations.of(context)!;
  return PopupMenuItem<String>(
    value: 'syncCloud',
    child: Row(
      children: [
        const Icon(Icons.cloud_sync, size: 20),
        const SizedBox(width: 8),
        Text(l10n.syncWithCloud),
      ],
    ),
  );
}

/// Runs a manual cloud sync and shows success/error feedback.
Future<void> performAccountCloudSync(
  BuildContext context, {
  VoidCallback? onSynced,
}) async {
  final l10n = AppLocalizations.of(context)!;

  if (!await CloudSyncPreferenceService.isEnabledForUser(
    FirebaseAuthService.userId,
  )) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.cloudSyncDisabledSnack),
          duration: const Duration(seconds: 2),
        ),
      );
    }
    return;
  }

  try {
    final success = await SimpleDataManager.performCloudSync(force: true);
    if (!success) {
      throw Exception('Cloud sync did not complete');
    }

    if (context.mounted) {
      onSynced?.call();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.syncCompleted),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  } catch (e) {
    debugPrint('Error syncing: $e');
    if (context.mounted) {
      final errorStr = e.toString().toLowerCase();
      final message = errorStr.contains('permission')
          ? l10n.noFirestorePermission
          : l10n.syncError;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.orange,
          duration: const Duration(seconds: 4),
        ),
      );
    }
  }
}

/// Cloud sync on/off switch shown in the account popup menu.
class AccountCloudSyncToggle extends StatefulWidget {
  const AccountCloudSyncToggle({super.key});

  @override
  State<AccountCloudSyncToggle> createState() => _AccountCloudSyncToggleState();
}

class _AccountCloudSyncToggleState extends State<AccountCloudSyncToggle> {
  bool _isUpdating = false;

  @override
  void initState() {
    super.initState();
    _refreshPreference();
    CloudSyncPreferenceService.enabledListenable.addListener(_onPreferenceChanged);
  }

  @override
  void dispose() {
    CloudSyncPreferenceService.enabledListenable
        .removeListener(_onPreferenceChanged);
    super.dispose();
  }

  void _onPreferenceChanged() {
    if (mounted) setState(() {});
  }

  Future<void> _refreshPreference() async {
    await CloudSyncPreferenceService.refreshForUser(
      FirebaseAuthService.userId,
    );
    if (mounted) setState(() {});
  }

  Future<void> _onToggle(bool value) async {
    final uid = FirebaseAuthService.userId;
    if (uid == null || _isUpdating) return;

    setState(() => _isUpdating = true);
    final l10n = AppLocalizations.of(context)!;

    try {
      await CloudSyncPreferenceService.setEnabled(uid, value);
      if (!value) {
        SimpleDataManager.clearCloudCaches();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.cloudSyncDisabledSnack),
              duration: const Duration(seconds: 2),
            ),
          );
        }
        return;
      }

      final synced = await SimpleDataManager.performCloudSync(force: true);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              synced ? l10n.cloudSyncEnabledSnack : l10n.syncError,
            ),
            backgroundColor: synced ? Colors.green : Colors.orange,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isUpdating = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final enabled = CloudSyncPreferenceService.enabledListenable.value;

    return SwitchListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      title: Text(
        l10n.cloudSyncToggleLabel,
        style: const TextStyle(fontSize: 14),
      ),
      value: enabled,
      onChanged: _isUpdating ? null : _onToggle,
    );
  }
}

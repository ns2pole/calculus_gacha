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

/// Top-bar sync control: visible only when signed in and cloud sync is on.
class AccountCloudSyncSyncButtonSlot extends StatelessWidget {
  const AccountCloudSyncSyncButtonSlot({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([
        CloudSyncPreferenceService.enabledListenable,
        CloudSyncPreferenceService.activeUserIdListenable,
      ]),
      builder: (context, _) {
        final uid = CloudSyncPreferenceService.activeUserIdListenable.value;
        final enabled = CloudSyncPreferenceService.enabledListenable.value;
        if (uid == null ||
            !enabled ||
            !FirebaseAuthService.isAuthenticated) {
          return const SizedBox.shrink();
        }
        return child;
      },
    );
  }
}

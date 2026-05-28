import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/app_logger.dart';
import '../problems/simple_data_manager.dart';
import 'cloud_sync_preference_service.dart';
import 'firebase_auth_service.dart';

/// One-time migration: persist explicit `true` for users who already used the app.
class CloudSyncMigration {
  CloudSyncMigration._();

  static const String _doneKey = 'joymath/migrations/cloud_sync_explicit_true_v1';

  /// Runs once per install. Does not overwrite existing preferences (e.g. purchase flow `false`).
  static Future<void> runIfNeeded() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(_doneKey) == true) {
      return;
    }

    final uids = <String>{};
    final lastUserId = await SimpleDataManager.getLastUserId();
    if (lastUserId != null && lastUserId.isNotEmpty) {
      uids.add(lastUserId);
    }
    final currentUid = FirebaseAuthService.userId;
    if (currentUid != null && currentUid.isNotEmpty) {
      uids.add(currentUid);
    }

    var migratedCount = 0;
    for (final uid in uids) {
      final wrote = await CloudSyncPreferenceService.migrateSetTrueIfAbsent(uid);
      if (wrote) migratedCount++;
    }

    await prefs.setBool(_doneKey, true);
    AppLogger.info(
      'クラウド同期フラグのマイグレーション完了',
      details: '明示的trueを書き込み: $migratedCount件 (対象uid: ${uids.length}件)',
    );

    if (currentUid != null) {
      await CloudSyncPreferenceService.refreshForUser(currentUid);
    }
  }
}

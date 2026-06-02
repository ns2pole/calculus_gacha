import 'dart:async';
import 'dart:convert';

import 'package:ai_chat_kit/ai_chat_kit.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../integrations/ai_chat/joymath_ai_chat_config.dart';
import '../../models/ai_chat_session_snapshot.dart';
import '../auth/firebase_auth_service.dart';
import '../auth/firestore_ai_chat_service.dart';
import 'ai_chat_message_codec.dart';

/// Local cache + Firestore persistence for per-problem AI chat.
/// Firestore is always the source of truth when a cloud document exists.
class AiChatSessionStore {
  AiChatSessionStore._();

  static const String _namespace = 'joymath_simple/ai_chat';
  static const String _legacyAnonymousOwner = 'anonymous';
  static const Duration _pushDebounce = Duration(milliseconds: 400);

  static const _codec = AiChatMessageCodec();
  static final AiChatInstallationIdStore _installationIdStore =
      AiChatInstallationIdStore(
    storageKey: JoymathAiChatConfig.apiConfigFromEnvironment()
        .installationIdStorageKey,
  );
  static final Map<String, Timer> _pushTimers = {};
  static final Map<String, AiChatSessionSnapshot> _pendingPush = {};

  static Future<String> _resolveOwnerId() async {
    final uid = FirebaseAuthService.userId;
    if (uid != null) return uid;
    return _installationIdStore.getOrCreate();
  }

  static String _localKey(String ownerId, String problemId) {
    final sanitized = AiChatMessageCodec.sanitizeProblemIdForStorage(problemId);
    return '$_namespace/$ownerId/$sanitized';
  }

  static Future<AiChatSessionSnapshot?> _readLocal(
    String ownerId,
    String problemId,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_localKey(ownerId, problemId));
      if (raw == null) return null;
      final decoded = jsonDecode(raw);
      if (decoded is! Map<String, dynamic>) return null;
      return _codec.decodeSession(decoded);
    } catch (e) {
      debugPrint('[AiChatSessionStore] Local read failed: $e');
      return null;
    }
  }

  static Future<void> _writeLocalForOwner(
    String ownerId,
    AiChatSessionSnapshot snapshot,
  ) async {
    final trimmed = snapshot.trimmed();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _localKey(ownerId, trimmed.problemId),
      jsonEncode(_codec.encodeSession(trimmed)),
    );
  }

  static Future<void> _writeLocal(AiChatSessionSnapshot snapshot) async {
    final ownerId = await _resolveOwnerId();
    await _writeLocalForOwner(ownerId, snapshot);
  }

  /// Moves legacy `anonymous` local keys under the current installation owner.
  static Future<void> _migrateLegacyAnonymousLocalSessions() async {
    try {
      final ownerId = await _resolveOwnerId();
      final prefs = await SharedPreferences.getInstance();
      final prefix = '$_namespace/$_legacyAnonymousOwner/';
      final keys = prefs
          .getKeys()
          .where((key) => key.startsWith(prefix))
          .toList(growable: false);

      for (final key in keys) {
        final sanitized = key.substring(prefix.length);
        final raw = prefs.getString(key);
        if (raw == null) continue;

        Map<String, dynamic> decoded;
        try {
          final parsed = jsonDecode(raw);
          if (parsed is! Map<String, dynamic>) continue;
          decoded = parsed;
        } catch (_) {
          continue;
        }

        AiChatSessionSnapshot legacySnapshot;
        try {
          legacySnapshot = _codec.decodeSession(decoded);
        } catch (_) {
          continue;
        }

        final problemId = legacySnapshot.problemId.isNotEmpty
            ? legacySnapshot.problemId
            : sanitized;

        final cloud = await FirestoreAiChatService.getSession(
          userId: ownerId,
          problemId: problemId,
        );
        if (cloud != null) {
          await prefs.remove(key);
          continue;
        }

        final trimmed = legacySnapshot.trimmed();
        await FirestoreAiChatService.saveSession(
          userId: ownerId,
          snapshot: trimmed,
        );
        await _writeLocalForOwner(ownerId, trimmed);
        await prefs.remove(key);
      }
    } catch (e) {
      debugPrint('[AiChatSessionStore] Legacy anonymous migration failed: $e');
    }
  }

  /// Loads messages for [problemId]. Firestore wins whenever a cloud doc exists.
  static Future<List<AiChatMessage>> load(String problemId) async {
    final uid = FirebaseAuthService.userId;
    if (uid != null) {
      await migrateAnonymousSessionsToUser(uid);
    } else {
      await _migrateLegacyAnonymousLocalSessions();
    }

    final ownerId = await _resolveOwnerId();
    await flushPendingPushes();

    final cloud = await FirestoreAiChatService.getSession(
      userId: ownerId,
      problemId: problemId,
    );
    if (cloud != null) {
      await _writeLocalForOwner(ownerId, cloud);
      return cloud.messages;
    }

    final local = await _readLocal(ownerId, problemId);
    if (local != null) {
      await FirestoreAiChatService.saveSession(
        userId: ownerId,
        snapshot: local,
      );
      return local.messages;
    }

    return const [];
  }

  /// Persists [messages] to local cache and pushes to Firestore.
  static Future<void> save(
    String problemId,
    List<AiChatMessage> messages,
  ) async {
    final uid = FirebaseAuthService.userId;
    if (uid == null) {
      await _migrateLegacyAnonymousLocalSessions();
    }

    final snapshot = AiChatSessionSnapshot(
      problemId: problemId,
      messages: List<AiChatMessage>.of(messages),
      updatedAt: DateTime.now(),
    ).trimmed();

    await _writeLocal(snapshot);

    final ownerId = await _resolveOwnerId();
    _schedulePush(ownerId, snapshot);
  }

  static void _schedulePush(String ownerId, AiChatSessionSnapshot snapshot) {
    final key = '${ownerId}_${snapshot.problemId}';
    _pendingPush[key] = snapshot;
    _pushTimers[key]?.cancel();
    _pushTimers[key] = Timer(_pushDebounce, () async {
      final pending = _pendingPush.remove(key);
      _pushTimers.remove(key);
      if (pending == null) return;
      await FirestoreAiChatService.saveSession(
        userId: ownerId,
        snapshot: pending,
      );
    });
  }

  static Future<Map<String, AiChatSessionSnapshot>> _readLocalSessionsForOwner(
    String ownerId,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final prefix = '$_namespace/$ownerId/';
    final sessions = <String, AiChatSessionSnapshot>{};

    for (final key in prefs.getKeys()) {
      if (!key.startsWith(prefix)) continue;
      final sanitized = key.substring(prefix.length);
      final raw = prefs.getString(key);
      if (raw == null) continue;

      try {
        final parsed = jsonDecode(raw);
        if (parsed is! Map<String, dynamic>) continue;
        final snapshot = _codec.decodeSession(parsed);
        final problemId = snapshot.problemId.isNotEmpty
            ? snapshot.problemId
            : sanitized;
        sessions[problemId] = pickNewerSnapshot(
              sessions[problemId],
              snapshot,
            ) ??
            snapshot;
      } catch (_) {
        continue;
      }
    }

    return sessions;
  }

  static Future<Set<String>> _collectProblemIdsForMigration(
    String installationId,
  ) async {
    final sourceOwnerIds = <String>{
      _legacyAnonymousOwner,
      installationId,
    };
    final problemIds = <String>{};

    for (final sourceOwnerId in sourceOwnerIds) {
      final localSessions = await _readLocalSessionsForOwner(sourceOwnerId);
      problemIds.addAll(localSessions.keys);
    }

    final installationCloudIds =
        await FirestoreAiChatService.listSessionProblemIds(installationId);
    problemIds.addAll(installationCloudIds);

    return problemIds;
  }

  /// Moves pre-login sessions to [uid]. UID Firestore is authoritative.
  static Future<void> migrateAnonymousSessionsToUser(String uid) async {
    try {
      final installationId = await _installationIdStore.getOrCreate();
      final sourceOwnerIds = <String>{
        _legacyAnonymousOwner,
        installationId,
      };
      final problemIds = await _collectProblemIdsForMigration(installationId);

      for (final problemId in problemIds) {
        final uidCloud = await FirestoreAiChatService.getSession(
          userId: uid,
          problemId: problemId,
        );
        if (uidCloud != null) {
          await _writeLocalForOwner(uid, uidCloud);
          continue;
        }

        final installationCloud = await FirestoreAiChatService.getSession(
          userId: installationId,
          problemId: problemId,
        );

        AiChatSessionSnapshot? localCandidate;
        for (final sourceOwnerId in sourceOwnerIds) {
          final local = await _readLocal(sourceOwnerId, problemId);
          localCandidate = pickNewerSnapshot(localCandidate, local);
        }

        final toSeed = authoritativeSnapshot(localCandidate, installationCloud);
        if (toSeed == null) continue;

        await FirestoreAiChatService.saveSession(userId: uid, snapshot: toSeed);
        await _writeLocalForOwner(uid, toSeed);
      }

      final prefs = await SharedPreferences.getInstance();
      for (final sourceOwnerId in sourceOwnerIds) {
        final prefix = '$_namespace/$sourceOwnerId/';
        for (final key in prefs.getKeys()) {
          if (key.startsWith(prefix)) {
            await prefs.remove(key);
          }
        }
      }
    } catch (e) {
      debugPrint('[AiChatSessionStore] Anonymous migration failed: $e');
    }
  }

  /// On login, migrates pre-login data. Per-problem cloud pull happens on [load].
  static Future<void> onUserSignedIn(String uid) async {
    await migrateAnonymousSessionsToUser(uid);
  }

  static Future<void> flushPendingPushes() async {
    final ownerId = await _resolveOwnerId();

    final pending = Map<String, AiChatSessionSnapshot>.from(_pendingPush);
    _pendingPush.clear();
    for (final timer in _pushTimers.values) {
      timer.cancel();
    }
    _pushTimers.clear();

    for (final entry in pending.entries) {
      if (!entry.key.startsWith('${ownerId}_')) continue;
      await FirestoreAiChatService.saveSession(
        userId: ownerId,
        snapshot: entry.value,
      );
    }
  }
}

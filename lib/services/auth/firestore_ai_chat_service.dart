import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/ai_chat_session_snapshot.dart';
import '../ai/ai_chat_message_codec.dart';

/// Firestore persistence for per-problem AI chat sessions.
class FirestoreAiChatService {
  FirestoreAiChatService._();

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const _codec = AiChatMessageCodec();

  static CollectionReference _sessionsRef(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('ai_chat_sessions');
  }

  static String _docId(String problemId) {
    return AiChatMessageCodec.sanitizeProblemIdForStorage(problemId);
  }

  static Future<AiChatSessionSnapshot?> getSession({
    required String userId,
    required String problemId,
  }) async {
    try {
      final doc = await _sessionsRef(userId).doc(_docId(problemId)).get();
      if (!doc.exists) return null;
      final data = doc.data();
      if (data is! Map<String, dynamic>) return null;
      return _snapshotFromFirestore(problemId, data);
    } catch (e) {
      print('Error getting AI chat session from Firestore: $e');
      return null;
    }
  }

  static Future<Set<String>> listSessionProblemIds(String userId) async {
    try {
      final snapshot = await _sessionsRef(userId).get();
      final problemIds = <String>{};
      for (final doc in snapshot.docs) {
        final data = doc.data();
        if (data is Map<String, dynamic>) {
          final problemId = data['problemId'];
          if (problemId is String && problemId.isNotEmpty) {
            problemIds.add(problemId);
            continue;
          }
        }
        problemIds.add(doc.id);
      }
      return problemIds;
    } catch (e) {
      print('Error listing AI chat sessions from Firestore: $e');
      return const {};
    }
  }

  static Future<bool> saveSession({
    required String userId,
    required AiChatSessionSnapshot snapshot,
  }) async {
    try {
      final trimmed = snapshot.trimmed();
      await _sessionsRef(userId).doc(_docId(trimmed.problemId)).set({
        'problemId': trimmed.problemId,
        'messages': trimmed.messages
            .map(_codec.encodeMessage)
            .toList(growable: false),
        'updatedAt': Timestamp.fromDate(trimmed.updatedAt),
        'schemaVersion': trimmed.schemaVersionValue,
      }, SetOptions(merge: true));
      return true;
    } catch (e) {
      print('Error saving AI chat session to Firestore: $e');
      return false;
    }
  }

  static AiChatSessionSnapshot _snapshotFromFirestore(
    String problemId,
    Map<String, dynamic> data,
  ) {
    final updatedAt = data['updatedAt'];
    DateTime updatedDateTime;
    if (updatedAt is Timestamp) {
      updatedDateTime = updatedAt.toDate();
    } else if (updatedAt is String) {
      updatedDateTime =
          DateTime.tryParse(updatedAt) ?? DateTime.fromMillisecondsSinceEpoch(0);
    } else {
      updatedDateTime = DateTime.fromMillisecondsSinceEpoch(0);
    }

    final messagesRaw = data['messages'];
    final messages = <dynamic>[];
    if (messagesRaw is List) {
      messages.addAll(messagesRaw);
    }

    return _codec.decodeSession({
      'schemaVersion': data['schemaVersion'] ?? AiChatSessionSnapshot.schemaVersion,
      'problemId': data['problemId'] ?? problemId,
      'updatedAt': updatedDateTime.toIso8601String(),
      'messages': messages,
    });
  }
}

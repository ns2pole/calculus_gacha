import 'package:ai_chat_kit/ai_chat_kit.dart';

import '../../models/ai_chat_session_snapshot.dart';

/// JSON serialization for persisted AI chat messages and sessions.
class AiChatMessageCodec {
  const AiChatMessageCodec();

  Map<String, dynamic> encodeSession(AiChatSessionSnapshot snapshot) {
    return {
      'schemaVersion': snapshot.schemaVersionValue,
      'problemId': snapshot.problemId,
      'updatedAt': snapshot.updatedAt.toIso8601String(),
      'messages': snapshot.messages.map(encodeMessage).toList(growable: false),
    };
  }

  AiChatSessionSnapshot decodeSession(Map<String, dynamic> json) {
    final problemId = json['problemId'];
    if (problemId is! String || problemId.isEmpty) {
      throw const FormatException('problemId is required');
    }

    final updatedAtRaw = json['updatedAt'];
    final updatedAt = updatedAtRaw is String
        ? DateTime.tryParse(updatedAtRaw) ?? DateTime.fromMillisecondsSinceEpoch(0)
        : DateTime.fromMillisecondsSinceEpoch(0);

    final messagesRaw = json['messages'];
    final messages = <AiChatMessage>[];
    if (messagesRaw is List) {
      for (final item in messagesRaw) {
        if (item is! Map) continue;
        try {
          messages.add(decodeMessage(Map<String, dynamic>.from(item)));
        } catch (_) {
          continue;
        }
      }
    }

    final schemaVersion = json['schemaVersion'];
    return AiChatSessionSnapshot(
      problemId: problemId,
      messages: messages,
      updatedAt: updatedAt,
      schemaVersionValue: schemaVersion is int ? schemaVersion : 1,
    ).trimmed();
  }

  Map<String, dynamic> encodeMessage(AiChatMessage message) {
    return {
      'id': message.id,
      'role': message.role.name,
      'text': message.text,
      if (message.textRaw != null) 'textRaw': message.textRaw,
      if (message.choiceId != null) 'choiceId': message.choiceId,
      'createdAt': message.createdAt.toIso8601String(),
    };
  }

  AiChatMessage decodeMessage(Map<String, dynamic> json) {
    final id = json['id'];
    final text = json['text'];
    final createdAtRaw = json['createdAt'];
    if (id is! String || id.isEmpty) {
      throw const FormatException('message id is required');
    }
    if (text is! String) {
      throw const FormatException('message text is required');
    }

    final roleName = json['role'];
    final role = roleName == 'assistant'
        ? AiChatMessageRole.assistant
        : AiChatMessageRole.user;

    final createdAt = createdAtRaw is String
        ? DateTime.tryParse(createdAtRaw) ?? DateTime.now()
        : DateTime.now();

    final choiceId = json['choiceId'];
    final textRaw = json['textRaw'];
    return AiChatMessage(
      id: id,
      role: role,
      text: text,
      textRaw: textRaw is String && textRaw.isNotEmpty ? textRaw : null,
      createdAt: createdAt,
      choiceId: choiceId is String ? choiceId : null,
    );
  }

  static String sanitizeProblemIdForStorage(String problemId) {
    return problemId.replaceAll('/', '_');
  }
}

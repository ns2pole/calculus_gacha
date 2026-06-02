import '../models/ai_chat_message.dart';
import '../models/ai_chat_session_payload.dart';

class AiChatRequestCodec {
  const AiChatRequestCodec();

  Map<String, dynamic> encode({
    required AiChatSessionPayload session,
    required List<AiChatMessage> history,
    required AiChatMessage userMessage,
    required String clientInstallationId,
    required String locale,
  }) {
    return {
      'context': _encodeSession(session),
      'history': history.map(_encodeMessage).toList(growable: false),
      'userMessage': _encodeMessage(userMessage),
      'clientInstallationId': clientInstallationId,
      'locale': locale,
    };
  }

  Map<String, dynamic> _encodeSession(AiChatSessionPayload session) {
    return {
      'title': session.title,
      'questionText': session.questionText,
      'category': session.category,
      'level': session.level,
      'referenceAnswer': session.referenceAnswer,
      'referenceSolution': session.referenceSolution,
      'hintShown': session.hintShown,
      'answerShown': session.answerShown,
      'attachmentsEnabled': session.attachmentsEnabled,
      if (session.extras != null && session.extras!.isNotEmpty)
        'extras': session.extras,
    };
  }

  Map<String, dynamic> _encodeMessage(AiChatMessage message) {
    return {
      'id': message.id,
      'role': message.role.name,
      'text': message.text,
      'choiceId': message.choiceId,
      'createdAt': message.createdAt.toIso8601String(),
      'attachments': message.attachments
          .map(_encodeAttachment)
          .toList(growable: false),
    };
  }

  Map<String, dynamic> _encodeAttachment(AiChatAttachment attachment) {
    return {
      'type': attachment.type.name,
      'localPath': attachment.localPath,
      'remoteUrl': attachment.remoteUrl,
      'mimeType': attachment.mimeType,
      'width': attachment.width,
      'height': attachment.height,
    };
  }
}

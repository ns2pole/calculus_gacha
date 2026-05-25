import '../../models/ai_chat_context.dart';
import '../../models/ai_chat_message.dart';
import 'ai_chat_usage_policy.dart';

class AiChatRequestCodec {
  const AiChatRequestCodec();

  Map<String, dynamic> encode({
    required AiChatContext context,
    required List<AiChatMessage> history,
    required AiChatMessage userMessage,
    required String clientInstallationId,
    required AiChatUsagePolicy usagePolicy,
  }) {
    return {
      'context': _encodeContext(context),
      'history': history.map(_encodeMessage).toList(growable: false),
      'userMessage': _encodeMessage(userMessage),
      'clientInstallationId': clientInstallationId,
      'usagePolicy': usagePolicy.toJson(),
    };
  }

  Map<String, dynamic> _encodeContext(AiChatContext context) {
    return {
      'title': context.title,
      'questionText': context.questionText,
      'category': context.category,
      'level': context.level,
      'hintShown': context.hintShown,
      'answerShown': context.answerShown,
      'attachmentsEnabled': context.attachmentsEnabled,
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

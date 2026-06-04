import 'ai_chat_quick_reply.dart';

enum AiChatMessageRole { user, assistant }

enum AiChatAttachmentType { image }

class AiChatAttachment {
  final AiChatAttachmentType type;
  final String? localPath;
  final String? remoteUrl;
  final String? mimeType;
  final int? width;
  final int? height;

  const AiChatAttachment({
    required this.type,
    this.localPath,
    this.remoteUrl,
    this.mimeType,
    this.width,
    this.height,
  });
}

class AiChatMessage {
  final String id;
  final AiChatMessageRole role;

  /// Text shown in the chat bubble (LaTeX-repaired for assistant replies).
  final String text;

  /// Assistant only: parsed JSON `text` before server-side LaTeX repair.
  final String? textRaw;

  final List<AiChatAttachment> attachments;
  final DateTime createdAt;
  final String? choiceId;
  final List<AiChatQuickReply> quickReplies;

  const AiChatMessage({
    required this.id,
    required this.role,
    required this.text,
    this.textRaw,
    this.attachments = const [],
    required this.createdAt,
    this.choiceId,
    this.quickReplies = const [],
  });
}

import '../models/ai_chat_message.dart';
import '../models/ai_chat_quick_reply.dart';
import '../models/ai_chat_session_payload.dart';

abstract class AiChatClient {
  Future<AiChatMessage> sendMessage({
    required AiChatSessionPayload session,
    required List<AiChatMessage> history,
    required AiChatMessage userMessage,
    String? locale,
  });
}

class AiChatClientException implements Exception {
  final String message;
  final String? code;
  final int? statusCode;

  const AiChatClientException(this.message, {this.code, this.statusCode});

  @override
  String toString() => message;
}

class AiChatRateLimitException extends AiChatClientException {
  final String? tier;
  final int? monthlyLimit;

  const AiChatRateLimitException(
    super.message, {
    super.code,
    super.statusCode,
    this.tier,
    this.monthlyLimit,
  });
}

class StubAiChatClient implements AiChatClient {
  const StubAiChatClient();

  @override
  Future<AiChatMessage> sendMessage({
    required AiChatSessionPayload session,
    required List<AiChatMessage> history,
    required AiChatMessage userMessage,
    String? locale,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 350));

    return AiChatMessage(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      role: AiChatMessageRole.assistant,
      text: _buildResponse(userMessage.choiceId),
      quickReplies: [
        const AiChatQuickReply(label: 'More detail'),
        const AiChatQuickReply(label: 'Next step only'),
      ],
      createdAt: DateTime.now(),
    );
  }

  String _buildResponse(String? choiceId) {
    switch (choiceId) {
      case 'approach_hint':
      case 'approach_only':
        return 'Start by separating what is given from what you need to find. '
            'Then pick one formula or transformation to try first.';
      case 'easier_analog':
      case 'hint':
        return 'Try a simpler version of the same idea with smaller numbers first.';
      default:
        return 'Thanks for your question. This is a stub response for development.';
    }
  }
}

import '../../models/ai_chat_context.dart';
import '../../models/ai_chat_message.dart';
import '../../models/ai_chat_quick_reply.dart';

abstract class AiChatClient {
  Future<AiChatMessage> sendMessage({
    required AiChatContext context,
    required List<AiChatMessage> history,
    required AiChatMessage userMessage,
    String? locale,
  });

  Future<List<AiChatQuickReply>> fetchStarterQuickReplies({
    required AiChatContext context,
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
    required AiChatContext context,
    required List<AiChatMessage> history,
    required AiChatMessage userMessage,
    String? locale,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 350));

    return AiChatMessage(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      role: AiChatMessageRole.assistant,
      text: _buildResponse(userMessage.choiceId),
      quickReplies: const [
        AiChatQuickReply(label: 'もう少し詳しく'),
        AiChatQuickReply(label: '次の1ステップを教えて'),
      ],
      createdAt: DateTime.now(),
    );
  }

  @override
  Future<List<AiChatQuickReply>> fetchStarterQuickReplies({
    required AiChatContext context,
    String? locale,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    return const [
      AiChatQuickReply(
        label: 'ヒントを教えて',
        actionId: 'hint',
      ),
      AiChatQuickReply(
        label: '方針だけ教えて',
        actionId: 'approach_only',
      ),
      AiChatQuickReply(
        label: '最初の一手だけ教えて',
        actionId: 'first_step',
      ),
    ];
  }

  String _buildResponse(String? choiceId) {
    switch (choiceId) {
      case 'approach_hint':
        return 'まずは問題文で与えられている条件と、求めたいものを分けて整理してみましょう。次に使えそうな公式や変形を1つだけ選ぶのがよいです。';
      case 'easier_analog':
        return '本問より簡単な類題で考えるなら、数字や式を小さくして同じ流れを確認すると分かりやすいです。まずは簡単な形で「何を同じように使うか」を見つけましょう。';
      default:
        return '入力ありがとうございます。今はスタブ応答ですが、実装時にはこの問題の文脈を使って、次の1ステップを短く返す想定です。';
    }
  }
}

import '../../models/ai_chat_context.dart';
import '../../models/ai_chat_message.dart';

abstract class AiChatClient {
  Future<AiChatMessage> sendMessage({
    required AiChatContext context,
    required List<AiChatMessage> history,
    required AiChatMessage userMessage,
  });
}

class StubAiChatClient implements AiChatClient {
  const StubAiChatClient();

  @override
  Future<AiChatMessage> sendMessage({
    required AiChatContext context,
    required List<AiChatMessage> history,
    required AiChatMessage userMessage,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 350));

    return AiChatMessage(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      role: AiChatMessageRole.assistant,
      text: _buildResponse(userMessage.choiceId),
      createdAt: DateTime.now(),
    );
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

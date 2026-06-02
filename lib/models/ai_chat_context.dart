class AiChatContext {
  final String? problemId;
  final String title;
  final String questionText;
  final String? category;
  final String? level;
  final String? referenceAnswer;
  final String? referenceSolution;
  final bool hintShown;
  final bool answerShown;
  final bool attachmentsEnabled;

  const AiChatContext({
    this.problemId,
    required this.title,
    required this.questionText,
    this.category,
    this.level,
    this.referenceAnswer,
    this.referenceSolution,
    this.hintShown = false,
    this.answerShown = false,
    this.attachmentsEnabled = false,
  });
}

/// Model for problem translations
class ProblemTranslation {
  final String? category;
  final String? level;
  final String? question;
  final String? answer;
  final String? hint;
  final String? shortExplanation;
  final List<String>? steps;
  final String? conditions;
  final String? constants;
  final List<String>? keywords;

  const ProblemTranslation({
    this.category,
    this.level,
    this.question,
    this.answer,
    this.hint,
    this.shortExplanation,
    this.steps,
    this.conditions,
    this.constants,
    this.keywords,
  });
}

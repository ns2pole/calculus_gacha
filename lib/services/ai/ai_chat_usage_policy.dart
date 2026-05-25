class AiChatUsagePolicy {
  final int freeDailyLimit;
  final int paidMonthlyLimit;

  const AiChatUsagePolicy({
    this.freeDailyLimit = 5,
    this.paidMonthlyLimit = 1500,
  });

  Map<String, int> toJson() {
    return {
      'freeDailyLimit': freeDailyLimit,
      'paidMonthlyLimit': paidMonthlyLimit,
    };
  }
}

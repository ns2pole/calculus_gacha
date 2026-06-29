class AiTutorPassUsageDetail {
  final String passId;
  final DateTime purchasedAt;
  final DateTime expiresAt;
  final int used;
  final int limit;
  final int remaining;

  const AiTutorPassUsageDetail({
    required this.passId,
    required this.purchasedAt,
    required this.expiresAt,
    required this.used,
    required this.limit,
    required this.remaining,
  });

  factory AiTutorPassUsageDetail.fromJson(Map<String, dynamic> json) {
    return AiTutorPassUsageDetail(
      passId: json['passId'] as String? ?? '',
      purchasedAt: DateTime.parse(json['purchasedAt'] as String),
      expiresAt: DateTime.parse(json['expiresAt'] as String),
      used: (json['used'] as num?)?.toInt() ?? 0,
      limit: (json['limit'] as num?)?.toInt() ?? 500,
      remaining: (json['remaining'] as num?)?.toInt() ?? 0,
    );
  }
}

class AiTutorUsageSnapshot {
  final String tier;
  final String period;
  final int count;
  final int limit;
  final int remaining;
  final int freeRemaining;
  final int freeLimit;
  final List<AiTutorPassUsageDetail> passes;

  const AiTutorUsageSnapshot({
    required this.tier,
    required this.period,
    required this.count,
    required this.limit,
    required this.remaining,
    required this.freeRemaining,
    required this.freeLimit,
    this.passes = const [],
  });

  bool get isPaid => tier == 'paid';

  bool get hasPasses => passes.isNotEmpty;

  int get totalRemaining => remaining;

  int get passRemaining =>
      passes.fold<int>(0, (sum, pass) => sum + pass.remaining);

  int get passLimit => passes.fold<int>(0, (sum, pass) => sum + pass.limit);

  factory AiTutorUsageSnapshot.fromJson(Map<String, dynamic> json) {
    final passesJson = json['passes'];
    final passes = passesJson is List
        ? passesJson
            .whereType<Map<String, dynamic>>()
            .map(AiTutorPassUsageDetail.fromJson)
            .toList()
        : const <AiTutorPassUsageDetail>[];

    final freeJson = json['free'];
    final freeRemaining = freeJson is Map<String, dynamic>
        ? (freeJson['remaining'] as num?)?.toInt()
        : null;
    final freeLimit = freeJson is Map<String, dynamic>
        ? (freeJson['limit'] as num?)?.toInt()
        : null;

    final remaining = (json['remaining'] as num?)?.toInt() ??
        (json['totalRemaining'] as num?)?.toInt() ??
        0;

    final passRemainingTotal = passes.fold<int>(
      0,
      (sum, pass) => sum + pass.remaining,
    );

    final resolvedFreeLimit = freeLimit ??
        (passes.isEmpty ? ((json['limit'] as num?)?.toInt() ?? 15) : 15);
    final resolvedFreeRemaining = freeRemaining ??
        (passes.isEmpty
            ? remaining
            : (remaining - passRemainingTotal).clamp(0, resolvedFreeLimit));

    return AiTutorUsageSnapshot(
      tier: json['tier'] as String? ?? 'free',
      period: json['period'] as String? ?? 'monthly',
      count: (json['count'] as num?)?.toInt() ?? 0,
      limit: (json['limit'] as num?)?.toInt() ?? 0,
      remaining: remaining,
      freeRemaining: resolvedFreeRemaining.toInt(),
      freeLimit: resolvedFreeLimit,
      passes: passes,
    );
  }

  static const emptyFree = AiTutorUsageSnapshot(
    tier: 'free',
    period: 'monthly',
    count: 0,
    limit: 15,
    remaining: 15,
    freeRemaining: 15,
    freeLimit: 15,
  );
}

import 'package:flutter/widgets.dart';

import '../models/ai_chat_quick_reply.dart';
import 'ai_chat_strings.dart';

class AiChatRateLimitInfo {
  final String? tier;
  final int? monthlyLimit;
  final String message;

  const AiChatRateLimitInfo({
    required this.message,
    this.tier,
    this.monthlyLimit,
  });

  bool get isPaidTier => tier == 'paid';
}

class AiChatUpgradeResult {
  final bool success;
  final bool cancelled;
  final String? userMessage;

  const AiChatUpgradeResult({
    required this.success,
    this.cancelled = false,
    this.userMessage,
  });

  const AiChatUpgradeResult.cancelled()
      : success = false,
        cancelled = true,
        userMessage = null;

  const AiChatUpgradeResult.success()
      : success = true,
        cancelled = false,
        userMessage = null;
}

/// Host app implements billing, auth headers, and optional upgrade UI.
abstract class AiChatHostPorts {
  AiChatStrings get strings;

  Future<Map<String, String>> authHeaders();

  List<AiChatQuickReply>? starterQuickReplies(String? contentId);

  /// Shown below the error when rate-limited. Return null to hide upgrade UI.
  Widget? buildUpgradeOffer(
    BuildContext context, {
    required AiChatRateLimitInfo limitInfo,
    required bool isRestoring,
    required VoidCallback onPurchase,
    required VoidCallback onRestore,
  });

  Future<AiChatUpgradeResult> purchaseUpgrade(BuildContext context);

  Future<AiChatUpgradeResult> restoreUpgrade(BuildContext context);
}

/// No upgrade UI; purchase/restore are no-ops.
class AiChatHostPortsMinimal implements AiChatHostPorts {
  AiChatHostPortsMinimal(this.strings);

  @override
  final AiChatStrings strings;

  @override
  Future<Map<String, String>> authHeaders() async => const {};

  @override
  List<AiChatQuickReply>? starterQuickReplies(String? contentId) => null;

  @override
  Widget? buildUpgradeOffer(
    BuildContext context, {
    required AiChatRateLimitInfo limitInfo,
    required bool isRestoring,
    required VoidCallback onPurchase,
    required VoidCallback onRestore,
  }) =>
      null;

  @override
  Future<AiChatUpgradeResult> purchaseUpgrade(BuildContext context) async {
    return const AiChatUpgradeResult(success: false);
  }

  @override
  Future<AiChatUpgradeResult> restoreUpgrade(BuildContext context) async {
    return const AiChatUpgradeResult(success: false);
  }
}

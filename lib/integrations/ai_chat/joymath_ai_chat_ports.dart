import 'package:ai_chat_kit/ai_chat_kit.dart';
import 'package:flutter/material.dart';

import '../../data/ai_chat/starter_quick_replies_by_problem_id.dart';
import '../../data/ai_chat/starter_quick_reply_localizations.dart';
import '../../l10n/app_localizations.dart';
import '../../services/payment/revenuecat_service.dart';
import 'joymath_ai_chat_client_factory.dart';
import 'joymath_ai_chat_purchase.dart';
import 'joymath_ai_chat_strings.dart';
import 'joymath_ai_tutor_upgrade_card.dart';

class JoymathAiChatPorts implements AiChatHostPorts {
  JoymathAiChatPorts(this._context);

  final BuildContext _context;
  String? _cachedPrice;

  @override
  AiChatStrings get strings => joymathAiChatStrings(_context);

  @override
  Future<Map<String, String>> authHeaders() =>
      JoymathAiChatClientFactory.authHeaders();

  @override
  List<AiChatQuickReply>? starterQuickReplies(String? contentId) {
    if (contentId == null) return null;
    final replies = lookupStarterQuickReplies(contentId);
    if (replies == null) return null;
    return localizeStarterQuickReplies(
      replies,
      Localizations.localeOf(_context),
    );
  }

  @override
  Widget? buildUpgradeOffer(
    BuildContext context, {
    required AiChatRateLimitInfo limitInfo,
    required bool isRestoring,
    required VoidCallback onPurchase,
    required VoidCallback onRestore,
  }) {
    final l10n = AppLocalizations.of(context)!;
    final price = _cachedPrice ?? l10n.defaultPrice;
    return JoymathAiTutorUpgradeCard(
      limitInfo: limitInfo,
      price: price,
      onPurchase: onPurchase,
      onRestore: onRestore,
      isRestoring: isRestoring,
    );
  }

  Future<void> preloadPrice() async {
    final price = await RevenueCatService.getAiTutorPassPrice();
    if (price != null && price.isNotEmpty) {
      _cachedPrice = price;
    }
  }

  @override
  Future<AiChatUpgradeResult> purchaseUpgrade(BuildContext context) {
    return joymathPurchaseAiTutor(context);
  }

  @override
  Future<AiChatUpgradeResult> restoreUpgrade(BuildContext context) async {
    final result = await joymathRestoreAiTutor(context);
    if (result.success) {
      return AiChatUpgradeResult(
        success: true,
        userMessage: result.userMessage,
      );
    }
    return result;
  }
}

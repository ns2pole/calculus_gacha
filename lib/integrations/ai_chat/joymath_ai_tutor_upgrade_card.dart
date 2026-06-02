import 'package:ai_chat_kit/ai_chat_kit.dart';
import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';

class JoymathAiTutorUpgradeCard extends StatelessWidget {
  final AiChatRateLimitInfo limitInfo;
  final String price;
  final VoidCallback onPurchase;
  final VoidCallback onRestore;
  final bool isRestoring;

  const JoymathAiTutorUpgradeCard({
    super.key,
    required this.limitInfo,
    required this.price,
    required this.onPurchase,
    required this.onRestore,
    required this.isRestoring,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      color: colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.workspace_premium,
                  color: colorScheme.onPrimaryContainer,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.aiTutorLimitReachedTitle,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme.onPrimaryContainer,
                            ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        l10n.aiTutorLimitReachedBody(price),
                        style: TextStyle(color: colorScheme.onPrimaryContainer),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: onPurchase,
                child: Text(l10n.aiTutorUpgradeButton),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: isRestoring ? null : onRestore,
                icon: isRestoring
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.restore),
                label: Text(
                  isRestoring
                      ? l10n.aiTutorRestoreInProgress
                      : l10n.aiTutorRestorePurchasedButton,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

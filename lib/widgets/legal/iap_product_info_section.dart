import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';

/// 課金ダイアログ内の商品名・価格・有効期間の表示。
class IapProductInfoSection extends StatelessWidget {
  final String productName;
  final String price;
  final String duration;

  const IapProductInfoSection({
    super.key,
    required this.productName,
    required this.price,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.4)),
      ),
      child: Column(
        children: [
          _InfoRow(label: l10n.iapInfoLabelName, value: productName),
          const SizedBox(height: 8),
          _InfoRow(label: l10n.iapInfoLabelPrice, value: price),
          const SizedBox(height: 8),
          _InfoRow(label: l10n.iapInfoLabelDuration, value: duration),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 72,
          child: Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

class ExpandableCalculatorWrapper extends StatelessWidget {
  final bool isExpanded;
  final VoidCallback onToggle;
  final Widget calculator;
  final double iconSize;

  const ExpandableCalculatorWrapper({
    Key? key,
    required this.isExpanded,
    required this.onToggle,
    required this.calculator,
    this.iconSize = 32.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: IconButton(
              icon: Icon(
                isExpanded ? Icons.keyboard_arrow_up : Icons.calculate,
                size: iconSize,
              ),
              onPressed: onToggle,
              tooltip: isExpanded
                  ? l10n.calculatorTooltipClose
                  : l10n.calculatorTooltipShow,
            ),
          ),
          if (isExpanded)
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: calculator,
              ),
            ),
        ],
      ),
    );
  }
}



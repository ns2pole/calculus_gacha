import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../services/payment/revenuecat_service.dart';

/// ホーム画面タイトル左のアプリアイコン。AI Tutor Plus 契約中は上にバッジを表示。
class HomeTitleIcon extends StatefulWidget {
  final double size;

  const HomeTitleIcon({super.key, required this.size});

  @override
  State<HomeTitleIcon> createState() => _HomeTitleIconState();
}

class _HomeTitleIconState extends State<HomeTitleIcon> {
  bool _showBadge = false;
  bool _routeWasCurrent = false;

  @override
  void initState() {
    super.initState();
    _loadSubscriptionStatus();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final isCurrent = ModalRoute.of(context)?.isCurrent ?? false;
    if (isCurrent && !_routeWasCurrent) {
      _loadSubscriptionStatus();
    }
    _routeWasCurrent = isCurrent;
  }

  Future<void> _loadSubscriptionStatus() async {
    final subscribed =
        await RevenueCatService.isAiTutorSubscriptionPurchased();
    if (!mounted) return;
    setState(() => _showBadge = subscribed);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    const badgeColor = Color(0xFF8B7355);
    final badgeFontSize = widget.size < 40 ? 8.0 : 9.0;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (_showBadge)
          Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: Text(
              l10n.aiTutorPlusBadge,
              style: TextStyle(
                fontSize: badgeFontSize,
                fontWeight: FontWeight.w700,
                height: 1,
                color: badgeColor,
                letterSpacing: -0.2,
              ),
            ),
          ),
        Image.asset(
          'assets/icon/home_icon_removebg.png',
          width: widget.size,
          height: widget.size,
          errorBuilder: (context, error, stackTrace) {
            return Icon(
              Icons.apps,
              size: widget.size,
              color: badgeColor,
            );
          },
        ),
      ],
    );
  }
}

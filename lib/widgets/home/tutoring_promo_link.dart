import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../l10n/app_localizations.dart';
import '../../utils/responsive_layout.dart';

const _tutoringJmtyUrl = 'https://jmty.jp/mie/les-stu/article-rsxi4';

class TutoringPromoLink extends StatelessWidget {
  const TutoringPromoLink({super.key});

  Future<void> _openExternalUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final responsive = context.appResponsive;
    const titleColor = Color(0xFF8B7355);
    final sectionFontSize = responsive.isCompact ? 17.0 : 20.0;
    final iconSize = responsive.isCompact ? 13.0 : 14.0;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _openExternalUrl(_tutoringJmtyUrl),
        borderRadius: BorderRadius.circular(24),
        child: Container(
          padding: EdgeInsets.fromLTRB(
            responsive.isCompact ? 14.0 : 18.0,
            responsive.isCompact ? 6.0 : 8.0,
            responsive.isCompact ? 22.0 : 26.0,
            responsive.isCompact ? 6.0 : 8.0,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: titleColor.withValues(alpha: 0.55),
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    l10n.tutoringPromoLine1,
                    style: TextStyle(
                      fontSize: sectionFontSize,
                      fontWeight: FontWeight.w600,
                      color: titleColor.withValues(alpha: 0.9),
                      height: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    l10n.tutoringPromoLine2,
                    style: TextStyle(
                      fontSize: sectionFontSize,
                      fontWeight: FontWeight.w600,
                      color: titleColor.withValues(alpha: 0.9),
                      height: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Positioned(
                top: responsive.isCompact ? -2.0 : -1.0,
                right: responsive.isCompact ? -25.0 : -30.0,
                child: Icon(
                  Icons.ads_click_outlined,
                  size: iconSize + 10,
                  color: titleColor.withValues(alpha: 0.80),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

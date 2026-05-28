import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/legal_urls.dart';
import '../../l10n/app_localizations.dart';

/// ホーム下部・購入ダイアログなどに表示するプライバシーポリシー・利用規約リンク。
class LegalNoticeFooter extends StatelessWidget {
  const LegalNoticeFooter({super.key});

  static Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    const linkStyle = TextStyle(
      fontSize: 12,
      color: Colors.blue,
      decoration: TextDecoration.underline,
      decorationColor: Colors.blue,
    );
    final bodyStyle = TextStyle(
      fontSize: 12,
      color: Colors.grey[700],
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text.rich(
            TextSpan(
              style: bodyStyle,
              children: [
                TextSpan(text: l10n.legalNoticePrivacyPrefix),
                WidgetSpan(
                  alignment: PlaceholderAlignment.baseline,
                  baseline: TextBaseline.alphabetic,
                  child: InkWell(
                    onTap: () => _launchUrl(LegalUrls.privacyPolicy),
                    child: Text(l10n.privacyPolicy, style: linkStyle),
                  ),
                ),
                TextSpan(text: l10n.legalNoticePrivacySuffix),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text.rich(
            TextSpan(
              style: bodyStyle,
              children: [
                TextSpan(text: l10n.legalNoticeTermsPrefix),
                WidgetSpan(
                  alignment: PlaceholderAlignment.baseline,
                  baseline: TextBaseline.alphabetic,
                  child: InkWell(
                    onTap: () => _launchUrl(LegalUrls.termsOfUse),
                    child: Text(l10n.legalNoticeTermsLink, style: linkStyle),
                  ),
                ),
                TextSpan(text: l10n.legalNoticeTermsSuffix),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

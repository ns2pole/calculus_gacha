// lib/widgets/home_card_widgets.dart
// ホームページとおまけガチャページで使用する共通カードウィジェット

import 'package:flutter/material.dart';

import '../../utils/responsive_layout.dart';

/// モダンなスタイルのカード（グラデーション背景）
class ModernCard extends StatelessWidget {
  final double buttonWidth;
  final IconData icon;
  final String title;
  final String subtitle;
  final Gradient gradient;
  final VoidCallback onPressed;
  final double? iconSpacing;
  final bool showBorder;

  const ModernCard({
    super.key,
    required this.buttonWidth,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.gradient,
    required this.onPressed,
    this.iconSpacing,
    this.showBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = context.appResponsive;
    final contentPadding = responsive.isCompact
        ? const EdgeInsets.symmetric(horizontal: 10, vertical: 12)
        : const EdgeInsets.symmetric(horizontal: 12, vertical: 16);
    final iconPadding = responsive.isCompact
        ? const EdgeInsets.all(10)
        : const EdgeInsets.all(12);

    final cardContent = Container(
      width: buttonWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onPressed,
          child: Container(
            padding: contentPadding,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              gradient: gradient,
              borderRadius: BorderRadius.circular(20),
            ),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: iconPadding,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      icon,
                      size: responsive.cardIconSize,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: iconSpacing ?? 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: responsive.cardTitleFontSize,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.visible,
                          softWrap: true,
                        ),
                        if (subtitle.isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Text(
                            subtitle,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: responsive.cardSubtitleFontSize,
                              color: Colors.white.withOpacity(0.9),
                            ),
                            overflow: TextOverflow.visible,
                            softWrap: true,
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white.withOpacity(0.8),
                    size: responsive.cardChevronSize,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    // 無料枠を外側に配置
    if (showBorder) {
      return Container(
        padding: const EdgeInsets.all(5), // ボーダーの太さ分のパディング
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(25), // ボーダーが外側に出るように
        ),
        child: cardContent,
      );
    } else {
      return cardContent;
    }
  }
}

/// シンプルなスタイルのカード（単色背景）
class SimpleCard extends StatelessWidget {
  final double buttonWidth;
  final IconData icon;
  final String title;
  final String subtitle;
  final Color? color;
  final VoidCallback onPressed;

  const SimpleCard({
    super.key,
    required this.buttonWidth,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = context.appResponsive;
    final contentPadding = responsive.isCompact
        ? const EdgeInsets.symmetric(horizontal: 10, vertical: 12)
        : const EdgeInsets.symmetric(horizontal: 12, vertical: 16);
    final iconPadding = responsive.isCompact
        ? const EdgeInsets.all(10)
        : const EdgeInsets.all(12);

    // ガチャと同じようにグラデーションを使用
    final gradient = color != null
        ? LinearGradient(
            colors: [color!, color!.withOpacity(0.8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
        : null;

    return Container(
      width: buttonWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onPressed,
          child: Container(
            padding: contentPadding,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              gradient: gradient,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: iconPadding,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    size: responsive.cardIconSize,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: responsive.cardTitleFontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        softWrap: true,
                      ),
                      if (subtitle.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          subtitle,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: responsive.cardSubtitleFontSize,
                            color: Colors.white.withOpacity(0.9),
                          ),
                          softWrap: true,
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white.withOpacity(0.8),
                  size: responsive.cardChevronSize,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// 選択可能なモダンなスタイルのカード（チェックマーク表示機能付き）
class SelectableModernCard extends StatelessWidget {
  final double buttonWidth;
  final IconData icon;
  final String title;
  final String subtitle;
  final Gradient gradient;
  final VoidCallback onPressed;
  final bool isSelected;
  final double? iconSpacing;

  const SelectableModernCard({
    super.key,
    required this.buttonWidth,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.gradient,
    required this.onPressed,
    this.isSelected = false,
    this.iconSpacing,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = context.appResponsive;
    final contentPadding = responsive.isCompact
        ? const EdgeInsets.symmetric(horizontal: 10, vertical: 12)
        : const EdgeInsets.symmetric(horizontal: 12, vertical: 16);
    final iconPadding = responsive.isCompact
        ? const EdgeInsets.all(10)
        : const EdgeInsets.all(12);

    final cardContent = Container(
      width: buttonWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onPressed,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: contentPadding,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  gradient: gradient,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: iconPadding,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        icon,
                        size: responsive.cardIconSize,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: iconSpacing ?? 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: responsive.cardTitleFontSize,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            softWrap: true,
                            overflow: TextOverflow.visible,
                          ),
                          if (subtitle.isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Text(
                              subtitle,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: responsive.cardSubtitleFontSize,
                                color: Colors.white.withOpacity(0.9),
                              ),
                              softWrap: true,
                              overflow: TextOverflow.visible,
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white.withOpacity(0.8),
                      size: responsive.cardChevronSize,
                    ),
                  ],
                ),
              ),
              // チェックマークを透かしのように中央に重ねる
              if (isSelected)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black.withOpacity(0.3),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.white,
                        size: 64,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );

    // 選択時の枠線を外側に配置
    if (isSelected) {
      return Container(
        padding: const EdgeInsets.all(4), // ボーダーの太さ分のパディング
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(24), // ボーダーが外側に出るように
        ),
        child: cardContent,
      );
    } else {
      return cardContent;
    }
  }
}

/// 情報表示用のカード
class InfoCard extends StatelessWidget {
  final String title;
  final String content;
  final IconData icon;
  final Color color;

  const InfoCard({
    super.key,
    required this.title,
    required this.content,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: color,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    content,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


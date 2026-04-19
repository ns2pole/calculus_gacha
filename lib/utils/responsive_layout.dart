import 'dart:math' as math;

import 'package:flutter/material.dart';

class AppResponsiveData {
  const AppResponsiveData._(this.size);

  final Size size;

  static AppResponsiveData of(BuildContext context) {
    return AppResponsiveData._(MediaQuery.sizeOf(context));
  }

  double get width => size.width;
  double get height => size.height;
  double get aspectRatio => height == 0 ? 1 : width / height;

  bool get isPhone => width < 600;
  bool get isTablet => width >= 600 && width < 1024;
  bool get isDesktop => width >= 1024;
  bool get isLandscape => width > height;
  bool get isLandscapePhone => isPhone && isLandscape;
  bool get isCompact => isPhone || isLandscapePhone;

  double get contentMaxWidth {
    if (isPhone) return 480;
    if (isTablet) return 760;
    return 1080;
  }

  double get pageHorizontalPadding {
    if (isPhone) return 12;
    if (isTablet) return 20;
    return 28;
  }

  double get pageVerticalPadding {
    if (isLandscapePhone) return 8;
    if (isPhone) return 12;
    return 16;
  }

  EdgeInsets get pagePadding => EdgeInsets.symmetric(
        horizontal: pageHorizontalPadding,
        vertical: pageVerticalPadding,
      );

  double get toolbarButtonSize => isCompact ? 56 : 72;
  double get toolbarIconSize => isCompact ? 28 : 36;
  double get toolbarSpacing => isCompact ? 32 : 60;

  double get titleFontSize {
    if (isPhone) return isLandscapePhone ? 22 : 24;
    if (isTablet) return 26;
    return 28;
  }

  double get cardTitleFontSize => isCompact ? 18 : 22;
  double get cardSubtitleFontSize => isCompact ? 13 : 14;
  double get cardIconSize => isCompact ? 24 : 28;
  double get cardChevronSize => isCompact ? 14 : 16;

  double contentWidthFor(double outerWidth) {
    return math.min(outerWidth, contentMaxWidth);
  }
}

extension AppResponsiveContext on BuildContext {
  AppResponsiveData get appResponsive => AppResponsiveData.of(this);
}

class AppResponsiveRoot extends StatelessWidget {
  const AppResponsiveRoot({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const MaterialScrollBehavior(),
      child: child,
    );
  }
}

class ResponsiveContentFrame extends StatelessWidget {
  const ResponsiveContentFrame({
    super.key,
    required this.child,
    this.maxWidth,
    this.padding,
    this.alignment = Alignment.topCenter,
  });

  final Widget child;
  final double? maxWidth;
  final EdgeInsetsGeometry? padding;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    final responsive = context.appResponsive;
    return Align(
      alignment: alignment,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth ?? responsive.contentMaxWidth,
        ),
        child: Padding(
          padding: padding ?? responsive.pagePadding,
          child: child,
        ),
      ),
    );
  }
}

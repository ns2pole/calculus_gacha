import 'dart:async';

import 'package:flutter/material.dart';

import '../common/common.dart' show MixedTextMath;
import '../../l10n/app_localizations.dart';

/// DeferredMixedTextMath, MixedTextMath (元コードを流用)
class DeferredMixedTextMath extends StatefulWidget {
  final String mixed;
  final TextStyle? labelStyle;
  final TextStyle? mathStyle;
  final bool forceTex;
  final bool defer;

  const DeferredMixedTextMath(this.mixed, {this.labelStyle, this.mathStyle, this.forceTex = false, this.defer = false, super.key});

  @override
  State<DeferredMixedTextMath> createState() => _DeferredMixedTextMathState();
}

class _DeferredMixedTextMathState extends State<DeferredMixedTextMath> {
  bool _showMath = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    if (widget.defer) {
      final delay = Duration(milliseconds: 30 + (DateTime.now().millisecondsSinceEpoch % 120));
      _timer = Timer(delay, () {
        if (mounted) setState(() => _showMath = true);
      });
    } else {
      _showMath = true;
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant DeferredMixedTextMath oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.mixed != oldWidget.mixed || widget.defer != oldWidget.defer) {
      _timer?.cancel();
      if (widget.defer) {
        _showMath = false;
        final delay = Duration(milliseconds: 30 + (DateTime.now().millisecondsSinceEpoch % 120));
        _timer = Timer(delay, () {
          if (mounted) setState(() => _showMath = true);
        });
      } else {
        if (!mounted) return;
        setState(() => _showMath = true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_showMath) {
      final text = widget.mixed.trim();
      if (text.isEmpty) return const SizedBox.shrink();

      final colonIndex = text.indexOf(':');
      final colonIndexFull = colonIndex >= 0 ? colonIndex : text.indexOf('：');
      if (colonIndexFull >= 0) {
        final leftRaw = text.substring(0, colonIndexFull).trim();
        final rightRaw = text.substring(colonIndexFull + 1).trim();
        if (leftRaw.toLowerCase() == 'tex') {
          final l10n = AppLocalizations.of(context)!;
          return Text(l10n.equationLabel, style: widget.labelStyle ?? const TextStyle(fontSize: 16));
        }
        if (leftRaw.isNotEmpty) {
          return Text(leftRaw + ':', style: widget.labelStyle ?? const TextStyle(fontSize: 16));
        }
      }

      final preview = text.length > 40 ? text.substring(0, 40) + '…' : text;
      return Text(preview, style: widget.labelStyle ?? const TextStyle(fontSize: 16));
    }

    return MixedTextMath(widget.mixed, labelStyle: widget.labelStyle, mathStyle: widget.mathStyle, forceTex: widget.forceTex);
  }
}


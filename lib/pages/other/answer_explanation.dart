import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';

/// Problem / Step の型は既存のものに合わせてください。
/// ここではフィールド名だけ使っています: p.imageAsset, p.answer, p.steps, s.tex, s.imageAsset
enum ProblemStatus { none, solved, understood, failed }
const int slotCount = 3;

class AnswerExplanation extends StatelessWidget {
  final dynamic problem; // 既存 Problem 型に置き換えてください
  final Future<bool> Function(String assetPath) assetExists;
  final double topImageMaxHeight;
  final double stepImageMaxHeight;

  const AnswerExplanation({
    Key? key,
    required this.problem,
    required this.assetExists,
    this.topImageMaxHeight = 220,
    this.stepImageMaxHeight = 200,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final p = problem;
    final langCode = Localizations.localeOf(context).languageCode;
    final isCjk = const {'ja', 'zh', 'ko'}.contains(langCode);
    final isEn = langCode == 'en';
    final stepLabelFontSize = isCjk ? 15.0 : (isEn ? 18.0 : 16.0);
    final stepMathFontSize = isCjk ? 20.0 : (isEn ? 26.0 : 22.0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // --- 解説の「一番最初」に画像を表示（存在する場合のみ）
        if (p.imageAsset != null) ...[
          FutureBuilder<bool>(
            future: assetExists(p.imageAsset!),
            builder: (ctx, snap) {
              if (snap.connectionState != ConnectionState.done) {
                // 読み込み中は空にする（元の実装に合わせる）
                return const SizedBox.shrink();
              }
              if (snap.hasData && snap.data == true) {
                // 存在が確認できたらプリキャッシュして表示
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  try {
                    precacheImage(AssetImage(p.imageAsset!), ctx);
                  } catch (_) {}
                });
                // 全画像を不定方程式と同じサイズ感（1.65倍）で統一し、センタリング
                final maxHeight = 220 * 1.65;
                return Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: maxHeight),
                    child: Image.asset(
                      p.imageAsset!,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
                    ),
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
          const SizedBox(height: 18),
        ],

        // 答え（元の MixedTextMath 使用を維持）
        Center(
          child: MixedTextMath(
            p.answer,
            labelStyle: const TextStyle(fontSize: 19),
            mathStyle: const TextStyle(fontSize: 25, color: Colors.green),
            forceTex: false,
          ),
        ),
        const SizedBox(height: 28),

        // ステップ（解説本文）
        ...((p.steps ?? []) as List).map((s) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (s.tex != null && (s.tex as String).trim().isNotEmpty)
                  Center(
                    child: MixedTextMath(
                      s.tex!,
                      forceTex: true,
                      labelStyle: TextStyle(fontSize: stepLabelFontSize),
                      mathStyle: TextStyle(fontSize: stepMathFontSize),
                    ),
                  ),

                // ステップ内画像（存在する場合のみ表示）
                if (s.imageAsset != null)
                  FutureBuilder<bool>(
                    future: assetExists(s.imageAsset!),
                    builder: (ctx, snap) {
                      if (snap.connectionState != ConnectionState.done) {
                        return const SizedBox.shrink();
                      }
                      if (snap.hasData && snap.data == true) {
                        // StepItem内画像を統一的に2倍大きくしてセンタリング
                        return Column(
                          children: [
                            const SizedBox(height: 6),
                            Center(
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(maxHeight: 400),
                                child: Image.asset(
                                  s.imageAsset!,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }
}



/// MixedTextMath (uses MathWidgetCache to avoid repeated Math.tex builds)
class MixedTextMath extends StatelessWidget {
  final String mixed;
  final TextStyle? labelStyle;
  final TextStyle? mathStyle;
  final bool forceTex;

  const MixedTextMath(this.mixed, {this.labelStyle, this.mathStyle, this.forceTex = false, super.key});

  String _stripTexPrefix(String s) {
    var t = s.trim();
    if (t.toLowerCase().startsWith('tex:')) return t.substring(4).trim();
    if (t.toLowerCase().startsWith('tex：')) return t.substring(4).trim();
    return t;
  }

  bool _looksLikeMath(String s) {
    if (s.isEmpty) return false;
    final lower = s.toLowerCase();
    if (s.contains(String.fromCharCode(92)) || s.contains('^') || s.contains('_') || s.contains(r'$')) return true;
    if (lower.contains('frac') || lower.contains('int') || lower.contains('sum') || lower.contains('sqrt')) return true;
    if (s.contains('(') || s.contains('[')) return true;
    return false;
  }

  Widget _cachedMathWidget(String tex, TextStyle? style) {
    final key = makeMathKey(tex, style);
    return MathWidgetCache.instance.getOrBuild(key, () {
      return RepaintBoundary(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Math.tex(tex, textStyle: style ?? const TextStyle(fontSize: 18)),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final text = mixed.trim();
    if (text.isEmpty) return const SizedBox.shrink();

    if (forceTex || text.toLowerCase().startsWith('tex:') || text.toLowerCase().startsWith('tex：')) {
      final tex = _stripTexPrefix(text);
      return _cachedMathWidget(tex, mathStyle ?? const TextStyle(fontSize: 18));
    }

    final colonIndex = text.indexOf(':');
    final colonIndexFull = colonIndex >= 0 ? colonIndex : text.indexOf('：');
    if (colonIndexFull >= 0) {
      final leftRaw = text.substring(0, colonIndexFull).trim();
      final rightRaw = text.substring(colonIndexFull + 1).trim();

      if (leftRaw.toLowerCase() == 'tex') {
        final rightTex = _stripTexPrefix(rightRaw);
        return _cachedMathWidget(rightTex, mathStyle ?? const TextStyle(fontSize: 18));
      }

      final leftWidget = _looksLikeMath(leftRaw)
          ? _cachedMathWidget(leftRaw, mathStyle ?? const TextStyle(fontSize: 16))
          : Text(leftRaw + ':', style: labelStyle ?? const TextStyle(fontSize: 16));

      final rightWidget = rightRaw.isEmpty
          ? const SizedBox.shrink()
          : _cachedMathWidget(rightRaw, mathStyle ?? const TextStyle(fontSize: 18));

      final leftCompact = Row(mainAxisSize: MainAxisSize.min, children: [leftWidget]);

      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(flex: 0, child: leftCompact),
          const SizedBox(width: 6),
          Expanded(child: rightWidget),
        ],
      );
    }

    final mathStartRegexp = RegExp(r'[=\\_\^]|\\bI_\\w|\\bint\\b|\\bfrac\\b', caseSensitive: false);
    final match = mathStartRegexp.firstMatch(text);
    if (match != null) {
      final idx = match.start;
      final left = text.substring(0, idx).trim();
      final right = text.substring(idx).trim();
      if (left.isEmpty) {
        return _cachedMathWidget(right, mathStyle ?? const TextStyle(fontSize: 18));
      } else {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(flex: 0, child: Text(left + ' ', style: labelStyle ?? const TextStyle(fontSize: 16))),
            Flexible(
              child: _cachedMathWidget(right, mathStyle ?? const TextStyle(fontSize: 18)),
            ),
          ],
        );
      }
    }

    return _cachedMathWidget(text, mathStyle ?? const TextStyle(fontSize: 18));
  }
}


ProblemStatus keyToStatus(String k) {
  switch (k) {
    case 'solved':
      return ProblemStatus.solved;
    case 'understood':
      return ProblemStatus.understood;
    case 'failed':
      return ProblemStatus.failed;
    default:
      return ProblemStatus.none;
  }
}

String statusToKey(ProblemStatus s) {
  switch (s) {
    case ProblemStatus.solved:
      return 'solved';
    case ProblemStatus.understood:
      return 'understood';
    case ProblemStatus.failed:
      return 'failed';
    case ProblemStatus.none:
    default:
      return 'none';
  }
}

String makeMathKey(String tex, TextStyle? style) {
  final size = style?.fontSize?.toStringAsFixed(2) ?? '';
  final color = (style?.color?.value ?? 0).toString();
  final weight = style?.fontWeight?.index.toString() ?? '';
  return 'tex:${tex}|fs:$size|c:$color|w:$weight';
}


/// Simple LRU cache for Math Widgets.
class MathWidgetCache {
  MathWidgetCache._({this.maxEntries = 200});
  static final MathWidgetCache instance = MathWidgetCache._();

  final int maxEntries;
  final LinkedHashMap<String, Widget> _cache = LinkedHashMap();

  Widget getOrBuild(String key, Widget Function() builder) {
    if (_cache.containsKey(key)) {
      final w = _cache.remove(key)!;
      _cache[key] = w;
      return w;
    }
    final w = builder();
    _cache[key] = w;
    if (_cache.length > maxEntries) _cache.remove(_cache.keys.first);
    return w;
  }

  void clear() => _cache.clear();
  int get length => _cache.length;
}

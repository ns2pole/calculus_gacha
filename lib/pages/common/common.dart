import 'package:flutter_math_fork/flutter_math.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:math' as math;
import '../../models/math_problem.dart';


/// テキストと数式（TeX）を混在表示するウィジェット
/// 
/// 主な機能:
/// - TeXマクロ（\displaystyle, \int等）を検出して数式として表示
/// - Math.texのビルドエラー時はプレーンテキストでフォールバック
/// - ブロック数式（$$...$$）は横スクロール表示
/// - インライン数式（$...$）は数式部分のみ横スクロール可能
/// - 段落間パディング: vertical:4.0、行間: height:1.35
/// 
/// 入力例:
/// - "これは $x^2 + y^2 = 1$ の式です"
/// - "$$\\int_0^1 x dx = \\frac{1}{2}$$"
/// - "tex: \\displaystyle \\sum_{i=1}^{n} i = \\frac{n(n+1)}{2}"
class MixedTextMath extends StatelessWidget {
  final String mixed;
  final TextStyle? labelStyle;
  final TextStyle? mathStyle;
  final bool forceTex;

  const MixedTextMath(
    this.mixed, {
    this.labelStyle,
    this.mathStyle,
    this.forceTex = false,
    Key? key,
  }) : super(key: key);

  /// "tex:" または "tex：" プレフィックスを除去
  /// 
  /// 入力例: "tex: \\int x dx" → "\\int x dx"
  /// 入力例: "tex：\\displaystyle \\sum_{i=1}^n i" → "\\displaystyle \\sum_{i=1}^n i"
  String _stripTexPrefix(String s) {
    var t = s.trim();
    if (t.toLowerCase().startsWith('tex:')) return t.substring(4).trim();
    if (t.toLowerCase().startsWith('tex：')) return t.substring(4).trim();
    return t;
  }

  /// 文字列が数式（TeX）かどうかを判定
  /// 
  /// 判定基準:
  /// - 先頭がバックスラッシュ（例: "\\int"）
  /// - TeXマクロを含む（\displaystyle, \int, \sum, \frac等）
  /// - TeXマクロパターン（\\[A-Za-z]+）に一致
  /// - 上付き/下付き記号（^, _）を含む
  /// - 数学記号（括弧、演算子）を含む
  /// 
  /// 入力例:
  /// - "\\int_0^1 x dx" → true
  /// - "x^2 + y^2" → true
  /// - "これは普通のテキスト" → false
  bool _looksLikeMath(String s) {
    if (s.isEmpty) return false;
    final t = s.trim();
    final lower = t.toLowerCase();

    if (t.startsWith(r'\')) return true;

    final keywords = [
      r'\displaystyle',
      r'\int',
      r'\sum',
      r'\frac',
      r'\sqrt',
      r'\lim',
      r'\begin',
      r'\end',
      r'\alpha',
      r'\beta',
      r'\gamma',
      r'\,',
    ];
    for (final k in keywords) {
      if (t.contains(k) || lower.contains(k.replaceAll(r'\', ''))) return true;
    }

    final macroRe = RegExp(r'\\[A-Za-z]+');
    if (macroRe.hasMatch(t)) return true;

    if (t.contains('^') || t.contains('_') || t.contains(r'$')) return true;

    final mathChars = RegExp(r'[(){}\[\]\+\-\*/=]');
    if (mathChars.hasMatch(t)) return true;

    return false;
  }

  /// TeX文字列をMath.texでレンダリング。エラー時はプレーンテキストでフォールバック
  /// 
  /// 入力: TeX文字列（例: "\\int_0^1 x dx"）
  /// 出力: Math.texウィジェット、またはエラー時はSelectableText
  Widget _mathCoreSafe(String tex, TextStyle style, {MathStyle? mathStyle}) {
    try {
      return Math.tex(
        tex,
        textStyle: style,
        mathStyle: mathStyle ?? MathStyle.text,
      );
    } catch (e, st) {
      // ignore: avoid_print
      print('MixedTextMath: Math.tex build error: $e\ntex: $tex\n$st');
      return SelectableText(tex, style: style);
    }
  }

  /// ブロック数式（独立行の数式）を表示するウィジェット
  /// 
  /// 入力: TeX文字列（例: "\\int_0^1 x dx = \\frac{1}{2}"）
  /// 出力: 横スクロール可能な数式ウィジェット
  /// 使用例: "$$x^2 + y^2 = 1$$" や "\\begin{align}...\\end{align}"
  Widget _blockMathWidget(String tex, TextStyle? style) {
    final effective = style ?? const TextStyle(fontSize: 26);
    final core = _mathCoreSafe(tex, effective, mathStyle: MathStyle.display);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const ClampingScrollPhysics(),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 0),
          child: core,
        ),
      ),
    );
  }

  /// インライン数式（文中の数式）を表示するウィジェット
  /// 
  /// 入力: TeX文字列（例: "x^2"）、最大幅
  /// 出力: 数式部分のみ横スクロール可能なウィジェット
  /// 使用例: "これは $x^2 + y^2 = 1$ の式です" の "$x^2 + y^2 = 1$" 部分
  Widget _inlineMathWidgetConstrained(String tex, double maxWidth, TextStyle? style) {
    final effective = style ?? const TextStyle(fontSize: 22);
    final core = _mathCoreSafe(tex, effective, mathStyle: MathStyle.text);

    final maxAllowed = maxWidth.isFinite ? maxWidth * 0.95 : 300.0;
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxAllowed),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const ClampingScrollPhysics(),
          child: core,
        ),
      ),
    );
  }

  // 正規表現パターン定義
  /// 段落区切り（空行）を検出: "\n\n" や "\n  \n"
  static final RegExp _paraSplit = RegExp(r'\n\s*\n', dotAll: true);
  /// インライン数式を検出: "$x^2$" → "x^2"
  static final RegExp _inlineDollar = RegExp(r'\$(.+?)\$', dotAll: true);
  /// ブロック数式を検出: "$$x^2 + y^2 = 1$$" → "x^2 + y^2 = 1"
  static final RegExp _blockMath = RegExp(r'^\s*\$\$(.+?)\$\$\s*$', dotAll: true);
  /// \textマクロを検出: "\text{これはテキスト}" → "これはテキスト"
  static final RegExp _textMacro = RegExp(r'\\text\s*\{([^}]*)\}', dotAll: true);
  /// TeX環境ブロックを検出: "\\begin{align}...\\end{align}" など
  static final RegExp _envBlock = RegExp(
    r'^\s*\\begin\{(aligned|align\*?|alignedat|gather\*?|equation\*?|multline\*?)\}(.+?)\\end\{\1\}\s*$',
    dotAll: true,
  );

  /// \textマクロで文字列を分割し、テキスト部分と数式部分を区別
  /// 
  /// 入力例: "x^2 + \text{これはテキスト} + y^2"
  /// 出力: [
  ///   {'isText': false, 'text': 'x^2 + '},
  ///   {'isText': true, 'text': 'これはテキスト'},
  ///   {'isText': false, 'text': ' + y^2'}
  /// ]
  List<Map<String, dynamic>> _splitByTextMacro(String s) {
    final out = <Map<String, dynamic>>[];
    int last = 0;
    for (final m in _textMacro.allMatches(s)) {
      if (m.start > last) {
        final between = s.substring(last, m.start);
        if (between.isNotEmpty) out.add({'isText': false, 'text': between});
      }
      final inner = m.group(1) ?? '';
      out.add({'isText': true, 'text': inner});
      last = m.end;
    }
    if (last < s.length) {
      final tail = s.substring(last);
      if (tail.isNotEmpty) out.add({'isText': false, 'text': tail});
    }
    return out;
  }

  /// 文字列の先頭・末尾の空白を分離
  /// 
  /// 入力例: "  x^2 + y^2  "
  /// 出力: {'leading': '  ', 'core': 'x^2 + y^2', 'trailing': '  '}
  Map<String, String> _extractPad(String s) {
    final leadingMatch = RegExp(r'^\s+').firstMatch(s);
    final trailingMatch = RegExp(r'\s+$').firstMatch(s);
    final leading = leadingMatch?.group(0) ?? '';
    final trailing = trailingMatch?.group(0) ?? '';
    final start = leading.length;
    final end = s.length - trailing.length;
    final core = (end > start) ? s.substring(start, end) : '';
    return {'leading': leading, 'core': core, 'trailing': trailing};
  }

  TextStyle _defaultLabelStyle(BuildContext context) {
    return labelStyle ?? const TextStyle(fontSize: 17, height: 1.35);
  }

  @override
  Widget build(BuildContext context) {
    final text = mixed;
    final trimmed = text.trim();
    if (trimmed.isEmpty) return const SizedBox.shrink();

    final hasTextMacro = text.contains(r'\text{');

    if (forceTex && !hasTextMacro) {
      final tex = _stripTexPrefix(trimmed);
      return _blockMathWidget(tex, mathStyle ?? const TextStyle(fontSize: 22));
    }

    final bool hasParaBreak = _paraSplit.hasMatch(text);
    final bool isSingleLine = !hasParaBreak && !text.contains('\n');

    if ((isSingleLine && _looksLikeMath(trimmed) && !hasTextMacro)) {
      final tex = _stripTexPrefix(trimmed);
      return _blockMathWidget(tex, mathStyle ?? const TextStyle(fontSize: 22));
    }

    final bool hasInlineDollar = text.contains(r'$');
    final bool isLongPlain = text.length > 60 && text.contains(' ');

    if (hasParaBreak || hasInlineDollar || hasTextMacro || isLongPlain) {
      final paragraphs = text.split(_paraSplit);

      return LayoutBuilder(builder: (ctx, constraints) {
        final maxW = constraints.hasBoundedWidth ? constraints.maxWidth : double.infinity;
        final defaultLabel = _defaultLabelStyle(context);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: paragraphs.map((para) {
            final paraTrim = para.trim();
            if (paraTrim.isEmpty) return const SizedBox.shrink();

            final envMatch = _envBlock.firstMatch(para);
            if (envMatch != null) {
              final envBody = envMatch.group(0) ?? '';
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Center(child: _blockMathWidget(envBody, mathStyle ?? const TextStyle(fontSize: 26))),
              );
            }

            final blockMatch = _blockMath.firstMatch(para);
            if (blockMatch != null) {
              final mathBody = blockMatch.group(1) ?? '';
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Center(child: _blockMathWidget(mathBody, mathStyle ?? const TextStyle(fontSize: 26))),
              );
            }

            if (_looksLikeMath(paraTrim) && !para.contains(r'\text{')) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: _blockMathWidget(paraTrim, mathStyle ?? const TextStyle(fontSize: 26)),
              );
            }

            if (para.contains(r'\text{')) {
              final parts = _splitByTextMacro(para);
              final spans = <InlineSpan>[];

              for (final part in parts) {
                final isText = part['isText'] as bool;
                final content = part['text'] as String;
                if (isText) {
                  spans.add(TextSpan(text: content, style: labelStyle ?? defaultLabel));
                } else {
                  final pad = _extractPad(content);
                  final leading = pad['leading'] ?? '';
                  final core = pad['core'] ?? '';
                  final trailing = pad['trailing'] ?? '';

                  if (leading.isNotEmpty) {
                    spans.add(TextSpan(text: leading, style: labelStyle ?? defaultLabel));
                  }

                  if (core.isNotEmpty) {
                    int lastIndex = 0;
                    bool foundDollar = false;
                    for (final m in _inlineDollar.allMatches(core)) {
                      foundDollar = true;
                      if (m.start > lastIndex) {
                        spans.add(TextSpan(
                            text: core.substring(lastIndex, m.start),
                            style: labelStyle ?? defaultLabel));
                      }
                      final mathBody = m.group(1) ?? '';
                      spans.add(WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: _inlineMathWidgetConstrained(mathBody, maxW, mathStyle ?? const TextStyle(fontSize: 22)),
                      ));
                      lastIndex = m.end;
                    }
                    if (foundDollar) {
                      if (lastIndex < core.length) {
                        spans.add(TextSpan(text: core.substring(lastIndex), style: labelStyle ?? defaultLabel));
                      }
                    } else {
                      spans.add(WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: _inlineMathWidgetConstrained(core, maxW, mathStyle ?? const TextStyle(fontSize: 22)),
                      ));
                    }
                  }

                  if (trailing.isNotEmpty) {
                    spans.add(TextSpan(text: trailing, style: labelStyle ?? defaultLabel));
                  }
                }
              }

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text.rich(TextSpan(children: spans), softWrap: true, textAlign: TextAlign.left),
              );
            }

            final spans = <InlineSpan>[];
            int lastIndex = 0;
            for (final m in _inlineDollar.allMatches(para)) {
              if (m.start > lastIndex) {
                spans.add(TextSpan(text: para.substring(lastIndex, m.start), style: labelStyle ?? defaultLabel));
              }
              final mathBody = m.group(1) ?? '';
              spans.add(WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: _inlineMathWidgetConstrained(mathBody, maxW, mathStyle ?? const TextStyle(fontSize: 22)),
              ));
              lastIndex = m.end;
            }
            if (lastIndex < para.length) {
              spans.add(TextSpan(text: para.substring(lastIndex), style: labelStyle ?? defaultLabel));
            }

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text.rich(TextSpan(children: spans), softWrap: true, textAlign: TextAlign.left),
            );
          }).toList(),
        );
      });
    }

    final colonIndex = text.indexOf(':');
    final colonIndexFull = colonIndex >= 0 ? colonIndex : text.indexOf('：');
    if (colonIndexFull >= 0) {
      final leftRaw = text.substring(0, colonIndexFull).trim();
      final rightRaw = text.substring(colonIndexFull + 1).trim();

      if (leftRaw.toLowerCase() == 'tex') {
        final rightTex = _stripTexPrefix(rightRaw);
        return _blockMathWidget(rightTex, mathStyle ?? const TextStyle(fontSize: 22));
      }

      final leftWidget = _looksLikeMath(leftRaw)
          ? _blockMathWidget(leftRaw, mathStyle ?? const TextStyle(fontSize: 20))
          : Text(leftRaw + ':', style: labelStyle ?? _defaultLabelStyle(context));

      final rightWidget = rightRaw.isEmpty ? const SizedBox.shrink() : _blockMathWidget(rightRaw, mathStyle ?? const TextStyle(fontSize: 22));

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
        return _blockMathWidget(right, mathStyle ?? const TextStyle(fontSize: 22));
      } else {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(flex: 0, child: Text(left + ' ', style: labelStyle ?? _defaultLabelStyle(context))),
            Flexible(child: _blockMathWidget(right, mathStyle ?? const TextStyle(fontSize: 22))),
          ],
        );
      }
    }

    return _blockMathWidget(trimmed, mathStyle ?? const TextStyle(fontSize: 22));
  }
}

/// 微分方程式ガチャ用のキーワードフィルタリング共通関数

/// キーワードを4グループに分類
/// 
/// 入力: 選択されたキーワードのセット（例: {'数値', '等加速度直線運動', '直流', 'コンデンサ'}）
/// 出力: グループごとに分類されたキーワードマップ
/// 
/// グループ定義:
/// - group1: {'数値', '一般'}
/// - group2: {'等加速度直線運動', '空気抵抗', '単振動'}
/// - group3: {'直流', '交流', '電圧0'}
/// - group4: {'コンデンサ', 'コイル', '抵抗'}
Map<String, Set<String>> categorizeKeywords4Groups(Set<String> selected) {
  final group1 = {'数値', '一般'};
  final group2 = {'等加速度直線運動', '空気抵抗', '単振動'};
  final group3 = {'直流', '交流', '電圧0'};
  final group4 = {'コンデンサ', 'コイル', '抵抗'};
  
  return {
    'group1': selected.intersection(group1),
    'group2': selected.intersection(group2),
    'group3': selected.intersection(group3),
    'group4': selected.intersection(group4),
  };
}

/// 問題をキーワードでフィルタリング（4グループ制：グループ内演算、グループ間AND/OR）
/// 
/// 入力:
/// - problems: 全問題リスト
/// - selected: 選択されたキーワードセット（例: {'数値', '等加速度直線運動', '直流', 'コンデンサ'}）
/// 
/// 出力: フィルタリングされた問題リスト
/// 
/// フィルタリングロジック:
/// 1. グループ内演算:
///    - group1: OR条件（'数値' OR '一般'）
///    - group2: 選択キーワードを含み、未選択キーワードを含まない
///    - group3: OR条件（'直流' OR '交流' OR '電圧0'）
///    - group4: 選択キーワードを含み、未選択キーワードを含まない
/// 2. グループ間演算:
///    - X = group3 AND group4
///    - Y = group2 OR X
///    - 最終結果 = group1 AND Y
/// 3. 大学キーワード処理:
///    - '大学'が選択されている場合、追加で大学問題をフィルタリング
///    - '大学' + '一般' → keywords: ['大学', '一般']のみ
///    - '大学' + '数値' → keywords: ['大学', '数値']のみ
/// 
/// 具体例:
/// - 選択: {'数値', '等加速度直線運動'} → group1 AND group2 に一致する問題
/// - 選択: {'数値', '直流', 'コンデンサ'} → group1 AND (group3 AND group4) に一致する問題
List<MathProblem> filterProblemsByKeywords(List<MathProblem> problems, Set<String> selected) {
  if (selected.isEmpty) return [];
  
  final groups = categorizeKeywords4Groups(selected);
  final group1 = groups['group1']!;
  final group2 = groups['group2']!;
  final group3 = groups['group3']!;
  final group4 = groups['group4']!;
  
  final group2All = {'等加速度直線運動', '空気抵抗', '単振動'};
  final group4All = {'コンデンサ', 'コイル', '抵抗'};
  
  final filtered = problems.where((p) {
    if (p.keywords.isEmpty) return false;
    
    // ステップ1: 各グループ内部の演算
    bool group1Match = false;
    if (group1.isNotEmpty) {
      group1Match = p.keywords.any((k) => group1.contains(k));
    }
    
    // グループ2: 選択キーワードを含み、未選択キーワードを含まない
    bool group2Match = false;
    if (group2.isNotEmpty) {
      final hasSelected = p.keywords.any((k) => group2.contains(k));
      if (hasSelected) {
        final unselected = group2All.difference(group2);
        final hasUnselected = p.keywords.any((k) => unselected.contains(k));
        if (!hasUnselected) {
          group2Match = true;
        }
      }
    }
    
    bool group3Match = false;
    if (group3.isNotEmpty) {
      group3Match = p.keywords.any((k) => group3.contains(k));
    }
    
    // グループ4: 選択キーワードを含み、未選択キーワードを含まない
    bool group4Match = false;
    if (group4.isNotEmpty) {
      final hasSelected = p.keywords.any((k) => group4.contains(k));
      if (hasSelected) {
        final unselected = group4All.difference(group4);
        final hasUnselected = p.keywords.any((k) => unselected.contains(k));
        if (!hasUnselected) {
          group4Match = true;
        }
      }
    }
    
    // ステップ2: グループ間の演算
    // X = group3 AND group4（両方選択時のみ計算）
    bool X = false;
    if (group3.isNotEmpty && group4.isNotEmpty) {
      X = group3Match && group4Match;
    }
    
    // Y = group2 OR X
    bool Y = group2.isNotEmpty ? (group2Match || X) : X;
    
    // 最終結果 = group1 AND Y
    bool matches = group1.isNotEmpty ? (group1Match && Y) : false;
    
    return matches;
  }).toList();
  
  // 大学キーワードが選択されている場合、大学問題を追加（通常フィルタ結果と和集合）
  if (selected.contains('大学')) {
    final hasNumerical = selected.contains('数値');
    final hasGeneral = selected.contains('一般');
    
    // YG: '大学' + '一般' → keywords: ['大学', '一般']のみ（他キーワードなし）
    final YG = <MathProblem>[];
    if (hasGeneral) {
      YG.addAll(problems.where((p) {
        final keywordsSet = p.keywords.toSet();
        return keywordsSet.length == 2 && 
               keywordsSet.contains('大学') && 
               keywordsSet.contains('一般');
      }));
    }
    
    // YC: '大学' + '数値' → keywords: ['大学', '数値']のみ（他キーワードなし）
    final YC = <MathProblem>[];
    if (hasNumerical) {
      YC.addAll(problems.where((p) {
        final keywordsSet = p.keywords.toSet();
        return keywordsSet.length == 2 && 
               keywordsSet.contains('大学') && 
               keywordsSet.contains('数値');
      }));
    }
    
    // 大学問題の和集合を生成
    final universityProblems = <MathProblem>[];
    if (hasNumerical && hasGeneral) {
      // YGとYCの和集合（idで重複排除）
      final resultIds = <String>{};
      for (final p in YG) {
        if (!resultIds.contains(p.id)) {
          resultIds.add(p.id);
          universityProblems.add(p);
        }
      }
      for (final p in YC) {
        if (!resultIds.contains(p.id)) {
          resultIds.add(p.id);
          universityProblems.add(p);
        }
      }
    } else if (hasGeneral) {
      universityProblems.addAll(YG);
    } else if (hasNumerical) {
      universityProblems.addAll(YC);
    }
    // '大学'のみ選択（'数値'も'一般'もOFF）の場合は何も追加しない
    
    // 通常フィルタ結果と大学問題の和集合を返す（idで重複排除）
    final resultIds = <String>{};
    final result = <MathProblem>[];
    
    for (final p in filtered) {
      if (!resultIds.contains(p.id)) {
        resultIds.add(p.id);
        result.add(p);
      }
    }
    
    for (final p in universityProblems) {
      if (!resultIds.contains(p.id)) {
        resultIds.add(p.id);
        result.add(p);
      }
    }
    
    return result;
  }
  
  return filtered;
}

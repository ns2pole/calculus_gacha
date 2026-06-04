import 'package:flutter_test/flutter_test.dart';
import 'package:joymath/pages/common/mixed_text_math_pipeline.dart';

void main() {
  group('normalizeDoubleEscapedLatex', () {
    test('collapses double-backslash frac to single', () {
      const input = '\\\\frac{k}{n}';
      expect(normalizeDoubleEscapedLatex(input), r'\frac{k}{n}');
    });

    test('does not alter single-backslash frac', () {
      expect(normalizeDoubleEscapedLatex(r'\frac{k}{n}'), r'\frac{k}{n}');
    });

    test('collapses \\\\displaystyle and \\\\lim in limit formula', () {
      const input =
          r'\\displaystyle \lim_{u\to 0} \frac{e^{u}-1}{u}=1';
      expect(
        normalizeDoubleEscapedLatex(input),
        r'\displaystyle \lim_{u\to 0} \frac{e^{u}-1}{u}=1',
      );
    });

    test('collapses four backslashes iteratively', () {
      const input = '\\\\\\\\displaystyle';
      expect(normalizeDoubleEscapedLatex(input), r'\displaystyle');
    });
  });

  group('shouldRenderWithMixedTextMath', () {
    test('returns true for inline \\displaystyle without dollar delimiters', () {
      const text =
          '分子が e^{2x} - 1 という形になり、\\displaystyle \\lim_{u\\to 0}\\frac{e^{u}-1}{u}=1 という公式';
      expect(shouldRenderWithMixedTextMath(text), isTrue);
    });

    test('returns false for plain Japanese only', () {
      expect(shouldRenderWithMixedTextMath('区分求積法のポイントです'), isFalse);
    });
  });

  group('normalizeAiChatMathDelimiters', () {
    test('converts \\( \\) inline delimiters to dollar math', () {
      const input =
          r'はい、その通りです！ $x \to \infty$ のとき、\( \displaystyle \lim_{\theta \to 0} \frac{\sin \theta}{\theta} = 1 \) という公式';
      expect(
        normalizeAiChatMathDelimiters(input),
        r'はい、その通りです！ $x \to \infty$ のとき、$ \displaystyle \lim_{\theta \to 0} \frac{\sin \theta}{\theta} = 1 $ という公式',
      );
    });

    test('leaves \\left( \\right) unchanged', () {
      const input = r'$\sin\left(\frac{1}{x}\right)$';
      expect(normalizeAiChatMathDelimiters(input), input);
    });
  });

  group('preprocessAiChatMathText', () {
    test('collapses double backslashes and normalizes delimiters', () {
      const input =
          r'はい！ $x \to \infty$ のとき、\( \lim_{\theta \to 0} \frac{\sin \theta}{\theta} = 1 \) '
          r'と $$ \\frac{1}{x} $$';
      final processed = preprocessAiChatMathText(input);
      expect(processed, isNot(contains(r'\(')));
      expect(processed, contains(r'\lim_{\theta \to 0}'));
      expect(processed, contains(r'\frac{1}{x}'));
      expect(processed, isNot(contains(r'\\frac')));
    });

    test('leaves already-decoded LaTeX unchanged aside from delimiter normalize', () {
      const input = r'$n + k = n \times (\text{何か})$';
      expect(preprocessAiChatMathText(input), input);
    });
  });

  group('shouldSplitMixedCjkAndLatex', () {
    test('returns true for Japanese with inline macro', () {
      expect(
        shouldSplitMixedCjkAndLatex(r'区分求積法を使うときに、 \frac{k}{n} の部分'),
        isTrue,
      );
    });

    test('returns false for delimited math only', () {
      expect(
        shouldSplitMixedCjkAndLatex(r'これは $\frac{k}{n}$ です'),
        isFalse,
      );
    });

    test('returns false for plain Japanese', () {
      expect(shouldSplitMixedCjkAndLatex('区分求積法のポイントです'), isFalse);
    });
  });

  group('segmentMixedCjkAndLatex', () {
    test('splits Japanese around \\frac without dollar delimiters', () {
      final segments = segmentMixedCjkAndLatex(
        '区分求積法を使うときに、 \\frac{k}{n} の部分を x と見なす',
      );

      expect(segments.length, 3);
      expect(segments[0].kind, MixedTextSegmentKind.plain);
      expect(segments[0].text, '区分求積法を使うときに、 ');
      expect(segments[1].kind, MixedTextSegmentKind.inlineMath);
      expect(segments[1].text, r'\frac{k}{n}');
      expect(segments[2].kind, MixedTextSegmentKind.plain);
      expect(segments[2].text, 'の部分を x と見なす');
    });

    test('keeps dollar-delimited math in plain segments for downstream', () {
      final segments = segmentMixedCjkAndLatex(
        r'例えば $n + k = n \times (\text{何か})$ です',
      );

      expect(segments.any((s) => s.text.contains(r'\times')), isTrue);
    });
  });

  group('Firestore 2026-06-03 session regressions', () {
    const msg11Assistant =
        'はい、では具体的に見ていきましょう。\n\n'
        r'元の式は $\displaystyle \lim_{n\to\infty}\frac{1}{n^{3}}\displaystyle \sum_{k=1}^{n}k^{2}$ でしたね。'
        '\n\n'
        r'先ほどの $\displaystyle \sum_{k=1}^{n}k^{2}=\frac{n(n+1)(2n+1)}{6}$ の公式を代入すると、次のようになります。'
        '\n\n'
        r'$$\frac{1}{n^{3}}\cdot \frac{n(n+1)(2n+1)}{6}$$ '
        '\n\n'
        'この式を \$n\$ の多項式の分数（有理関数）の形に整理してみてください。'
        '分子と分母の \$n\$ の次数に注目すると、極限を求めるヒントになりますよ。';

    const msg13Assistant =
        'はい、では具体的に見ていきましょう。 '
        r'元の式は $\displaystyle \lim_{n\to\infty}\frac{1}{n^{3}}\displaystyle \sum_{k=1}^{n}k^{2}$ でしたね。 '
        r'先ほどの $\displaystyle \sum_{k=1}^{n}k^{2}=\frac{n(n+1)(2n+1)}{6}$ の公式を代入すると、次のようになります。 '
        r'$$\frac{1}{n^{3}}\cdot \frac{n(n+1)(2n+1)}{6}$$ '
        'この式を \$n\$ の多項式の分数（有理関数）の形に整理してみてください。'
        '分子と分母の \$n\$ の次数に注目すると、極限を求めるヒントになりますよ。';

    const msg9AssistantText =
        r'はい、元の問題に戻りましょう！ 先ほど確認した $1-\cos x = 2\sin^2\left(\frac{x}{2}\right)$ を問題の式に代入すると、次のようになりますね。 $$ \lim_{x\to 0}\frac{2\sin^2\left(\frac{x}{2}\right)}{x^{2}} $$ ここから、$\displaystyle \lim_{t \to 0} \frac{\sin t}{t} = 1$ の形を作るには、どうすれば良いか考えてみましょう。';

    const msg1AssistantFirstStep =
        r'$x \to 0$ のときに $\frac{0}{0}$ の不定形になるので、式変形が必要です。分子の $1-\cos x$ を、半角の公式を使って $\sin$ を含む形に変形してみましょう。具体的には $1-\cos x = 2\sin^2\left(\frac{x}{2}\right)$ という関係式が使えますよ。';

    const msg9TextRaw =
        r'はい、元の問題に戻りましょう！ 先ほど確認した $1-\cos x = 2\sin^2\left(\frac{x}{2}\right)$ を問題の式に代入すると、次のようになりますね。 $$ \\lim_{x\\to 0}\\frac{2\\sin^2\\left(\\frac{x}{2}\\right)}{x^{2}} $$ ここから、$\displaystyle \\lim_{t \\to 0} \\frac{\\sin t}{t} = 1$ の形を作るには、どうすれば良いか考えてみましょう。';

    const msg5Assistant =
        r'はい、その通りです！ $x \to \infty$ のとき $1/x \to 0$ になることを利用すると、\( \displaystyle \lim_{\theta \to 0} \frac{\sin \theta}{\theta} = 1 \) という有名な極限の公式が使える形になりますよ。';

    const msg17Assistant =
        r'グラフで考えると、$y = \sin \theta$ のグラフと、$y = \theta$（これは原点を通る傾き1の直線ですね）のグラフを比べてみましょう。\theta が $0$ に限りなく近づくとき、この2つのグラフは原点付近でほとんど重なるように見えます。';

    const msg19Assistant =
        r'はい、ではイメージしてみましょう。 まず、$y = \theta$ のグラフは、原点 $(0,0)$ を通る傾き $1$ の直線ですね。'
        r' 次に、$y = \text{sin } \theta$ のグラフは、波のような形をしています。'
        r' この「ぴったり重なる」という様子が、$\frac{\text{sin } \theta}{\theta}$ の値が $1$ に近づく、ということを視覚的に示しています。';

    final paraSplit = RegExp(r'\n\s*\n', dotAll: true);

    List<String> paragraphs(String text) {
      return text
          .split(paraSplit)
          .map((p) => p.trim())
          .where((p) => p.isNotEmpty)
          .toList();
    }

    test('msg11: paragraphs with \$ must keep TeX inside dollar spans only', () {
      for (final para in paragraphs(msg11Assistant)) {
        if (!para.contains(r'$')) continue;
        expect(
          texMacrosAreOnlyInsideDollarSpans(para),
          isTrue,
          reason: 'paragraph must not trigger CJK+macro split: $para',
        );
      }
    });

    test('msg11: must not use segmentMixedCjkAndLatex (avoids bare \$ in UI)', () {
      for (final para in paragraphs(msg11Assistant)) {
        expect(
          shouldSplitMixedCjkAndLatex(para),
          isFalse,
          reason: 'wrong split leaves literal \$ and \\\\n in bubbles: $para',
        );
      }
    });

    test('msg13 follow-up: single paragraph with \$\$ block must not CJK-split', () {
      expect(shouldSplitMixedCjkAndLatex(msg13Assistant), isFalse);
      expect(texMacrosAreOnlyInsideDollarSpans(msg13Assistant), isTrue);
    });

    test('msg9 textRaw: preprocess collapses JSON double backslashes', () {
      final processed = preprocessAiChatMathText(msg9TextRaw);
      expect(processed, isNot(contains(r'\\lim')));
      expect(processed, contains(r'\lim_{x\to 0}'));
    });

    test('msg1 first_step assistant: dollar-only TeX must not CJK-split', () {
      expect(texMacrosAreOnlyInsideDollarSpans(msg1AssistantFirstStep), isTrue);
      expect(shouldSplitMixedCjkAndLatex(msg1AssistantFirstStep), isFalse);
    });

    test('msg5: \\( \\) becomes dollar math in preprocess', () {
      final processed = preprocessAiChatMathText(msg5Assistant);
      expect(processed, isNot(contains(r'\(')));
      expect(processed, contains(r'\lim_{\theta \to 0}'));
      expect(processed, contains(r'\sin \theta'));
    });

    test('msg17: bare \\theta outside dollars stays intact', () {
      final processed = preprocessAiChatMathText(msg17Assistant);
      expect(processed, contains(r'\theta'));
      expect(processed.contains('y = heta'), isFalse);
      expect(processed.contains('\t'), isFalse);
    });

    test('msg19: decoded LaTeX stays intact through preprocess', () {
      final processed = preprocessAiChatMathText(msg19Assistant);
      expect(processed, contains(r'\theta'));
      expect(processed, contains(r'\text{sin }'));
      expect(processed, contains(r'\frac{\text{sin } \theta}{\theta}'));
      expect(processed.contains('y = heta'), isFalse);
    });

    test('msg11: preprocess preserves real newlines (not literal backslash-n)', () {
      final processed = preprocessAiChatMathText(msg11Assistant);
      expect(processed, contains('\n\n'));
      expect(processed, isNot(contains(r'\n\n')));
    });
  });

  group('normalizeLiteralEscapedNewlines', () {
    test('converts literal backslash-n paragraph breaks', () {
      const input = r'段落1。\n\n段落2。';
      expect(normalizeLiteralEscapedNewlines(input), '段落1。\n\n段落2。');
    });

    test('keeps \\nabla as TeX', () {
      const input = r'$\nabla f$';
      expect(normalizeLiteralEscapedNewlines(input), input);
    });

    test('keeps \\nu as TeX', () {
      const input = r'$\nu$';
      expect(normalizeLiteralEscapedNewlines(input), input);
    });
  });

  group('2026-06-03 lim sin/x assistant reply', () {
    const body =
        r'まず $\displaystyle \lim_{x\to 0}\frac{\sin x}{x} = 1$ については、図形的に「はさみうちの原理」を使って証明することができます。単位円と扇形の面積の関係を使うと、この値が1に近づくことを示すことができますよ。';

    const tail =
        r'そして $\displaystyle \lim_{x\to 0}\cos x = 1$ については、$\cos x$ は連続な関数なので、$x$ が0に近づくとき、その値は $\cos 0$ に近づきます。$\cos 0 = 1$ なので、この極限は1になりますね。';

    final assistantRealNewlines = '$body\n\n$tail';
    final assistantLiteralNewlines = '$body\\n\\n$tail';

    final paraSplit = RegExp(r'\n\s*\n', dotAll: true);

    List<String> paragraphs(String text) {
      return text
          .split(paraSplit)
          .map((p) => p.trim())
          .where((p) => p.isNotEmpty)
          .toList();
    }

    void expectDollarParagraphsDoNotCjkSplit(String processed) {
      for (final para in paragraphs(processed)) {
        expect(
          shouldSplitMixedCjkAndLatex(para),
          isFalse,
          reason: 'must use dollar math spans, not segmentMixedCjk: $para',
        );
        expect(texMacrosAreOnlyInsideDollarSpans(para), isTrue);
      }
    }

    test('real newlines: paragraphs do not CJK-split', () {
      final processed = preprocessAiChatMathText(assistantRealNewlines);
      expect(processed, contains(r'\lim_{x\to 0}'));
      expect(processed, isNot(contains(r'\n\n')));
      expectDollarParagraphsDoNotCjkSplit(processed);
    });

    test('literal \\n\\n: preprocess then paragraphs do not CJK-split', () {
      expect(assistantLiteralNewlines, contains(r'\n\n'));
      final processed = preprocessAiChatMathText(assistantLiteralNewlines);
      expect(processed, contains('\n\n'));
      expect(processed, isNot(contains(r'\n\n')));
      expect(processed, contains(r'\lim_{x\to 0}'));
      expectDollarParagraphsDoNotCjkSplit(processed);
    });

    test('literal \\n\\n alone does not count as TeX macro outside dollars', () {
      expect(containsRecognizedTexMacros(r'よ。\n\nそして'), isFalse);
      expect(texMacrosAreOnlyInsideDollarSpans(assistantLiteralNewlines), isTrue);
    });
  });

  group('production regressions', () {
    test('well-formed \\ldots in math is unchanged', () {
      const ok = r'$S_1, S_2, S_3, \ldots$';
      expect(preprocessAiChatMathText(ok), ok);
    });

    test('Japanese + \\\\displaystyle limit — preprocess + segment', () {
      const input =
          'を消すことができます。そうすると、分子が e^{2x} - 1 という形になり、'
          r'\\displaystyle \lim_{u\to 0}\frac{e^{u}-1}{u}=1 というよく知られた極限の公式に近づける';
      final processed = preprocessAiChatMathText(input);
      expect(processed, contains(r'\displaystyle'));
      expect(processed, isNot(contains(r'\\displaystyle')));
      expect(shouldRenderWithMixedTextMath(processed), isTrue);

      final segments = segmentMixedCjkAndLatex(processed);
      expect(
        segments.any(
          (s) => s.isMath && s.text.contains(r'\displaystyle'),
        ),
        isTrue,
      );
    });
  });
}

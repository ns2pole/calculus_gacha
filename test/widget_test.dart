// MyApp / HomePage のスモークテスト（旧カウンターテンプレは実装と不一致のため削除）

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:joymath/main.dart';
import 'package:joymath/pages/other/home_page.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('MyApp builds and shows HomePage', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(const MyApp());
    // HomePage 内の非同期・無限に近いアニメに引っ張られないよう frame を進める
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    expect(find.byType(HomePage), findsOneWidget);
  });
}

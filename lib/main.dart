import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_web_options.dart';
import 'pages/other/home_page.dart';
import './utils/update_checker.dart';
import 'services/problems/simple_data_manager.dart';
import 'services/payment/revenuecat_service.dart';
import 'services/payment/iap_secondary_products_config.dart';
import 'l10n/app_localizations.dart';
import 'utils/app_logger.dart';
import 'utils/locale_utils.dart';

// 共有の navigatorKey を1つだけ作る
final GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Firebase初期化
  // 初期化プロセスのセクション数を設定（アプリ初期化、RevenueCat初期化、StoreKit設定テスト）
  AppLogger.resetSectionCounter(totalSections: 3);
  AppLogger.section('アプリケーション初期化', showNumber: true);
  bool firebaseInitialized = false;
  try {
    if (kIsWeb && !FirebaseWebOptions.isConfigured) {
      AppLogger.warning(
        'Web: Firebase が未設定です',
        details: 'lib/firebase_web_options.dart に Firebase Console の Web アプリ設定を入れるか、flutterfire configure で生成した web ブロックをコピーしてください。',
      );
    } else {
      await Firebase.initializeApp(
        options: kIsWeb ? FirebaseWebOptions.current : null,
      );
    }
    // 初期化が成功したか確認
    final apps = Firebase.apps;
    if (apps.isEmpty) {
      AppLogger.warning('Firebaseアプリリストが空です',
        details: '設定ファイルが不足している可能性があります:\n- Web: lib/firebase_web_options.dart（Firebase Console で Web アプリを追加し値を設定）\n- Android: android/app/google-services.json\n- iOS: ios/GoogleService-Info.plist（ios/GoogleService-Info.plist.example をコピーして Firebase の値を埋める）\nFirebase機能は利用できません。');
    } else {
      firebaseInitialized = true;
      AppLogger.success('Firebaseの初期化が完了しました', details: 'アプリ数: ${apps.length}');
    }
  } catch (e, stackTrace) {
    AppLogger.error('Firebaseの初期化に失敗しました', error: e,
      details: '設定ファイルを確認してください:\n- Android: android/app/google-services.json\n- iOS: ios/GoogleService-Info.plist\nアプリは続行しますが、Firebase機能は利用できません。');
    // Firebase初期化エラー時もアプリは起動を続行
    // ただし、Firebase機能は使用できない
  }
  
  runApp(const MyApp());
  // runApp の後で非同期にアップデートチェックを開始（postFrame は安全） ここをオンにすればupdateがチェックされる。
  WidgetsBinding.instance.addPostFrameCallback((_) async {
    // シンプルデータマネージャーを初期化
    await SimpleDataManager.initialize();
    
    // RevenueCat は iOS / Android / macOS のみ（Web ではプラグイン未対応）
    if (!kIsWeb) {
      AppLogger.subsection('RevenueCat初期化', showNumber: true);
      final revenueCatInitialized = await RevenueCatService.initialize();
      if (revenueCatInitialized) {
        AppLogger.success('RevenueCatの初期化が完了しました');
      } else {
        AppLogger.warning('RevenueCatの初期化に失敗しました',
            details: 'AndroidではAPIキーが設定されていない可能性があります（正常動作に影響なし）');
      }
    } else {
      AppLogger.info('Web: RevenueCat の初期化をスキップしました');
    }
    
    // 初回起動時に購入情報を復元（アンインストール後の再インストール時にも動作）
    // ログインダイアログが邪魔になるため一時的に無効化
    // await _restorePurchasesOnFirstLaunch();
    
    // StoreKit Configuration の診断（デバッグ・二次IAP有効時のみ）
    if (kDebugMode && !kIsWeb && kEnableLearningHistoryAndStoreKitDiagnostics) {
      AppLogger.subsection('StoreKit設定テスト', showNumber: true);

      final allProductsResult = await RevenueCatService.listAllAvailableProducts();
      if (allProductsResult != null) {
        if (allProductsResult['success'] == true) {
          final products = allProductsResult['products'] as List?;
          if (products != null && products.isNotEmpty) {
            AppLogger.success('利用可能な商品が見つかりました', details: '${products.length}個');
            for (var product in products) {
              AppLogger.info('商品: ${product['productId']}', details: '${product['title']} (${product['localizedPrice']})');
            }
          } else {
            AppLogger.warning('利用可能な商品が見つかりませんでした');
          }

          final invalidIds = allProductsResult['invalidProductIds'] as List?;
          if (invalidIds != null && invalidIds.isNotEmpty) {
            AppLogger.warning('無効な商品IDが見つかりました', details: invalidIds.join(", "));
          }
        } else {
          AppLogger.error('商品リストの取得に失敗しました', details: allProductsResult['error']?.toString());
        }
      }

      final testResult =
          await RevenueCatService.testStoreKitConfiguration(RevenueCatService.factorizationOptionProductId);
      if (testResult != null) {
        if (testResult['success'] == true) {
          AppLogger.success(
            'StoreKitテスト: 商品情報取得成功',
            details: 'Product ID: ${testResult['productId']}\nTitle: ${testResult['title']}\nPrice: ${testResult['localizedPrice']}',
          );
        } else {
          AppLogger.error('StoreKitテスト: 商品情報取得失敗', details: testResult['error']?.toString());
        }
      } else {
        AppLogger.error('StoreKitテスト: 結果がnull');
      }
    }
    
    if (!kIsWeb) {
      UpdateChecker(
        iosId: '6753078774',
        androidId: 'com.joymath',
        skipDays: 3,
        navigatorKey: appNavigatorKey,
        // forceShowForDebug: true, // デバッグ時に強制表示したいなら有効化
      ).checkOnAppStart();
    }
  });
}

/// 初回起動時に購入情報を復元
/// アンインストール後の再インストール時にも動作する
Future<void> _restorePurchasesOnFirstLaunch() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    const restoreKey = 'has_restored_purchases_on_install';
    
    // 既に復元済みかチェック
    final hasRestored = prefs.getBool(restoreKey) ?? false;
    
    if (!hasRestored) {
      debugPrint('[PurchaseRestore] 初回起動を検出。購入情報を復元します...');
      
      // 購入情報を復元
      final restored = await RevenueCatService.restorePurchases();
      
      if (restored) {
        debugPrint('[PurchaseRestore] ✅ 購入情報の復元に成功しました');
        
        // 実際にプレミアム購入が有効になっているかを確認
        final isPremiumPurchased = await SimpleDataManager.isPremiumPurchased();
        
        if (isPremiumPurchased) {
          debugPrint('[PurchaseRestore] ✅ プレミアム購入が有効であることを確認しました');
          
          // アプリが完全に起動するまで少し待ってからアラートを表示
          await Future.delayed(const Duration(milliseconds: 500));
          
          // アラートダイアログを表示
          _showRestoreSuccessDialog();
        } else {
          debugPrint('[PurchaseRestore] ℹ️ 復元は成功しましたが、プレミアム購入は有効ではありませんでした');
        }
      } else {
        debugPrint('[PurchaseRestore] ℹ️ 復元可能な購入情報はありませんでした');
      }
      
      // 復元処理を実行したことを記録（次回以降はスキップ）
      await prefs.setBool(restoreKey, true);
    } else {
      debugPrint('[PurchaseRestore] 既に復元済みのためスキップします');
    }
  } catch (e) {
    debugPrint('[PurchaseRestore] エラー: $e');
    // エラーが発生してもアプリの起動は続行
  }
}

/// 購入復元成功時のアラートダイアログを表示
void _showRestoreSuccessDialog() {
  // アプリが完全に起動するまで待機
  WidgetsBinding.instance.addPostFrameCallback((_) async {
    // 少し遅延を入れて、UIが完全に構築されてから表示
    await Future.delayed(const Duration(milliseconds: 800));
    
    final context = appNavigatorKey.currentContext;
    if (context != null && context.mounted) {
      final l10n = AppLocalizations.of(context)!;
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
          content: Text(
            l10n.pastPurchasesRestored,
            style: const TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(l10n.ok),
            ),
          ],
        ),
      );
    }
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: appNavigatorKey,
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
      theme: ThemeData(primarySwatch: Colors.blue),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      localeResolutionCallback: resolveAppLocale,
      home: const HomePage(),
    );
  }
}

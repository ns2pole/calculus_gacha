// lib/pages/other/cloud_backup_confirmation_page.dart
import 'package:flutter/material.dart';
import '../../widgets/home/background_image_widget.dart';
import 'auth_page.dart';
import '../../l10n/app_localizations.dart';

/// クラウドバックアップ確認ページ
/// 2つの無料ガチャ登録後に表示される
class CloudBackupConfirmationPage extends StatelessWidget {
  const CloudBackupConfirmationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return WillPopScope(
      onWillPop: () async => false, // 戻るボタンを無効化
      child: Scaffold(
        body: Stack(
          children: [
            // 背景画像（home_pageと同じスタイル）
            Positioned.fill(
              child: const BackgroundImageWidget(),
            ),
            // コンテンツ
            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        l10n.cloudBackupConfirmTitle,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 48),
                      // 「はい」ボタン
                      SizedBox(
                        width: 280,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                            // 新規登録画面（AuthPage）に遷移（初回登録フローとして）
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const AuthPage(isInitialSignUp: true),
                                fullscreenDialog: true,
                              ),
                            ).then((result) {
                              // 認証成功後、homeに戻る
                              if (result == true) {
                                Navigator.of(context).pop(); // CloudBackupConfirmationPageを閉じてhomeに戻る
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            l10n.ok,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      // 「あとで」ボタン
                      SizedBox(
                        width: 280,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                            // 何もせずにhomeに戻る
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[300],
                            foregroundColor: Colors.black87,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            l10n.updateDialogLater,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

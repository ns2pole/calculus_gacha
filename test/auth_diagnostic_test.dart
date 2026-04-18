// test/auth_diagnostic_test.dart
// 認証機能の診断テスト - 「できたりできなかったり」問題の診断用
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:joymath/services/auth/firebase_auth_service.dart';
import 'dart:io';

/// 認証機能の診断結果
class AuthDiagnosticResult {
  final String method;
  final bool available;
  final String? error;
  final String? details;
  final DateTime timestamp;

  AuthDiagnosticResult({
    required this.method,
    required this.available,
    this.error,
    this.details,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  @override
  String toString() {
    final status = available ? '✅' : '❌';
    final errorText = error != null ? ' (Error: $error)' : '';
    final detailsText = details != null ? ' - $details' : '';
    return '$status $method: ${available ? "Available" : "Not Available"}$errorText$detailsText';
  }
}

void main() {
  // Flutter bindingの初期化（Firebase初期化に必要）
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Authentication Diagnostic Tests', () {
    List<AuthDiagnosticResult> diagnosticResults = [];

    setUpAll(() async {
      try {
        // 既に初期化されている場合はスキップ
        if (Firebase.apps.isEmpty) {
          await Firebase.initializeApp();
        }
        print('✅ Firebase initialized for diagnostics');
      } catch (e) {
        print('❌ Firebase initialization failed: $e');
        print('⚠️ Make sure Firebase configuration files are present:');
        print('   - Android: android/app/google-services.json');
        print('   - iOS: ios/GoogleService-Info.plist');
      }
    });

    test('Platform Information', () {
      print('\n📱 Platform Information:');
      print('   OS: ${Platform.operatingSystem}');
      print('   Version: ${Platform.operatingSystemVersion}');
      print('   Android: ${Platform.isAndroid}');
      print('   iOS: ${Platform.isIOS}');
    });

    test('Firebase Configuration Check', () {
      print('\n🔥 Firebase Configuration:');
      final apps = Firebase.apps;
      print('   Apps initialized: ${apps.length}');
      
      for (final app in apps) {
        print('   - App name: ${app.name}');
        print('   - Options: ${app.options.projectId}');
      }

      final result = AuthDiagnosticResult(
        method: 'Firebase Initialization',
        available: apps.isNotEmpty,
        details: apps.isNotEmpty 
          ? '${apps.length} app(s) initialized' 
          : 'No Firebase apps found',
      );
      diagnosticResults.add(result);
      print('   $result');
    });

    test('Google Sign-In Diagnostic', () async {
      print('\n🔵 Google Sign-In:');
      
      try {
        await FirebaseAuthService.signOut();
        print('   Testing Google Sign-In...');
        final startTime = DateTime.now();
        final result = await FirebaseAuthService.signInWithGoogle();
        final duration = DateTime.now().difference(startTime);
        
        if (result != null && result.user != null) {
          final user = result.user!;
          print('   ✅ Success');
          print('   User ID: ${user.uid}');
          print('   Email: ${user.email ?? "N/A"}');
          print('   Display Name: ${user.displayName ?? "N/A"}');
          print('   Duration: ${duration.inMilliseconds}ms');
          
          diagnosticResults.add(AuthDiagnosticResult(
            method: 'Google Sign-In',
            available: true,
            details: 'Email: ${user.email ?? "N/A"}',
          ));
        } else {
          print('   ⚠️ Returned null (user may have cancelled)');
          diagnosticResults.add(AuthDiagnosticResult(
            method: 'Google Sign-In',
            available: false,
            error: 'User cancelled or not available',
            details: 'This may be expected in test environment',
          ));
        }
      } catch (e, stackTrace) {
        print('   ❌ Error: $e');
        print('   Stack trace: ${stackTrace.toString().split("\n").take(3).join("\n")}');
        diagnosticResults.add(AuthDiagnosticResult(
          method: 'Google Sign-In',
          available: false,
          error: e.toString(),
        ));
      }
    });

    test('Apple Sign-In Diagnostic', () async {
      print('\n🍎 Apple Sign-In:');
      
      // プラットフォームチェック
      if (!Platform.isIOS && !Platform.isAndroid) {
        print('   ⚠️ Apple Sign-In is only available on iOS and Android');
        diagnosticResults.add(AuthDiagnosticResult(
          method: 'Apple Sign-In',
          available: false,
          error: 'Platform not supported',
        ));
        return;
      }

      try {
        await FirebaseAuthService.signOut();
        print('   Testing Apple Sign-In...');
        final startTime = DateTime.now();
        final result = await FirebaseAuthService.signInWithApple();
        final duration = DateTime.now().difference(startTime);
        
        if (result != null && result.user != null) {
          final user = result.user!;
          print('   ✅ Success');
          print('   User ID: ${user.uid}');
          print('   Email: ${user.email ?? "N/A"}');
          print('   Duration: ${duration.inMilliseconds}ms');
          
          diagnosticResults.add(AuthDiagnosticResult(
            method: 'Apple Sign-In',
            available: true,
            details: 'Email: ${user.email ?? "N/A"}',
          ));
        } else {
          print('   ⚠️ Returned null (user may have cancelled or not available)');
          diagnosticResults.add(AuthDiagnosticResult(
            method: 'Apple Sign-In',
            available: false,
            error: 'User cancelled or not available',
            details: Platform.isAndroid 
              ? 'Check Web client ID configuration in Firebase Console'
              : 'This may be expected in test environment',
          ));
        }
      } catch (e, stackTrace) {
        print('   ❌ Error: $e');
        print('   Stack trace: ${stackTrace.toString().split("\n").take(5).join("\n")}');
        
        String? errorDetails;
        final errorString = e.toString();
        if (errorString.contains('CONFIGURATION_NOT_FOUND')) {
          errorDetails = 'Apple Sign-In not configured in Firebase Console';
        } else if (errorString.contains('invalid') && errorString.contains('client')) {
          errorDetails = 'Invalid Web client ID - check Firebase Console';
        } else if (errorString.contains('invalid-credential')) {
          errorDetails = 'Invalid credential - check bundle ID and Firebase configuration';
        }
        
        diagnosticResults.add(AuthDiagnosticResult(
          method: 'Apple Sign-In',
          available: false,
          error: e.toString(),
          details: errorDetails,
        ));
      }
    });

    test('SMS/Phone Authentication Diagnostic', () async {
      print('\n📱 SMS/Phone Authentication:');
      
      try {
        String? verificationId;
        bool codeSent = false;
        String? errorMessage;
        
        print('   Testing phone number verification...');
        final startTime = DateTime.now();
        
        await FirebaseAuthService.verifyPhoneNumber(
          phoneNumber: '+81901234567', // テスト用電話番号
          codeSent: (id) {
            verificationId = id;
            codeSent = true;
            print('   ✅ Code sent callback received');
            print('   Verification ID: ${id.substring(0, 20)}...');
          },
          verificationFailed: (error) {
            errorMessage = error;
            print('   ❌ Verification failed: $error');
          },
        );
        
        // コールバックが呼ばれるまで待つ
        await Future.delayed(const Duration(seconds: 3));
        final duration = DateTime.now().difference(startTime);
        
        if (codeSent && verificationId != null) {
          print('   ✅ Phone verification initiated');
          print('   Duration: ${duration.inMilliseconds}ms');
          
          diagnosticResults.add(AuthDiagnosticResult(
            method: 'SMS Phone Verification',
            available: true,
            details: 'Verification ID received',
          ));
        } else if (errorMessage != null) {
          print('   ❌ Phone verification failed');
          diagnosticResults.add(AuthDiagnosticResult(
            method: 'SMS Phone Verification',
            available: false,
            error: errorMessage,
            details: 'Check Firebase Console phone authentication settings',
          ));
        } else {
          print('   ⚠️ No response (may be expected in test environment)');
          diagnosticResults.add(AuthDiagnosticResult(
            method: 'SMS Phone Verification',
            available: false,
            error: 'No response received',
            details: 'May require actual device and phone number',
          ));
        }
      } catch (e, stackTrace) {
        print('   ❌ Error: $e');
        diagnosticResults.add(AuthDiagnosticResult(
          method: 'SMS Phone Verification',
          available: false,
          error: e.toString(),
        ));
      }
    });

    test('Linking Diagnostic', () async {
      print('\n🔗 Account Linking:');
      print('   ⚠️ Account linking has been removed (anonymous authentication was deprecated)');
      diagnosticResults.add(AuthDiagnosticResult(
        method: 'Account Linking',
        available: false,
        error: 'Deprecated',
        details: 'Anonymous authentication and linking features have been removed',
      ));
    });

    test('Summary Report', () {
      print('\n📊 Diagnostic Summary:');
      print('=' * 60);
      
      final availableCount = diagnosticResults.where((r) => r.available).length;
      final totalCount = diagnosticResults.length;
      
      print('Total tests: $totalCount');
      print('Available: $availableCount');
      print('Not available: ${totalCount - availableCount}');
      print('');
      
      for (final result in diagnosticResults) {
        print(result.toString());
      }
      
      print('=' * 60);
      
      // 推奨事項
      print('\n💡 Recommendations:');
      final failedMethods = diagnosticResults.where((r) => !r.available).toList();
      
      if (failedMethods.isEmpty) {
        print('   ✅ All authentication methods are working correctly!');
      } else {
        for (final failed in failedMethods) {
          print('   ⚠️ ${failed.method}:');
          if (failed.error != null) {
            print('      Error: ${failed.error}');
          }
          if (failed.details != null) {
            print('      Details: ${failed.details}');
          }
          
          // プラットフォーム固有の推奨事項
          if (failed.method.contains('Apple') && Platform.isAndroid) {
            print('      → Check Web client ID in Firebase Console > Authentication > Sign-in method > Apple');
            print('      → Verify redirect URI matches Firebase Console settings');
          }
          if (failed.method.contains('Google')) {
            print('      → Check Google Sign-In configuration in Firebase Console');
            print('      → Verify SHA-1/SHA-256 fingerprints are registered (Android)');
            print('      → Verify URL scheme is registered in Info.plist (iOS)');
          }
          if (failed.method.contains('SMS') || failed.method.contains('Phone')) {
            print('      → Check Phone authentication is enabled in Firebase Console');
            print('      → Verify reCAPTCHA is configured (Android)');
            print('      → Test with actual device and phone number');
          }
        }
      }
    });
  });
}


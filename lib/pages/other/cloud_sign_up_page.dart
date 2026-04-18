// lib/pages/other/cloud_sign_up_page.dart
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../l10n/app_localizations.dart';
import '../../services/auth/firebase_auth_service.dart';
import '../../services/problems/simple_data_manager.dart';
import '../../widgets/home/background_image_widget.dart';

/// クラウド新規登録ページ
/// 3つの認証方法から選択できる（iOSなら4つ）
class CloudSignUpPage extends StatefulWidget {
  const CloudSignUpPage({super.key});

  @override
  State<CloudSignUpPage> createState() => _CloudSignUpPageState();
}

class _CloudSignUpPageState extends State<CloudSignUpPage> {
  // 電話番号認証用
  final _phoneController = TextEditingController();
  final _smsCodeController = TextEditingController();
  final _phoneFormKey = GlobalKey<FormState>();
  final _smsFormKey = GlobalKey<FormState>();
  bool _isPhoneAuth = false;
  bool _isSmsCodeSent = false;
  String? _verificationId;
  
  // メール/パスワード新規登録用
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFormKey = GlobalKey<FormState>();
  bool _isEmailAuth = false;
  bool _obscurePassword = true;
  
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _phoneController.dispose();
    _smsCodeController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _onAuthSuccess(String method) async {
    // バックグラウンドで同期処理を実行
    _syncDataInBackground();
    
    // 成功メッセージを表示してhomeに戻る
    if (mounted) {
      final l10n = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.auth_signUpSuccess(method)),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.of(context).pop(); // CloudBackupConfirmationPageに戻る
      Navigator.of(context).pop(); // homeに戻る
    }
  }

  Future<void> _syncDataInBackground() async {
    try {
      // UIが先に表示されるように、同期処理を遅延実行
      // これにより、ログイン後の画面遷移がスムーズに行われる
      await Future.delayed(const Duration(seconds: 2));
      
      // 認証状態が確実に反映されるまで待機
      // 最大1秒まで待機
      int waitCount = 0;
      const maxWaitCount = 10; // 100ms × 10 = 1秒
      while (!FirebaseAuthService.isAuthenticated && waitCount < maxWaitCount) {
        await Future.delayed(const Duration(milliseconds: 100));
        waitCount++;
      }
      
      if (!FirebaseAuthService.isAuthenticated) {
        print('Warning: Authentication state not ready after waiting, skipping sync');
        return;
      }
      
      // UIスレッドに制御を戻す
      await Future.delayed(Duration.zero);
      
      // アカウント切り替えを検知
      final isAccountSwitched = await SimpleDataManager.isAccountSwitched();
      
      // UIスレッドに制御を戻す
      await Future.delayed(const Duration(milliseconds: 50));
      
      if (isAccountSwitched) {
        // アカウント切り替え時：ローカルデータとFirestoreデータをタイムスタンプベースでマージ
        // history配列はtimeフィールドで重複チェックしながら統合される
        print('Account switch detected, merging local and Firestore data...');
        await SimpleDataManager.syncOnAccountSwitch();
        
        // UIスレッドに制御を戻す
        await Future.delayed(const Duration(milliseconds: 50));
      } else {
        // 通常のクラウドに保存時：ローカルデータと設定をFirestoreに同期
        // （既存のアカウントでクラウドに保存した場合）
        await SimpleDataManager.syncLocalDataToFirestore();
        
        // UIスレッドに制御を戻す
        await Future.delayed(const Duration(milliseconds: 50));
        
        await SimpleDataManager.syncLocalSettingsToFirestore();
        
        // UIスレッドに制御を戻す
        await Future.delayed(const Duration(milliseconds: 50));
        
        // Firestoreから既存データを取得してマージ
        await SimpleDataManager.initialize();
        
        // UIスレッドに制御を戻す
        await Future.delayed(const Duration(milliseconds: 50));
        
        // 現在のユーザーIDを保存（次回のアカウント切り替え検知用）
        final currentUserId = FirebaseAuthService.userId;
        if (currentUserId != null) {
          await SimpleDataManager.setLastUserId(currentUserId);
        }
      }
      
      print('Background sync completed');
    } catch (e) {
      print('Error in background sync: $e');
      // エラーが発生してもユーザーには影響しない（バックグラウンド処理のため）
    }
  }

  Future<void> _signInWithGoogle() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final userCredential = await FirebaseAuthService.signInWithGoogle();
      if (userCredential != null) {
        await _onAuthSuccess(AppLocalizations.of(context)!.auth_methodGoogle);
      } else {
        setState(() {
          final l10n = AppLocalizations.of(context)!;
          _errorMessage = l10n.auth_googleSignInFailed;
        });
      }
    } catch (e) {
      final l10n = AppLocalizations.of(context)!;
      String errorMsg = l10n.auth_googleSignInFailed;
      if (e.toString().contains('credential-already-in-use')) {
        errorMsg = l10n.auth_credentialAlreadyInUse;
      } else if (e.toString().contains('account-exists-with-different-credential')) {
        errorMsg = l10n.auth_credentialAlreadyInUse;
      } else if (e.toString().contains('network')) {
        errorMsg = l10n.auth_networkErrorCheckConnection;
      } else {
        errorMsg = l10n.auth_unexpectedError(e.toString());
      }
      setState(() {
        _errorMessage = errorMsg;
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _signInWithApple() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final userCredential = await FirebaseAuthService.signInWithApple();
      if (userCredential != null) {
        await _onAuthSuccess(AppLocalizations.of(context)!.auth_methodApple);
      } else {
        setState(() {
          final l10n = AppLocalizations.of(context)!;
          _errorMessage = l10n.auth_appleSignInFailedEnsureEnabled;
        });
      }
    } on FirebaseAuthException catch (e) {
      // FirebaseAuthExceptionのエラーコードを適切に処理
      final l10n = AppLocalizations.of(context)!;
      String errorMsg = l10n.auth_appleSignInFailed;
      
      switch (e.code) {
        case 'invalid-credential':
          errorMsg = l10n.auth_invalidCredentialTryAgain;
          break;
        case 'invalid-id-token':
          errorMsg = l10n.auth_invalidIdTokenTryAgain;
          break;
        case 'credential-already-in-use':
          errorMsg = l10n.auth_credentialAlreadyInUse;
          break;
        case 'account-exists-with-different-credential':
          errorMsg = l10n.auth_credentialAlreadyInUse;
          break;
        case 'operation-not-allowed':
          errorMsg = l10n.auth_operationNotAllowed;
          break;
        default:
          // エラーコードとメッセージを含めた詳細なメッセージ
          errorMsg = l10n.auth_unexpectedError('${e.code}: ${e.message ?? "no details"}');
          break;
      }
      
      setState(() {
        _errorMessage = errorMsg;
      });
    } catch (e) {
      final l10n = AppLocalizations.of(context)!;
      String errorMsg = l10n.auth_appleSignInFailed;
      if (e.toString().contains('CONFIGURATION_NOT_FOUND') || 
          e.toString().contains('17999')) {
        errorMsg = l10n.auth_appleSignInNotConfigured;
      } else if (e.toString().contains('credential-already-in-use')) {
        errorMsg = l10n.auth_credentialAlreadyInUse;
      } else if (e.toString().contains('account-exists-with-different-credential')) {
        errorMsg = l10n.auth_credentialAlreadyInUse;
      } else {
        errorMsg = l10n.auth_unexpectedError(e.toString());
      }
      setState(() {
        _errorMessage = errorMsg;
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _sendSmsCode() async {
    if (!_phoneFormKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      String phoneNumber = _phoneController.text.trim();
      // 電話番号が+で始まっていない場合は+を追加（日本の場合）
      if (!phoneNumber.startsWith('+')) {
        phoneNumber = phoneNumber.replaceAll(RegExp(r'[-\s]'), '');
        if (phoneNumber.startsWith('0')) {
          phoneNumber = '+81${phoneNumber.substring(1)}';
        } else {
          phoneNumber = '+81$phoneNumber';
        }
      }

      await FirebaseAuthService.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        codeSent: (String verificationId) {
          setState(() {
            _verificationId = verificationId;
            _isSmsCodeSent = true;
            _isLoading = false;
          });
        },
        verificationFailed: (String error) {
          setState(() {
            _errorMessage = error;
            _isLoading = false;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          setState(() {
            _verificationId = verificationId;
          });
        },
      );
    } catch (e) {
      setState(() {
        _errorMessage = AppLocalizations.of(context)!.errorOccurred(e.toString());
        _isLoading = false;
      });
    }
  }

  Future<void> _verifySmsCode() async {
    if (!_smsFormKey.currentState!.validate()) {
      return;
    }

    if (_verificationId == null) {
      setState(() {
        _errorMessage = AppLocalizations.of(context)!.auth_invalidVerificationId;
      });
      return;
    }

    final l10n = AppLocalizations.of(context)!;

    // Android の SMS 自動検証で先にサインイン済みのとき、手動確認で session-expired になるだけなら成功扱い
    if (FirebaseAuthService.isAuthenticated &&
        (FirebaseAuthService.currentUser?.phoneNumber ?? '').isNotEmpty) {
      await _onAuthSuccess(l10n.auth_methodPhone);
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final userCredential = await FirebaseAuthService.signInWithPhoneNumber(
        verificationId: _verificationId!,
        smsCode: _smsCodeController.text.trim(),
      );

      if (userCredential != null) {
        await _onAuthSuccess(l10n.auth_methodPhone);
      } else {
        setState(() {
          _errorMessage = l10n.auth_smsVerificationFailed;
        });
      }
    } on FirebaseAuthException catch (e) {
      String errorMsg = l10n.auth_smsVerificationFailed;
      if (e.code == 'invalid-verification-code') {
        errorMsg = l10n.auth_invalidVerificationCode;
      } else if (e.code == 'session-expired') {
        if (FirebaseAuthService.isAuthenticated) {
          await _onAuthSuccess(l10n.auth_methodPhone);
          return;
        }
        errorMsg = l10n.auth_sessionExpired;
      } else if (e.code == 'credential-already-in-use') {
        errorMsg = l10n.auth_phoneAlreadyInUse;
      }
      setState(() {
        _errorMessage = errorMsg;
      });
    } catch (e) {
      if (e.toString().contains('session-expired') &&
          FirebaseAuthService.isAuthenticated) {
        await _onAuthSuccess(l10n.auth_methodPhone);
        return;
      }
      setState(() {
        _errorMessage = l10n.auth_unexpectedError(e.toString());
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _signUpWithEmailAndPassword() async {
    if (!_emailFormKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final userCredential = await FirebaseAuthService.signUpWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (userCredential != null) {
        await _onAuthSuccess(AppLocalizations.of(context)!.auth_methodEmail);
      } else {
        setState(() {
          _errorMessage = AppLocalizations.of(context)!.auth_signUpFailed;
        });
      }
    } on FirebaseAuthException catch (e) {
      final l10n = AppLocalizations.of(context)!;
      String errorMsg = l10n.auth_signUpFailed;
      switch (e.code) {
        case 'email-already-in-use':
          errorMsg = l10n.auth_emailAlreadyInUse;
          break;
        case 'weak-password':
          errorMsg = l10n.auth_weakPassword;
          break;
        case 'invalid-email':
          errorMsg = l10n.auth_invalidEmail;
          break;
        case 'operation-not-allowed':
          errorMsg = l10n.auth_operationNotAllowed;
          break;
        default:
          errorMsg = l10n.auth_unexpectedError('${e.code}: ${e.message ?? "no details"}');
      }
      setState(() {
        _errorMessage = errorMsg;
      });
    } catch (e) {
      setState(() {
        _errorMessage = AppLocalizations.of(context)!.auth_unexpectedError(e.toString());
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

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
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    // タイトル
                    Text(
                      l10n.syncWithCloud,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 48),
                    
                    // 電話番号認証のUI
                    if (_isPhoneAuth) ...[
                      Form(
                        key: _phoneFormKey,
                        child: Column(
                          children: [
                            if (!_isSmsCodeSent) ...[
                              TextFormField(
                                controller: _phoneController,
                                decoration: InputDecoration(
                                  labelText: l10n.auth_phoneNumberLabel,
                                  hintText: l10n.auth_phoneNumberHint,
                                  border: const OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.phone,
                                enabled: !_isLoading,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return l10n.auth_phoneNumberRequired;
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 24),
                              SizedBox(
                                width: double.infinity,
                                height: 56,
                                child: ElevatedButton(
                                  onPressed: _isLoading ? null : _sendSmsCode,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    foregroundColor: Colors.white,
                                  ),
                                  child: _isLoading
                                      ? const SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                          ),
                                        )
                                      : Text(
                                          l10n.auth_sendSmsCodeButton,
                                          style: const TextStyle(fontSize: 18),
                                        ),
                                ),
                              ),
                            ] else ...[
                              Form(
                                key: _smsFormKey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: _smsCodeController,
                                      decoration: InputDecoration(
                                        labelText: l10n.auth_smsCodeLabel,
                                        hintText: l10n.auth_smsCodeHint,
                                        border: const OutlineInputBorder(),
                                      ),
                                      keyboardType: TextInputType.number,
                                      enabled: !_isLoading,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return l10n.auth_smsCodeRequired;
                                        }
                                        if (value.length != 6) {
                                          return l10n.auth_smsCodeLength;
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 24),
                                    SizedBox(
                                      width: double.infinity,
                                      height: 56,
                                      child: ElevatedButton(
                                        onPressed: _isLoading ? null : _verifySmsCode,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue,
                                          foregroundColor: Colors.white,
                                        ),
                                        child: _isLoading
                                            ? const SizedBox(
                                                width: 20,
                                                height: 20,
                                                child: CircularProgressIndicator(
                                                  strokeWidth: 2,
                                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                                ),
                                              )
                                            : Text(
                                                l10n.auth_verifyButton,
                                                style: const TextStyle(fontSize: 18),
                                              ),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    TextButton(
                                      onPressed: _isLoading
                                          ? null
                                          : () {
                                              setState(() {
                                                _isSmsCodeSent = false;
                                                _smsCodeController.clear();
                                                _errorMessage = null;
                                              });
                                            },
                                      child: Text(l10n.auth_changePhoneNumberButton),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                            const SizedBox(height: 16),
                            TextButton(
                              onPressed: _isLoading
                                  ? null
                                  : () {
                                      setState(() {
                                        _isPhoneAuth = false;
                                        _isSmsCodeSent = false;
                                        _phoneController.clear();
                                        _smsCodeController.clear();
                                        _errorMessage = null;
                                      });
                                    },
                              child: Text(l10n.auth_backButton),
                            ),
                          ],
                        ),
                      ),
                    ]
                    // メール/パスワード新規登録のUI
                    else if (_isEmailAuth) ...[
                      Form(
                        key: _emailFormKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                labelText: l10n.auth_emailLabel,
                                border: const OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              enabled: !_isLoading,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return l10n.auth_emailRequired;
                                }
                                if (!value.contains('@')) {
                                  return l10n.auth_invalidEmail;
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _passwordController,
                              decoration: InputDecoration(
                                labelText: l10n.auth_passwordLabel,
                                border: const OutlineInputBorder(),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword ? Icons.visibility : Icons.visibility_off,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                ),
                              ),
                              obscureText: _obscurePassword,
                              enabled: !_isLoading,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return l10n.auth_passwordRequired;
                                }
                                if (value.length < 6) {
                                  return l10n.auth_passwordTooShort;
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 24),
                            SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: ElevatedButton(
                                onPressed: _isLoading ? null : _signUpWithEmailAndPassword,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  foregroundColor: Colors.white,
                                ),
                                child: _isLoading
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                        ),
                                      )
                                    : Text(
                                        l10n.auth_signUpButton,
                                        style: const TextStyle(fontSize: 18),
                                      ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextButton(
                              onPressed: _isLoading
                                  ? null
                                  : () {
                                      setState(() {
                                        _isEmailAuth = false;
                                        _emailController.clear();
                                        _passwordController.clear();
                                        _errorMessage = null;
                                      });
                                    },
                              child: Text(l10n.auth_backButton),
                            ),
                          ],
                        ),
                      ),
                    ]
                    // 認証方法選択画面
                    else ...[
                      // エラーメッセージ
                      if (_errorMessage != null) ...[
                        Container(
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.only(bottom: 24),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            border: Border.all(color: Colors.red.shade300),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            _errorMessage!,
                            style: TextStyle(color: Colors.red.shade900),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                      
                      // 1. 電話番号でクラウドに保存
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: _isLoading
                              ? null
                              : () {
                                  setState(() {
                                    _isPhoneAuth = true;
                                    _errorMessage = null;
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
                            l10n.auth_phoneSignInButton,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // 2. メールアドレスでクラウドに保存
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: _isLoading
                              ? null
                              : () {
                                  setState(() {
                                    _isEmailAuth = true;
                                    _errorMessage = null;
                                  });
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            l10n.auth_emailSignInButton,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // 3. Googleでクラウドに保存
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _signInWithGoogle,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black87,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(color: Colors.grey.shade300),
                            ),
                          ),
                          child: _isLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black87),
                                  ),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.g_mobiledata, size: 24),
                                    const SizedBox(width: 8),
                                    Text(
                                      l10n.auth_googleSignInButton,
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                      
                      // 4. iOSのみAppleアカウントでクラウドに保存
                      if (Platform.isIOS) ...[
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _signInWithApple,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: _isLoading
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                    ),
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.apple, size: 24),
                                      const SizedBox(width: 8),
                                      Text(
                                        l10n.auth_appleSignInButton,
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ],
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

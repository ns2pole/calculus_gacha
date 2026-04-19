// lib/pages/auth_page.dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../../l10n/app_localizations.dart';
import '../../services/auth/firebase_auth_service.dart';
import '../../services/problems/simple_data_manager.dart';
import '../../utils/l10n_utils.dart';
import '../../utils/responsive_layout.dart';

class AuthPage extends StatefulWidget {
  final bool isInitialSignUp;
  
  const AuthPage({
    super.key,
    this.isInitialSignUp = false,
  });

  @override
  State<AuthPage> createState() => _AuthPageState();
}

enum AuthMethod {
  none,
  phone,
  email,
  google,
  apple,
}

class _AuthPageState extends State<AuthPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _smsCodeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _phoneFormKey = GlobalKey<FormState>();
  final _smsFormKey = GlobalKey<FormState>();
  bool _isLoading = false;
  late bool _isSignUp;
  AuthMethod _selectedAuthMethod = AuthMethod.none;
  bool _isSmsCodeSent = false;
  bool _isPasswordResetMode = false;
  String? _errorMessage;
  String? _verificationId;
  
  @override
  void initState() {
    super.initState();
    // 初回登録フローの場合は新規登録モードで開始
    _isSignUp = widget.isInitialSignUp;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _smsCodeController.dispose();
    super.dispose();
  }

  Future<void> _sendPasswordResetEmail() async {
    if (_selectedAuthMethod != AuthMethod.email) {
      return;
    }
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final l10n = AppLocalizations.of(context)!;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await FirebaseAuthService.sendPasswordResetEmail(
        email: _emailController.text.trim(),
      );
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.auth_passwordResetEmailSent),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 4),
          ),
        );
        // パスワードリセットモードを解除
        setState(() {
          _isPasswordResetMode = false;
          _emailController.clear();
        });
      }
    } on FirebaseAuthException catch (e) {
      String errorMsg = l10n.auth_passwordResetFailed;
      switch (e.code) {
        case 'user-not-found':
          errorMsg = l10n.auth_userNotFound;
          break;
        case 'invalid-email':
          errorMsg = l10n.auth_invalidEmail;
          break;
        case 'too-many-requests':
          errorMsg = l10n.auth_tooManyRequests;
          break;
        default:
          errorMsg = '${l10n.auth_passwordResetFailed}: ${e.message ?? e.code}';
      }
      setState(() {
        _errorMessage = errorMsg;
      });
    } catch (e) {
      setState(() {
        _errorMessage = l10n.auth_unexpectedError(e.toString());
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _signInWithEmailAndPassword() async {
    if (_selectedAuthMethod != AuthMethod.email) {
      return;
    }
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final l10n = AppLocalizations.of(context)!;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      UserCredential? userCredential;
      
      if (_isSignUp) {
        userCredential = await FirebaseAuthService.signUpWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
      } else {
        userCredential = await FirebaseAuthService.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
      }

      if (userCredential != null) {
        // バックグラウンドで同期処理を実行（画面を閉じる前に開始）
        _syncDataInBackground();
        
        if (mounted) {
          // 成功メッセージを表示
          final loginMethod = FirebaseAuthService.loginMethod;
          final localizedMethod = getLocalizedLoginMethod(context, loginMethod ?? 'email');
          final message = _isSignUp 
              ? l10n.auth_signUpSuccess(localizedMethod)
              : l10n.auth_emailSignInSuccess(localizedMethod);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 2),
            ),
          );
          Navigator.of(context).pop(true);
        }
      } else {
        setState(() {
          _errorMessage = _isSignUp 
              ? l10n.auth_signUpFailed
              : l10n.auth_signInFailed;
        });
      }
    } on LoginLockedException catch (e) {
      // ログイン試行制限によるロックエラー
      String errorMsg;
      if (e.isPasswordResetRequired) {
        errorMsg = l10n.auth_lockMessageResetRequired;
      } else if (e.unlockTime != null) {
        final unlockTime = e.unlockTime!;
        final now = DateTime.now();
        final remainingMinutes = unlockTime.difference(now).inMinutes + 1;
        errorMsg = l10n.auth_lockMessageWait(remainingMinutes);
      } else {
        errorMsg = l10n.auth_lockTitle;
      }
      setState(() {
        _errorMessage = errorMsg;
      });
    } on FirebaseAuthException catch (e) {
      String errorMsg = '${l10n.errorOccurred(e.code)}: ${e.message ?? e.code}';
      // Firebase認証エラーを適切に処理
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
        case 'user-not-found':
          errorMsg = l10n.auth_userNotFound;
          break;
        case 'wrong-password':
        case 'invalid-credential':
          errorMsg = l10n.auth_wrongPassword;
          break;
        case 'credential-already-in-use':
          errorMsg = l10n.auth_credentialAlreadyInUse;
          break;
        case 'too-many-requests':
          errorMsg = l10n.auth_tooManyRequests;
          break;
        case 'operation-not-allowed':
          errorMsg = l10n.auth_operationNotAllowed;
          break;
        default:
          errorMsg = '${l10n.auth_signInFailed}: ${e.message ?? e.code}';
      }
      setState(() {
        _errorMessage = errorMsg;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _sendSmsCode() async {
    if (!_phoneFormKey.currentState!.validate()) {
      return;
    }

    final l10n = AppLocalizations.of(context)!;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      String phoneNumber = _phoneController.text.trim();
      // 電話番号が+で始まっていない場合は+を追加（日本の場合）
      if (!phoneNumber.startsWith('+')) {
        // 日本の電話番号として処理（090-1234-5678 や 09012345678 の形式）
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
          print('Phone verification failed in UI: $error');
          setState(() {
            _errorMessage = error;
            _isLoading = false;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Androidで自動取得がタイムアウトした場合
          setState(() {
            _verificationId = verificationId;
          });
        },
      );
    } catch (e) {
      setState(() {
        _errorMessage = '${l10n.auth_passwordResetFailed}: $e';
        _isLoading = false;
      });
    }
  }

  /// 電話番号ログイン成功時の共通処理（Android の自動検証で先にサインイン済みの場合もここへ集約）
  void _completePhoneSignInSuccess() {
    if (!mounted) return;
    setState(() => _errorMessage = null);
    _syncDataInBackground();
    final l10n = AppLocalizations.of(context)!;
    final loginMethod = FirebaseAuthService.loginMethod;
    final localizedMethod = getLocalizedLoginMethod(context, loginMethod ?? 'phone');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(l10n.auth_emailSignInSuccess(localizedMethod)),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
      ),
    );
    Navigator.of(context).pop(true);
  }

  Future<void> _verifySmsCode() async {
    if (!_smsFormKey.currentState!.validate()) {
      return;
    }

    final l10n = AppLocalizations.of(context)!;

    if (_verificationId == null) {
      setState(() {
        _errorMessage = l10n.auth_invalidVerificationId;
      });
      return;
    }

    // Android の SMS 自動検証で verifyPhoneNumber 内ですでにサインイン済みのとき、
    // 手動で確認すると検証セッションが無効化され session-expired になるだけなので成功扱いにする。
    if (FirebaseAuthService.isAuthenticated &&
        (FirebaseAuthService.currentUser?.phoneNumber ?? '').isNotEmpty) {
      _completePhoneSignInSuccess();
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
        _completePhoneSignInSuccess();
      } else {
        setState(() {
          _errorMessage = l10n.auth_smsVerificationFailed;
        });
      }
    } on FirebaseAuthException catch (e) {
      // Firebase認証エラーの詳細な処理
      String errorMsg = l10n.auth_smsVerificationFailed;
      
      print('FirebaseAuthException in _verifySmsCode:');
      print('  Code: ${e.code}');
      print('  Message: ${e.message}');
      
      switch (e.code) {
        case 'invalid-verification-code':
          errorMsg = l10n.auth_invalidVerificationCode;
          break;
        case 'invalid-verification-id':
          errorMsg = l10n.auth_invalidVerificationId;
          break;
        case 'session-expired':
          if (FirebaseAuthService.isAuthenticated) {
            _completePhoneSignInSuccess();
            return;
          }
          errorMsg = l10n.auth_sessionExpired;
          break;
        case 'credential-already-in-use':
          errorMsg = l10n.auth_phoneAlreadyInUse;
          break;
        case 'provider-already-linked':
          errorMsg = l10n.auth_providerAlreadyLinked;
          break;
        case 'too-many-requests':
          errorMsg = l10n.auth_tooManyRequests;
          break;
        case 'operation-not-allowed':
          errorMsg = l10n.auth_phoneAuthDisabled;
          break;
        default:
          errorMsg = '${l10n.auth_smsVerificationFailed}: ${e.code}\n${e.message ?? ""}';
      }
      
      setState(() {
        _errorMessage = errorMsg;
      });
    } catch (e, stackTrace) {
      // その他のエラー
      print('Unexpected error in _verifySmsCode: $e');
      print('Stack trace: $stackTrace');
      
      String errorMsg = l10n.auth_smsVerificationFailed;
      if (e.toString().contains('invalid-verification-code')) {
        errorMsg = l10n.auth_invalidVerificationCode;
      } else if (e.toString().contains('session-expired')) {
        if (FirebaseAuthService.isAuthenticated) {
          _completePhoneSignInSuccess();
          return;
        }
        errorMsg = l10n.auth_sessionExpired;
      } else if (e.toString().contains('credential-already-in-use')) {
        errorMsg = l10n.auth_phoneAlreadyInUse;
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

  void _resetAuthMethod() {
    setState(() {
      _selectedAuthMethod = AuthMethod.none;
      _isSmsCodeSent = false;
      _verificationId = null;
      _phoneController.clear();
      _smsCodeController.clear();
      _emailController.clear();
      _passwordController.clear();
      _errorMessage = null;
      _isPasswordResetMode = false;
    });
  }

  /// バックグラウンドでデータ同期を実行（認証成功後、画面を閉じた後に実行）
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
    final l10n = AppLocalizations.of(context)!;
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final userCredential = await FirebaseAuthService.signInWithGoogle();
      if (userCredential != null) {
        // バックグラウンドで同期処理を実行（画面を閉じる前に開始）
        _syncDataInBackground();
        
        if (mounted) {
          // 成功メッセージを表示
          final loginMethod = FirebaseAuthService.loginMethod;
          final localizedMethod = getLocalizedLoginMethod(context, loginMethod ?? 'google');
          final message = _isSignUp 
              ? l10n.auth_signUpSuccess(localizedMethod)
              : l10n.auth_emailSignInSuccess(localizedMethod);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 2),
            ),
          );
          Navigator.of(context).pop(true);
        }
      } else {
        setState(() {
          _errorMessage = l10n.auth_signInFailed;
        });
      }
    } catch (e) {
      String errorMsg = l10n.auth_signInFailed;
      // リンク時のエラーを適切に処理
      if (e.toString().contains('credential-already-in-use')) {
        errorMsg = l10n.auth_credentialAlreadyInUse;
      } else if (e.toString().contains('account-exists-with-different-credential')) {
        errorMsg = l10n.auth_credentialAlreadyInUse;
      } else if (e.toString().contains('network')) {
        errorMsg = l10n.auth_tooManyRequests;
      }
      setState(() {
        _errorMessage = errorMsg;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _signInWithApple() async {
    final l10n = AppLocalizations.of(context)!;
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final userCredential = await FirebaseAuthService.signInWithApple();
      if (userCredential != null) {
        // バックグラウンドで同期処理を実行（画面を閉じる前に開始）
        _syncDataInBackground();
        
        if (mounted) {
          // 成功メッセージを表示
          final loginMethod = FirebaseAuthService.loginMethod;
          final localizedMethod = getLocalizedLoginMethod(context, loginMethod ?? 'apple');
          final message = _isSignUp 
              ? l10n.auth_signUpSuccess(localizedMethod)
              : l10n.auth_emailSignInSuccess(localizedMethod);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 2),
            ),
          );
          Navigator.of(context).pop(true);
        }
      } else {
        setState(() {
          _errorMessage = l10n.auth_signInFailed;
        });
      }
    } on FirebaseAuthException catch (e) {
      // FirebaseAuthExceptionのエラーコードを適切に処理
      String errorMsg = l10n.auth_signInFailed;
      
      switch (e.code) {
        case 'invalid-credential':
        case 'invalid-id-token':
          errorMsg = l10n.auth_wrongPassword;
          break;
        case 'credential-already-in-use':
        case 'account-exists-with-different-credential':
          errorMsg = l10n.auth_credentialAlreadyInUse;
          break;
        case 'operation-not-allowed':
          errorMsg = l10n.auth_operationNotAllowed;
          break;
        default:
          errorMsg = '${l10n.auth_signInFailed}\n${e.code}\n${e.message ?? ""}';
          break;
      }
      
      setState(() {
        _errorMessage = errorMsg;
      });
    } catch (e) {
      String errorMsg = l10n.auth_signInFailed;
      if (e.toString().contains('CONFIGURATION_NOT_FOUND') || 
          e.toString().contains('17999')) {
        errorMsg = l10n.auth_operationNotAllowed;
      } else if (e.toString().contains('credential-already-in-use')) {
        errorMsg = l10n.auth_credentialAlreadyInUse;
      } else if (e.toString().contains('account-exists-with-different-credential')) {
        errorMsg = l10n.auth_credentialAlreadyInUse;
      }
      setState(() {
        _errorMessage = errorMsg;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// Firebaseが初期化されているか確認
  bool get _isFirebaseAvailable {
    try {
      return Firebase.apps.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isFirebaseAvailable = _isFirebaseAvailable;
    final l10n = AppLocalizations.of(context)!;
    final responsive = context.appResponsive;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: null,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: ResponsiveContentFrame(
        maxWidth: responsive.isPhone ? 520 : 640,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 32),
              
              // Firebaseが利用できない場合の警告
              if (!isFirebaseAvailable) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    border: Border.all(color: Colors.orange.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.warning_amber, color: Colors.orange.shade700, size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              l10n.auth_firebaseNotConfigured,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.orange.shade900,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        l10n.auth_firebaseConfigGuide,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.orange.shade900,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              
              const SizedBox(height: 32),
              
              // エラーメッセージ
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ),
              
              // 認証方法選択画面
              if (_selectedAuthMethod == AuthMethod.none) ...[
                // 1. 電話番号でクラウドに保存
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: (_isLoading || !isFirebaseAvailable)
                        ? null
                        : () {
                            setState(() {
                              _selectedAuthMethod = AuthMethod.phone;
                              _errorMessage = null;
                            });
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(l10n.auth_phoneSignInButton),
                  ),
                ),
                const SizedBox(height: 16),
                
                // 2. メールアドレスでクラウドに保存
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: (_isLoading || !isFirebaseAvailable)
                        ? null
                        : () {
                            setState(() {
                              _selectedAuthMethod = AuthMethod.email;
                              _errorMessage = null;
                            });
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(l10n.auth_emailSignInButton),
                  ),
                ),
                const SizedBox(height: 16),
                
                // 3. Googleでクラウドに保存
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: (_isLoading || !isFirebaseAvailable) ? null : _signInWithGoogle,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black87,
                      side: BorderSide(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.g_mobiledata, size: 24),
                        const SizedBox(width: 8),
                        Flexible(child: Text(l10n.auth_googleSignInButton)),
                      ],
                    ),
                  ),
                ),
                
                // 4. iOSのみAppleアカウントでクラウドに保存
                if (!kIsWeb && defaultTargetPlatform == TargetPlatform.iOS) ...[
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: (_isLoading || !isFirebaseAvailable) ? null : _signInWithApple,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.apple, size: 24),
                          const SizedBox(width: 8),
                          Flexible(child: Text(l10n.auth_appleSignInButton)),
                        ],
                      ),
                    ),
                  ),
                ],
              ]
              
              // メールアドレス認証フォーム
              else if (_selectedAuthMethod == AuthMethod.email) ...[
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      // パスワードフィールド（パスワードリセットモードでない場合のみ表示）
                      if (!_isPasswordResetMode) ...[
                        TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: l10n.auth_passwordLabel,
                            border: const OutlineInputBorder(),
                          ),
                          obscureText: true,
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
                        // 通常のログイン/新規登録モード
                        ElevatedButton(
                          onPressed: (_isLoading || !isFirebaseAvailable) ? null : _signInWithEmailAndPassword,
                          child: Text(_isSignUp ? l10n.auth_signUpButton : l10n.auth_signInButton),
                        ),
                        const SizedBox(height: 8),
                        // パスワードリセットボタン（ログインモードの場合のみ表示）
                        if (!_isSignUp)
                          TextButton(
                            onPressed: _isLoading
                                ? null
                                : () {
                                    setState(() {
                                      _isPasswordResetMode = true;
                                      _passwordController.clear();
                                      _errorMessage = null;
                                    });
                                  },
                            child: Text(l10n.auth_forgotPassword),
                          ),
                        // サインアップ/クラウドに保存切り替え（初回登録フローの場合は表示しない）
                        if (!widget.isInitialSignUp)
                          TextButton(
                            onPressed: _isLoading
                                ? null
                                : () {
                                    setState(() {
                                      _isSignUp = !_isSignUp;
                                      _isPasswordResetMode = false;
                                      _errorMessage = null;
                                    });
                                  },
                            child: Text(_isSignUp
                                ? l10n.auth_alreadyHaveAccount
                                : l10n.auth_createNewAccount),
                          ),
                      ] else ...[
                        // パスワードリセットモードの場合
                        ElevatedButton(
                          onPressed: (_isLoading || !isFirebaseAvailable) ? null : _sendPasswordResetEmail,
                          child: Text(l10n.auth_sendResetEmailButton),
                        ),
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: _isLoading
                              ? null
                              : () {
                                  setState(() {
                                    _isPasswordResetMode = false;
                                    _errorMessage = null;
                                  });
                                },
                          child: Text(l10n.auth_backButton),
                        ),
                      ],
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: _isLoading ? null : _resetAuthMethod,
                        child: Text(l10n.auth_backButton),
                      ),
                    ],
                  ),
                ),
              ]
              
              // 電話番号認証フォーム
              else if (_selectedAuthMethod == AuthMethod.phone) ...[
                if (!_isSmsCodeSent) ...[
                  // 電話番号入力フォーム
                  Form(
                    key: _phoneFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          controller: _phoneController,
                          decoration: InputDecoration(
                            labelText: l10n.auth_phoneNumberLabel,
                            hintText: l10n.auth_phoneNumberHint,
                            border: const OutlineInputBorder(),
                            prefixIcon: const Icon(Icons.phone),
                          ),
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return l10n.auth_phoneNumberRequired;
                            }
                            // 基本的な電話番号形式チェック
                            final cleaned = value.replaceAll(RegExp(r'[-\s]'), '');
                            if (cleaned.length < 10) {
                              return l10n.auth_invalidPhoneNumber;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: (_isLoading || !isFirebaseAvailable) ? null : _sendSmsCode,
                          child: Text(l10n.auth_sendSmsCodeButton),
                        ),
                      ],
                    ),
                  ),
                ] else ...[
                  // SMSコード入力フォーム
                  Form(
                    key: _smsFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          l10n.auth_enterSmsCode,
                          style: Theme.of(context).textTheme.titleMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          l10n.auth_smsCodeSentTo(_phoneController.text),
                          style: Theme.of(context).textTheme.bodySmall,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _smsCodeController,
                          decoration: InputDecoration(
                            labelText: l10n.auth_smsCodeLabel,
                            hintText: l10n.auth_smsCodeHint,
                            border: const OutlineInputBorder(),
                            prefixIcon: const Icon(Icons.sms),
                          ),
                          keyboardType: TextInputType.number,
                          maxLength: 6,
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
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: (_isLoading || !isFirebaseAvailable) ? null : _verifySmsCode,
                          child: Text(l10n.auth_verifyButton),
                        ),
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: _isLoading ? null : _sendSmsCode,
                          child: Text(l10n.auth_resendCodeButton),
                        ),
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: _isLoading ? null : () {
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
                  onPressed: _isLoading ? null : _resetAuthMethod,
                  child: Text(l10n.auth_backButton),
                ),
              ],
              
              const SizedBox(height: 32),
              Text(
                l10n.auth_cloudSyncDescription,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
          ],
        ),
        ),
      ),
    );
  }
}


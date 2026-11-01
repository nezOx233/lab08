import 'package:flutter/material.dart';
import 'widgets/sign_in_screen.dart';
import 'widgets/sign_up_screen.dart';
import 'widgets/reset_password_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2563EB),
          primary: const Color(0xFF2563EB),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color(0xFFD1D5DB),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color(0xFF2563EB),
              width: 2,
            ),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2563EB),
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFF2563EB),
            minimumSize: const Size(double.infinity, 52),
            side: const BorderSide(
              color: Color(0xFF2563EB),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      home: const AuthScreen(),
    );
  }
}

enum AuthPage {
  login,
  register,
  recovery,
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  AuthPage currentPage = AuthPage.login;

  final loginKey = GlobalKey<FormState>();
  final registerKey = GlobalKey<FormState>();
  final recoveryKey = GlobalKey<FormState>();

  final loginEmail = TextEditingController();
  final loginPassword = TextEditingController();

  final registerName = TextEditingController();
  final registerEmail = TextEditingController();
  final registerPassword = TextEditingController();
  final confirmPassword = TextEditingController();

  final recoveryEmail = TextEditingController();

  bool showLoginPassword = false;
  bool showRegisterPassword = false;
  bool showConfirmPassword = false;

  String? savedName;
  String? savedEmail;
  String? savedPassword;

  @override
  void dispose() {
    loginEmail.dispose();
    loginPassword.dispose();
    registerName.dispose();
    registerEmail.dispose();
    registerPassword.dispose();
    confirmPassword.dispose();
    recoveryEmail.dispose();
    super.dispose();
  }

  void changePage(AuthPage page) {
    FocusScope.of(context).unfocus();

    setState(() {
      currentPage = page;
    });
  }

  void showMessage(String message, {bool error = false}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: error
            ? const Color(0xFFDC2626)
            : const Color(0xFF16A34A),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  String? validateEmail(String? value) {
    final email = value?.trim() ?? '';

    if (email.isEmpty) {
      return 'Введіть електронну пошту';
    }

    final pattern = RegExp(
      r'^[\w.+-]+@[\w.-]+\.[a-zA-Z]{2,}$',
    );

    if (!pattern.hasMatch(email)) {
      return 'Введіть правильну електронну пошту';
    }

    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Введіть пароль';
    }

    if (value.length < 6) {
      return 'Пароль повинен містити мінімум 6 символів';
    }

    return null;
  }

  void signIn() {
    if (!loginKey.currentState!.validate()) {
      return;
    }

    final email = loginEmail.text.trim();
    final password = loginPassword.text;

    if (savedEmail == null) {
      showMessage(
        'Спочатку створіть обліковий запис',
        error: true,
      );
      return;
    }

    if (email == savedEmail && password == savedPassword) {
      showMessage('Вітаємо, $savedName! Вхід успішний.');
    } else {
      showMessage(
        'Неправильна пошта або пароль',
        error: true,
      );
    }
  }

  void signUp() {
    if (!registerKey.currentState!.validate()) {
      return;
    }

    setState(() {
      savedName = registerName.text.trim();
      savedEmail = registerEmail.text.trim();
      savedPassword = registerPassword.text;

      loginEmail.text = savedEmail!;
      loginPassword.clear();

      currentPage = AuthPage.login;
    });

    showMessage('Реєстрація пройшла успішно!');
  }

  void resetPassword() {
    if (!recoveryKey.currentState!.validate()) {
      return;
    }

    final email = recoveryEmail.text.trim();

    if (savedEmail != null && email == savedEmail) {
      showMessage(
        'Запит на відновлення прийнято (демо-режим)',
      );

      changePage(AuthPage.login);
    } else {
      showMessage(
        'Обліковий запис із такою поштою не знайдено',
        error: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget page;

    switch (currentPage) {
      case AuthPage.login:
        page = SignInScreen(
          formKey: loginKey,
          emailController: loginEmail,
          passwordController: loginPassword,
          showPassword: showLoginPassword,
          onTogglePassword: () {
            setState(() {
              showLoginPassword = !showLoginPassword;
            });
          },
          validateEmail: validateEmail,
          validatePassword: validatePassword,
          onSignIn: signIn,
          onRegister: () => changePage(AuthPage.register),
          onForgotPassword: () {
            recoveryEmail.text = loginEmail.text;
            changePage(AuthPage.recovery);
          },
        );
        break;
      case AuthPage.register:
        page = SignUpScreen(
          formKey: registerKey,
          nameController: registerName,
          emailController: registerEmail,
          passwordController: registerPassword,
          confirmPasswordController: confirmPassword,
          showPassword: showRegisterPassword,
          showConfirmPassword: showConfirmPassword,
          onTogglePassword: () {
            setState(() {
              showRegisterPassword = !showRegisterPassword;
            });
          },
          onToggleConfirmPassword: () {
            setState(() {
              showConfirmPassword = !showConfirmPassword;
            });
          },
          validateEmail: validateEmail,
          validatePassword: validatePassword,
          onSignUp: signUp,
          onBack: () => changePage(AuthPage.login),
        );
        break;
      case AuthPage.recovery:
        page = ResetPasswordScreen(
          formKey: recoveryKey,
          emailController: recoveryEmail,
          validateEmail: validateEmail,
          onResetPassword: resetPassword,
          onBack: () => changePage(AuthPage.login),
        );
        break;
    }

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 400,
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
                child: Container(
                  key: ValueKey(currentPage),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 24,
                  ),
                  child: page,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

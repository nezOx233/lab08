import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.showPassword,
    required this.onTogglePassword,
    required this.validateEmail,
    required this.validatePassword,
    required this.onSignIn,
    required this.onRegister,
    required this.onForgotPassword,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool showPassword;
  final VoidCallback onTogglePassword;
  final FormFieldValidator<String> validateEmail;
  final FormFieldValidator<String> validatePassword;
  final VoidCallback onSignIn;
  final VoidCallback onRegister;
  final VoidCallback onForgotPassword;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AuthLogo(),
          const Text(
            'З поверненням!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Увійдіть до свого облікового запису',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 32),

          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            validator: validateEmail,
            decoration: const InputDecoration(
              labelText: 'Електронна пошта',
              prefixIcon: Icon(Icons.email_outlined),
            ),
          ),

          const SizedBox(height: 16),

          AuthPasswordField(
            controller: passwordController,
            label: 'Пароль',
            visible: showPassword,
            onToggle: onTogglePassword,
            validator: validatePassword,
          ),

          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: onForgotPassword,
              child: const Text('Забули пароль?'),
            ),
          ),

          const SizedBox(height: 12),

          ElevatedButton(
            onPressed: onSignIn,
            child: const Text('Увійти'),
          ),

          const SizedBox(height: 16),

          OutlinedButton(
            onPressed: onRegister,
            child: const Text('Створити обліковий запис'),
          ),
        ],
      ),
    );
  }
}

class AuthLogo extends StatelessWidget {
  const AuthLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const FlutterLogo(
          size: 85,
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

class AuthPasswordField extends StatelessWidget {
  const AuthPasswordField({
    super.key,
    required this.controller,
    required this.label,
    required this.visible,
    required this.onToggle,
    required this.validator,
  });

  final TextEditingController controller;
  final String label;
  final bool visible;
  final VoidCallback onToggle;
  final FormFieldValidator<String> validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: !visible,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: IconButton(
          onPressed: onToggle,
          icon: Icon(
            visible ? Icons.visibility_off : Icons.visibility,
          ),
        ),
      ),
    );
  }
}

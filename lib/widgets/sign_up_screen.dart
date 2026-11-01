import 'package:flutter/material.dart';
import 'sign_in_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.showPassword,
    required this.showConfirmPassword,
    required this.onTogglePassword,
    required this.onToggleConfirmPassword,
    required this.validateEmail,
    required this.validatePassword,
    required this.onSignUp,
    required this.onBack,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool showPassword;
  final bool showConfirmPassword;
  final VoidCallback onTogglePassword;
  final VoidCallback onToggleConfirmPassword;
  final FormFieldValidator<String> validateEmail;
  final FormFieldValidator<String> validatePassword;
  final VoidCallback onSignUp;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AuthLogo(),
          const Text(
            'Реєстрація',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Створіть свій обліковий запис',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 28),

          TextFormField(
            controller: nameController,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              labelText: "Ім'я",
              prefixIcon: Icon(Icons.person_outline),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "Введіть ім'я";
              }
              if (value.trim().length < 2) {
                return "Ім'я занадто коротке";
              }
              return null;
            },
          ),

          const SizedBox(height: 16),

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

          const SizedBox(height: 16),

          AuthPasswordField(
            controller: confirmPasswordController,
            label: 'Підтвердіть пароль',
            visible: showConfirmPassword,
            onToggle: onToggleConfirmPassword,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Підтвердіть пароль';
              }
              if (value != passwordController.text) {
                return 'Паролі не збігаються';
              }
              return null;
            },
          ),

          const SizedBox(height: 28),

          ElevatedButton(
            onPressed: onSignUp,
            child: const Text('Зареєструватися'),
          ),

          const SizedBox(height: 16),

          OutlinedButton(
            onPressed: onBack,
            child: const Text('Повернутися до входу'),
          ),
        ],
      ),
    );
  }
}

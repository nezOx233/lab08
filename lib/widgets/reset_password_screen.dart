import 'package:flutter/material.dart';
import 'sign_in_screen.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.validateEmail,
    required this.onResetPassword,
    required this.onBack,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final FormFieldValidator<String> validateEmail;
  final VoidCallback onResetPassword;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AuthLogo(),

          Container(
            width: 76,
            height: 76,
            decoration: const BoxDecoration(
              color: Color(0xFFDBEAFE),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.lock_reset,
              size: 38,
              color: Color(0xFF2563EB),
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            'Відновлення пароля',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          const Text(
            'Введіть електронну пошту, пов’язану з вашим '
            'обліковим записом, щоб розпочати відновлення пароля.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
              height: 1.5,
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

          const SizedBox(height: 24),

          ElevatedButton(
            onPressed: onResetPassword,
            child: const Text('Відновити пароль'),
          ),

          const SizedBox(height: 16),

          OutlinedButton.icon(
            onPressed: onBack,
            icon: const Icon(Icons.arrow_back),
            label: const Text('Повернутися до входу'),
          ),
        ],
      ),
    );
  }
}

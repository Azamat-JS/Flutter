import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool obscureText;
  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(hintText: 'Email'),
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: passwordController,
            obscureText: obscureText,
            decoration: InputDecoration(hintText: 'Password'),
          ),
        ],
      ),
    );
  }
}

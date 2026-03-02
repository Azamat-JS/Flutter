import 'package:bloc_test/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              // Handle login logic here
              context.read<AuthCubit>().login(
                emailController.text,
                passwordController.text,
              );
            },
            child: Text('Login'),
          ),
        ],
      ),
    );
  }
}

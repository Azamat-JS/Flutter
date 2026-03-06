import 'package:bloc_test_todo/presentation/bloc/auth_bloc.dart';
import 'package:bloc_test_todo/presentation/components/my_button.dart';
import 'package:bloc_test_todo/presentation/components/my_text_field.dart';
import 'package:bloc_test_todo/presentation/pages/sign_up_page.dart';
import 'package:bloc_test_todo/presentation/themes/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const LoginPage());
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final pwController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  MyTextField(
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email required';
                      }
                      return null;
                    },
                    hintText: 'Email',
                  ),
                  SizedBox(height: 10),
                  MyTextField(
                    controller: pwController,
                    validator: (value) {
                      if (value == null || value.length < 6) {
                        return 'Password too short';
                      }
                      return null;
                    },
                    hintText: 'Password',
                  ),
                  SizedBox(height: 20),
                  MyButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                          LoginRequested(
                            emailController.text.trim(),
                            pwController.text.trim(),
                          ),
                        );
                      }
                    },
                    text: 'Login',
                  ),
                  SizedBox(height: 25),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, SignUpPage.route());
                    },
                    child: RichText(
                      text: TextSpan(
                        text: "Don't have an account? ",
                        style: Theme.of(context).textTheme.titleMedium,
                        children: [
                          TextSpan(
                            text: " Register now",
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  color: Pallete.gradient2,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

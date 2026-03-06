import 'package:bloc_test_todo/presentation/bloc/auth_bloc.dart';
import 'package:bloc_test_todo/presentation/components/my_button.dart';
import 'package:bloc_test_todo/presentation/components/my_text_field.dart';
import 'package:bloc_test_todo/presentation/themes/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => const SignUpPage());
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final pwController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          Navigator.of(context).popUntil((route) => route.isFirst);
        }
        if (state is AuthFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    MyTextField(
                      controller: usernameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Username required';
                        }
                        return null;
                      },
                      hintText: 'Username',
                    ),
                    SizedBox(height: 10),
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
                            SignUpRequested(
                              usernameController.text.trim(),
                              emailController.text.trim(),
                              pwController.text.trim(),
                            ),
                          );
                        }
                      },
                      text: 'Register',
                    ),
                    SizedBox(height: 25),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: RichText(
                        text: TextSpan(
                          text: "Already have an account? ",
                          style: Theme.of(context).textTheme.titleMedium,
                          children: [
                            TextSpan(
                              text: " Login",
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
      ),
    );
  }
}

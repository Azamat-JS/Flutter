import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:social_media_app/components/my_textfield.dart';

class LoginPage extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/lotties/Login.json', height: 200),
              const SizedBox(height: 25),
              Text('M I N I M A L', style: TextStyle(fontSize: 20)),
              const SizedBox(height: 50),
              MyTextfield(
                controller: emailController,
                hintText: "Enter an email",
                obscureText: false,
              ),
              const SizedBox(height: 10),
              MyTextfield(
                controller: passwordController,
                hintText: "Enter a password",
                obscureText: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

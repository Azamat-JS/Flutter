import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/lotties/Login.json', height: 200),
            const SizedBox(height: 10),
            Text(
              "Welcome back, Let's start to chat!",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 20),
            TextField(),
          ],
        ),
      ),
    );
  }
}

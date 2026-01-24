import 'package:authentication/components/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Column(
          children: [
            Image.asset('assets/images/logo.png'),
            SizedBox(height: 20),
            Text(
              'Welcome back you\'ve been missed!',
              style: TextStyle(color: Colors.grey[700], fontSize: 16),
            ),
            SizedBox(height: 20),

            MyTextfield(
              controller: usernameController,
              hintText: 'Username',
              obscureText: false,
            ),
            SizedBox(height: 10),
            MyTextfield(
              controller: passwordController,
              hintText: 'Password',
              obscureText: true,
            ),

            const SizedBox(height: 10),
            // forgot password?
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: const Color.fromARGB(255, 13, 140, 243),
                      fontSize: 14,
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

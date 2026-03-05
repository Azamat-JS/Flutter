import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final String hintText;
  const MyTextField({
    super.key,
    required this.controller,
    required this.validator,
    this.obscureText = false,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      decoration: InputDecoration(hintText: hintText),
    );
  }
}

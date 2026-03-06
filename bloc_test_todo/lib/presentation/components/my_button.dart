import 'package:flutter/material.dart';
import 'package:bloc_test_todo/presentation/themes/pallete.dart';

class MyButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  const MyButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Pallete.gradient1, Pallete.gradient2, Pallete.gradient3],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          fixedSize: const Size(395, 55),
          shadowColor: Colors.transparent,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 17,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

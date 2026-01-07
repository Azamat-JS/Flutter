import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;
  final Color textColor;
  VoidCallback onPressed;

  MyButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon = Icons.add,
    this.color = Colors.yellow,
    this.textColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Text(text, style: TextStyle(color: textColor)),
          SizedBox(width: 2),
          Icon(icon, color: textColor),
        ],
      ),
    );
  }
}

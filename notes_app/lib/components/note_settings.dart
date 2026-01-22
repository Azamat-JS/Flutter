import 'package:flutter/material.dart';

class NoteSettings extends StatelessWidget {
  void Function()? onEditTap;
  void Function()? onDeleteTap;
  NoteSettings({super.key, required this.onEditTap, required this.onDeleteTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onEditTap,
          child: Container(
            height: 50,
            color: Theme.of(context).colorScheme.primary,
            child: Center(
              child: Text(
                'Edit',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: onDeleteTap,
          child: Container(
            height: 50,
            color: Theme.of(context).colorScheme.primary,
            child: Center(
              child: Text(
                'Delete',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

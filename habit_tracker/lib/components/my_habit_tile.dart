import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MyHabitTile extends StatelessWidget {
  final String text;
  final bool isCompleted;
  final void Function(bool?)? onChanged;
  final void Function(BuildContext?)? editHabit;
  final void Function(BuildContext?)? deleteHabit;
  const MyHabitTile({
    super.key,
    required this.isCompleted,
    required this.text,
    required this.onChanged,
    required this.editHabit,
    required this.deleteHabit,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: editHabit,
            backgroundColor: Colors.grey.shade800,
            foregroundColor: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            icon: Icons.settings,
            label: 'Edit',
          ),
          SlidableAction(
            onPressed: deleteHabit,
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          if (onChanged != null) {
            onChanged!(!isCompleted);
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: isCompleted
                ? Colors.green
                : Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.all(12.0),
          margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 25.0),
          child: ListTile(
            title: Text(text),
            leading: Checkbox(
              value: isCompleted,
              onChanged: onChanged,
              activeColor: Colors.green,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:notes_app/components/note_settings.dart';
import 'package:popover/popover.dart';

class NoteTile extends StatelessWidget {
  final String text;
  final void Function()? updateNote;
  final void Function()? deleteNote;
  const NoteTile({
    super.key,
    required this.text,
    required this.updateNote,
    required this.deleteNote,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        title: Text(
          text,
          style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
        ),
        trailing: Builder(
          builder: (context) => IconButton(
            onPressed: () => showPopover(
              width: 100,
              height: 100,
              backgroundColor: Theme.of(context).colorScheme.surface,
              context: context,
              bodyBuilder: (context) => NoteSettings(
                onEditTap: () {
                  Navigator.of(context).pop();
                  updateNote!();
                },
                onDeleteTap: () {
                  Navigator.of(context).pop();
                  deleteNote!();
                },
              ),
            ),
            icon: Icon(Icons.more_vert),
          ),
        ),
      ),
    );
  }
}

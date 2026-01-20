import 'package:flutter/material.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/models/note_databse.dart';
import 'package:provider/provider.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchNotes();
  }

  void createNote() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New Note'),
        content: TextField(
          autofocus: true,
          controller: textController,
          onSubmitted: (value) {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              context.read<NoteDatabse>().addNote(textController.text);
              textController.clear();
              Navigator.of(context).pop();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void fetchNotes() {
    context.read<NoteDatabse>().fetchNotes();
  }

  @override
  Widget build(BuildContext context) {
    final noteDatabase = context.watch<NoteDatabse>();
    List<Note> notes = noteDatabase.currentNotes;
    return Scaffold(
      appBar: AppBar(title: const Text('Notes')),
      floatingActionButton: FloatingActionButton(
        onPressed: createNote,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];
          return ListTile(
            title: Text(note.text),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                noteDatabase.deleteNote(note.id);
                fetchNotes();
              },
            ),
              ],
            )
          );
        },
      ),
    );
  }
}

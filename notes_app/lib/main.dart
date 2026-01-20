import 'package:flutter/material.dart';
import 'package:notes_app/models/note_databse.dart';
import 'package:notes_app/pages/notes_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDatabse.initialize();
  runApp(
    ChangeNotifierProvider<NoteDatabse>(
      create: (context) => NoteDatabse(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: NotesPage());
  }
}

import 'package:bloc_test_todo/data/datasources/todo_local_datasource_impl.dart';
import 'package:bloc_test_todo/data/models/todo_model.dart';
import 'package:bloc_test_todo/data/repositories/todo_repo_impl.dart';
import 'package:bloc_test_todo/domain/repositories/todo_repo.dart';
import 'package:bloc_test_todo/presentation/bloc/todo_bloc.dart';
import 'package:bloc_test_todo/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();

  final isar = await Isar.open([TodoModelSchema], directory: dir.path);
  final local = TodoLocalDatasourceImpl(isar);
  final repository = TodoRepositoryImpl(local);
  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final TodoRepository repository;
  const MyApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoBloc(repository)..add(LoadTodos()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const HomePage(),
      ),
    );
  }
}

import 'package:bloc_test_todo/data/datasources/auth_local_datasource.dart';
import 'package:bloc_test_todo/data/datasources/todo_local_datasource_impl.dart';
import 'package:bloc_test_todo/data/models/auth_model.dart';
import 'package:bloc_test_todo/data/models/session_model.dart';
import 'package:bloc_test_todo/data/models/todo_model.dart';
import 'package:bloc_test_todo/data/repositories/auth_repo_impl.dart';
import 'package:bloc_test_todo/data/repositories/todo_repo_impl.dart';
import 'package:bloc_test_todo/domain/repositories/auth_repo.dart';
import 'package:bloc_test_todo/domain/repositories/todo_repo.dart';
import 'package:bloc_test_todo/presentation/bloc/auth_bloc.dart';
import 'package:bloc_test_todo/presentation/bloc/todo_bloc.dart';
import 'package:bloc_test_todo/presentation/cubit/btm_nav_cubit.dart';
import 'package:bloc_test_todo/presentation/pages/home_page.dart';
import 'package:bloc_test_todo/presentation/themes/cubit/theme_cubit.dart';
import 'package:bloc_test_todo/presentation/themes/dark_mode.dart';
import 'package:bloc_test_todo/presentation/themes/light_mode.dart';
import 'package:bloc_test_todo/presentation/widgets/auth_gate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();

  final isar = await Isar.open([
    TodoModelSchema,
    UserModelSchema,
    SessionModelSchema,
  ], directory: dir.path);
  final todoRepository = TodoRepositoryImpl(TodoLocalDatasourceImpl(isar));
  final authRepository = AuthRepositoryImpl(AuthLocalDatasourceImpl(isar));
  runApp(MyApp(todoRepository: todoRepository, authRepository: authRepository));
}

class MyApp extends StatelessWidget {
  final TodoRepository todoRepository;
  final AuthRepository authRepository;
  const MyApp({
    super.key,
    required this.todoRepository,
    required this.authRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TodoBloc(todoRepository)..add(LoadTodos()),
        ),
        BlocProvider(
          create: (context) =>
              AuthBloc(authRepository)..add(AuthCheckRequested()),
        ),
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => BtmNavCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Todo App',
            theme: lightMode,
            darkTheme: darkMode,
            themeMode: themeMode,
            home: const AuthGate(),
          );
        },
      ),
    );
  }
}

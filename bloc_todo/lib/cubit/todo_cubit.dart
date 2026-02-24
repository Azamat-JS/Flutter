import 'package:bloc_todo/models/todo_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoCubit extends Cubit<List<TodoModel>> {
  TodoCubit() : super([]);

  void addTodo(String name) {
    if (name.isEmpty) {
      addError("Todo title cannot be empty", StackTrace.current);
      return;
    }
    final newTodo = TodoModel(name: name, createdAt: DateTime.now());
    emit([...state, newTodo]);
  }

  @override
  void onChange(Change<List<TodoModel>> change) {
    super.onChange(change);
    print("TodoCubit - $change");
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    print("TodoCubit - $error");
  }
}

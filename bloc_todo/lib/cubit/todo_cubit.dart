import 'package:bloc_todo/models/todo_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoCubit extends Cubit<List<TodoModel>> {
  TodoCubit() : super([]);

  void addTodo(String name) {
    final newTodo = TodoModel(name: name, createdAt: DateTime.now());
    emit([...state, newTodo]);
  }

  @override
  void onChange(Change<List<TodoModel>> change) {
    super.onChange(change);
    print("TodoCubit - $change");
  }
}

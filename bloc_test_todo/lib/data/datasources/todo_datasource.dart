import 'package:bloc_test_todo/data/models/todo_model.dart';

abstract class TodoLocalDataSource {
  Future<List<TodoModel>> getTodos();
  Future<TodoModel?> getTodoById(int id);
  Future<void> insertTodo(TodoModel todo);
  Future<void> updateTodo(TodoModel todo);
  Future<void> toggleTodo(int id);
  Future<void> deleteTodo(int id);
}

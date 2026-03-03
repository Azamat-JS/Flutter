import 'package:bloc_test_todo/domain/entities/todo_entity.dart';

abstract class TodoRepository {
  Future<List<Todo>> getTodos();
  Future<void> addTodo(String title);
  Future<void> updateTodo(int id, String title);
  Future<void> toggleTodo(int id);
  Future<void> deleteTodo(int id);
}

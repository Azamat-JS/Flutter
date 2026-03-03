import 'package:bloc_test_todo/domain/entities/todo_entity.dart';

abstract class TodoRepository {
  Future<List<Todo>> getTodos();
  Future<void> addTodo(String title);
  Future<void> updateTodo(String id, String title, String isCompleted);
  Future<void> deleteTodo(String id);
}

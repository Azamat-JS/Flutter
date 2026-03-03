import 'package:bloc_test_todo/data/datasources/todo_datasource.dart';
import 'package:bloc_test_todo/data/models/todo_model.dart';
import 'package:bloc_test_todo/domain/entities/todo_entity.dart';
import 'package:bloc_test_todo/domain/repositories/todo_repo.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoLocalDataSource local;

  TodoRepositoryImpl(this.local);

  @override
  Future<List<Todo>> getTodos() async {
    final models = await local.getTodos();
    return models
        .map((e) => Todo(id: e.id, title: e.title, isCompleted: e.isCompleted))
        .toList();
  }

  @override
  Future<void> addTodo(String title) async {
    final todo = TodoModel();
    todo.title = title;
    todo.isCompleted = false;
    await local.insertTodo(todo);
  }

  @override
  Future<void> updateTodo(int id, String title) async {
    final existing = await local.getTodoById(id);
    if (existing == null) return;
    existing.title = title;
    await local.updateTodo(existing);
  }

  @override
  Future<void> toggleTodo(int id) async {
    final todos = await local.getTodos();
    final todo = todos.firstWhere((e) => e.id == id);
    todo.isCompleted = !todo.isCompleted;
    await local.updateTodo(todo);
  }

  @override
  Future<void> deleteTodo(int id) async {
    await local.deleteTodo(id);
  }
}

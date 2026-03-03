import 'package:bloc_test_todo/data/datasources/todo_datasource.dart';
import 'package:bloc_test_todo/data/models/todo_model.dart';
import 'package:isar/isar.dart';

class TodoLocalDatasourceImpl implements TodoLocalDataSource {
  final Isar isar;

  TodoLocalDatasourceImpl(this.isar);

  @override
  Future<List<TodoModel>> getTodos() async {
    return await isar.todoModels.where().findAll();
  }

  @override
  Future<void> insertTodo(TodoModel todo) async {
    await isar.writeTxn(() async {
      await isar.todoModels.put(todo);
    });
  }

  @override
  Future<void> updateTodo(TodoModel todo) async {
    await isar.writeTxn(() async {
      await isar.todoModels.put(todo);
    });
  }

  @override
  Future<void> toggleTodo(int id) async {
    final todo = await isar.todoModels.get(id);
    if (todo == null) return;
    todo.isCompleted = !todo.isCompleted;
    await isar.writeTxn(() async {
      await isar.todoModels.put(todo);
    });
  }

  @override
  Future<void> deleteTodo(int id) async {
    await isar.writeTxn(() async {
      await isar.todoModels.delete(id);
    });
  }
}

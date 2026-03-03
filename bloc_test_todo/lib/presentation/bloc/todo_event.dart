part of 'todo_bloc.dart';

@immutable
sealed class TodoEvent {}

final class LoadTodos extends TodoEvent {}

final class AddTodo extends TodoEvent {
  final String title;

  AddTodo(this.title);
}

final class UpdateTodo extends TodoEvent {
  final int id;
  final String title;

  UpdateTodo(this.id, this.title);
}

final class ToggleTodo extends TodoEvent {
  final int id;

  ToggleTodo(this.id);
}

final class DeleteTodo extends TodoEvent {
  final int id;

  DeleteTodo(this.id);
}

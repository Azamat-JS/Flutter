import 'package:bloc_test_todo/domain/entities/todo_entity.dart';
import 'package:bloc_test_todo/domain/repositories/todo_repo.dart';
import "package:flutter/foundation.dart";
import 'package:flutter_bloc/flutter_bloc.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository repository;
  TodoBloc(this.repository) : super(TodoInitial()) {
    on<LoadTodos>((event, emit) async {
      emit(TodoLoading());
      try {
        final todos = await repository.getTodos();
        emit(TodoLoaded(todos));
      } catch (e) {
        emit(TodoError(e.toString()));
      }
    });

    on<AddTodo>((event, emit) async {
      try {
        await repository.addTodo(event.title);
        add(LoadTodos());
      } catch (e) {
        emit(TodoError(e.toString()));
      }
    });

    on<UpdateTodo>((event, emit) async {
      try {
        await repository.updateTodo(event.id, event.title);
        add(LoadTodos());
      } catch (e) {
        emit(TodoError(e.toString()));
      }
    });

    on<ToggleTodo>((event, emit) async {
      try {
        await repository.toggleTodo(event.id);
        add(LoadTodos());
      } catch (e) {
        emit(TodoError(e.toString()));
      }
    });

    on<DeleteTodo>((event, emit) async {
      try {
        await repository.deleteTodo(event.id);
        add(LoadTodos());
      } catch (e) {
        emit(TodoError(e.toString()));
      }
    });
  }
}

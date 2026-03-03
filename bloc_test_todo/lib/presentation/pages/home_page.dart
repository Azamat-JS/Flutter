import 'package:bloc_test_todo/presentation/bloc/todo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final titleController = TextEditingController();

  void addTodo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add ToDo'),
        content: TextField(
          autofocus: true,
          controller: titleController,
          onSubmitted: (value) {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          Row(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              SizedBox(width: 5),
              ElevatedButton(
                onPressed: () {
                  context.read<TodoBloc>().add(
                    AddTodo(titleController.text.trim()),
                  );
                  titleController.clear();
                  Navigator.of(context).pop();
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Todo App")),
      floatingActionButton: FloatingActionButton(
        onPressed: addTodo,
        child: Icon(Icons.add),
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is TodoLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (state is TodoLoaded) {
            if (state.todos.isEmpty) {
              return const Center(child: Text('No Todos yet'));
            }
            return ListView.builder(
              itemCount: state.todos.length,
              itemBuilder: (context, index) {
                final todo = state.todos[index];
                return ListTile(
                  title: Text(todo.title),
                  trailing: Checkbox(
                    value: todo.isCompleted,
                    onChanged: (_) {
                      context.read<TodoBloc>().add(ToggleTodo(todo.id));
                    },
                  ),
                );
              },
            );
          }
          if (state is TodoError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
          return const SizedBox();
        },
      ),
    );
  }
}

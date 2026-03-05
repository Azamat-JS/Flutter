import 'package:bloc_test_todo/presentation/bloc/todo_bloc.dart';
import 'package:bloc_test_todo/presentation/components/my_drawer.dart';
import 'package:bloc_test_todo/presentation/components/todo_tile.dart';
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
        title: Text(
          'Add todo',
          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
        ),
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

  void showUpdateDialog(int id, String currentTitle) {
    titleController.text = currentTitle;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Update todo',
          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
        ),
        content: TextField(controller: titleController, autofocus: true),
        actions: [
          Row(
            children: [
              TextButton(
                onPressed: () {
                  titleController.clear();
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              SizedBox(width: 5),
              ElevatedButton(
                onPressed: () {
                  final newTitle = titleController.text.trim();
                  if (newTitle.isNotEmpty) {
                    context.read<TodoBloc>().add(UpdateTodo(id, newTitle));
                  }
                  titleController.clear();
                  Navigator.of(context).pop();
                },
                child: const Text('Update'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void showDeleteConfirmation(int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Delete todo',
          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
        ),
        content: const Text('Are you sure you want to delete this todo?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              context.read<TodoBloc>().add(DeleteTodo(id));
              titleController.clear();
              Navigator.of(context).pop();
            },
            child: const Text('Delete', style: TextStyle(color: Colors.white)),
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
        backgroundColor: Theme.of(context).colorScheme.secondary,
        onPressed: addTodo,
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
      drawer: MyDrawer(),
      body: BlocConsumer<TodoBloc, TodoState>(
        listener: (context, state) {
          if (state is TodoError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
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
                return TodoTile(
                  title: todo.title,
                  isCompleted: todo.isCompleted,
                  toggleTodo: (_) {
                    context.read<TodoBloc>().add(ToggleTodo(todo.id));
                  },
                  deleteFunction: (_) {
                    showDeleteConfirmation(todo.id);
                  },
                  updatedFunction: (_) {
                    showUpdateDialog(todo.id, todo.title);
                  },
                );
              },
            );
          }
          if (state is TodoError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
    );
  }
}

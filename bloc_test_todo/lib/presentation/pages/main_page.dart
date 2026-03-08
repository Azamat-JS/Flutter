import 'package:bloc_test_todo/presentation/bloc/todo_bloc.dart';
import 'package:bloc_test_todo/presentation/components/my_drawer.dart';
import 'package:bloc_test_todo/presentation/components/navbar_bottom.dart';
import 'package:bloc_test_todo/presentation/cubit/btm_nav_cubit.dart';
import 'package:bloc_test_todo/presentation/pages/home_page.dart';
import 'package:bloc_test_todo/presentation/pages/profile_page.dart';
import 'package:bloc_test_todo/presentation/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              SizedBox(width: 5),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                ),
                onPressed: () {
                  context.read<TodoBloc>().add(
                    AddTodo(titleController.text.trim()),
                  );
                  titleController.clear();
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Save',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  final List<Widget> _pages = [
    const HomePage(),
    const ProfilePage(),
    const SettingsPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BtmNavCubit, int>(
      builder: (context, index) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Todo App'),
            leading: Builder(
              builder: (context) {
                return IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                );
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            onPressed: addTodo,
            child: Icon(
              Icons.add,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
          bottomNavigationBar: NavbarBottom(
            selectedIndex: index,
            onTabChange: (i) {
              debugPrint("Gnav Tapped: $index");
              context.read<BtmNavCubit>().changeTab(i);
            },
          ),
          drawer: MyDrawer(
            selectedIndex: index,
            onDestinationSelected: (i) {
              context.read<BtmNavCubit>().changeTab(i);
            },
          ),
          body: IndexedStack(index: index, children: _pages),
        );
      },
    );
  }
}

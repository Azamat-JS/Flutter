import 'package:bloc_test_todo/presentation/components/my_drawer.dart';
import 'package:bloc_test_todo/presentation/components/navbar_bottom.dart';
import 'package:bloc_test_todo/presentation/pages/home_page.dart';
import 'package:bloc_test_todo/presentation/pages/profile_page.dart';
import 'package:bloc_test_todo/presentation/pages/settings_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  void navigationBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    const HomePage(),
    const ProfilePage(),
    const SettingsPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      bottomNavigationBar: NavbarBottom(
        selectedIndex: _selectedIndex,
        onTabChange: navigationBottomBar,
      ),
      drawer: MyDrawer(
        selectedIndex: _selectedIndex,
        onDestinationSelected: navigationBottomBar,
      ),
      body: IndexedStack(index: _selectedIndex, children: _pages),
    );
  }
}

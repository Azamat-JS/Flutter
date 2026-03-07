import 'package:bottom_navbar/pages/cart_page.dart';
import 'package:bottom_navbar/pages/home_page.dart';
import 'package:bottom_navbar/pages/settings_page.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  int _selectedIndex = 0;

  final List<Widget> pages = [
    const HomePage(),
    const CartPage(),
    const SettingsPage(),
  ];

  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Navbar App')),
      body: pages[_selectedIndex],
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: BottomNavigationBar(
            selectedItemColor: Colors.white,
            backgroundColor: Colors.blue,
            selectedFontSize: 20,
            currentIndex: _selectedIndex,
            onTap: navigateBottomBar,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: "Cart",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: "Settings",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

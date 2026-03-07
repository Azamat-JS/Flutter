import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NavbarBottom extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabChange;

  const NavbarBottom({
    super.key,
    required this.selectedIndex,
    required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: GNav(
        color: Colors.grey[400],
        activeColor: Colors.grey.shade700,
        tabActiveBorder: Border.all(color: Colors.white),
        tabBackgroundColor: Colors.grey.shade100,
        mainAxisAlignment: MainAxisAlignment.center,
        tabBorderRadius: 16,
        gap: 8,
        selectedIndex: selectedIndex,
        onTabChange: onTabChange,
        tabs: const [
          GButton(icon: Icons.home, text: 'Home'),
          GButton(icon: Icons.person, text: 'Profile'),
          GButton(icon: Icons.settings, text: 'Settings'),
        ],
      ),
    );
  }
}

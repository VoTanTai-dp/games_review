import 'package:flutter/material.dart';

class BottomNavbar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const BottomNavbar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: selectedIndex,
      onTap: onItemTapped,
      backgroundColor: const Color(0xFF12141C),
      selectedItemColor: Colors.white,
      unselectedItemColor: const Color(0xFF868688),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(
            icon: Icon(Icons.trending_up), label: "Trending"),
        BottomNavigationBarItem(icon: Icon(Icons.list), label: "Games List"),
        BottomNavigationBarItem(
            icon: Icon(Icons.settings), label: "Games Manager"),
      ],
    );
  }
}

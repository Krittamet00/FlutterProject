import 'package:flutter/material.dart';
import 'overview_screen.dart';
import 'transactions_screen.dart';
import 'summary_screen.dart';
import 'categories_screen.dart';
import 'menu_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static List<Widget> _screens = [
    OverviewScreen(),
    TransactionsScreen(),
    SummaryScreen(),
    CategoriesScreen(),
    MenuScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Overview'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Transactions'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Summary'),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menu'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

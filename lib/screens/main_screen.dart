import 'package:flutter/material.dart';
import 'currency_conversion_screen.dart';
import 'time_conversion_screen.dart';
import 'home_screen.dart';
import 'feedback_screen.dart';
import 'profile_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 2;
  final List<Widget> _pages = [
    CurrencyConversionScreen(),
    TimeConversionScreen(),
    HomeScreen(),
    FeedbackScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.attach_money), label: 'Currency'),
          BottomNavigationBarItem(icon: Icon(Icons.access_time), label: 'Time'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.feedback), label: 'Feedback'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

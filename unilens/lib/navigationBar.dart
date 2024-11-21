import 'package:flutter/material.dart';
import 'package:unilens/screens/info_screen.dart';
import 'screens/home_screen.dart';
import 'screens/community.dart';
import 'screens/profile_screen.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    CommunityScreen(),
    InfoScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: _screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home,
                  color: _selectedIndex == 0 ? Colors.red : Colors.grey),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people,
                  color: _selectedIndex == 1 ? Colors.red : Colors.grey),
              label: 'Community',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info,
                  color: _selectedIndex == 2 ? Colors.red : Colors.grey),
              label: 'Info',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person,
                  color: _selectedIndex == 3 ? Colors.red : Colors.grey),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

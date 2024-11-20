import 'package:flutter/material.dart';
import 'package:unilens/screens/info_screen.dart';
import 'screens/home_screen.dart';
import 'screens/community.dart';
import 'screens/profile_screen.dart';
//import 'screens/profile_screen.dart';
//import 'screens/settings_screen.dart';

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
        bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
            NavigationDestination(icon: Icon(Icons.people), label: 'Community'),
            NavigationDestination(icon: Icon(Icons.info), label: 'Info'),
            NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}

import 'package:appifylab_test/views/screens/home_screen.dart';

import 'package:appifylab_test/views/screens/searched_weather_screen.dart';
import 'package:flutter/material.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int selectedScreen = 0;
  final List<Widget> screens = [Homescreen(), SearchedWeatherScreen()];
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedScreen,
      onTap: (value) {
        setState(() {
          selectedScreen = value;
        });
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
      ],
    );
  }
}

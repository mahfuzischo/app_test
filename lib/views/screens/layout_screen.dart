import 'package:appifylab_test/views/screens/home_screen.dart';
import 'package:appifylab_test/views/screens/searched_weather_screen.dart';
import 'package:flutter/material.dart';

class LayoutScreen extends StatefulWidget {
  const LayoutScreen({super.key});

  @override
  State<LayoutScreen> createState() => _LayoutScreenState();
}

class _LayoutScreenState extends State<LayoutScreen> {
  int selectedScreen = 0;
  final List<Widget> screens = [Homescreen(), SearchedWeatherScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedScreen],
      bottomNavigationBar: BottomNavigationBar(
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
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'person_screen.dart';
import 'vehicle_screen.dart';
import 'parking_screen.dart';
import 'parking_space_screen.dart';

class HomeScreen extends StatefulWidget {
  final String username;
  final VoidCallback toggleTheme;
  final bool isDarkMode;

  const HomeScreen({
    Key? key,
    required this.username,
    required this.toggleTheme,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  late final List<Widget> screens;

  @override
  void initState() {
    super.initState();
    screens = [
      PersonScreen(),
      VehicleScreen(),
      ParkingSpaceScreen(),
      ParkingScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Välkommen, ${widget.username}'),
        actions: [
          IconButton(
            icon: Icon(widget.isDarkMode ? Icons.wb_sunny : Icons.nightlight),
            onPressed: widget.toggleTheme,
          ),
        ],
      ),
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: Colors.indigo,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Personer'),
          BottomNavigationBarItem(
              icon: Icon(Icons.directions_car), label: 'Fordon'),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_parking), label: 'Platser'),
          BottomNavigationBarItem(
              icon: Icon(Icons.history), label: 'Parkeringar'),
        ],
      ),
    );
  }
}

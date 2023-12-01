import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:uemk/attendance.dart';
import 'package:uemk/profile.dart';
import 'package:uemk/settings.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen>{
  final _navPages = [Attendance(), const Settings(), const Profile()];
  int _selectedItem = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Center(
        child: _navPages[_selectedItem],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          // boxShadow: [
          //   BoxShadow(
          //     blurRadius: 20,
          //     color: Colors.black.withOpacity(.1),
          //   )
          // ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              // backgroundColor: Colors.black87,
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.black,
              tabs: const [
                GButton(
                  icon: Icons.people,
                  text: 'Attendance',
                ),
                GButton(
                  icon: Icons.settings,
                  text: 'Settings',
                ),
                GButton(
                  icon: Icons.face,
                  text: 'Profile',
                ),
              ],
              selectedIndex: _selectedItem,
              onTabChange: (index) {
                setState(() {
                  _selectedItem = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
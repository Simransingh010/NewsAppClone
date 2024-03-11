import 'package:flutter/material.dart';
import 'package:news_clone_app/screens/home_page.dart';
import 'package:news_clone_app/screens/profile_page.dart';
import 'package:news_clone_app/screens/search_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _index = 0;
  List pages = [
    HomePage(),
    SearchPage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages.elementAt(_index),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _index,
        selectedLabelStyle: TextStyle(
          color: Colors.black,
        ),
        unselectedLabelStyle: TextStyle(
          color: Colors.transparent,
        ),
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black.withAlpha(100),
        onTap: (index) {
          setState(() {
            _index = index;
            print('index = $index');
          });
        },
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.home,
              color: Colors.black,
              size: 30,
            ),
            icon: Icon(
              Icons.home_outlined,
              color: Colors.black,
              size: 25,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.search,
              color: Colors.black,
              size: 30,
            ),
            icon: Icon(
              Icons.search_outlined,
              color: Colors.black,
              size: 25,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.person,
              color: Colors.black,
              size: 30,
            ),
            icon: Icon(
              Icons.person_outline,
              color: Colors.black,
              size: 25,
            ),
            label: '',
          )
        ],
      ),
    );
  }
}

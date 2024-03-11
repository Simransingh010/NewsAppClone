import 'package:flutter/material.dart';
// import 'package:news_clone_app/screens/BottomNavbar1.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static const routeName = '/Profile';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: BottomNavBar1(index: 2),
      body: ListView(
        children: [
          Center(
            child: Text(
              'king',
              style: TextStyle(fontSize: 100),
            ),
          ),
        ],
      ),
    );
  }
}

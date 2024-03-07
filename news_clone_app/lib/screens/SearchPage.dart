import 'package:flutter/material.dart';
// import 'package:news_clone_app/screens/BottomNavbar1.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  static const routeName = '/Search';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: BottomNavBar1(index: 1),
      body: ListView(
        children: [
          Center(
            child: Text(
              'AHUJA',
              style: TextStyle(fontSize: 100),
            ),
          ),
        ],
      ),
    );
  }
}

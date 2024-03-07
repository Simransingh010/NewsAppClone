import 'package:flutter/material.dart';
// import 'package:news_clone_app/screens/BottomNavbar1.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const routeName = '/';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Text(
            'simran',
            style: TextStyle(fontSize: 100),
          )
        ],
      ),
    );
  }
}

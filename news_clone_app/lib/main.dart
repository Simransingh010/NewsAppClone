import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_clone_app/screens/bottom_navbar.dart';
import 'package:news_clone_app/screens/profile_page.dart';
import 'package:news_clone_app/screens/search_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          textTheme: GoogleFonts.latoTextTheme(
        Theme.of(context).textTheme,
      )),
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        bottomNavigationBar: BottomNavBar(),
      ),
      initialRoute: '/',
      routes: {
        // HomePage.routeName: (context) => const HomePage(),
        ProfilePage.routeName: (context) => const ProfilePage(),
        SearchPage.routeName: (context) => const SearchPage(),
      },
    );
  }
}

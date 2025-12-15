import 'package:flutter/material.dart';
import 'package:flutter_own_page_view_integration/flash_screen.dart';
import 'package:flutter_own_page_view_integration/personal_profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Profile App",
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: FlashScreen(),   // Start with the Personal Profile page
    );
  }
}

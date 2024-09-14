import 'package:flutter/material.dart';
import 'package:icthub_2024_9/features/home_nav/ui/screens/home_nav_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeNavScreen(),
    );
  }
}

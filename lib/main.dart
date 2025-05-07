import 'package:flutter/material.dart';
import 'package:todoapp/screens/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'WinkySans',
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: TodoPage(),
    );
  }
}

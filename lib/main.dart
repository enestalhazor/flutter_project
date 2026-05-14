import 'package:flutter/material.dart';
import 'package:flutter_project/views/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Project", 
      home: LoginScreen()
    );
  }
}

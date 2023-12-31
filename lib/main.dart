import 'package:flutter/material.dart';
import 'package:studentapp/pages/Login.dart';
import 'package:studentapp/views/SplashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student App',
      home: SplashScreen(),
    );
  }
}

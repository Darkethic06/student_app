import 'package:flutter/material.dart';
import 'package:studentapp/views/Topbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 25),
        child: Column(
          children: [
            // Topbar(),
          ],
        ),
      ),
    ));
  }
}

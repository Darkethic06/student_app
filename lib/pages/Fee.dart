import 'package:flutter/material.dart';

import '../utils/myColors.dart';
import '../views/Feature.dart';
import '../views/Topbar.dart';

class FeePage extends StatefulWidget {
  const FeePage({super.key});

  @override
  State<FeePage> createState() => _FeePageState();
}

class _FeePageState extends State<FeePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 25),
        child: Column(
          children: [
            // Topbar(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15),
                  children: [
                    FeatureCard(
                      name: "Pay Fee",
                      featureIcon: Icons.payment,
                      mySize: 60,
                    ),
                    FeatureCard(
                      name: "Fee Receipt",
                      featureIcon: Icons.receipt_long,
                      mySize: 60,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:studentapp/utils/myColors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
        ),
        backgroundColor: mainColor,
        centerTitle: true,
      ),
      body: Center(),
    );
  }
}

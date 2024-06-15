import 'package:flutter/material.dart';
import 'package:studentapp/utils/myColors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3,
              child: Image.asset(
                './profile-banner.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 10.0,
                      spreadRadius: 4.0,
                      offset: Offset(5.0, 5.0),
                    ),
                  ],
                ),
                height: 250,
                width: MediaQuery.of(context).size.width,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(child: Text("Koushik Dey")),
                      Center(child: Text("Student Code")),
                      Text("Date of Birth: 01/01/2025"),
                      Text("Contact No: 7894563201"),
                      Text("Email Id: arijit@yopmail.com"),
                      Text("Father's Name: Subhas Paul"),
                      Text("Mother's Name: Subhas Paul"),
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}

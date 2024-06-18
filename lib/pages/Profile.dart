import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studentapp/utils/api.dart';
import 'package:http/http.dart' as http;
import 'package:studentapp/utils/myColors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = '';
  String email = '';
  String studentCode = '';
  String phone = '';
  String fathers_name = '';
  String mothers_name = '';
  String imageUrl = '';
  String dob = '';

  Future<void> fetchProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final uri = Uri.parse('$basePath/user');
    final headers = {'Authorization': 'Bearer $token'};
    final response = await http.get(uri, headers: headers);

    final data = jsonDecode(response.body);
    print(data);
    setState(() {
      name = data['data']['full_name'];
      studentCode = data['data']['student_code'];
      phone = data['data']['phone'];
      email = data['data']['email'];
      fathers_name = data['data']['fathers_name'];
      mothers_name = data['data']['mothers_name'];
      imageUrl = data['data']['profile_photo_url'];
      dob = data['data']['dob'];
    });
  }

  @override
  void initState() {
    super.initState();
    fetchProfile();
    // print();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 3,
                  child: Image.asset(
                    'assets/profile-banner.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height / 3 + 20,
                  left: 16.0, // Add left padding
                  right: 16.0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 32.0, horizontal: 16.0),
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Center(
                              child: Text(
                            name,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: mainColor),
                          )),
                          Center(
                              child: Text(
                            studentCode,
                            style: TextStyle(
                                color: mainColor,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w400),
                          )),
                          Text(
                            "Date of Birth: " + dob,
                            style: TextStyle(color: mainColor, fontSize: 15.0),
                          ),
                          Text(
                            "Contact No: " + phone,
                            style: TextStyle(color: mainColor, fontSize: 15.0),
                          ),
                          Text(
                            "Email Id: " + email,
                            style: TextStyle(color: mainColor, fontSize: 15.0),
                          ),
                          Text(
                            "Father's Name: " + fathers_name,
                            style: TextStyle(color: mainColor, fontSize: 15.0),
                          ),
                          Text(
                            "Mother's Name: " + mothers_name,
                            style: TextStyle(color: mainColor, fontSize: 15.0),
                          ),
                        ]),
                  ),
                ),
                Positioned(
                  top: (MediaQuery.of(context).size.height / 3) - 40,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 3.0, color: mainColor),
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      radius: 40.0,
                      backgroundImage: NetworkImage(imageUrl),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studentapp/pages/Dashboard.dart';
import 'package:studentapp/utils/api.dart';
import 'package:studentapp/utils/myColors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;

  final _studentCode = TextEditingController();
  final _password = TextEditingController();
  bool _validate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(color: mainColor),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50.0),
                  bottomRight: Radius.circular(50.0),
                ),
              ),
              child: Image.asset("assets/logo.png"),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 3,
                    ),
                    const Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        "Student Code",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: TextField(
                        controller: _studentCode,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Student Code',
                            errorStyle: TextStyle(color: btnColor),
                            errorText: _validate
                                ? 'Student Code Can\'t Be Empty'
                                : null,
                            border: OutlineInputBorder()),
                      ),
                    ),
                    const Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        "Password",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                      child: TextField(
                        maxLength: 8,
                        obscureText: _obscureText,
                        controller: _password,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Password',
                            errorStyle: TextStyle(color: btnColor),
                            errorText:
                                _validate ? 'Password Can\'t Be Empty' : null,
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              icon: Icon(
                                  _obscureText ? Icons.lock : Icons.lock_open),
                            ),
                            border: OutlineInputBorder()),
                      ),
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            setState(() {
                              if (_studentCode.text.isEmpty ||
                                  _password.text.isEmpty) {
                                _validate = true;
                              } else {
                                _validate = false;

                                studentLogin(_studentCode.text, _password.text);
                              }
                            });
                          });
                        },
                        child: Text(
                          "Sign In",
                          style: TextStyle(fontSize: 18),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 18, vertical: 10),
                          backgroundColor: btnColor,
                        ),
                      ),
                    ),
                  ],
                ), // Add your login form widget here
              ),
            ),
          ],
        ),
      ),
    );
  }

  void studentLogin(String studentCode, String password) async {
    final response = await http.post(
      Uri.parse('${basePath}/login'), // Replace with your API endpoint
      body: {'student_code': studentCode, 'password': password},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      String token = data['token'];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Dashboard()));
    } else {
      final data = jsonDecode(response.body);

      final snackBar = SnackBar(
        content: Text(data['message']),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print(response.body);
    }
  }
}

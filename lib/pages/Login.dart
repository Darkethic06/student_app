import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studentapp/pages/Dashboard.dart';
import 'package:studentapp/utils/api.dart';
import 'package:studentapp/utils/myColors.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

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
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              "./login-banner.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 2 - 50),
            height: MediaQuery.of(context).size.height / 2 + 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50.0),
                topRight: Radius.circular(50.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                    child: Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Text(
                    "NORTH POINT DAY SCHOOL",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: mainColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                )),
                const Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 36.0),
                  child: Text(
                    "Student Code",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 36, vertical: 20),
                  child: TextField(
                    controller: _studentCode,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Boxicons.bx_book_reader),
                        fillColor: Color(0xFFeef7fe),
                        filled: true,
                        hintText: 'Student Code',
                        errorStyle: TextStyle(color: btnColor),
                        errorText:
                            _validate ? 'Student Code Can\'t Be Empty' : null,
                        border: InputBorder.none),
                  ),
                ),
                const Padding(
                  padding: const EdgeInsets.only(left: 36.0),
                  child: Text(
                    "Password",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 36.0, vertical: 20),
                  child: TextField(
                    maxLength: 8,
                    obscureText: _obscureText,
                    controller: _password,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Color(0xFFeef7fe),
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFFeef7fe),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      prefixIcon: Icon(Icons.lock),
                      fillColor: Color(0xFFeef7fe),
                      filled: true,
                      hintText: 'Password',
                      errorStyle: TextStyle(color: btnColor),
                      errorText: _validate ? 'Password Can\'t Be Empty' : null,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        icon: Icon(_obscureText
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                    ),
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
                      "LOGIN",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 65, vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      backgroundColor: mainColor,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void studentLogin(String studentCode, String password) async {
    final response = await http.post(
      Uri.parse('${basePath}/login'),
      body: {'student_code': studentCode, 'password': password},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      String token = data['token'];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      // if (token != null) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Dashboard()));
      // }
    } else {
      final data = jsonDecode(response.body);

      final snackBar = SnackBar(
        content: Text(data['message']),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}

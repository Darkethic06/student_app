import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
                                // Navigator.of(context).pushReplacement(
                                //     MaterialPageRoute(
                                //         builder: (context) => Dashboard()));
                                // print(_studentCode.text);
                                // print(_password.text);
                                // studentLogin(_studentCode.text, _password.text);
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
                    // Padding(
                    //   padding: EdgeInsets.only(top: 30.0),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: Text(
                    //           "Forget Username?",
                    //           style: TextStyle(color: Colors.white),
                    //         ),
                    //       ),
                    //       ElevatedButton(
                    //         onPressed: () {
                    //           Navigator.of(context).push(MaterialPageRoute(
                    //               builder: (context) => SignUp()));
                    //         },
                    //         child: Text(
                    //           "Find Now",
                    //           style:
                    //               TextStyle(fontSize: 14, color: Colors.white),
                    //         ),
                    //         style: ElevatedButton.styleFrom(
                    //           padding: EdgeInsets.symmetric(
                    //               horizontal: 8, vertical: 5),
                    //           backgroundColor: Color.fromRGBO(6, 161, 248, 1),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // )
                  ],
                ), // Add your login form widget here
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<LoginData> studentLogin(String student_code, password) async {
    final http.Response response = await http.post(
      Uri.parse(basePath + 'login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, String>{'student_code': student_code, 'password': password}),
    );

    if (response.statusCode == 201) {
      return LoginData.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to Login');
    }
  }
}

class LoginData {
  final String student_code;
  final String password;

  LoginData({required this.student_code, required this.password});

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      student_code: json['student_code'],
      password: json['password'],
    );
  }
}

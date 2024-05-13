import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studentapp/utils/api.dart';

import '../views/ClassmateCard.dart';
import 'package:http/http.dart' as http;

class AllTeacher extends StatefulWidget {
  const AllTeacher({super.key});

  @override
  State<AllTeacher> createState() => _AllTeacherState();
}

class _AllTeacherState extends State<AllTeacher> {
  List teachers = [];

  fetchTeachers() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final uri = Uri.parse('$basePath/get-all-teachers');
    final headers = {'Authorization': 'Bearer $token'};
    await http.get(uri, headers: headers).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        teachers = result['data'];
        // print(teachers);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fetchTeachers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: teachers != null && teachers.isNotEmpty
            ? teacherWidget()
            : teachers.isEmpty
                ? Center(child: Text("No Teacher Found"))
                : Center(child: CircularProgressIndicator()));
  }

  Widget teacherWidget() {
    return Column(children: [
      SizedBox(
        height: 20,
      ),
      Expanded(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 0, mainAxisSpacing: 8),
          itemCount: teachers.length,
          itemBuilder: ((context, index) {
            return ClassmateCard(
              name: teachers[index]['full_name'],
              image: teachers[index]['profile_photo_url'],
            );
          }),
        ),
      ),
    ]);
  }
}

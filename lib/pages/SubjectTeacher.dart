import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studentapp/utils/api.dart';

import '../views/ClassmateCard.dart';
import 'package:http/http.dart' as http;

class SubjectTeacher extends StatefulWidget {
  const SubjectTeacher({super.key});

  @override
  State<SubjectTeacher> createState() => _SubjectTeacherState();
}

class _SubjectTeacherState extends State<SubjectTeacher> {
  List teachers = [];

  fetchTeachers() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final uri = Uri.parse('$basePath/get-class-teachers');
    final headers = {'Authorization': 'Bearer $token'};
    await http.get(uri, headers: headers).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        teachers = result['data'];
        // print(result);
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
                ? Center(child: Text("No Class Teacher Found"))
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
              name: teachers[index]['teacher']['full_name'],
              image: teachers[index]['teacher']['profile_photo_path'] != null
                  ? teachers[index]['teacher']["profile_photo_url"]
                  : '${assetPath}admin_assets/demo.png',
            );
          }),
        ),
      ),
    ]);
  }
}

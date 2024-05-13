import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studentapp/utils/api.dart';
import 'package:studentapp/utils/myColors.dart';
import '../views/ClassmateCard.dart';
import 'package:http/http.dart' as http;

class ClassmatePage extends StatefulWidget {
  const ClassmatePage({super.key});

  @override
  State<ClassmatePage> createState() => _ClassmatePageState();
}

class _ClassmatePageState extends State<ClassmatePage> {
  List students = [];

  fetchStudents() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final uri = Uri.parse('$basePath/class-mates');
    final headers = {'Authorization': 'Bearer $token'};
    await http.get(uri, headers: headers).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        students = result['data'];
        // print(students);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fetchStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Classmates",
          ),
          centerTitle: true,
          backgroundColor: mainColor,
        ),
        body: students != null && students.isNotEmpty
            ? classMate()
            : Center(child: CircularProgressIndicator()));
  }

  Widget classMate() {
    return SafeArea(
      child: Column(
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(12.0),
          //   child: SearchBar(
          //     hintText: "Search",
          //     trailing: <Widget>[
          //       Tooltip(
          //         message: 'Change brightness mode',
          //         child: IconButton(
          //           onPressed: () {},
          //           icon: const Icon(Icons.search),
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          SizedBox(
            height: 12,
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 0, mainAxisSpacing: 8),
              itemCount: students.length,
              itemBuilder: ((context, index) {
                return ClassmateCard(
                  name: students[index]["full_name"],
                  image: students[index]["profile_photo_path"] ??
                      students[index]["profile_photo_url"],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studentapp/utils/api.dart';
import 'package:studentapp/utils/myColors.dart';
import 'package:studentapp/views/AssignmentCard.dart';
import 'package:studentapp/views/ReportCardContainer.dart';

import 'AllTeacher.dart';
import 'SubjectTeacher.dart';
import 'package:http/http.dart' as http;

class AssignmentsPage extends StatefulWidget {
  const AssignmentsPage({super.key});

  @override
  State<AssignmentsPage> createState() => _AssignmentsPageState();
}

class _AssignmentsPageState extends State<AssignmentsPage> {
  List assignments = [];

  fetchAssignment() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final uri = Uri.parse('$basePath/get-assignments');
    final headers = {'Authorization': 'Bearer $token'};
    await http.get(uri, headers: headers).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        assignments = result['data'];
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fetchAssignment();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                "Assignments",
              ),
              backgroundColor: mainColor,
              centerTitle: true,
              // bottom: TabBar(
              //     labelColor: Colors.white,
              //     unselectedLabelColor: btnColor,
              //     indicatorColor: btnColor,
              //     tabs: <Widget>[
              //       Container(
              //         child: Tab(
              //           text: "All",
              //         ),
              //       ),
              //       Tab(
              //         text: "Subjects",
              //       ),
              //     ]),
            ),
            body: assignments.isEmpty
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : assignments.length > 0
                    ? ListView.builder(
                        itemCount: assignments.length,
                        itemBuilder: (context, index) {
                          return AssignmentCard(
                            title: assignments[index]['name'],
                            assigndOn: assignments[index]['created_at'],
                            submittedBy: assignments[index]['submission_date'],
                            updated: assignments[index]['updated_at'],
                            file: assignments[index]['file_full_path'],
                            subject: assignments[index]['subject']['title'],
                          );
                        })
                    : Center(
                        child: Text("No Notice Found"),
                      )));
  }
}

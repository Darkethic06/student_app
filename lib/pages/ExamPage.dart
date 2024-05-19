import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studentapp/utils/api.dart';
import 'package:studentapp/utils/myColors.dart';
import 'package:studentapp/views/ExamCard.dart';
import 'package:http/http.dart' as http;

class ExamPage extends StatefulWidget {
  const ExamPage({super.key});

  @override
  State<ExamPage> createState() => _ExamPageState();
}

class _ExamPageState extends State<ExamPage> {
  List exams = [];

  fetchExams() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final uri = Uri.parse('$basePath/exam-details');
    final headers = {'Authorization': 'Bearer $token'};
    await http.get(uri, headers: headers).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        exams = result['data'];
        // print();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fetchExams();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Assignments",
          ),
          backgroundColor: mainColor,
          centerTitle: true,
        ),
        body: exams.isEmpty
            ? Center(
                child: CircularProgressIndicator(),
              )
            : exams.length > 0
                ? ListView.builder(
                    itemCount: exams.length,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: ExamCard(
                            title: exams[index]['name'],
                            subject: exams[index]['subject']['title'],
                            examDate: exams[index]['exam_date'],
                            startTime: exams[index]['time_form'],
                            endTime: exams[index]['time_to'],
                          ));
                    })
                : Center(
                    child: Text("No Notice Found"),
                  ));
  }
}

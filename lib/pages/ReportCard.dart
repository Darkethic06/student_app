import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studentapp/utils/api.dart';
import 'package:studentapp/utils/myColors.dart';
import 'package:studentapp/views/ReportCardContainer.dart';
import 'package:http/http.dart' as http;

class ReportCardPage extends StatefulWidget {
  const ReportCardPage({super.key});

  @override
  State<ReportCardPage> createState() => _ReportCardPageState();
}

class _ReportCardPageState extends State<ReportCardPage> {
  List reportCards = [];

  fetchReportcard() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final uri = Uri.parse('$basePath/reportcard');
    final headers = {'Authorization': 'Bearer $token'};
    await http.get(uri, headers: headers).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        reportCards = result['data'];
        // print(result['data']);
        // print(reportCards[0]);
        // print(reportCards[0]['class']);
        // print(reportCards[0]['created_at']);
        // print(reportCards[0]['created_at']);
        // print(reportCards[0]['file_full_path']);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fetchReportcard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            "Report Card",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: mainColor,
          centerTitle: true,
        ),
        body: reportCards.isEmpty
            ? Center(
                child: CircularProgressIndicator(),
              )
            : reportCards.isNotEmpty
                ? ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                    itemCount: reportCards.length,
                    itemBuilder: (context, index) {
                      return ReportCardContainer(
                        title: reportCards[index]['exam']['name'],
                        examClass: reportCards[index]['class']['class'],
                        published: reportCards[index]['created_at'],
                        file: reportCards[index]['file_full_path'],
                      );
                    })
                : Center(
                    child: Text("No Notice Found"),
                  ));
  }
}

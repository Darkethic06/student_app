import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studentapp/utils/api.dart';
import 'package:http/http.dart' as http;
import 'package:studentapp/views/NoticeCard.dart';

class ClassNotice extends StatefulWidget {
  const ClassNotice({super.key});

  @override
  State<ClassNotice> createState() => _ClassNoticeState();
}

class _ClassNoticeState extends State<ClassNotice> {
  List notice = [];

  fetchNotice() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final uri = Uri.parse('$basePath/get-class-notice-list');
    final headers = {'Authorization': 'Bearer $token'};
    await http.get(uri, headers: headers).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        notice = result['data'];
        print(notice);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fetchNotice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: notice.isEmpty
            ? Center(
                child: CircularProgressIndicator(),
              )
            : notice.length > 0
                ? ListView.builder(
                    itemCount: notice.length,
                    itemBuilder: (context, index) {
                      return NoticeCard(
                        title: notice[index]['notice_class']['title'],
                        date: notice[index]['notice_class']['created_at'],
                        file: notice[index]['notice_class']['file_full_path'],
                      );
                      // return Text("hello");
                    })
                : Center(
                    child: Text("No Notice Found"),
                  ));
  }
}

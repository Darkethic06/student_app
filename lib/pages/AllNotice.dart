import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studentapp/utils/api.dart';
import 'package:http/http.dart' as http;

import '../views/NoticeCard.dart';

class AllNotice extends StatefulWidget {
  const AllNotice({super.key});

  @override
  State<AllNotice> createState() => _AllNoticeState();
}

class _AllNoticeState extends State<AllNotice> {
  List notice = [];

  fetchNotice() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final uri = Uri.parse('$basePath/get-school-notice-list');
    final headers = {'Authorization': 'Bearer $token'};
    await http.get(uri, headers: headers).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        notice = result['data'];
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
                      // print(notice[index]['title']);
                      return NoticeCard(
                        title: notice[index]['title'],
                        date: notice[index]['created_at'],
                        file: notice[index]['file_full_path'],
                      );
                      // return Text("hello");
                    })
                : Center(
                    child: Text("No Notice Found"),
                  ));
  }
}

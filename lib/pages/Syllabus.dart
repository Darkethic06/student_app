import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:flutter_media_downloader/flutter_media_downloader.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studentapp/pages/ViewSyllabusPdf.dart';
import 'package:studentapp/utils/api.dart';
import 'package:studentapp/utils/myColors.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class SyllabusPage extends StatefulWidget {
  const SyllabusPage({super.key});

  @override
  State<SyllabusPage> createState() => _SyllabusPageState();
}

class _SyllabusPageState extends State<SyllabusPage> {
  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat('MM/dd/yyyy hh:mm a');
  final _flutterMediaDownloaderPlugin = MediaDownload();
  var data = [];

  fetchSyllabus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final uri = Uri.parse('$basePath/syllabus');
    final headers = {'Authorization': 'Bearer $token'};
    await http.get(uri, headers: headers).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        data = result['data'];
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fetchSyllabus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Syllabus",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: mainColor,
      ),
      body: SafeArea(
        child: data.isNotEmpty
            ? buildContent()
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget buildContent() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      itemCount: data.length,
      itemBuilder: (context, index) {
        return buildSyllabusItem(data[index]);
      },
    );
  }

  Widget buildSyllabusItem(Map<String, dynamic> syllabus) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        height: 150,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.white,
              width: 1.0,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 10.0,
              spreadRadius: 4.0,
              offset: Offset(5.0, 5.0),
            ),
          ],
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                syllabus['title'],
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
              child: Text(
                "Updated On: " +
                    DateFormat('d/M/yyyy h:mm a')
                        .format(DateTime.parse(syllabus['created_at'])),
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewSyllabusPdf(
                                  pdfLink: syllabus['file_full_path'])),
                        );
                      },
                      child: Row(
                        children: [
                          Text(
                            "View",
                            style: TextStyle(color: blueColor),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.0),
                            child: Icon(
                              Icons.visibility,
                              color: blueColor,
                            ),
                          )
                        ],
                      )),
                  TextButton(
                      onPressed: () async {
                        _flutterMediaDownloaderPlugin.downloadMedia(
                            context, syllabus['file_full_path']);
                      },
                      child: Row(
                        children: [
                          Text(
                            "Download",
                            style: TextStyle(color: blueColor),
                          ),
                          // Icon(Icons.arrow_downward, color: blueColor)
                          Icon(
                            Boxicons.bx_download,
                            color: blueColor,
                          )
                        ],
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

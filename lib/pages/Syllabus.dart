import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
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

  var data = null;

  fetchSyllabus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final uri = Uri.parse('$basePath/syllabus');
    final headers = {'Authorization': 'Bearer $token'};
    await http.get(uri, headers: headers).then((value) {
      Map result = jsonDecode(value.body);
      // print(value.body);
      setState(() {
        data = result['data'];
        print(data);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
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
        child: data != null && data.isNotEmpty
            ? buildContent()
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget buildContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
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
                data[0]['title'],
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
                        .format(DateTime.parse(data[0]['created_at'])),
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
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => ViewSyllabusPdf(
                  //               pdfLink: data[0]['file_full_path'])),
                  //     );
                  //   },
                  //   child: Container(
                  //     width: MediaQuery.of(context).size.width / 3,
                  //     child: Column(
                  //       children: [
                  //         Icon(
                  //           Boxicons.bx_show,
                  //           size: 30,
                  //           color: btnColor,
                  //         ),
                  //         Text(
                  //           "view",
                  //           style: TextStyle(fontSize: 16),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),

                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewSyllabusPdf(
                                  pdfLink: data[0]['file_full_path'])),
                        );
                      },
                      child: Row(
                        children: [
                          Text("View"),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.0),
                            child: Icon(Icons.visibility),
                          )
                        ],
                      )),

                  // GestureDetector(
                  //   onTap: () {
                  //     print("donwload");
                  //   },
                  //   child: Container(
                  //     width: MediaQuery.of(context).size.width / 3,
                  //     child: Column(
                  //       children: [
                  //         Icon(
                  //           Boxicons.bx_download,
                  //           size: 30,
                  //           color: btnColor,
                  //         ),
                  //         Text(
                  //           "Download",
                  //           style: TextStyle(fontSize: 16),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  TextButton(
                      onPressed: () {},
                      child: Row(
                        children: [
                          Text("Download"),
                          Icon(Icons.arrow_downward)
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

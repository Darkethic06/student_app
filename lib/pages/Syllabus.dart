import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:studentapp/utils/myColors.dart';
import 'package:intl/intl.dart';

class SyllabusPage extends StatefulWidget {
  const SyllabusPage({super.key});

  @override
  State<SyllabusPage> createState() => _SyllabusPageState();
}

class _SyllabusPageState extends State<SyllabusPage> {
  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat('MM/dd/yyyy hh:mm a');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Syllabus"),
        centerTitle: true,
        backgroundColor: mainColor,
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height / 4,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.white,
                width: 1.0,
              ),
            ),
            color: Colors.black.withOpacity(0.05),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Subject : ALL",
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
                child: Text(
                  "Title : Class 3 Syllabus 2023-2024",
                  style: TextStyle(
                      color: fontColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
                  child: Text("Updated On: " + formatter.format(now))),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width / 3,
                        child: Column(
                          children: [
                            Icon(
                              Boxicons.bx_show,
                              size: 30,
                              color: btnColor,
                            ),
                            Text(
                              "view",
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        )),
                    GestureDetector(
                      onTap: () {
                        print("hello");
                      },
                      child: Container(
                          width: MediaQuery.of(context).size.width / 3,
                          child: Column(
                            children: [
                              Icon(
                                Boxicons.bx_download,
                                size: 30,
                                color: btnColor,
                              ),
                              Text(
                                "Download",
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studentapp/utils/api.dart';
import 'package:studentapp/utils/myColors.dart';
import 'package:http/http.dart' as http;

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  List session_list = [];
  int? dropdownvalue;
  bool is_data = false;
  // String? monthValue;
  // List attendance_List = [];
  String? totalClass;
  String? totalAttend;
  String? totalPercentage;
  Map<String, dynamic> attendanceData = {};

  Future<void> fetchSession() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final uri = Uri.parse('$basePath/get-all-sessions');
    final headers = {'Authorization': 'Bearer $token'};
    final response = await http.get(uri, headers: headers);

    final data = jsonDecode(response.body);
    setState(() {
      session_list = data['data'];
      // print(session_list);
    });
  }

  Future<void> fetchAttendanceData(int sessionId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final uri =
        Uri.parse('$basePath/get-user-attendance-list?sessionid=$sessionId');
    final headers = {'Authorization': 'Bearer $token'};
    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        print(data);
        attendanceData = data['data']['month'];
        totalAttend = data['data']['total_present'].toString();
        totalClass = data['data']['total_class'].toString();
        totalPercentage = data['data']['total_percentage'].toString();
        is_data = true;
      });
    } else {
      setState(() {
        is_data = false;
      });
      print('Error: ${response.reasonPhrase}');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchSession();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "ATTENDANCE",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: mainColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 10.0,
                    spreadRadius: 4.0,
                    offset: Offset(5.0, 5.0),
                  ),
                ],
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
                  isExpanded: true,
                  style: TextStyle(color: Colors.black),
                  value: dropdownvalue,
                  hint: Text("Select Session",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600)),
                  icon: const Icon(Icons.keyboard_arrow_down,
                      color: Colors.black),
                  items: session_list.map<DropdownMenuItem<int>>((items) {
                    return DropdownMenuItem<int>(
                      value: items['id'],
                      child: Text(
                        items['session_name'],
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    );
                  }).toList(),
                  onChanged: (int? value) {
                    setState(() {
                      dropdownvalue = value!;
                      // print(dropdownvalue);
                      fetchAttendanceData(dropdownvalue!);
                    });
                  },
                ),
              ),
            ),
          ),
          is_data
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 15),
                  child: Container(
                    width: MediaQuery.of(context).size.width - 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          blurRadius: 10.0,
                          spreadRadius: 4.0,
                          offset: Offset(5.0, 5.0),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total Class Held: $totalClass",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "Total Class Attended: $totalAttend",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "Attendance Percentage: $totalPercentage%",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              : Container(),
          is_data
              ? Container(
                  // width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 10.0,
                        spreadRadius: 4.0,
                        offset: Offset(5.0, 5.0),
                      ),
                    ],
                  ),
                  child: Expanded(
                    child: SingleChildScrollView(
                      // scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('Month')),
                          DataColumn(label: Text('Classes Held')),
                          DataColumn(label: Text('Classes Present')),
                        ],
                        rows: attendanceData.entries.map((entry) {
                          return DataRow(cells: [
                            DataCell(
                                Text(entry.key, textAlign: TextAlign.center)),
                            DataCell(Text(
                              entry.value['held'].toString(),
                              textAlign: TextAlign.center,
                            )),
                            DataCell(Text(entry.value['present'].toString(),
                                textAlign: TextAlign.center)),
                          ]);
                        }).toList(),
                      ),
                    ),
                  ),
                )
              : Center(
                  child: Text("No attendance data available."),
                ),
        ],
      ),
    );
  }
}

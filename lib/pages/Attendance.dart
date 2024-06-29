import 'dart:convert';
import 'package:flutter/material.dart';
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
  List sessionList = [];
  int? dropdownValue;
  bool isData = false;
  String? totalClass;
  String? totalAttend;
  String? totalPercentage;
  Map<String, dynamic> attendanceData = {};

  Future<void> fetchSession() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final uri = Uri.parse('$basePath/get-all-sessions');
      final headers = {'Authorization': 'Bearer $token'};
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          sessionList = data['data'];
        });
      } else {
        throw Exception('Failed to load sessions');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> fetchAttendanceData(int sessionId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      final uri =
          Uri.parse('$basePath/get-user-attendance-list?sessionid=$sessionId');
      final headers = {'Authorization': 'Bearer $token'};
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          attendanceData = data['data']['month'];
          totalAttend = data['data']['total_present'].toString();
          totalClass = data['data']['total_class'].toString();
          totalPercentage = data['data']['total_percentage'].toString();
          isData = true;
        });
      } else {
        setState(() {
          isData = false;
        });
        throw Exception('Failed to load attendance data');
      }
    } catch (e) {
      print('Error: $e');
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
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "ATTENDANCE",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: mainColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15),
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
                      offset: const Offset(5.0, 5.0),
                    ),
                  ],
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<int>(
                    isExpanded: true,
                    style: const TextStyle(color: Colors.black),
                    value: dropdownValue,
                    hint: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Text(
                        "Select Session",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    icon: const Icon(Icons.keyboard_arrow_down,
                        color: Colors.black),
                    items: sessionList.map<DropdownMenuItem<int>>((items) {
                      return DropdownMenuItem<int>(
                        value: items['id'],
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            items['session_name'],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (int? value) {
                      setState(() {
                        dropdownValue = value!;
                        fetchAttendanceData(dropdownValue!);
                      });
                    },
                  ),
                ),
              ),
            ),
            isData
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 15),
                    child: Container(
                      width: MediaQuery.of(context).size.width - 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 10.0,
                            spreadRadius: 4.0,
                            offset: const Offset(5.0, 5.0),
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
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "Total Class Attended: $totalAttend",
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "Attendance Percentage: $totalPercentage%",
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
            isData
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 15),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 10.0,
                            spreadRadius: 4.0,
                            offset: const Offset(5.0, 5.0),
                          ),
                        ],
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
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
                : const Center(
                    child: Text("No attendance data available."),
                  ),
          ],
        ),
      ),
    );
  }
}

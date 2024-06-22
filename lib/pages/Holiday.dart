import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studentapp/utils/api.dart';
import 'package:studentapp/utils/myColors.dart';
import 'package:http/http.dart' as http;

class HolidayPage extends StatefulWidget {
  const HolidayPage({super.key});

  @override
  State<HolidayPage> createState() => _HolidayPageState();
}

class _HolidayPageState extends State<HolidayPage> {
  List session_list = [];
  int? dropdownvalue;
  bool is_data = true;
  List holiday_List = [];

  Future<void> fetchSession() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final uri = Uri.parse('$basePath/get-all-sessions');
    final headers = {'Authorization': 'Bearer $token'};
    final response = await http.get(uri, headers: headers);

    final data = jsonDecode(response.body);
    setState(() {
      session_list = data['data'];
    });
  }

  Future<void> fetchHolidayData(int sessionId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final uri =
        Uri.parse('$basePath/get-all-holiday-list?sessionid=$sessionId');
    final headers = {'Authorization': 'Bearer $token'};
    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // Handle the data as needed
      setState(() {
        holiday_List = data['data'];
      });
      print(holiday_List);
    } else {
      // Handle the error as needed
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
          "Holiday",
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
                      EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
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
                      fetchHolidayData(dropdownvalue!);
                    });
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: holiday_List.isEmpty
                  ? [
                      Container(
                        // color: Colors.yellow,
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                            child: is_data
                                ? Text(
                                    'Please Select a Session',
                                    style: TextStyle(color: Colors.black),
                                  )
                                : Text("No data found")),
                      ),
                    ]
                  : holiday_List.map((item) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width - 60,
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
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Text(
                                      item['title'],
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(Boxicons.bx_calendar),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text(
                                          item['from_date'],
                                          // "he",
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
            ),
          )
        ],
      ),
    );
  }
}

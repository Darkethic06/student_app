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
  int? monthValue;
  List holiday_List = [];
  bool isMonthData = true;

  int? setSessionid;

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
      setState(() {
        holiday_List = data['data'];
      });
    } else {
      setState(() {
        is_data = false;
      });
      print('Error: ${response.reasonPhrase}');
    }
  }

  Future<void> fetchHolidayDataBasedOnMonth(int monthId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (setSessionid == null) {
      return;
    }
    final uri = Uri.parse(
        '$basePath/get-all-holiday-list?sessionid=$setSessionid&month=$monthId');
    final headers = {'Authorization': 'Bearer $token'};
    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        holiday_List = data['data'];
        isMonthData = true;
      });
    } else {
      setState(() {
        isMonthData = false;
      });
      print('Error: ${response.reasonPhrase}');
    }
  }

  List month_list = [
    {"id": 1, "month": "January"},
    {"id": 2, "month": "February"},
    {
      "id": 3,
      "month": "March",
    },
    {"id": 4, "month": "April"},
    {"id": 5, "month": "May"},
    {"id": 6, "month": "June"},
    {"id": 7, "month": "July"},
    {"id": 8, "month": "August"},
    {"id": 9, "month": "September"},
    {"id": 10, "month": "October"},
    {"id": 11, "month": "November"},
    {"id": 12, "month": "December"}
  ];

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
                      setSessionid = value;
                      fetchHolidayData(dropdownvalue!);
                    });
                  },
                ),
              ),
            ),
          ),
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
                  value: monthValue,
                  hint: Text("Select Month",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600)),
                  icon: const Icon(Icons.keyboard_arrow_down,
                      color: Colors.black),
                  items: month_list.map<DropdownMenuItem<int>>((items) {
                    return DropdownMenuItem<int>(
                      value: items['id'],
                      child: Text(
                        items['month'],
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    );
                  }).toList(),
                  onChanged: (int? monthId) {
                    setState(() {
                      monthValue = monthId!;
                      fetchHolidayDataBasedOnMonth(monthValue!);
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(children: [
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
                                      ]),
                                      item['to_date'] != null
                                          ? Row(children: [
                                              const Icon(Boxicons.bx_calendar),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0),
                                                child: Text(
                                                  item['to_date'] != null
                                                      ? item['to_date']
                                                      : '',
                                                  // "he",
                                                  style: TextStyle(
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                            ])
                                          : Text("")
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

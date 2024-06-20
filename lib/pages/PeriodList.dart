import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studentapp/utils/api.dart';
import 'package:studentapp/utils/myColors.dart';
import 'package:http/http.dart' as http;

class PeriodList extends StatefulWidget {
  const PeriodList({super.key});

  @override
  State<PeriodList> createState() => _PeriodListState();
}

class _PeriodListState extends State<PeriodList> {
  List day_list = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday"
  ];
  String? dropdownvalue;
  List holiday_data = [];

  Future<void> fetchHolidayData(String day) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final uri = Uri.parse('$basePath/get-period-list?day=$day');
    final headers = {'Authorization': 'Bearer $token'};
    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        holiday_data = data['data'];
      });
      // print(holiday_data);
    } else {
      print('Error: ${response.reasonPhrase}');
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  //   // fetchSession();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "Time Table",
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
                    hint: Text("Select Day",
                        style: TextStyle(color: Colors.black, fontSize: 18)),
                    icon: const Icon(Icons.keyboard_arrow_down,
                        color: Colors.black),
                    items: day_list.map<DropdownMenuItem<String>>((items) {
                      return DropdownMenuItem<String>(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      // setState(() {
                      //   dropdownvalue = value!;
                      //   fetchHolidayData(dropdownvalue!);
                      // });
                      if (value != null) {
                        setState(() {
                          dropdownvalue = value;
                          fetchHolidayData(value);
                        });
                      }
                    },
                  ),
                ),
              ),
            ),
            Container(
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
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Period Name')),
                  DataColumn(label: Text('Subject Name')),
                ],
                rows: holiday_data.isEmpty
                    ? [
                        DataRow(cells: [
                          DataCell(Text(
                            'Please select a Day',
                            textAlign: TextAlign.center,
                          )),
                          DataCell(Text('')), // Empty cell for alignment
                        ]),
                      ]
                    : holiday_data.map<DataRow>((item) {
                        // print(item);
                        return DataRow(cells: [
                          DataCell(Text(
                            item['period_name'],
                            textAlign: TextAlign.center,
                          )),
                          DataCell(Text(
                            item['subject']['title'],
                            textAlign: TextAlign.center,
                          )),
                        ]);
                      }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

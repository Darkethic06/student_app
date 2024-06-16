import 'package:flutter/material.dart';
import 'package:studentapp/pages/AllTeacher.dart';
import 'package:studentapp/pages/SubjectTeacher.dart';
import 'package:studentapp/utils/myColors.dart';

class TeachersPage extends StatefulWidget {
  const TeachersPage({super.key});

  @override
  State<TeachersPage> createState() => _TeachersPageState();
}

class _TeachersPageState extends State<TeachersPage> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "TEACHER",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: mainColor,
        centerTitle: true,
        // bottom: TabBar(
        //     labelColor: Colors.white,
        //     unselectedLabelColor: btnColor,
        //     indicatorColor: btnColor,
        //     tabs: <Widget>[
        //       Container(
        //         child: Tab(
        //           text: "All Teacher",
        //         ),
        //       ),
        //       Tab(
        //         text: "Class Teacher",
        //       ),
        //     ]),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildButton("All Teacher", 0),
                buildButton("Class Teacher", 1),
              ],
            ),
            Expanded(
              child: IndexedStack(
                index: _selectedIndex,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: AllTeacher(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: SubjectTeacher(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildButton(String text, int index) {
    return Container(
      height: 40,
      width: MediaQuery.of(context).size.width / 3,
      decoration: BoxDecoration(
        color: _selectedIndex == index ? mainColor : Colors.white,
        borderRadius: BorderRadius.circular(0.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            offset: Offset(0, 3),
            blurRadius: 10.0,
          ),
        ],
      ),
      child: TextButton(
        onPressed: () {
          setState(() {
            _selectedIndex = index;
          });
        },
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            color: _selectedIndex == index ? Colors.white : mainColor,
          ),
        ),
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
      ),
    );
  }
}

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
  List pages = [];
  // int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                "Teachers",
              ),
              backgroundColor: mainColor,
              centerTitle: true,
              bottom: TabBar(
                  labelColor: Colors.white,
                  unselectedLabelColor: btnColor,
                  indicatorColor: btnColor,
                  tabs: <Widget>[
                    Container(
                      child: Tab(
                        text: "All Teacher",
                      ),
                    ),
                    Tab(
                      text: "Class Teacher",
                    ),
                  ]),
            ),
            body: TabBarView(
              children: [AllTeacher(), SubjectTeacher()],
            )));
  }
}

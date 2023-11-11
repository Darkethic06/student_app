import 'package:flutter/material.dart';
import 'package:studentapp/utils/myColors.dart';
import 'package:studentapp/views/ReportCardContainer.dart';

import 'AllTeacher.dart';
import 'SubjectTeacher.dart';

class AssignmentsPage extends StatefulWidget {
  const AssignmentsPage({super.key});

  @override
  State<AssignmentsPage> createState() => _AssignmentsPageState();
}

class _AssignmentsPageState extends State<AssignmentsPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                "Assignments",
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
                        text: "All",
                      ),
                    ),
                    Tab(
                      text: "Subjects",
                    ),
                  ]),
            ),
            body: TabBarView(
              children: [],
            )));
  }
}

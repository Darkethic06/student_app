import 'package:flutter/material.dart';
import 'package:studentapp/utils/myColors.dart';
import 'package:studentapp/views/ReportCardContainer.dart';

class ReportCardPage extends StatefulWidget {
  const ReportCardPage({super.key});

  @override
  State<ReportCardPage> createState() => _ReportCardPageState();
}

class _ReportCardPageState extends State<ReportCardPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Report Card",
            ),
            backgroundColor: mainColor,
            centerTitle: true,
            bottom: TabBar(
                isScrollable: true,
                labelColor: Colors.white,
                unselectedLabelColor: btnColor,
                indicatorColor: btnColor,
                tabs: <Widget>[
                  Tab(
                    child: Text(
                      "KG-C\n2020-2021",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Tab(
                    child: Text(
                      "KG-C\n2020-2021",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Tab(
                    child: Text(
                      "KG-C\n2020-2021",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Tab(
                    child: Text(
                      "KG-C\n2020-2021",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Tab(
                    child: Text(
                      "KG-C\n2020-2021",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ]),
          ),
          body: TabBarView(
            children: [ReportCardContainer()],
          )),
    );
  }
}

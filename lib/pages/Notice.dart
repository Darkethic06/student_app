import 'package:flutter/material.dart';
import 'package:studentapp/pages/AllNotice.dart';
import 'package:studentapp/pages/ClassNotice.dart';
import 'package:studentapp/utils/myColors.dart';

class NoticePage extends StatefulWidget {
  const NoticePage({super.key});

  @override
  State<NoticePage> createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Notice",
            ),
            centerTitle: true,
            backgroundColor: mainColor,
            bottom: TabBar(
                labelColor: Colors.white,
                unselectedLabelColor: btnColor,
                indicatorColor: btnColor,
                tabs: <Widget>[
                  Container(
                    child: Tab(
                      text: "All Notice",
                    ),
                  ),
                  Tab(
                    text: "Class Notice",
                  ),
                ]),
          ),
          body: TabBarView(
            children: [AllNotice(), ClassNotice()],
          )),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:studentapp/pages/Assignments.dart';
import 'package:studentapp/pages/Classmate.dart';
import 'package:studentapp/pages/ExamPage.dart';
import 'package:studentapp/pages/Gallery.dart';
import 'package:studentapp/pages/Notice.dart';
import 'package:studentapp/pages/ReportCard.dart';
import 'package:studentapp/pages/Syllabus.dart';
import 'package:studentapp/pages/Teachers.dart';
import 'package:studentapp/utils/myColors.dart';
import 'package:studentapp/views/Feature.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 25),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 16.0),
                height: MediaQuery.of(context).size.height / 3,
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
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Attendance",
                            style: TextStyle(
                                color: mainColor,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Boxicons.bxs_chevron_right,
                                color: mainColor,
                              ))
                        ],
                      ),
                    ),
                    CircularPercentIndicator(
                      radius: MediaQuery.of(context).size.height / 9,
                      lineWidth: 15,
                      percent: 0.9,
                      backgroundColor: Colors.blue,
                      progressColor: mainColor,
                      circularStrokeCap: CircularStrokeCap.round,
                      center: Text(
                        "94%\nPercent",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: mainColor),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 16.0),
                height: 450,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => NoticePage()));
                          },
                          child: FeatureCard(
                            name: "Notice",
                            featureIcon: Icons.notifications_active,
                            mySize: 50,
                          ),
                        ),
                        GestureDetector(
                          child: FeatureCard(
                            name: "Attendance",
                            featureIcon: Icons.school_rounded,
                            mySize: 50,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ExamPage()));
                          },
                          child: FeatureCard(
                            name: "Exam",
                            featureIcon: Icons.timer_rounded,
                            mySize: 50,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AssignmentsPage()));
                          },
                          child: FeatureCard(
                            name: "Assignment",
                            featureIcon: Icons.edit_note_rounded,
                            mySize: 50,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SyllabusPage()));
                          },
                          child: FeatureCard(
                            name: "Syllabus",
                            featureIcon: Icons.collections_bookmark_rounded,
                            mySize: 50,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => TeachersPage()));
                          },
                          child: FeatureCard(
                            name: "Teachers",
                            featureIcon: Icons.contact_page_rounded,
                            mySize: 50,
                          ),
                        ),
                        GestureDetector(
                          onTap: (() {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ClassmatePage()));
                          }),
                          child: FeatureCard(
                            name: "Classmates",
                            featureIcon: Icons.groups_rounded,
                            mySize: 50,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ReportCardPage()));
                          },
                          child: FeatureCard(
                            name: "Report Card",
                            featureIcon: Icons.cast_for_education,
                            mySize: 50,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => GalleryPage()));
                            },
                            child: FeatureCard(
                              name: "Gallery",
                              featureIcon: Icons.image,
                              mySize: 50,
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 16.0, right: 16.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => GalleryPage()));
                            },
                            child: FeatureCard(
                              name: "Holidays",
                              featureIcon: Icons.beach_access,
                              mySize: 50,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => GalleryPage()));
                          },
                          child: FeatureCard(
                            name: "Time Table",
                            featureIcon: Icons.calendar_month,
                            mySize: 50,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )

              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: GridView(
              //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //         crossAxisCount: 4,
              //         crossAxisSpacing: 15,
              //         mainAxisSpacing: 15),
              //     children: [
              // GestureDetector(
              //   onTap: () {
              //     Navigator.of(context).push(MaterialPageRoute(
              //         builder: (context) => NoticePage()));
              //   },
              //   child: FeatureCard(
              //     name: "Notice",
              //     featureIcon: Icons.notifications_active,
              //     mySize: 50,
              //   ),
              // ),
              // FeatureCard(
              //   name: "Attendance",
              //   featureIcon: Icons.school_rounded,
              //   mySize: 50,
              // ),
              // GestureDetector(
              //   onTap: () {
              //     Navigator.of(context).push(MaterialPageRoute(
              //         builder: (context) => ExamPage()));
              //   },
              //   child: FeatureCard(
              //     name: "Exam",
              //     featureIcon: Icons.timer_rounded,
              //     mySize: 50,
              //   ),
              // ),
              // GestureDetector(
              //   onTap: () {
              //     Navigator.of(context).push(MaterialPageRoute(
              //         builder: (context) => AssignmentsPage()));
              //   },
              //   child: FeatureCard(
              //     name: "Assignment",
              //     featureIcon: Icons.edit_note_rounded,
              //     mySize: 50,
              //   ),
              // ),
              // GestureDetector(
              //   onTap: () {
              //     Navigator.of(context).push(MaterialPageRoute(
              //         builder: (context) => SyllabusPage()));
              //   },
              //   child: FeatureCard(
              //     name: "Syllabus",
              //     featureIcon: Icons.collections_bookmark_rounded,
              //     mySize: 50,
              //   ),
              // ),
              // GestureDetector(
              //   onTap: () {
              //     Navigator.of(context).push(MaterialPageRoute(
              //         builder: (context) => TeachersPage()));
              //   },
              //   child: FeatureCard(
              //     name: "Teachers",
              //     featureIcon: Icons.contact_page_rounded,
              //     mySize: 50,
              //   ),
              // ),
              // GestureDetector(
              //   onTap: (() {
              //     Navigator.of(context).push(MaterialPageRoute(
              //         builder: (context) => ClassmatePage()));
              //   }),
              //   child: FeatureCard(
              //     name: "Classmates",
              //     featureIcon: Icons.groups_rounded,
              //     mySize: 50,
              //   ),
              // ),
              // GestureDetector(
              //   onTap: () {
              //     Navigator.of(context).push(MaterialPageRoute(
              //         builder: (context) => ReportCardPage()));
              //   },
              //   child: FeatureCard(
              //     name: "Report Card",
              //     featureIcon: Icons.cast_for_education,
              //     mySize: 50,
              //   ),
              // ),
              // GestureDetector(
              //   onTap: () {
              //     Navigator.of(context).push(MaterialPageRoute(
              //         builder: (context) => GalleryPage()));
              //   },
              //   child: FeatureCard(
              //     name: "Gallery",
              //     featureIcon: Icons.image,
              //     mySize: 50,
              //   ),
              // ),
              // GestureDetector(
              //   onTap: () {
              //     Navigator.of(context).push(MaterialPageRoute(
              //         builder: (context) => GalleryPage()));
              //   },
              //   child: FeatureCard(
              //     name: "Holidays",
              //     featureIcon: Icons.beach_access,
              //     mySize: 50,
              //   ),
              // ),
              // GestureDetector(
              //   onTap: () {
              //     Navigator.of(context).push(MaterialPageRoute(
              //         builder: (context) => GalleryPage()));
              //   },
              //   child: FeatureCard(
              //     name: "Time Table",
              //     featureIcon: Icons.calendar_month,
              //     mySize: 50,
              //   ),
              // ),
              // ],
              // ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

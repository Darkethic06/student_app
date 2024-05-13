import 'package:flutter/material.dart';
import 'package:studentapp/pages/Assignments.dart';
import 'package:studentapp/pages/Classmate.dart';
import 'package:studentapp/pages/Fee.dart';
import 'package:studentapp/pages/Gallery.dart';
import 'package:studentapp/pages/Notice.dart';
import 'package:studentapp/pages/ReportCard.dart';
import 'package:studentapp/pages/SubjectTeacher.dart';
import 'package:studentapp/pages/Syllabus.dart';
import 'package:studentapp/pages/Teachers.dart';
import 'package:studentapp/views/Feature.dart';
import '../views/Topbar.dart';
import 'Notification.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 25),
        child: Column(
          children: [
            // Topbar(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15),
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
                    // FeatureCard(
                    //   name: "Activity",
                    //   featureIcon: Icons.calendar_month,
                    //   mySize: 50,
                    // ),
                    FeatureCard(
                      name: "Attendance",
                      featureIcon: Icons.school_rounded,
                      mySize: 50,
                    ),
                    FeatureCard(
                      name: "Exam",
                      featureIcon: Icons.timer_rounded,
                      mySize: 50,
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
                    GestureDetector(
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
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}

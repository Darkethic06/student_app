import 'package:flutter/material.dart';

import '../views/ClassmateCard.dart';

class SubjectTeacher extends StatefulWidget {
  const SubjectTeacher({super.key});

  @override
  State<SubjectTeacher> createState() => _SubjectTeacherState();
}

class _SubjectTeacherState extends State<SubjectTeacher> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        SizedBox(
          height: 20,
        ),
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 0, mainAxisSpacing: 8),
            itemCount: 50,
            itemBuilder: ((context, index) {
              return ClassmateCard(name: "Teacher Name $index");
            }),
          ),
        ),
      ]),
    );
  }
}

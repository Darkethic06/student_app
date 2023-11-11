import 'package:flutter/material.dart';

import '../views/ClassmateCard.dart';

class AllTeacher extends StatefulWidget {
  const AllTeacher({super.key});

  @override
  State<AllTeacher> createState() => _AllTeacherState();
}

class _AllTeacherState extends State<AllTeacher> {
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

import 'package:flutter/material.dart';

class ClassNotice extends StatefulWidget {
  const ClassNotice({super.key});

  @override
  State<ClassNotice> createState() => _ClassNoticeState();
}

class _ClassNoticeState extends State<ClassNotice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Class Notice"),
      ),
    );
  }
}

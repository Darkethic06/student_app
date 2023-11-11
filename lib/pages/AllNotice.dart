import 'package:flutter/material.dart';

class AllNotice extends StatefulWidget {
  const AllNotice({super.key});

  @override
  State<AllNotice> createState() => _AllNoticeState();
}

class _AllNoticeState extends State<AllNotice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("All Notice"),
      ),
    );
  }
}

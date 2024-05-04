import 'package:flutter/material.dart';
import 'package:studentapp/utils/myColors.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ViewSyllabusPdf extends StatelessWidget {
  final String pdfLink;
  const ViewSyllabusPdf({super.key, required this.pdfLink});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "View PDF",
          style: TextStyle(color: Color(0xffFFFFFF)),
        ),
        centerTitle: true,
        backgroundColor: mainColor,
      ),
      body: SfPdfViewer.network(pdfLink),
    );
  }
}

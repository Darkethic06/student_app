import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:studentapp/pages/ViewSyllabusPdf.dart';
import 'package:studentapp/utils/myColors.dart';

// ignore: must_be_immutable
class NoticeCard extends StatelessWidget {
  final String title;
  final String date;
  final String file;
  NoticeCard(
      {super.key, required this.title, required this.date, required this.file});
  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat('MM/dd/yyyy hh:mm a');
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() => {
            print(file),
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ViewSyllabusPdf(pdfLink: file)),
            )
          }),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 6,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.white,
              width: 1.0,
            ),
          ),
          color: Colors.black.withOpacity(0.05),
        ),
        child: Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
              ),
              Text(
                "Published On: " +
                    DateFormat('d/M/yyyy h:mm a').format(DateTime.parse(date)),
                style: TextStyle(
                  color: fontColor,
                  fontSize: 18,
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}

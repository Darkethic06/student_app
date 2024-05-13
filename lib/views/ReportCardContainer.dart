import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:studentapp/pages/ViewSyllabusPdf.dart';
import 'package:studentapp/utils/myColors.dart';

// ignore: must_be_immutable
class ReportCardContainer extends StatelessWidget {
  final String title;
  final String examDate;
  final String published;
  final String file;

  ReportCardContainer(
      {super.key,
      required this.title,
      required this.examDate,
      required this.published,
      required this.file});
  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat('MM/dd/yyyy hh:mm a');
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 5,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.white,
                width: 1.0,
              ),
            ),
            color: Colors.black.withOpacity(0.05),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.s,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.assignment,
                  size: 60,
                ),
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      "Exam Date:" +
                          DateFormat('d/M/yyyy')
                              .format(DateTime.parse(examDate)),
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                  Text(
                    "Published On:" +
                        DateFormat('d/M/yyyy h:mm a')
                            .format(DateTime.parse(published)),
                    style: TextStyle(
                      color: fontColor,
                      fontSize: 18,
                    ),
                  )
                ],
              )),
            ],
          ),
        ),
        Row(
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewSyllabusPdf(pdfLink: file)),
                    );
                  },
                  child: Text(
                    "View",
                    style: TextStyle(fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: btnColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.zero),
                    ),
                  ),
                )),
            SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Download",
                    style: TextStyle(fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: btnColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.zero),
                    ),
                  ),
                ))
          ],
        )
      ],
    );
  }
}

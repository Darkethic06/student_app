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
          // color: Colors.black.withOpacity(0.05),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      title,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      "Date " +
                          DateFormat('d/M/yyyy').format(DateTime.parse(date)),
                      style: TextStyle(
                        color: fontColor,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      "Updated on " +
                          DateFormat('d/M/yyyy').format(DateTime.parse(date)),
                      style: TextStyle(
                        color: fontColor,
                        fontSize: 15,
                      ),
                    ),
                  )
                ],
              ),
            )),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
              child: Icon(
                Icons.assignment,
                size: 40,
                color: mainColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}

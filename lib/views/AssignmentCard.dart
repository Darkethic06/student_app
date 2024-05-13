import 'package:flutter/material.dart';
import 'package:studentapp/pages/ViewSyllabusPdf.dart';
import 'package:studentapp/utils/myColors.dart';
import 'package:intl/intl.dart';

class AssignmentCard extends StatelessWidget {
  final String title;
  final String assigndOn;
  final String submittedBy;
  final String updated;
  final String file;
  final String subject;
  const AssignmentCard(
      {super.key,
      required this.title,
      required this.assigndOn,
      required this.submittedBy,
      required this.updated,
      required this.subject,
      required this.file});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          // height: MediaQuery.of(context).size.height / 4,
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
                  Text(
                    "(" + subject + ")",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      "Assigned On:" +
                          DateFormat('d/M/yyyy')
                              .format(DateTime.parse(assigndOn)),
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                  Text(
                    "To Be Submitted On:" +
                        DateFormat('d/M/yyyy')
                            .format(DateTime.parse(submittedBy)),
                    style: TextStyle(
                      color: fontColor,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "Updated By: " +
                        DateFormat('d/M/yyyy').format(DateTime.parse(updated)),
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
        SizedBox(
            width: MediaQuery.of(context).size.width,
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
            ))
      ],
    );
  }
}

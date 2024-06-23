import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExamCard extends StatelessWidget {
  final String title;
  final String subject;
  final String examDate;
  final String startTime;
  final String endTime;
  const ExamCard(
      {super.key,
      required this.title,
      required this.subject,
      required this.examDate,
      required this.startTime,
      required this.endTime});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: Colors.white,
                    width: 1.0,
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 10.0,
                    spreadRadius: 4.0,
                    offset: Offset(5.0, 5.0),
                  ),
                ]
                // color: Colors.white,
                ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.s,
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Icon(
                  //     Icons.assignment,
                  //     size: 60,
                  //   ),
                  // ),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      Text(
                        "(" + subject + ")",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          "Exam Date: " +
                              DateFormat('d/M/yyyy')
                                  .format(DateTime.parse(examDate)),
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Text(
                        "Exam Time: " +
                            DateFormat("h:mm a").format(
                                DateFormat("HH:mm:ss").parse(startTime)) +
                            " - " +
                            DateFormat("h:mm a")
                                .format(DateFormat("HH:mm:ss").parse(endTime)),
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

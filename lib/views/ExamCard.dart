import 'package:flutter/material.dart';
import 'package:studentapp/utils/myColors.dart';
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
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "(" + subject + ")",
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF3D6386)),
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
                      "Exam Time:" + startTime + "-" + endTime,
                      style: TextStyle(
                        color: fontColor,
                        fontSize: 18,
                      ),
                    ),
                  ],
                )),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

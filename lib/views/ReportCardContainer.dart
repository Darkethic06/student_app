import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:studentapp/pages/ViewSyllabusPdf.dart';
import 'package:studentapp/utils/myColors.dart';

// ignore: must_be_immutable
class ReportCardContainer extends StatelessWidget {
  final String title;
  final String examClass;
  final String published;
  final String file;

  ReportCardContainer(
      {super.key,
      required this.title,
      required this.examClass,
      required this.published,
      required this.file});
  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat('MM/dd/yyyy hh:mm a');
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 5,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 10.0,
              spreadRadius: 4.0,
              offset: Offset(5.0, 5.0),
            ),
          ],
          border: Border(
            bottom: BorderSide(
              color: Colors.white,
              width: 1.0,
            ),
          ),
          // color: Colors.black.withOpacity(0.05),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.s,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          examClass,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Text(
                        "Updated On: " +
                            DateFormat('d/M/yyyy h:mm a')
                                .format(DateTime.parse(published)),
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      )
                    ],
                  )),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // SizedBox(
                //     width: MediaQuery.of(context).size.width / 2,
                //     height: 50,
                //     child: ElevatedButton(
                //       onPressed: () {
                //         Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //               builder: (context) =>
                //                   ViewSyllabusPdf(pdfLink: file)),
                //         );
                //       },
                //       child: Text(
                //         "View",
                //         style: TextStyle(fontSize: 20),
                //       ),
                //       style: ElevatedButton.styleFrom(
                //         backgroundColor: btnColor,
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.all(Radius.zero),
                //         ),
                //       ),
                //     )),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ViewSyllabusPdf(pdfLink: file)),
                      );
                    },
                    child: Row(
                      children: [
                        Text("View"),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.0),
                          child: Icon(Icons.visibility),
                        )
                      ],
                    )),
                TextButton(
                    onPressed: () {},
                    child: Row(
                      children: [Text("Download"), Icon(Icons.arrow_downward)],
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}

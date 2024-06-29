import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:flutter_media_downloader/flutter_media_downloader.dart';
import 'package:intl/intl.dart';
import 'package:studentapp/pages/ViewSyllabusPdf.dart';
import 'package:studentapp/utils/myColors.dart';

// ignore: must_be_immutable
class ReportCardContainer extends StatefulWidget {
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

  @override
  State<ReportCardContainer> createState() => _ReportCardContainerState();
}

class _ReportCardContainerState extends State<ReportCardContainer> {
  final _flutterMediaDownloaderPlugin = MediaDownload();
  DateTime now = DateTime.now();

  DateFormat formatter = DateFormat('MM/dd/yyyy hh:mm a');

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        height: 170,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
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
          ],
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.title,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                "Class: " + widget.examClass,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
              child: Text(
                "Updated On: " +
                    DateFormat('d/M/yyyy h:mm a')
                        .format(DateTime.parse(widget.published)),
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ViewSyllabusPdf(pdfLink: widget.file)),
                        );
                      },
                      child: Row(
                        children: [
                          Text(
                            "View",
                            style: TextStyle(color: blueColor),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.0),
                            child: Icon(
                              Icons.visibility,
                              color: blueColor,
                            ),
                          )
                        ],
                      )),
                  TextButton(
                      onPressed: () async {
                        _flutterMediaDownloaderPlugin.downloadMedia(
                            context, widget.file);
                      },
                      child: Row(
                        children: [
                          Text(
                            "Download",
                            style: TextStyle(color: blueColor),
                          ),
                          Icon(Icons.arrow_downward, color: blueColor)
                        ],
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

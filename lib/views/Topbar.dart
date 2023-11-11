import 'package:flutter/material.dart';
import '../pages/Notification.dart';
import '../utils/myColors.dart';

class Topbar extends StatefulWidget {
  const Topbar({super.key});
  @override
  State<Topbar> createState() => _TopbarState();
}

class _TopbarState extends State<Topbar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            decoration: BoxDecoration(
                border: Border.all(color: mainColor),
                borderRadius: BorderRadius.circular(50)),
            child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.person,
                  color: mainColor,
                ))),
        // Container(
        //     decoration: BoxDecoration(
        //         border: Border.all(color: mainColor),
        //         borderRadius: BorderRadius.circular(50)),
        //     child: IconButton(
        //         onPressed: () {
        //           Navigator.of(context).push(MaterialPageRoute(
        //               builder: (context) => NotificationPage()));
        //         },
        //         icon: Icon(
        //           Icons.notifications,
        //           color: mainColor,
        //         )))
      ],
    );
  }
}

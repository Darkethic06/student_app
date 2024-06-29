import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:studentapp/views/SplashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // requestPermission();
  }

  // Future<void> requestPermission() async {
  //   var status = await Permission.storage.status;
  //   if (status.isDenied) {
  //     // We didn't ask for permission yet or the permission has been denied before but not permanently.
  //     if (await Permission.storage.request().isGranted) {
  //       print('Permission granted');
  //     } else {
  //       print('Permission denied');
  //     }
  //   } else if (status.isPermanentlyDenied) {
  //     openAppSettings();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student App',
      home: SplashScreen(),
    );
  }
}

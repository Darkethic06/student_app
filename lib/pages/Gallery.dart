import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studentapp/utils/api.dart';
import 'package:studentapp/utils/myColors.dart';
import 'package:http/http.dart' as http;

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  List photos = [];

  fetchPhotos() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final uri = Uri.parse('$basePath/gallery');
    final headers = {'Authorization': 'Bearer $token'};
    await http.get(uri, headers: headers).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        photos = result['data'];
        print(photos);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text("GALLERY", style: TextStyle(color: Colors.white)),
          backgroundColor: mainColor,
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 15, crossAxisCount: 3, mainAxisSpacing: 15),
            itemCount: photos.length,
            itemBuilder: (context, index) {
              // print(photos[index]['full_image_path']);
              return Container(
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
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Image.network(
                    photos[index]['full_image_path'],
                    fit: BoxFit.contain,
                    width: MediaQuery.of(context).size.width / 3,
                    height: MediaQuery.of(context).size.height / 4,
                  ),
                ),
              );
            },
          ),
        ));
  }
}

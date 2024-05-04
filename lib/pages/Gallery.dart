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
          title: Text(
            "Gallery",
          ),
          backgroundColor: mainColor,
          centerTitle: true,
        ),
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Adjust columns as needed
          ),
          itemCount: photos.length,
          itemBuilder: (context, index) {
            print(photos[index]['full_image_path']);
            return Image.network(photos[index]['full_image_path'],
                fit: BoxFit.cover);
          },
        ));
  }
}

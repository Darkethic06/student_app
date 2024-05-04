import 'package:flutter/material.dart';
import 'package:studentapp/utils/myColors.dart';

class ClassmateCard extends StatelessWidget {
  final String name;
  final String image;

  const ClassmateCard({required this.name, super.key, this.image = ""});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: null,
          backgroundImage: NetworkImage(image),
          radius: 50,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(name),
        )
      ],
    );
  }
}

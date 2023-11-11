import 'package:flutter/material.dart';
import 'package:studentapp/utils/myColors.dart';

class ClassmateCard extends StatelessWidget {
  final String name;

  const ClassmateCard({required this.name, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: null,
          backgroundImage: NetworkImage(
              "https://static.vecteezy.com/system/resources/previews/008/442/086/non_2x/illustration-of-human-icon-user-symbol-icon-modern-design-on-blank-background-free-vector.jpg"),
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

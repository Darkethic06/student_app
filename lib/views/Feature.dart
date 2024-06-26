import 'package:flutter/material.dart';
import 'package:studentapp/utils/myColors.dart';

class FeatureCard extends StatelessWidget {
  final IconData featureIcon;
  final String name;
  final double mySize;

  const FeatureCard(
      {required this.featureIcon,
      required this.mySize,
      required this.name,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 5,
      height: 100,
      decoration: BoxDecoration(
          color: mainColor, borderRadius: BorderRadius.circular(15)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            featureIcon,
            color: Colors.white,
            size: mySize,
          ),
          Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontSize: 11.0,
                fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}

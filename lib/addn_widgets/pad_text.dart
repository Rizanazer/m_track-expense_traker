import 'package:flutter/material.dart';

// ignore: camel_case_types
class padtext extends StatelessWidget {
  final String name;
  final FontWeight fontWeight;
  final double fontsize;
  // ignore: prefer_typing_uninitialized_variables
  final color;
  const padtext(
      {super.key,
      required this.name,
      required this.fontsize,
      required this.fontWeight,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0),
      child: Text(
        name,
        style:
            TextStyle(fontSize: fontsize, fontWeight: fontWeight, color: color),
      ),
    );
  }
}

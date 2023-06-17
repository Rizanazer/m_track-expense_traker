// ignore: camel_case_types, must_be_immutable
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

// ignore: camel_case_types, must_be_immutable
class chart extends StatelessWidget {
  final double q;
  String v;
  // ignore: prefer_typing_uninitialized_variables
  final w;
  chart({super.key, required this.q, required this.v, required this.w});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => w));
      },
      child: CircularPercentIndicator(
        backgroundColor: Colors.transparent,
        progressColor: const Color.fromARGB(255, 139, 57, 171),
        radius: 50.0,
        lineWidth: 10.0,
        animation: true,
        percent: q,
        center: Text(
          v,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: Color.fromARGB(255, 139, 57, 171)),
        ),
      ),
    );
  }
}

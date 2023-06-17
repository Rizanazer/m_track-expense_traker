// ignore: camel_case_types
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class buttonname extends StatelessWidget {
  final String name;
  final double x;
  final double y;
  final double z;
  // ignore: prefer_typing_uninitialized_variables
  final icon;
  // ignore: prefer_typing_uninitialized_variables
  final pagex;
  const buttonname(
      {super.key,
      required this.name,
      required this.x,
      required this.pagex,
      required this.icon,
      required this.y,
      required this.z});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => pagex));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(252, 244, 255, 1),
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: x, vertical: y)),
                label: Text(name),
                icon: Image.asset(
                  icon,
                  width: 20,
                  height: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: CircularPercentIndicator(
                  radius: 18,
                  animation: true,
                  lineWidth: 5,
                  progressColor: Colors.red,
                  percent: z,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

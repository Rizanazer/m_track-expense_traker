import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class button_normal extends StatelessWidget {
  final String name;
  final double x;
  final double y;
  final double z;
  // final Function onpressed;
  // ignore: prefer_typing_uninitialized_variables
  final color;
  // ignore: prefer_typing_uninitialized_variables
  final icon;
  // ignore: prefer_typing_uninitialized_variables

  const button_normal({
    super.key,
    required this.name,
    required this.x,
    required this.icon,
    required this.y,
    required this.z,
    this.color,
  });

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
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: color,
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: x, vertical: y)),
                label: Text(name),
                icon: Image.asset(
                  icon,
                  width: 20,
                  height: 20,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

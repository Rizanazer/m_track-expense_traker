import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class button_logout extends StatelessWidget {
  final String name;
  final double x;
  final double y;
  final double size;
  // final Function onpressed;
  // ignore: prefer_typing_uninitialized_variables

  // ignore: prefer_typing_uninitialized_variables

  // ignore: prefer_typing_uninitialized_variables

  const button_logout(
      {super.key,
      required this.name,
      required this.x,
      required this.y,
      required this.size});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF77D8E),
                padding: EdgeInsets.symmetric(horizontal: x, vertical: y),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                    bottomLeft: Radius.circular(25),
                  ),
                ),
              ),
              child: Text(
                name,
                style: TextStyle(color: Colors.white, fontSize: size),
              ),
            ),
          ],
        )
      ],
    );
  }
}

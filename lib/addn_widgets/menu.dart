import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:m_trackn/addn_widgets/button_name.dart';
import 'package:m_trackn/screens/temp/temp_message.dart';
import 'package:rive/rive.dart';

import 'button_normal.dart';

late Size mediaquery;

class menu extends StatelessWidget {
  const menu({super.key});

  @override
  Widget build(BuildContext context) {
    bool isShowSignInDialog = false;
    mediaquery = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            width: MediaQuery.of(context).size.width * 1.7,
            left: 100,
            bottom: 100,
            child: Image.asset(
              "assets/Backgrounds/Spline.png",
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: const SizedBox(),
            ),
          ),
          const RiveAnimation.asset(
            "assets/RiveAssets/shapes.riv",
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: const SizedBox(),
            ),
          ),
          AnimatedPositioned(
            // ignore: dead_code
            top: isShowSignInDialog ? -50 : 0,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            duration: const Duration(milliseconds: 260),
            child: SafeArea(
              child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: mediaquery.width * .18,
                      vertical: mediaquery.height * .18),
                  child: Column(
                    children: [
                      button_logout(
                        name: "log out",
                        x: mediaquery.width * 0.239,
                        y: 20,
                        size: 20,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      buttonname(
                        name: "sms_temp",
                        pagex: const temp_msg(),
                        x: mediaquery.width * 0.199,
                        y: 20,
                        size: 20,
                      ),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

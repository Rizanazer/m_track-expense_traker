// ignore_for_file: unused_field

import 'dart:async';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:m_trackn/screens/login/switch_screen.dart';
import 'package:rive/rive.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isShowSignInDialog = false;
  final _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      // if (FirebaseAuth.instance.currentUser == null) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (ctx) => const mainpage()),
          (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/banner-bg.jpg"), fit: BoxFit.fill)),
          child: Stack(clipBehavior: Clip.none, children: [
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
              top: isShowSignInDialog ? -50 : 0,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              duration: const Duration(milliseconds: 260),
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.all(88.0),
                child: Image.asset('assets/ashi pig.gif'),
              )),
            ),
          ])),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:m_trackn/screens/afterlogin/budgetinput.dart';
// import 'package:m_trackn/screens/afterlogin/budgetinput.dart';

import 'package:m_trackn/screens/login/login.dart';
// import 'package:m_trackn/screens/home/screen_home.dart';

// ignore: camel_case_types
class mainpage extends StatelessWidget {
  const mainpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return priority();
          } else {
            return const login();
          }
        },
      ),
    );
  }
}

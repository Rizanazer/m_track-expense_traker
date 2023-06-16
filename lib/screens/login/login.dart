import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:m_trackn/screens/login/resetpass.dart';

import 'package:m_trackn/screens/login/signin.dart';

late Size mediaquery;
//for adjesting size to phone

// ignore: camel_case_types
class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

// ignore: camel_case_types
class _loginState extends State<login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String? errorMessage = '';
  Widget _errorMessage() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Text(
        errorMessage == '' ? '' : 'Humm ? $errorMessage',
        style: const TextStyle(color: Colors.red),
      ),
    );
  }

  Future SignIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text.trim(), password: password.text.trim());
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mediaquery = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('LOGIN'),
      // ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/banner-bg.jpg"), fit: BoxFit.fill)),
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: mediaquery.height * .2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                textfeild(
                  condn: false,
                  name: 'Email',
                  controller: email,
                  icon: Icons.email,
                ),
                SizedBox(
                  height: mediaquery.height * .01,
                ),
                textfeild(
                  condn: true,
                  name: 'Password',
                  controller: password,
                  icon: Icons.password_outlined,
                ),
                SizedBox(
                  height: mediaquery.height * .03,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (email.text.isNotEmpty && password.text.isNotEmpty) {
                      SignIn();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("enter credentials")));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 142, 66, 163),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: SizedBox(
                      width: mediaquery.width * 0.75,
                      child: const Center(
                          child: Text(
                        "Login",
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ))),
                ),
                SizedBox(
                  height: mediaquery.height * .02,
                ),
                RichText(
                    text: TextSpan(
                        text: "Dont have an account?",
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 15),
                        children: [
                      TextSpan(
                          text: " Create",
                          style: const TextStyle(
                              color: Color.fromARGB(255, 142, 66, 163),
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => signup()));
                            })
                    ])),
                Row(
                  children: [
                    // Expanded(
                    //     child: Container(
                    //   width: 10,
                    // )),
                    SizedBox(
                      width: mediaquery.width * .37,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: mediaquery.width * 0.08,
                          top: mediaquery.height * .02),
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const resetpassword())),
                        child: const Text(
                          "forget password",
                          style: TextStyle(
                              color: Color.fromARGB(255, 142, 66, 163)),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: mediaquery.height * 0.03,
                ),
                _errorMessage(),
                SizedBox(
                  height: mediaquery.height * 0.43,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//shadow text box
// ignore: camel_case_types
class textfeild extends StatelessWidget {
  final String name;
  final bool condn;
  final icon;
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  const textfeild(
      {super.key,
      required this.name,
      required this.condn,
      this.controller,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: mediaquery.width * 0.06),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(),
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
          obscureText: condn,
          controller: controller,
          decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide:
                      const BorderSide(color: Colors.white, width: 1.0)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide:
                      const BorderSide(color: Colors.white, width: 1.0)),
              hintText: name,
              prefixIcon: Icon(icon),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(30))),
        ),
      ),
    );
  }
}

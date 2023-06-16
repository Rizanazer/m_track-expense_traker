import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:m_trackn/screens/login/login.dart';
import 'package:firebase_auth/firebase_auth.dart';

late Size mediaquery;

class signup extends StatefulWidget {
  signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  TextEditingController email = TextEditingController();

  TextEditingController username = TextEditingController();

  TextEditingController password = TextEditingController();

  TextEditingController repassword = TextEditingController();
  String? errormessage = '';

  Widget _errorMessage() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Text(
        errormessage == '' ? '' : 'Humm ? $errormessage',
        style: const TextStyle(color: Colors.red),
      ),
    );
  }

  @override
  void dispose() {
    email.dispose();
    username.dispose();
    password.dispose();
    repassword.dispose();
    super.dispose();
  }

  getuid() => FirebaseAuth.instance.currentUser?.uid;

  Future SignUp() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text, password: password.text);
      addUserDetails(username.text.trim(), getuid()
          //int.parse(controller.text.trom()) => for integer
          );
      // FirebaseAuth.instance.currentUser?.updateDisplayName(username.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errormessage = e.message;
      });
    }
  }

  Future addUserDetails(String name, String uid) async {
    //  await FirebaseFirestore.instance.collection('user').add({
    //   'Username': name,
    // }); => random doc id generated for documents
    await FirebaseFirestore.instance.collection('user').doc(uid).set({
      'Username': name,
    });
  }

  @override
  Widget build(BuildContext context) {
    mediaquery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("SignUp"),
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/banner-bg.jpg"), fit: BoxFit.fill)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // textfeild(
            //   name: "username",
            //   condn: false,
            //   controller: username,
            //   icon: Icons.account_circle,
            // ),
            // SizedBox(
            //   height: mediaquery.height * .02,
            // ),
            textfeild(
              name: "email",
              condn: false,
              controller: email,
              icon: Icons.email,
            ),
            SizedBox(
              height: mediaquery.height * .02,
            ),
            textfeild(
              name: "password",
              condn: false,
              controller: password,
              icon: Icons.password_outlined,
            ),
            SizedBox(
              height: mediaquery.height * .02,
            ),
            textfeild(
              name: "re-password",
              condn: true,
              controller: repassword,
              icon: Icons.password_outlined,
            ),
            SizedBox(
              height: mediaquery.height * .02,
            ),
            ElevatedButton(
              onPressed: () {
                if (email.text.isNotEmpty &&
                    // username.text.isNotEmpty &&
                    password.text.isNotEmpty) {
                  if (password.text.trim() == repassword.text.trim()) {
                    SignUp();
                    // Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Match Your Password!!")));
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Fill your Info!!")));
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
                    "SignUp",
                    style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                  ))),
            ),
            SizedBox(
              height: mediaquery.height * .04,
            ),
            _errorMessage()
          ],
        ),
      ),
    );
  }
}

//
import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:m_trackn/screens/home/screen_home.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rive/rive.dart';

class priority extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const welcome_screen(),
      );
}

late Size mediaquery;
String dropdownValue = list.first;

const List<String> list = <String>[
  'IO-bank',
  'Canara Bank',
];

// ignore: camel_case_types
class welcome_screen extends StatefulWidget {
  const welcome_screen({super.key});

  @override
  State<welcome_screen> createState() => _welcome_screenState();
}

// ignore: camel_case_types
class _welcome_screenState extends State<welcome_screen> {
  // ignore: unused_field
  late RiveAnimationController _btnAnimationController;

  bool isShowSignInDialog = false;
  final SmsQuery _query = SmsQuery();

  // ignore: prefer_final_fields
  List<SmsMessage> _messages = [];
  DatabaseReference mRootreference = FirebaseDatabase.instance.ref();
  @override
  void initState() {
    Load([
      'VM-IOBCHN',
      'VK-IOBCHN',
      'JM-IOBCHN',
      'JK-IOBCHN',
      'JX-IOBCHN',
      'JD-IOBCHN',
      'BP-IOBCHN',
      'BX-IOBCHN',
      'BZ-IOBCHN',
      'BK-IOBCHN',
      'AD-IOBCHN',
      'BT-IOBCHN',
      'CP-IOBCHN',
      'JK-CANBNK',
      'AX-CANBNK',
    ]);
    super.initState();
    //   controller.addListener(rebuild);
  }

  Load(
    List<String> addresses,
  ) async {
    var permission = await Permission.sms.status;
    if (permission.isGranted) {
      List<SmsMessage> messages = [];
      for (String address in addresses) {
        final addressMessages = await _query.querySms(
          kinds: [
            SmsQueryKind.inbox,
            SmsQueryKind.sent,
          ],
          address: address,
          count: messages.length,
        );
        messages.addAll(addressMessages);
      }
      // Do something with the `messages` list here

      debugPrint('sms inbox messages: ${messages.length}');

      setState(() => _messages = messages);
      addToFirebase(_messages);
    } else {
      await Permission.sms.request();
    }
  }

  void addToFirebase(var messages) {
    for (var msg in messages) {
      HashMap<String, dynamic> data = HashMap<String, dynamic>();

      String id1 = msg.id.toString();
      // int id1 = 0;
      String date = msg.date.toString();

      final String smsText = msg.body;

      var regex;
      var mode;

      var purpose = 'none_Assigned';
      if (dropdownValue == 'IO-bank') {
        if (smsText.contains('Debit')) {
          regex = RegExp(r'(?<=Rs\.)\d+\.\d+', caseSensitive: false);
          mode = 'DEBITED';
        } else if (smsText.contains('Credit')) {
          regex = RegExp(r'(?<=Rs\.)\d+\.\d+', caseSensitive: false);
          mode = 'CREDITED';
        } else if (smsText.toLowerCase().contains('Your')) {
          regex = RegExp(r'(?<=Rs\.)\d+\.\d+', caseSensitive: false);
          mode = 'UPI';
        } else {
          continue;
        }
        Match? match = regex.firstMatch(smsText);
        String? amount;
        if (match != null) {
          amount = match.group(0);
        }
        data['id'] = id1;
        data["amount"] = amount;
        data["DateTime"] = date;
        data["mode"] = mode;
        data["purpose"] = purpose;
        // ignore: unrelated_type_equality_checks
        if (["purpose"] == 'none_Assigned') {
          data["purpose"] = purpose;
        } else {
          continue;
        }

        mRootreference.child("BankDb").child('All').child(id1).update(data);
      } else if (dropdownValue == 'Canara Bank') {
        if (smsText.contains('DEBIT')) {
          regex = RegExp(r'(\d+\.\d{2}) (?:has been )?DEBITED',
              caseSensitive: false);
          mode = 'DEBITED';
        } else if (smsText.contains('CREDIT')) {
          regex = RegExp(r'(\d+\.\d{2}) (?:has been )?CREDITED',
              caseSensitive: false);
          mode = 'CREDITED';
        } else if (smsText.toLowerCase().contains('UPI')) {
          regex = RegExp(r'(?<=Rs\.)\d+(?:\.\d+)?', caseSensitive: false);
          mode = 'UPI';
        } else {
          continue;
        }
        Match? match = regex.firstMatch(smsText);
        String? amount;
        if (match != null) {
          amount = match.group(1);
        }
        data['id'] = id1;
        data["amount"] = amount;
        data["DateTime"] = date;
        data["mode"] = mode;
        data["purpose"] = purpose;

        mRootreference.child("BankDb").child('All').child(id1).update(data);
      }
    }
  }

  Widget adaptor(
    var message,
  ) {
    return Container(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {},
        child: Card(
          child: Column(
            children: [
              Text('${message.sender} [${message.date}]'),
              Text('${message.body}'),
            ],
          ),
        ),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    print(dropdownValue);
    return Stack(
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
          top: isShowSignInDialog ? -50 : 0,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          duration: const Duration(milliseconds: 260),
          child: SafeArea(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    SizedBox(
                        height: 200,
                        width: 200,
                        child: Image.asset('assets/ashi pig.gif')),
                    const SizedBox(
                      height: 90,
                    ),
                    const Text(
                      "enter your bank: ",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          decoration: TextDecoration.none),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    buildDropdownButton(
                      dropdownValue,
                      list,
                      (String? value) {
                        setState(() {
                          dropdownValue = value!;
                        });
                      },
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ScreenHome(),
                          ));
                        },
                        child: const Text("next  ->"))
                  ],
                )),
          ),
        ),
      ],
    );
  }

  Widget buildDropdownButton(
      String selectedValue, List<String> dropdownValues, var onChanged) {
    return DropdownButton<String>(
      value: selectedValue,
      onChanged: onChanged,
      dropdownColor: Colors.white,
      items: dropdownValues.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

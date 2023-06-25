import 'dart:collection';
// import 'dart:ffi';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:permission_handler/permission_handler.dart';

// ignore: camel_case_types
class temp_msg extends StatefulWidget {
  const temp_msg({super.key});

  @override
  State<temp_msg> createState() => _temp_msgState();
}

// ignore: camel_case_types
class _temp_msgState extends State<temp_msg> {
  // ignore: unused_field
  final SmsQuery _query = SmsQuery();

  // ignore: prefer_final_fields
  List<SmsMessage> _messages = [];
  DatabaseReference mRootreference = FirebaseDatabase.instance.ref();
  // ignore: unused_field
  @override
  void initState() {
    // Load(['JK-CANBNK', 'AX-CANBNK']);
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
      'CP-IOBCHN'
    ]);
    // Load(['Nx-bank']);

    super.initState();
  }

  // Load(
  //   _query,
  // ) async {
  //   var permission = await Permission.sms.status;
  //   if (permission.isGranted) {
  //     final messages = await _query.querySms(
  //       kinds: [
  //         SmsQueryKind.inbox,
  //         SmsQueryKind.sent,
  //       ],
  //       addresses: 'JK-CANBNK',
  //       'AX-CANBNK',
  //       count: 10,
  //     );

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

  // void addMessage(String text) {
  //   final newMessageRef = mRootreference.child("BankDb1").push();
  //   newMessageRef.set({
  //     'text': text,
  //     'timestamp': ServerValue.timestamp,
  //   });
  // }

  // ListenMessage(
  //   var message,
  // ) {
  //   mRootreference.onChildAdded.listen((event) {
  //     final Message = message.fromSnapshot(event.snapshot);
  //     print("sanbashjhaj${Message}");
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10.0),
                child: _messages.isNotEmpty
                    ? ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _messages.length,
                        itemBuilder: (BuildContext context, int i) {
                          var message = _messages[i];
                          return adaptor(message);
                        },
                      )
                    : Center(
                        child: Text(
                          'No messages to show.\n Tap refresh button...',
                          style: Theme.of(context).textTheme.headlineSmall,
                          textAlign: TextAlign.center,
                        ),
                      ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
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
              'CP-IOBCHN'
            ]);

            // Load(['JK-CANBNK', 'AX-CANBNK']);
            // Load(['Nx-bank']);
          },
          child: const Icon(Icons.refresh),
        ),
      ),
    );
  }

  // test(var message) {
  //   for (var msg in message) {
  //     HashMap<String, dynamic> data = HashMap<String, dynamic>();
  //     String id1 = msg.id.toString();
  //     String date = msg.date.toString();

  //     final String smsText = msg.body;

  //     String getTransactionType() {
  //       if (smsText.toLowerCase().contains('DEBIT')) {
  //         return 'Debited';
  //       } else if (smsText.contains('CREDIT')) {
  //         return 'Credited';
  //       } else if (smsText.toLowerCase().contains('UPI')) {
  //         return 'UPI';
  //       } else {
  //         return 'unknown';
  //       }
  //     }

  //     if (getTransactionType() == 'Debited') {
  //       RegExp regex =
  //           RegExp(r'(\d+\.\d{2}) (?:has been )?DEBITED', caseSensitive: false);
  //       Match? match = regex.firstMatch(smsText);
  //       // String debitedAmount = '';

  //       // if (match != null) {
  //       //   debitedAmount = match.group(1) ?? '';
  //       //   setState(() {
  //       //     _debitedAmount = debitedAmount;
  //       //   });
  //       // } else {
  //       //   setState(() {
  //       //     _debitedAmount = 'No debited amount found';
  //       //   });
  //       // }

  //       // data["debit"] = debitedAmount;
  //       // data["DateTime"] = date;

  //       // mRootreference.child("BankDb").child('debit').child(id1).update(data);

  //       String allAmount = '';

  //       if (match != null) {
  //         allAmount = match.group(1) ?? '';
  //         setState(() {
  //           _allAmount = allAmount;
  //         });
  //       } else {
  //         setState(() {
  //           _allAmount = 'No debited amount found';
  //         });
  //       }

  //       data["all_amount"] = allAmount;
  //       data["DateTime"] = date;
  //       data["mode"] = "DEBITED";
  //       mRootreference.child("BankDb").child('All').child(id1).update(data);
  //       debitedd += double.parse(allAmount);

  //       // debugPrint(debitedd.toString());
  //     } else if (getTransactionType() == 'UPI') {
  //       RegExp regex = RegExp(r'(?<=Rs\.)\d+(?:\.\d+)?', caseSensitive: false);
  //       Match? match = regex.firstMatch(smsText);
  //       String upiAmount = '';
  //       if (match != null) {
  //         upiAmount = match.group(1) ?? '';
  //         setState(() {
  //           _upi = upiAmount;
  //         });
  //       } else {
  //         setState(() {
  //           _upi = 'No debited amount found';
  //         });
  //       }

  //       data["upi"] = upiAmount;
  //       data["DateTime"] = date;
  //       data["mode"] = "UPI";
  //       mRootreference.child("BankDb").child('upi').child(id1).update(data);
  //       String allAmount = '';
  //       if (match != null) {
  //         allAmount = match.group(1) ?? '';
  //         setState(() {
  //           _allAmount = allAmount;
  //         });
  //       } else {
  //         setState(() {
  //           _allAmount = 'No debited amount found';
  //         });
  //       }

  //       data["all_amount"] = allAmount;
  //       data["DateTime"] = date;
  //       mRootreference.child("BankDb").child('All').child(id1).update(data);
  //     } else if (getTransactionType() == 'Credited') {
  //       RegExp regex = RegExp(r'(\d+\.\d{2}) (?:has been )?CREDITED',
  //           caseSensitive: false);
  //       // RegExp regex = RegExp(r'After credit of Rs (\d+(?:\.\d+)?),');
  //       Match? match = regex.firstMatch(smsText);
  //       String creditedAmount = '';
  //       if (match != null) {
  //         creditedAmount = match.group(1) ?? '';
  //         setState(() {
  //           _creditedAmount = creditedAmount;
  //         });
  //       } else {
  //         setState(() {
  //           _creditedAmount = 'No debited amount found';
  //         });
  //       }

  //       data["credit"] = creditedAmount;
  //       data["DateTime"] = date;
  //       mRootreference.child("BankDb").child('credit').child(id1).update(data);
  //       String allAmount = '';
  //       if (match != null) {
  //         allAmount = match.group(1) ?? '';
  //         setState(() {
  //           _allAmount = allAmount;
  //         });
  //       } else {
  //         setState(() {
  //           _allAmount = 'No debited amount found';
  //         });
  //       }

  //       data["all_amount"] = allAmount;
  //       data["DateTime"] = date;
  //       data["mode"] = "CREDITED";
  //       mRootreference.child("BankDb").child('All').child(id1).update(data);
  //     }

  //     // RegExp regex = RegExp(r'After (debit|credit) of Rs (\d+(?:\.\d+)?),');
  //     // Match? match = regex.firstMatch(smsText);
  //   }
  // }

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

      mRootreference.child("BankDb").child('All').child(id1).update(data);

      // void updateFirebaseValue(String id, String newValue) {
      //   DatabaseReference mRootReference = FirebaseDatabase.instance.ref();

      //   mRootReference
      //       .child("BankDb")
      //       .child('All')
      //       .child(id)
      //       .update({'purpose': newValue}).then((_) {
      //     print('Value updated successfully.');
      //   }).catchError((error) {
      //     print('Failed to update value: $error');
      //   });
      // }
    }
  }

  Widget adaptor(
    var message,
  ) {
    return Container(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          // String id1 = message.id.toString();
          // HashMap<String, dynamic> data = HashMap<String, dynamic>();
          // data["Details"] = message.body;
          // mRootreference.child("BankDb").child(id1).update(data);
        },
        child: Card(
          child: Column(
            children: [
              // Text(debitedd.toString()),
              Text('${message.sender} [${message.date}]'),
              Text('${message.body}'),
            ],
          ),
        ),
      ),
    ));
  }
}

// class _MessagesListView extends StatelessWidget {
//   _MessagesListView({
//     Key? key,
//     required this.messages,
//   }) : super(key: key);
//   DatabaseReference mRootreference = FirebaseDatabase.instance.ref();
//   final List<SmsMessage> messages;

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       shrinkWrap: true,
//       itemCount: messages.length,
//       itemBuilder: (BuildContext context, int i) {
//         var message = messages[i];

//         return adaptor(message);
//         //     ListTile(
//         //   title: Text('${message.sender} [${message.date}]'),
//         //   subtitle: Text('${message.body}'),
//         // );
//       },
//     );
//   }

// }

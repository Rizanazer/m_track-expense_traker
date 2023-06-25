// import 'dart:collection';
// // import 'dart:ffi';

// import 'package:drag_select_grid_view/drag_select_grid_view.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
// import 'package:m_trackn/screens/afterlogin/budgetinput.dart';
// // import 'package:m_trackn/screens/afterlogin/image.dart';

// import 'package:m_trackn/screens/afterlogin/two.dart';
// import 'package:m_trackn/screens/home/screen_home.dart';
// import 'package:permission_handler/permission_handler.dart';

// // import 'package:m_trackn/screens/overview/screen_overview.dart';
// late Size mediaquery;
// String dropdownValue = list.first;

// const List<String> list = <String>[
//   'IO-bank',
//   'Canara Bank',
// ];
// // late List<String> list3 = <String>[];

// class SelectGridPage extends StatefulWidget {
//   @override
//   _SelectGridPageState createState() => _SelectGridPageState();
// }

// class _SelectGridPageState extends State<SelectGridPage> {
//   final SmsQuery _query = SmsQuery();

//   // ignore: prefer_final_fields
//   List<SmsMessage> _messages = [];
//   DatabaseReference mRootreference = FirebaseDatabase.instance.ref();
//   // final controller = DragSelectGridViewController();
//   // final urlImages = [
//   //   'https://cdn5.vectorstock.com/i/1000x1000/64/49/travel-and-vacation-cartoons-vector-21926449.jpg',
//   //   'https://cdn3.vectorstock.com/i/1000x1000/91/67/kawaii-cartoon-fast-food-vector-24379167.jpg',
//   //   'https://img.freepik.com/premium-vector/camera-film-roll-cartoon-illustration-cinema-icon-concept-white-isolated-flat-cartoon-style_75802-229.jpg',
//   //   'https://freedesignfile.com/upload/2021/04/Online-shop-cartoon-illustration-vector.jpg',
//   //   'https://cdn3.vectorstock.com/i/1000x1000/44/82/saving-money-cartoon-vector-25154482.jpg',
//   //   'https://img.freepik.com/premium-vector/medical-health-bag-stethoscope-jar-pills-cartoon-icon-illustration-healthcare-medicine-icon-concept-isolated-premium-flat-cartoon-style_138676-1619.jpg?w=2000',
//   //   'https://png.pngtree.com/png-vector/20221108/ourmid/pngtree-cartoon-house-illustration-png-image_6434928.png',
//   //   'https://img.freepik.com/free-vector/cute-cat-dog-cartoon_138676-3018.jpg',
//   //   'https://img.freepik.com/premium-vector/car-cartoon-vehicle-transportation-isolated_138676-2473.jpg'
//   // ];

//   @override
//   void initState() {
//     Load([
//       'VM-IOBCHN',
//       'VK-IOBCHN',
//       'JM-IOBCHN',
//       'JK-IOBCHN',
//       'JX-IOBCHN',
//       'JD-IOBCHN',
//       'BP-IOBCHN',
//       'BX-IOBCHN',
//       'BZ-IOBCHN',
//       'BK-IOBCHN',
//       'AD-IOBCHN',
//       'BT-IOBCHN',
//       'CP-IOBCHN',
//       'JK-CANBNK',
//       'AX-CANBNK'
//     ]);
//     super.initState();
//   //   controller.addListener(rebuild);
//   }

//   // @override
//   // void dispose() {
//   //   controller.removeListener(rebuild);
//   //   super.dispose();
//   // }

//   // var j;
//   // void rebuild() => setState(() {
//   //       // var j = controller;
//   //       list3.
//   //       print(list3);
//   //     });

//   Load(
//     List<String> addresses,
//   ) async {
//     var permission = await Permission.sms.status;
//     if (permission.isGranted) {
//       List<SmsMessage> messages = [];
//       for (String address in addresses) {
//         final addressMessages = await _query.querySms(
//           kinds: [
//             SmsQueryKind.inbox,
//             SmsQueryKind.sent,
//           ],
//           address: address,
//           count: messages.length,
//         );
//         messages.addAll(addressMessages);
//       }
//       // Do something with the `messages` list here

//       debugPrint('sms inbox messages: ${messages.length}');

//       setState(() => _messages = messages);
//       addToFirebase(_messages);
//     } else {
//       await Permission.sms.request();
//     }
//   }

//   void addToFirebase(var messages) {
//     for (var msg in messages) {
//       HashMap<String, dynamic> data = HashMap<String, dynamic>();

//       String id1 = msg.id.toString();
//       // int id1 = 0;
//       String date = msg.date.toString();

//       final String smsText = msg.body;

//       var regex;
//       var mode;
//       var purpose = 'none_Assigned';
//       if (dropdownValue == 'IO-bank') {
//         if (smsText.contains('Debit')) {
//           regex = RegExp(r'(?<=Rs\.)\d+\.\d+', caseSensitive: false);
//           mode = 'DEBITED';
//         } else if (smsText.contains('Credit')) {
//           regex = RegExp(r'(?<=Rs\.)\d+\.\d+', caseSensitive: false);
//           mode = 'CREDITED';
//         } else if (smsText.toLowerCase().contains('Your')) {
//           regex = RegExp(r'(?<=Rs\.)\d+\.\d+', caseSensitive: false);
//           mode = 'UPI';
//         } else {
//           continue;
//         }
//         Match? match = regex.firstMatch(smsText);
//         String? amount;
//         if (match != null) {
//           amount = match.group(0);
//         }
//         data['id'] = id1;
//         data["amount"] = amount;
//         data["DateTime"] = date;
//         data["mode"] = mode;
//         data["purpose"] = purpose;

//         mRootreference.child("BankDb").child('All').child(id1).update(data);
//       } else if (dropdownValue == 'Canara Bank') {
//         if (smsText.contains('DEBIT')) {
//           regex = RegExp(r'(\d+\.\d{2}) (?:has been )?DEBITED',
//               caseSensitive: false);
//           mode = 'DEBITED';
//         } else if (smsText.contains('CREDIT')) {
//           regex = RegExp(r'(\d+\.\d{2}) (?:has been )?CREDITED',
//               caseSensitive: false);
//           mode = 'CREDITED';
//         } else if (smsText.toLowerCase().contains('UPI')) {
//           regex = RegExp(r'(?<=Rs\.)\d+(?:\.\d+)?', caseSensitive: false);
//           mode = 'UPI';
//         } else {
//           continue;
//         }
//         Match? match = regex.firstMatch(smsText);
//         String? amount;
//         if (match != null) {
//           amount = match.group(1);
//         }
//         data['id'] = id1;
//         data["amount"] = amount;
//         data["DateTime"] = date;
//         data["mode"] = mode;
//         data["purpose"] = purpose;

//         mRootreference.child("BankDb").child('All').child(id1).update(data);
//       }
//     }
//   }

//   Widget adaptor(
//     var message,
//   ) {
//     return Container(
//         child: Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: InkWell(
//         onTap: () {},
//         child: Card(
//           child: Column(
//             children: [
//               Text('${message.sender} [${message.date}]'),
//               Text('${message.body}'),
//             ],
//           ),
//         ),
//       ),
//     ));
//   }

//   @override
//   Widget build(BuildContext context) {
//     // print(controller.value.selectedIndexes.toString());

//     // print(j);
//     print(dropdownValue);
//     // final isSelected = controller.value.isSelecting;
//     // final text = isSelected
//     //     ? '${controller.value.amount} Images Selected'
//     //     : priority.title;
//     mediaquery = MediaQuery.of(context).size;
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: Text(text),
//       //   leading: isSelected ? CloseButton() : Container(),
//       //   actions: [
//       //     if (isSelected)
//       //       IconButton(
//       //         icon: Icon(Icons.done),
//       //         onPressed: () {
//       //           // ignore: unused_local_variable
//       //           final urlSelectedImages = controller.value.selectedIndexes
//       //               .map<String>((index) => urlImages[index])
//       //               .toList();

//       //           Navigator.of(context).push(MaterialPageRoute(
//       //               builder: (context) => const ScreenHome()));
//       //         },
//       //       ),
//       //   ],
//       // ),
//       body: Container(
//         decoration: const BoxDecoration(
//             image: DecorationImage(
//                 image: AssetImage("assets/banner-bg.jpg"), fit: BoxFit.fill)),
//         child: DragSelectGridView(
//           gridController: controller,
//           padding: const EdgeInsets.all(8),
//           itemCount: urlImages.length,
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 3,
//             crossAxisSpacing: 8,
//             mainAxisSpacing: 8,
//           ),
//           itemBuilder: (context, index, isSelected) => SelectableItemWidget(
//             url: urlImages[index],
//             isSelected: isSelected,
//           ),
//         ),
//       ),
//       floatingActionButton: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           const Text("enter ur bank: "),
//           buildDropdownButton(
//             dropdownValue,
//             list,
//             (String? value) {
//               setState(() {
//                 dropdownValue = value!;
//               });
//             },
//           )
//         ],
//       ),
//     );
//   }

//   Widget buildDropdownButton(
//       String selectedValue, List<String> dropdownValues, var onChanged) {
//     return DropdownButton<String>(
//       value: selectedValue,
//       onChanged: onChanged,
//       items: dropdownValues.map((String value) {
//         return DropdownMenuItem<String>(
//           value: value,
//           child: Text(value),
//         );
//       }).toList(),
//     );
//   }
// }

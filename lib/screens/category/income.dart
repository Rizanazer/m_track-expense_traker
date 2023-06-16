// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
// import 'package:m_trackn/screens/transactions/dialogbox.dart';
// import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
// final FirebaseDatabase database = FirebaseDatabase.instance;

class income extends StatefulWidget {
  const income({Key? key}) : super(key: key);
  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

  @override
  State<income> createState() => _ScreenTransactionState();
}

class _ScreenTransactionState extends State<income> {
  TextEditingController dial = TextEditingController();
  var reference = FirebaseDatabase.instance
      .ref()
      .child('BankDb')
      .child('All')
      .orderByChild('mode')
      .equalTo('CREDITED');

  Widget listItem({required Map data}) {
    return Container(
      // margin: const EdgeInsets.all(10),
      // padding: const EdgeInsets.all(10),
      // height: 110,
      // color: Colors.amberAccent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Card(
            color: const Color.fromARGB(255, 251, 243, 255),
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: ListTile(
                leading: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color.fromARGB(255, 224, 210, 236),
                  ),
                  child: SizedBox(
                    height: 50,
                    width: 100,
                    child: Center(
                      child: Text(
                        data['DateTime'].toString().substring(2, 10),
                        style: const TextStyle(
                            color: Color.fromARGB(255, 84, 9, 95)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                // ignore: prefer_interpolation_to_compose_strings
                title: Text(
                  // ignore: prefer_interpolation_to_compose_strings
                  '₹' + data['amount'],
                  style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 92, 18, 99)),
                ),
              ),
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/banner-bg.jpg"), fit: BoxFit.fill)),
        child: FirebaseAnimatedList(
          query: reference,
          itemBuilder: (BuildContext context, DataSnapshot snapshot,
              Animation<double> animation, int index) {
            Map data = snapshot.value as Map;
            data['key'] = snapshot.key;

            return listItem(data: data);
          },
        ),
      ),
    );
  }
}


// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_database/ui/firebase_animated_list.dart';
// import 'package:flutter/material.dart';

// // import 'package:flutter_firebase_series/screens/update_record.dart';
 
// class FetchData extends StatefulWidget {
//   const FetchData({Key? key}) : super(key: key);
 
//   @override
//   State<FetchData> createState() => _FetchDataState();
// }
 
// class _FetchDataState extends State<FetchData> {
  
//   Query dbRef = FirebaseDatabase.instance.ref().child('Students');
//   DatabaseReference reference = FirebaseDatabase.instance.ref().child('Students');
  
//   Widget listItem({required Map student}) {
//     return Container(
//       margin: const EdgeInsets.all(10),
//       padding: const EdgeInsets.all(10),
//       height: 110,
//       color: Colors.amberAccent,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             student['name'],
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
//           ),
//           const SizedBox(
//             height: 5,
//           ),
//           Text(
//             student['age'],
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
//           ),
//           const SizedBox(
//             height: 5,
//           ),
//           Text(
//             student['salary'],
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               GestureDetector(
//                 onTap: () {
//                  Navigator.push(context, MaterialPageRoute(builder: (_) => UpdateRecord(studentKey: student['key'])));
//                 },
//                 child: Row(
//                   children: [
//                     Icon(
//                       Icons.edit,
//                       color: Theme.of(context).primaryColor,
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 width: 6,
//               ),
//               GestureDetector(
//                 onTap: () {
//                   reference.child(student['key']).remove();
//                 },
//                 child: Row(
//                   children: [
//                     Icon(
//                       Icons.delete,
//                       color: Colors.red[700],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
 
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Fetching data'),
//       ),
//       body: Container(
//         height: double.infinity,
//         child: FirebaseAnimatedList(
//           query: dbRef,
//           itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
 
//             Map student = snapshot.value as Map;
//             student['key'] = snapshot.key;
 
//             return listItem(student: student);
 
//           },
//         ),
//       )
//     );
//   }
// }

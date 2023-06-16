// import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../transactions/dialogbox.dart';

// import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
String? dropdownValue;
// GlobalKey<ListViewState> listViewKey = GlobalKey<ListViewState>();

class expense extends StatefulWidget {
  const expense({Key? key}) : super(key: key);
  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

  @override
  State<expense> createState() => _expenseState();
}

class _expenseState extends State<expense> {
  choise() {
    var m;
    if (dropdownValue == 'food') {
      m = 'variablecost';
    } else if (dropdownValue == 'travel') {
      m = 'variablecost';
    } else if (dropdownValue == 'entertainment') {
      m = 'variablecost';
    } else if (dropdownValue == 'studies') {
      m = 'variablecost';
    } else {
      m = 'fixedcost';
    }
    return m;
  }

  TextEditingController dial = TextEditingController();
  var reference = FirebaseDatabase.instance
      .ref()
      .child('BankDb')
      .child('All')
      .orderByChild('mode')
      .equalTo('DEBITED');
  // void someFunction() {
  //   final listViewState = listViewKey.currentState;
  //   final listViewId = listViewState?.hashCode;

  //   if (listViewId != null) {
  //     // Use the listViewId as needed
  //     print('Current ListView ID: $listViewId');
  //   }
  // }

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
                // key: listViewKey,
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
                  '₹' + data['amount'],
                  style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 92, 18, 99)),
                ),
                trailing: GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return dialogbox(
                              controller: (String? value) {
                                setState(() {
                                  dropdownValue = value!;
                                });
                              },
                              ontap: () async {
                                // choise();
                                print(choise());
                                print(data['id']);

                                HashMap<String, dynamic> dat =
                                    HashMap<String, dynamic>();
                                dat['purpose'] = choise();
                                reference.ref.child(data['id']).update(dat);
                              },
                            );
                          });
                    },
                    child: Text(data['purpose'])),
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
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     if (expense.selectedIndexNotifier.value == 0) {
      //       print('Add Transaction');
      //     }
      //   },
      //   child: Icon(Icons.add),
      // ),
    );
  }
}

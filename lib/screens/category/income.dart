import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

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
            // image: DecorationImage(
            //     image: AssetImage("assets/banner-bg.jpg"), fit: BoxFit.fill)),
            color: Color(0xFFFDE1D7)),
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

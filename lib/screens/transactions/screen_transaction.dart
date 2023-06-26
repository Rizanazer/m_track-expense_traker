import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

String dropdownValue = list1.first;
RegExp? m;
late Size mediaquery;
const List<String> list1 = <String>[
  // 'jul_22',
  // 'aug_22',
  // 'sept_22',
  // 'oct_22',
  // 'nov_22',
  // 'dec_22',
  // 'jan_23',
  'feb_23',
  'mar_23',
  'apr_23',
  'may_23',
  'jun_23',
];

class ScreenTransaction extends StatefulWidget {
  const ScreenTransaction({Key? key}) : super(key: key);
  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

  @override
  State<ScreenTransaction> createState() => _ScreenTransactionState();
}

class _ScreenTransactionState extends State<ScreenTransaction> {
  DatabaseReference reference =
      FirebaseDatabase.instance.ref().child('BankDb').child('All');
  month() {
    // if (dropdownValue == 'jul_22') {
    //   m = RegExp(r'2022-07-(\d{2}) \d{2}:\d{2}:\d{2}\.\d{3}');

    //   return m;
    // } else if (dropdownValue == 'aug_22') {
    //   m = RegExp(r'2022-08-(\d{2}) \d{2}:\d{2}:\d{2}\.\d{3}');

    //   return m;
    // } else if (dropdownValue == 'sept_22') {
    //   m = RegExp(r'2022-09-(\d{2}) \d{2}:\d{2}:\d{2}\.\d{3}');

    //   return m;
    // } else if (dropdownValue == 'oct_22') {
    //   m = RegExp(r'2022-10-(\d{2}) \d{2}:\d{2}:\d{2}\.\d{3}');

    //   return m;
    // } else if (dropdownValue == 'nov_22') {
    //   m = RegExp(r'2022-11-(\d{2}) \d{2}:\d{2}:\d{2}\.\d{3}');

    //   return m;
    // } else if (dropdownValue == 'dec_22') {
    //   m = RegExp(r'2022-12-(\d{2}) \d{2}:\d{2}:\d{2}\.\d{3}');

    //   return m;
    // } else if (dropdownValue == 'jan_23') {
    //   m = RegExp(r'2023-01-(\d{2}) \d{2}:\d{2}:\d{2}\.\d{3}');

    //   return m;
    // }
    if (dropdownValue == 'feb_23') {
      m = RegExp(r'2023-02-(\d{2}) \d{2}:\d{2}:\d{2}\.\d{3}');

      return m;
    } else if (dropdownValue == 'mar_23') {
      m = RegExp(r'2023-03-(\d{2}) \d{2}:\d{2}:\d{2}\.\d{3}');

      return m;
    } else if (dropdownValue == 'apr_23') {
      m = RegExp(r'2023-04-(\d{2}) \d{2}:\d{2}:\d{2}\.\d{3}');

      return m;
    } else if (dropdownValue == 'may_23') {
      m = RegExp(r'2023-05-(\d{2}) \d{2}:\d{2}:\d{2}\.\d{3}');

      return m;
    } else if (dropdownValue == 'jun_23') {
      m = RegExp(r'2023-06-(\d{2}) \d{2}:\d{2}:\d{2}\.\d{3}');

      return m;
    }
  }

  debit(Map data) {
    final RegExp pattern = month();
    final Match? match = pattern.firstMatch(data['DateTime']);
    if (match != null) {
      return Text(
        // ignore: prefer_interpolation_to_compose_strings
        '₹' + data['amount'],
        style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
            color: data['mode'] == 'DEBITED'
                ? const Color.fromARGB(255, 163, 76, 76)
                : data['mode'] == "CREDITED"
                    ? const Color.fromARGB(255, 90, 134, 73)
                    : null),
      );
    }
  }

  date(Map data) {
    final RegExp pattern = month();
    final Match? match = pattern.firstMatch(data['DateTime']);
    if (match != null) {
      return Card(
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
                    style:
                        const TextStyle(color: Color.fromARGB(255, 84, 9, 95)),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            // ignore: prefer_interpolation_to_compose_strings
            title: debit(data),
            trailing: Image.asset("assets/coins.gif"),
          ),
        ),
      );
    }
  }

  Widget buildDropdownButton(
      String selectedValue, List<String> dropdownValues, var onChanged) {
    return DropdownButton<String>(
      value: selectedValue,
      onChanged: onChanged,
      items: dropdownValues.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget listItem({required Map data}) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: date(data)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    mediaquery = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Color(0xFFFDE1D7)),
        // image: DecorationImage(
        // image: AssetImage("assets/banner-bg.jpg"), fit: BoxFit.fill)

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
      floatingActionButton: buildDropdownButton(
        dropdownValue,
        list1,
        (String? value) {
          setState(() {
            dropdownValue = value!;
          });
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';

// import 'package:m_trackn/screens/login/login.dart';
String dropdownValue = list1.first;
late Size mediaquery;
const List<String> list1 = <String>[
  'fixed_expense',
  'food',
  'travel',
  'entertainment',
  'studies',
];

// ignore: camel_case_types, must_be_immutable
class dialogbox extends StatelessWidget {
  final controller;
  VoidCallback ontap;

  dialogbox({super.key, required this.controller, required this.ontap});

  @override
  Widget build(BuildContext context) {
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

    mediaquery = MediaQuery.of(context).size;
    return Dialog(
        child: SizedBox(
      height: mediaquery.height * .2,
      width: mediaquery.width * .15,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: mediaquery.height * .01,
          ),
          // textfeild(
          //   name: "enter ur purpose",
          //   condn: false,
          //   icon: Icons.abc,
          //   controller: controller,
          // ),
          Padding(
            padding: EdgeInsets.only(left: mediaquery.width * .2),
            child: buildDropdownButton(dropdownValue, list1, controller),
          ),
          SizedBox(
            height: mediaquery.height * .02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: ontap,
                child: const Text("update"),
              )
            ],
          )
        ],
      ),
    ));
  }
}

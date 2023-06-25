// ignore: unused_import
import 'dart:collection';
import 'package:flutter_carousel_slider/carousel_slider.dart';
// ignore: unused_import
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';
import 'package:m_trackn/screens/category/expense.dart';

import 'package:m_trackn/screens/category/income.dart';
import 'package:m_trackn/screens/overview/stats/month_chart.dart';
import 'package:m_trackn/screens/temp/temp_message.dart';
// import 'package:m_trackn/screens/transactions/dialogbox.dart';

import '../../addn_widgets/button_name.dart';

import '../../addn_widgets/chart.dart';
import '../../addn_widgets/pad_text.dart';

late Size mediaquery;
String dropdownValue = list1.first;
RegExp? m;
double limitValue = list2.first;
var reference = FirebaseDatabase.instance.ref().child('BankDb');
const List<String> list1 = <String>[
  'feb_23',
  'mar_23',
  'apr_23',
  'may_23',
  'jun_23',
];
const List<double> list2 = <double>[
  10.00,
  20.00,
  30.00,
  40.00,
  50.00,
  60.00,
  70.00,
  80.00,
  90.00,
];

// ignore: camel_case_types
class overview extends StatefulWidget {
  const overview({super.key});

  @override
  State<overview> createState() => _nameState();
}

// ignore: camel_case_types
class _nameState extends State<overview> {
  @override
  void initState() {
    super.initState();
  }

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

  Future<double> getTotal(String type) async {
    var data = await FirebaseDatabase.instance
        .ref()
        .child('BankDb')
        .child('All')
        .orderByChild('mode')
        .equalTo(type)
        .get();
    double sum = 0.0;
    double sum2 = 0.0;
    // ignore: unused_local_variable
    double sum1 = 0.0;
    final RegExp pattern =
        // RegExp(r'2023-02-09 09:29:19.320');
        month();

    (data.value as Map).forEach((key, element) {
      final Match? match = pattern.firstMatch(element['DateTime']);
      if (match != null) {
        sum += double.parse(element['amount']);
        if (sum == 0) {
          sum2 = 0;
        } else {
          sum2 = sum;
        }
      } else {
        sum1 += double.parse(element['amount']);
      }
    });
    return sum2;
  }

  Future val() async {
    var x = await getTotal('CREDITED');
    var y = await getTotal('DEBITED');
    var z;
    if (y != 0) {
      z = (x / (x + y));
    } else {
      z = 0;
    }
    return z!;
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

  Widget buildDropdownintButton(
      double selectedValue, List<double> dropdownValues, var onChanged) {
    return DropdownButton<double>(
      value: selectedValue,
      onChanged: onChanged,
      items: dropdownValues.map((double value) {
        return DropdownMenuItem<double>(
          value: value,
          child: Text(value.toString()),
        );
      }).toList(),
    );
  }

  Future val1() async {
    var x = await getTotal('CREDITED');
    var y = await getTotal('DEBITED');
    var z;
    if (y != 0) {
      z = (y / (x + y));
    } else {
      z = 0;
    }

    return z!;
  }

  atext() {
    if (a == 0) {
      return '';
    } else {
      return (a * 100).toString().substring(0, 4);
    }
  }

  wtext() {
    if (w == 0) {
      return '';
    } else {
      return (w * 100).toString().substring(0, 4);
    }
  }

  // ignore: prefer_typing_uninitialized_variables
  var w;
  // ignore: prefer_typing_uninitialized_variables
  var a;

  @override
  Widget build(BuildContext context) {
    mediaquery = MediaQuery.of(context).size;

    val().then((val) {
      print(val);
    });

    setState(() {
      // ignore: unused_local_variable
      w = val().then((val) {
        w = val!;
      });
      a = val1().then((val) {
        a = val;
      });
    });

    val1().then((val) {
      print(val);
    });
    print(month());

    getTotal("CREDITED").then((value) => print(value));
    getTotal("DEBITED").then((value) => print(value));

    Widget _buildCarousel(item1, item2) {
      return SizedBox(
        height: 150,
        width: mediaquery.width * 1,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 2,
          itemBuilder: (context, index) {
            // create a container to hold each carousel item
            return Container(
              // set the width of each carousel item
              child: Card(
                color: Color.fromARGB(255, 248, 234, 230),
                child: index == 0
                    ? Center(
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 150),
                              child:
                                  chart(q: w!, v: wtext(), w: const income()),
                            ),
                            SizedBox(
                              height: mediaquery.height * .007,
                            ),
                            const padtext(
                              name: "Income",
                              fontsize: 15,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 139, 57, 171),
                            ),
                          ],
                        ),
                      )
                    : Center(
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 150),
                              child:
                                  chart(q: a!, v: atext(), w: const expense()),
                            ),
                            SizedBox(
                              height: mediaquery.height * .007,
                            ),
                            const padtext(
                              name: "Expense",
                              fontsize: 15,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 139, 57, 171),
                            ),
                            SizedBox(
                              height: mediaquery.height * .007,
                            )
                          ],
                        ),
                      ), // use the appropriate future builder widget based on the index
              ),
            );
          },
        ),
      );
    }

    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        // margin: EdgeInsets.only(top: mediaquery.height * .12),
        decoration: const BoxDecoration(
            // image: DecorationImage(
            //     image: AssetImage("assets/banner-bg.jpg"), fit: BoxFit.fill)
            color: Color(0xFFFDE1D7)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          FutureBuilder(
              future: Future.wait([val(), val1()]),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // if both future builders are done, build the carousel widget
                  return _buildCarousel(snapshot.data[0], snapshot.data[1]);
                } else {
                  // show a loading indicator while waiting for the future builders to complete
                  return Center(child: CircularProgressIndicator());
                }
              }),

          //////////////////////////////////////////////////////

          Container(
            margin: EdgeInsets.only(
              top: mediaquery.height * .009,
              left: mediaquery.width * .03,
              right: mediaquery.width * .03,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(mediaquery.width * 0.1),
                color: Colors.white70,
                boxShadow: [
                  BoxShadow(
                      blurRadius: mediaquery.width * 0.1,
                      spreadRadius: mediaquery.width * 0.06,
                      offset: const Offset(1, 1),
                      color: Colors.grey.withOpacity(0.2))
                ]),
            // child:
          ),
          Container(
              margin: EdgeInsets.only(
                top: mediaquery.height * .009,
                left: mediaquery.width * .03,
                right: mediaquery.width * .03,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(mediaquery.width * 0.1),
                  color: Colors.white70,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: mediaquery.width * 0.1,
                        spreadRadius: mediaquery.width * 0.06,
                        offset: const Offset(1, 1),
                        color: Colors.grey.withOpacity(0.2))
                  ]),
              child: Column(children: [
                Padding(
                  padding: EdgeInsets.only(left: mediaquery.width * 0.1),
                  child: Row(children: [
                    const Text(
                      "Select month",
                      style: TextStyle(
                          // color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: mediaquery.width * 0.06),
                      child: buildDropdownButton(
                        dropdownValue,
                        list1,
                        (String? value) {
                          setState(() {
                            dropdownValue = value!;
                          });
                        },
                      ),
                    ),
                  ]),
                ),
              ])),
          Padding(
            padding: EdgeInsets.only(left: mediaquery.width * 0.08),
            child: Row(children: [
              const Text(
                "Select your m-limitr: ",
                style: TextStyle(
                    // color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
              Padding(
                padding: EdgeInsets.only(left: mediaquery.width * 0.06),
                child: buildDropdownintButton(
                  limitValue,
                  list2,
                  (double? value) {
                    setState(() {
                      limitValue = value!;
                    });

                    limit();
                    HashMap<String, dynamic> limiter =
                        HashMap<String, dynamic>();
                    limiter['limitvalue'] = limitValue;
                    reference.ref.update(limiter);
                  },
                ),
              ),
            ]),
          ),
          Container(
            margin: EdgeInsets.only(
              top: mediaquery.height * .009,
              left: mediaquery.width * .03,
              right: mediaquery.width * .03,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(mediaquery.width * 0.1),
              color: Colors.transparent,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: mediaquery.width * 0.1,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 0),
                  child: Text(
                    "Stat-e-gory",
                    style: TextStyle(
                        fontSize: 40,
                        // color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(
                  height: mediaquery.width * 0.05,
                ),
                buttonname(
                    name: "sms_temp",
                    x: mediaquery.width * 0.23,
                    pagex: const temp_msg(),
                    icon: "assets/loading.gif",
                    y: 20,
                    z: 0),
                SizedBox(
                  height: mediaquery.width * 0.05,
                ),
                Column(children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('not allocated')));
                        },
                        child: Container(
                            margin: EdgeInsets.only(
                              top: mediaquery.height * .009,
                              left: mediaquery.width * .03,
                              // right: mediaquery.width * .03,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: const Color.fromARGB(137, 255, 0, 0),
                                  width: 5),
                              borderRadius: BorderRadius.circular(
                                  mediaquery.width * 0.05),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: mediaquery.width * 0.14,
                                  vertical: mediaquery.width * 0.14),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: mediaquery.width * 0.02),
                                child: const Text("daily"),
                              ),
                            )),
                      ),
                      InkWell(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('not allocated')));
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                            top: mediaquery.height * .009,
                            left: mediaquery.width * .03,
                            // right: mediaquery.width * .03,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromARGB(137, 255, 0, 0),
                                width: 5),
                            borderRadius:
                                BorderRadius.circular(mediaquery.width * 0.05),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: mediaquery.width * 0.14,
                                vertical: mediaquery.width * 0.14),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: mediaquery.width * 0.04),
                              child: const Text("all"),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: mediaquery.width * 0.02,
                  ),
                  Row(
                    children: [
                      InkWell(
                        // onTap: () => const monthly_stat(),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const monthly_stat()));
                        },
                        child: Container(
                            margin: EdgeInsets.only(
                              top: mediaquery.height * .009,
                              left: mediaquery.width * .03,
                              // right: mediaquery.width * .03,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: const Color.fromARGB(137, 255, 0, 0),
                                  width: 5),
                              borderRadius: BorderRadius.circular(
                                  mediaquery.width * 0.05),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: mediaquery.width * 0.12,
                                  vertical: mediaquery.width * 0.14),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: mediaquery.width * 0.01),
                                child: const Text("monthly"),
                              ),
                            )),
                      ),
                      InkWell(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('not allocated')));
                        },
                        child: Container(
                            margin: EdgeInsets.only(
                              top: mediaquery.height * .009,
                              left: mediaquery.width * .03,
                              // right: mediaquery.width * .03,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: const Color.fromARGB(137, 255, 0, 0),
                                  width: 5),
                              borderRadius: BorderRadius.circular(
                                  mediaquery.width * 0.05),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: mediaquery.width * 0.14,
                                  vertical: mediaquery.width * 0.14),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: mediaquery.width * 0.015),
                                child: const Text("yearly"),
                              ),
                            )),
                      )
                    ],
                  )
                ]),
                SizedBox(
                  height: mediaquery.width * 0.05,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: mediaquery.height * .02,
              left: mediaquery.width * .03,
              right: mediaquery.width * .03,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(mediaquery.width * 0.1),
                color: Colors.white70,
                boxShadow: [
                  BoxShadow(
                      blurRadius: mediaquery.width * 0.1,
                      spreadRadius: mediaquery.width * 0.06,
                      offset: const Offset(1, 1),
                      color: Colors.grey.withOpacity(0.2))
                ]),
            child: Column(children: [
              SizedBox(
                height: mediaquery.width * 0.05,
              ),
              SizedBox(
                height: mediaquery.width * 0.05,
              )
            ]),
          ),
        ]),
      ),
    ));
  }

  limit() {
    if (limitValue <= (a * 100.00)) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("your way over ur limit bro....")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("your good bro....")));
    }
  }
}

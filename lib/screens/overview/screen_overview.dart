import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';
import 'package:m_trackn/screens/category/expense.dart';

import 'package:m_trackn/screens/category/income.dart';
import 'package:m_trackn/screens/overview/stats/month_chart.dart';
import 'package:m_trackn/screens/temp/temp_message.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

late Size mediaquery;
String dropdownValue = list1.first;
RegExp? m;

const List<String> list1 = <String>[
  'feb_23',
  'mar_23',
  'apr_23',
  'may_23',
  'jun_23',
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
        w = val;
      });
    });

    val1().then((val) {
      print(val);
    });
    print(month());
    setState(() {
      // ignore: unused_local_variable
      a = val1().then((val) {
        a = val;
      });
    });
    getTotal("CREDITED").then((value) => print(value));
    getTotal("DEBITED").then((value) => print(value));
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/banner-bg.jpg"), fit: BoxFit.fill)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          FutureBuilder(
            future: val(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  break;
                case ConnectionState.waiting:
                  return const CircularProgressIndicator(
                    color: Colors.black54,
                    strokeWidth: 2,
                  );
                case ConnectionState.active:
                  break;
                case ConnectionState.done:
                  return Center(
                    child: Column(
                      children: [
                        chart(
                            q: w,
                            v:
                                // '5',
                                wtext(),
                            // (w * 100).toString().substring(0, 4),
                            w: const income()),
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
                  );
              }
              return const Text('Some error ocurred try getDoctor');
            },
          ),
          FutureBuilder(
            future: val1(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  break;
                case ConnectionState.waiting:
                  return const CircularProgressIndicator(
                    color: Colors.black54,
                    strokeWidth: 2,
                  );
                case ConnectionState.active:
                  break;
                case ConnectionState.done:
                  return Center(
                    child: Column(
                      children: [
                        chart(q: a, v: atext(), w: const expense()),
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
                  );
              }
              return const Text('Some error ocurred try getDoctor');
            },
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
                      Container(
                          margin: EdgeInsets.only(
                            top: mediaquery.height * .009,
                            left: mediaquery.width * .05,
                            // right: mediaquery.width * .03,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius:
                                BorderRadius.circular(mediaquery.width * 0.05),
                            color: Colors.transparent,
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
                      Container(
                        margin: EdgeInsets.only(
                          top: mediaquery.height * .009,
                          left: mediaquery.width * .03,
                          // right: mediaquery.width * .03,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius:
                              BorderRadius.circular(mediaquery.width * 0.05),
                          color: Colors.transparent,
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
                              left: mediaquery.width * .05,
                              // right: mediaquery.width * .03,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(
                                  mediaquery.width * 0.05),
                              color: Colors.transparent,
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
                      Container(
                          margin: EdgeInsets.only(
                            top: mediaquery.height * .009,
                            left: mediaquery.width * .03,
                            // right: mediaquery.width * .03,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius:
                                BorderRadius.circular(mediaquery.width * 0.05),
                            color: Colors.transparent,
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
                          ))
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
              button_normal(
                name: "log out",
                x: mediaquery.width * 0.32,
                icon: "assets/loading.gif",
                color: Colors.redAccent,
                y: 20,
                z: 0,
              ),
              SizedBox(
                height: mediaquery.width * 0.05,
              )
            ]),
          )
        ]),
      ),
    ));
  }
}

// ignore: camel_case_types, must_be_immutable
class chart extends StatelessWidget {
  final double q;
  String v;
  // ignore: prefer_typing_uninitialized_variables
  final w;
  chart({super.key, required this.q, required this.v, required this.w});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => w));
      },
      child: CircularPercentIndicator(
        backgroundColor: Colors.transparent,
        progressColor: const Color.fromARGB(255, 139, 57, 171),
        radius: 50.0,
        lineWidth: 10.0,
        animation: true,
        percent: q,
        center: Text(
          v,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: Color.fromARGB(255, 139, 57, 171)),
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class buttonname extends StatelessWidget {
  final String name;
  final double x;
  final double y;
  final double z;
  // ignore: prefer_typing_uninitialized_variables
  final icon;
  // ignore: prefer_typing_uninitialized_variables
  final pagex;
  const buttonname(
      {super.key,
      required this.name,
      required this.x,
      required this.pagex,
      required this.icon,
      required this.y,
      required this.z});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => pagex));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(252, 244, 255, 1),
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: x, vertical: y)),
                label: Text(name),
                icon: Image.asset(
                  icon,
                  width: 20,
                  height: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: CircularPercentIndicator(
                  radius: 18,
                  animation: true,
                  lineWidth: 5,
                  progressColor: Colors.red,
                  percent: z,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class button_normal extends StatelessWidget {
  final String name;
  final double x;
  final double y;
  final double z;
  // final Function onpressed;
  // ignore: prefer_typing_uninitialized_variables
  final color;
  // ignore: prefer_typing_uninitialized_variables
  final icon;
  // ignore: prefer_typing_uninitialized_variables

  const button_normal({
    super.key,
    required this.name,
    required this.x,
    required this.icon,
    required this.y,
    required this.z,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton.icon(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: color,
                    foregroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: x, vertical: y)),
                label: Text(name),
                icon: Image.asset(
                  icon,
                  width: 20,
                  height: 20,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class padtext extends StatelessWidget {
  final String name;
  final FontWeight fontWeight;
  final double fontsize;
  // ignore: prefer_typing_uninitialized_variables
  final color;
  const padtext(
      {super.key,
      required this.name,
      required this.fontsize,
      required this.fontWeight,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0),
      child: Text(
        name,
        style:
            TextStyle(fontSize: fontsize, fontWeight: fontWeight, color: color),
      ),
    );
  }
}

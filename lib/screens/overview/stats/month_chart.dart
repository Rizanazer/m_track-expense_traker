import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

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
class monthly_stat extends StatefulWidget {
  const monthly_stat({super.key});

  @override
  State<monthly_stat> createState() => _monthly_statState();
}

// ignore: camel_case_types
class _monthly_statState extends State<monthly_stat> {
  List<Color> colorList = [
    const Color.fromRGBO(0, 45, 243, 1),
    const Color.fromARGB(255, 0, 185, 236),
    const Color.fromARGB(255, 101, 63, 155),
  ];

  final gradientList = <List<Color>>[
    [
      const Color.fromARGB(255, 182, 169, 255),
      const Color.fromARGB(255, 133, 112, 250),
    ],
    [
      const Color.fromARGB(255, 253, 175, 175),
      const Color.fromARGB(255, 236, 119, 117),
    ],
    [
      const Color.fromARGB(255, 71, 171, 141),
      // Color.fromARGB(255, 170, 255, 146),
      const Color.fromARGB(255, 128, 205, 207),
    ]
  ];
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
        sum1 = 0;
      }
    });
    return sum2;
  }

  // ignore: non_constant_identifier_names
  Future val_income() async {
    var x = await getTotal('CREDITED');
    // ignore: unused_local_variable
    var q = await getTotal('DEBITED');
    // ignore: prefer_typing_uninitialized_variables
    var z;
    if (x != 0) {
      z = (x / 100);
    } else {
      z = 0;
    }
    return z!;
  }

  Future val_exp() async {
    var q = await getTotal('DEBITED');
    // ignore: prefer_typing_uninitialized_variables
    var i;
    if (q != 0) {
      i = (q / 100);
    } else {
      i = 0;
    }
    return i!;
  }

  Future<double> getTotaldebit(String type) async {
    var data = await FirebaseDatabase.instance
        .ref()
        .child('BankDb')
        .child('All')
        .orderByChild('mode')
        .equalTo('DEBITED')
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
      if (element['purpose'] == type) {
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
      } else {
        // ignore: avoid_returning_null_for_void
        return null;
      }
    });
    return sum2;
  }

  // ignore: non_constant_identifier_names
  val_debit_fixed() async {
    var x = await getTotaldebit('fixedcost');
    // ignore: prefer_typing_uninitialized_variables
    var z;

    if (x != 0) {
      z = (x);
    } else {
      z = 0;
    }
    return z!;
  }

  // ignore: non_constant_identifier_names
  val_debit_variable() async {
    var x = await getTotaldebit('variablecost');
    // ignore: prefer_typing_uninitialized_variables
    var z;

    if (x != 0) {
      z = (x);
    } else {
      z = 0;
    }
    return z!;
  }

  savings() async {
    var w = await getTotal('DEBITED');

    return w;
  }

  Future difference() async {
    var x = await getTotal('DEBITED');
    var y = await getTotal('CREDITED');
    var z;
    z = x - y;
    if (z > 0) {
      return z!;
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_typing_uninitialized_variables, unused_local_variable
    var f;
    // ignore: prefer_typing_uninitialized_variables, unused_local_variable
    var v;
    // ignore: prefer_typing_uninitialized_variables, unused_local_variable
    var c;
    var s;
    late var d;
    setState(() {
      f = val_debit_fixed().then((val) {
        f = val;
      });
      v = val_debit_variable().then((val) {
        v = val;
      });
      c = val_income().then((val) {
        c = val;
      });
      s = savings().then((val) {
        s = val;
      });
      d = difference().then((val) {
        d = val;
        print(d);
      });
    });

    late var t = (s - (v + f));
    // ignore: no_leading_underscores_for_local_identifiers
    Widget _buildCarousel(item1, item2, item3) {
      return SizedBox(
          width: mediaquery.width * 1,
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: 1,
              itemBuilder: (context, index) {
                // create a container to hold each carousel item
                return Column(
                  children: [
                    Column(
                      children: [
                        PieChart(
                          dataMap: {
                            'fixed: ${c * 50}': 50,
                            'variable: ${c * 30}': 30,
                            'savings: ${c * 20}': 20,
                          },
                          colorList: colorList,
                          chartRadius: MediaQuery.of(context).size.width / 2,
                          centerText: "income",
                          ringStrokeWidth: 24,
                          animationDuration: const Duration(seconds: 3),
                          chartValuesOptions: const ChartValuesOptions(
                              showChartValues: true,
                              showChartValuesOutside: true,
                              showChartValuesInPercentage: true,
                              showChartValueBackground: false),
                          legendOptions: const LegendOptions(
                              showLegends: true,
                              legendShape: BoxShape.rectangle,
                              legendTextStyle:
                                  TextStyle(fontSize: 15, color: Colors.black),
                              legendPosition: LegendPosition.bottom,
                              showLegendsInRow: true),
                          gradientList: gradientList,
                        ),
                        // ignore: prefer_interpolation_to_compose_strings
                        Text('Total credit: ' + (c * 100).toString(),
                            style: const TextStyle(
                                fontSize: 15, color: Colors.black)),
                      ],
                    ),
                    Column(
                      children: [
                        PieChart(
                          dataMap: {
                            'fixed: $f': (f / (f + v + t)),
                            'variable: $v': (v / (f + v + t)),
                            'savings: $t': (t / (f + v + t)),
                          },
                          colorList: colorList,
                          chartRadius: MediaQuery.of(context).size.width / 2,
                          centerText: "Expense",
                          ringStrokeWidth: 24,
                          animationDuration: const Duration(seconds: 3),
                          chartValuesOptions: const ChartValuesOptions(
                              showChartValues: true,
                              showChartValuesOutside: true,
                              showChartValuesInPercentage: true,
                              showChartValueBackground: false),
                          legendOptions: const LegendOptions(
                              showLegends: true,
                              legendShape: BoxShape.rectangle,
                              legendTextStyle:
                                  TextStyle(fontSize: 15, color: Colors.black),
                              legendPosition: LegendPosition.bottom,
                              showLegendsInRow: true),
                          gradientList: gradientList,
                        ),
                        Text('total debit: ${v + f + t}',
                            style: const TextStyle(
                                fontSize: 15, color: Colors.black)),
                      ],
                    ),
                    Column(
                      children: [
                        Text("previous months unaccounted: $d",
                            style: const TextStyle(
                                fontSize: 15, color: Colors.black)),
                      ],
                    )
                  ],
                );
              }));
    }

    mediaquery = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(color: Color(0xFFFDE1D7)),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: mediaquery.height * .05,
                  bottom: mediaquery.height * .05),
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
            FutureBuilder(
                future: Future.wait([val_income(), val_exp(), difference()]),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    // if both future builders are done, build the carousel widget
                    return _buildCarousel(
                        snapshot.data[0], snapshot.data[1], snapshot.data[2]);
                  } else {
                    // show a loading indicator while waiting for the future builders to complete
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
            Padding(
              padding: EdgeInsets.only(top: mediaquery.height * 0.03),
              child: const Text(
                "disclamer:fixed expense=loan+tax+home-bills+etc...",
                style: TextStyle(fontSize: 10),
              ),
            ),
            const Text(
              "variable expense=food+movie+travel+study expense+etc...",
              style: TextStyle(fontSize: 10),
            )
          ],
        ),
      ),
    );
  }
}

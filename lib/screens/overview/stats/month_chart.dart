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
      const Color.fromARGB(255, 49, 29, 59),
      const Color.fromARGB(255, 133, 112, 250),
    ],
    [
      Color.fromARGB(255, 255, 255, 255),
      Color.fromARGB(255, 11, 0, 70),
    ],
    [
      const Color.fromARGB(255, 145, 62, 175),
      const Color.fromARGB(255, 254, 92, 197),
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

  // ignore: prefer_typing_uninitialized_variables
  // var q;
  // // ignore: non_constant_identifier_names
  // review_fix(c, f) {
  //   if ((c * 50) < f) {
  //     q = 'fixed expense exceeded the limit about :${f - (c * 50)}';
  //   } else {
  //     q = 'in limit';
  //   }
  //   return q;
  // }

  // // ignore: prefer_typing_uninitialized_variables
  // var e;
  // // ignore: non_constant_identifier_names
  // review_var(c, v) {
  //   if ((c * 30) < v) {
  //     e = 'variable expense exceeded the limit about :${v - (c * 30)}';
  //   } else {
  //     e = 'in limit';
  //   }
  //   return e;
  // }

  // review_sav(c, f) {
  //   if ((c * 20) < f) {
  //     q = 'fixed expense exceeded the limit about :' + (f - (c * 50));
  //   } else {
  //     q = 'in limit';
  //   }
  // }

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
    // ignore: prefer_typing_uninitialized_variables
    var z;
    if (x != 0) {
      z = (x / 100);
    } else {
      z = 0;
    }
    return z!;
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

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_typing_uninitialized_variables, unused_local_variable
    var f;
    // ignore: prefer_typing_uninitialized_variables, unused_local_variable
    var v;
    // ignore: prefer_typing_uninitialized_variables, unused_local_variable
    var c;
    setState(() {
      f = val_debit_fixed().then((val) {
        f = val;
      });
    });
    setState(() {
      v = val_debit_variable().then((val) {
        v = val;
      });
    });
    setState(() {
      c = val_income().then((val) {
        c = val;
      });
    });
    val_debit_fixed().then((val) {
      print(val);
    });
    val_debit_variable().then((val) {
      print(val);
    });
    val_income().then((val) {
      print(val);
    });
    var s;
    savings() {
      if ((c * 100) > (f + v)) {
        s = (c * 100) - (f + v);
      } else {
        s = 0;
      }
      return s;
    }

    mediaquery = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/banner-bg.jpg"), fit: BoxFit.fill)),
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
              future: val_income(),
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
                    return PieChart(
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
                    );
                }
                return const Text('Some error ocurred try getDoctor');
              },
            ),
            FutureBuilder(
              future: val_income(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    break;
                  case ConnectionState.waiting:
                    return const CircularProgressIndicator(
                      color: Colors.black,
                      strokeWidth: 2,
                    );
                  case ConnectionState.active:
                    break;
                  case ConnectionState.done:
                    return PieChart(
                      dataMap: {
                        'fixed: $f': (f / (f + v + savings())),
                        'variable: $v': (v / (f + v + savings())),
                        'savings: ${savings()}':
                            (savings() / (f + v + savings())),
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
                    );
                }
                return const Text('Some error ocurred try getDoctor');
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: mediaquery.height * 0.03),
              child: const Text(
                "disclamer:fixed expense=loan+tax+home-bills+etc...",
                style: TextStyle(fontSize: 10),
              ),
            ),
            // Text(
            //   review_var(c, v).toString(),
            //   style: const TextStyle(fontSize: 15),
            // ),
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

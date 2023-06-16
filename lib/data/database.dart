import 'package:hive_flutter/hive_flutter.dart';

// ignore: camel_case_types
class todoDatabase {
  List myTile = [''];
  //ref box
  final _mybox = Hive.box('mybox');

  void createIntialdata() {
    myTile = [
      ['A'],
      ['B']
    ];
  }

  void loadData() {
    myTile = _mybox.get("myTile");
  }

  void updateDatabase() {
    _mybox.put("myTile", myTile);
  }
}

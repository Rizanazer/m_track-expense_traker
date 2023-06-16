import 'package:flutter/material.dart';
import 'package:m_trackn/screens/category/screen_category.dart';
import 'package:m_trackn/screens/home/widgets/bottom_navigation.dart';
import 'package:m_trackn/screens/overview/screen_overview.dart';
import 'package:m_trackn/screens/transactions/screen_transaction.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);

  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

  final _pages = const [
    overview(),
    ScreenTransaction(),
    ScreenCategory(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      // appBar: AppBar(
      //   // title: Text('MONEY MANAGER'),
      //   centerTitle: true,
      // ),
      bottomNavigationBar: const MoneyManagerBottomNavigation(),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: selectedIndexNotifier,
          builder: (BuildContext context, int updatedIndex, _) {
            return _pages[updatedIndex];
          },
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     if (selectedIndexNotifier.value == 0) {
      //       print('Add Transaction');
      //     } else {
      //       print('Add Category');
      //     }
      //   },
      //   child: Icon(Icons.add),
      // ),
    );
  }
}

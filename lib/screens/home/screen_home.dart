import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:m_trackn/addn_widgets/menu.dart';
import 'package:m_trackn/screens/category/screen_category.dart';
import 'package:m_trackn/screens/home/widgets/bottom_navigation.dart';
import 'package:m_trackn/screens/overview/screen_overview.dart';
import 'package:m_trackn/screens/transactions/screen_transaction.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);

  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

  final _pages = const [
    menu(),
    overview(),
    ScreenTransaction(),
    ScreenCategory(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDE1D7),
      // appBar: AppBar(
      //   // title: Text('MONEY MANAGER'),
      //   centerTitle: true,
      // ),
      bottomNavigationBar: MoneyManagerBottomNavigation(
        behaviour: SnakeBarBehaviour.floating,
        snakeShape: SnakeShape.circle,
      ),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: selectedIndexNotifier,
          builder: (BuildContext context, int updatedIndex, _) {
            return _pages[updatedIndex];
          },
        ),
      ),
    );
  }
}

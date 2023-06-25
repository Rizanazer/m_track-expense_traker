import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

import 'package:m_trackn/screens/home/screen_home.dart';

// ignore: must_be_immutable
class MoneyManagerBottomNavigation extends StatefulWidget {
  MoneyManagerBottomNavigation({
    Key? key,
    required this.snakeShape,
    required this.behaviour,
  }) : super(key: key);

  EdgeInsets padding = const EdgeInsets.all(12);

  SnakeShape snakeShape = SnakeShape.circle;

  bool showSelectedLabels = false;
  bool showUnselectedLabels = false;

  /// If [SnakeBarBehaviour.floating] this color is
  /// used as background color of shaped view.
  /// If [SnakeBarBehaviour.pinned] this color just
  /// a background color of whole [SnakeNavigationBar] view

  List<Color> containerColors = [
    const Color(0xFFFDE1D7),
    const Color(0xFFE4EDF5),
    const Color(0xFFE7EEED),
    const Color(0xFFF4E4CE),
  ];

  final SnakeBarBehaviour behaviour;

  @override
  State<MoneyManagerBottomNavigation> createState() =>
      _MoneyManagerBottomNavigationState();
}

class _MoneyManagerBottomNavigationState
    extends State<MoneyManagerBottomNavigation> {
  // ignore: unused_field
  final BorderRadius _borderRadius = const BorderRadius.only(
    topLeft: Radius.circular(25),
    topRight: Radius.circular(25),
  );

  ShapeBorder? bottomBarShape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(25)),
  );

  SnakeBarBehaviour snakeBarStyle = SnakeBarBehaviour.floating;

  Color selectedColor = Colors.black;

  Color unselectedColor = Colors.blueGrey;

  Gradient selectedGradient =
      const LinearGradient(colors: [Colors.red, Colors.amber]);

  Gradient unselectedGradient =
      const LinearGradient(colors: [Colors.red, Colors.blueGrey]);

  Color? containerColor;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ScreenHome.selectedIndexNotifier,
      builder: (BuildContext ctx, int updatedIndex, Widget? _) {
        return SnakeNavigationBar.color(
          // backgroundColor: const Color(0xFFFDE1D7),
          // shadowColor: const Color(0xFFFDE1D7),
          behaviour: snakeBarStyle,
          snakeShape: widget.snakeShape,
          shape: bottomBarShape,
          padding: widget.padding,
          snakeViewColor: selectedColor,
          selectedItemColor:
              widget.snakeShape == SnakeShape.indicator ? selectedColor : null,
          unselectedItemColor: Colors.blueGrey,
          showUnselectedLabels: widget.showUnselectedLabels,
          showSelectedLabels: widget.showSelectedLabels,
          currentIndex: updatedIndex,
          onTap: (newIndex) {
            ScreenHome.selectedIndexNotifier.value = newIndex;
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'menu'),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'overview'),
            BottomNavigationBarItem(
                icon: Icon(Icons.wallet), label: 'transaction'),
            BottomNavigationBarItem(
                icon: Icon(Icons.category_rounded), label: 'category'),
          ],
        );
      },
    );
  }
}

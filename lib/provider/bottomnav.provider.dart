import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class BottomNavigationBarProvider with ChangeNotifier {
  int _currentIndex = 0;

  get currentIndex => _currentIndex;

  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  List<BottomNavigationBarItem> _bottomnav;
  List<BottomNavigationBarItem> get bottomnav => _bottomnav;

  List<BottomNavigationBarItem> bottomNavBarItems(int index) {
    switch (index) {
      case 0:
        return _bottomnav = bottomNavBarItems0;
        break;
      case 1:
        return _bottomnav = bottomNavBarItems1;
        break;
      case 2:
        return _bottomnav = bottomNavBarItems2;
        break;
      case 3:
        return _bottomnav = bottomNavBarItems3;
        break;
      default:
        return _bottomnav = bottomNavBarItems0;
    }
  }

  List<BottomNavigationBarItem> bottomNavBarItems0 = [
    BottomNavigationBarItem(
        icon: Image.asset(
          "assets/images/home_variant.png",
          height: 25,
        ),
        label: ""),
    BottomNavigationBarItem(
        icon: Image.asset(
          "assets/images/order_outlined.png",
          height: 25,
        ),
        label: ""),
    BottomNavigationBarItem(
        icon: Image.asset(
          "assets/images/love_outlined.png",
          height: 25,
        ),
        label: ""),
    BottomNavigationBarItem(
        icon: Image.asset(
          "assets/images/profile_outlined.png",
          height: 25,
        ),
        label: ""),
  ];

  List<BottomNavigationBarItem> bottomNavBarItems1 = [
    BottomNavigationBarItem(
        icon: Image.asset(
          "assets/images/home_outlined.png",
          height: 25,
        ),
        label: ""),
    BottomNavigationBarItem(
        icon: Image.asset(
          "assets/images/order_variant.png",
          height: 25,
        ),
        label: ""),
    BottomNavigationBarItem(
        icon: Image.asset(
          "assets/images/love_outlined.png",
          height: 25,
        ),
        label: ""),
    BottomNavigationBarItem(
        icon: Image.asset(
          "assets/images/profile_outlined.png",
          height: 25,
        ),
        label: ""),
  ];

  List<BottomNavigationBarItem> bottomNavBarItems2 = [
    BottomNavigationBarItem(
        icon: Image.asset(
          "assets/images/home_outlined.png",
          height: 25,
        ),
        label: ""),
    BottomNavigationBarItem(
        icon: Image.asset(
          "assets/images/order_outlined.png",
          height: 25,
        ),
        label: ""),
    BottomNavigationBarItem(
        icon: Image.asset(
          "assets/images/love_variant.png",
          height: 25,
        ),
        label: ""),
    BottomNavigationBarItem(
        icon: Image.asset(
          "assets/images/profile_outlined.png",
          height: 25,
        ),
        label: ""),
  ];

  List<BottomNavigationBarItem> bottomNavBarItems3 = [
    BottomNavigationBarItem(
        icon: Image.asset(
          "assets/images/home_outlined.png",
          height: 25,
        ),
        label: ""),
    BottomNavigationBarItem(
        icon: Image.asset(
          "assets/images/order_outlined.png",
          height: 25,
        ),
        label: ""),
    BottomNavigationBarItem(
        icon: Image.asset(
          "assets/images/love_outlined.png",
          height: 25,
        ),
        label: ""),
    BottomNavigationBarItem(
        icon: Image.asset(
          "assets/images/profile_variant.png",
          height: 25,
        ),
        label: ""),
  ];
}

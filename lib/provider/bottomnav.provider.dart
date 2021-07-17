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
    BottomNavigationBarItem(icon: Icon(MdiIcons.homeVariant), label: ""),
    BottomNavigationBarItem(
        icon: Icon(MdiIcons.newspaperVariantOutline), label: ""),
    BottomNavigationBarItem(
        icon: Icon(Icons.favorite_border_outlined), label: ""),
    BottomNavigationBarItem(icon: Icon(MdiIcons.accountOutline), label: ""),
  ];

  List<BottomNavigationBarItem> bottomNavBarItems1 = [
    BottomNavigationBarItem(icon: Icon(MdiIcons.homeVariantOutline), label: ""),
    BottomNavigationBarItem(icon: Icon(MdiIcons.newspaperVariant), label: ""),
    BottomNavigationBarItem(
        icon: Icon(Icons.favorite_border_outlined), label: ""),
    BottomNavigationBarItem(icon: Icon(MdiIcons.accountOutline), label: ""),
  ];

  List<BottomNavigationBarItem> bottomNavBarItems2 = [
    BottomNavigationBarItem(icon: Icon(MdiIcons.homeVariantOutline), label: ""),
    BottomNavigationBarItem(
        icon: Icon(MdiIcons.newspaperVariantOutline), label: ""),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ""),
    BottomNavigationBarItem(icon: Icon(MdiIcons.accountOutline), label: ""),
  ];

  List<BottomNavigationBarItem> bottomNavBarItems3 = [
    BottomNavigationBarItem(icon: Icon(MdiIcons.homeVariantOutline), label: ""),
    BottomNavigationBarItem(
        icon: Icon(MdiIcons.newspaperVariantOutline), label: ""),
    BottomNavigationBarItem(
        icon: Icon(Icons.favorite_border_outlined), label: ""),
    BottomNavigationBarItem(icon: Icon(MdiIcons.account), label: ""),
  ];
}

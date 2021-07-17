import 'package:flutter/material.dart';
import 'package:galeri_teknologi_bersama/common/styles.dart';
import 'package:galeri_teknologi_bersama/data/preferences/theme.preference.dart';

class PreferencesProvider extends ChangeNotifier {
  ThemePreference themePreference;

  PreferencesProvider({this.themePreference}) {
    _getTheme();
  }

  bool _isDarkTheme = false;
  bool get isDarkTheme => _isDarkTheme;

  ThemeData get themeData => _isDarkTheme ? darkTheme : lightTheme;

  void _getTheme() async {
    _isDarkTheme = await themePreference.isDarkTheme;
    notifyListeners();
  }

//setter
  void enableDarkTheme(bool value) {
    themePreference.setDarkTheme(value);
    _getTheme();
  }
}

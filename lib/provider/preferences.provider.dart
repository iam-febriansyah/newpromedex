import 'package:flutter/material.dart';
import 'package:galeri_teknologi_bersama/common/styles.dart';
import 'package:galeri_teknologi_bersama/data/local/theme.preference.dart';
import 'package:galeri_teknologi_bersama/data/local/user.preference.dart';

class PreferencesProvider extends ChangeNotifier {
  ThemePreference themePreference;
  UserPreference userPreference;

  PreferencesProvider({this.themePreference, this.userPreference}) {
    _getTheme();
    _getName();
    _getEmail();
    _getPhone();
  }

  bool _isDarkTheme = false;
  bool get isDarkTheme => _isDarkTheme;
  ThemeData get themeData => _isDarkTheme ? darkTheme : lightTheme;

  void _getTheme() async {
    _isDarkTheme = await themePreference.isDarkTheme;
    notifyListeners();
  }

  void enableDarkTheme(bool value) {
    themePreference.setDarkTheme(value);
    _getTheme();
  }

  //
  String _accesToken = "";
  String get accessToken => _accesToken;

  void getAccesToken() async {
    _accesToken = await userPreference.accesToken;
  }

  void setAccesToken(String value) {
    userPreference.setaccesToken(value);
    getAccesToken();
  }

  //

  //
  String _name = "";
  String get name => _name;
  void get getName => _getName();

  void _getName() async {
    _name = await userPreference.name;
    notifyListeners();
  }

  void setName(String value) {
    userPreference.setName(value);
    _getName();
  }

  //
  String _phone = "";
  String get phone => _phone;
  void get getPhone => _getPhone();

  void _getPhone() async {
    _phone = await userPreference.phone;
    notifyListeners();
  }

  //
  String _email = "";
  String get email => _email;
  void get getEmail => _getEmail();

  void _getEmail() async {
    _email = await userPreference.email;
    notifyListeners();
  }
}

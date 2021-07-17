import 'package:shared_preferences/shared_preferences.dart';

class ThemePreference {
  final Future<SharedPreferences> sharedPreferences;

  ThemePreference({this.sharedPreferences});

  static const DARK_THEME = 'DARK_THEME';

  Future<bool> get isDarkTheme async {
    final prefs = await sharedPreferences;
    return prefs.getBool(DARK_THEME) ?? false;
  }

  void setDarkTheme(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(DARK_THEME, value);
  }
}

import 'package:shared_preferences/shared_preferences.dart';

class UserPreference {
  final Future<SharedPreferences> sharedPreferences;

  UserPreference({this.sharedPreferences});

  static const TOKEN = 'accesToken';
  static const TOKENFCM = 'accesTokenFCM';

  static const EMAIL = 'email';
  static const PHONE = 'phone';
  static const NAME = 'name';

//
  Future<String> get accesToken async {
    final prefs = await sharedPreferences;
    return prefs.getString(TOKEN) ?? "defaultMyToken";
  }

  void setaccesToken(String value) async {
    final prefs = await sharedPreferences;
    prefs.setString(TOKEN, value);
  }

  //
  Future<String> get accesTokenFcm async {
    final prefs = await sharedPreferences;
    return prefs.getString(TOKENFCM) ?? "defaultMyToken";
  }

  void setaccesTokenFcm(String value) async {
    final prefs = await sharedPreferences;
    prefs.setString(TOKENFCM, value);
  }

  //
  Future<String> get name async {
    final prefs = await sharedPreferences;
    return prefs.getString(NAME) ?? "Login/Register";
  }

  void setName(String value) async {
    final prefs = await sharedPreferences;
    prefs.setString(NAME, value);
  }

  //
  Future<String> get phone async {
    final prefs = await sharedPreferences;
    return prefs.getString(PHONE) ?? "";
  }

  void setPhone(String value) async {
    final prefs = await sharedPreferences;
    prefs.setString(PHONE, value);
  }

  //
  Future<String> get email async {
    final prefs = await sharedPreferences;
    return prefs.getString(EMAIL) ?? "";
  }

  void setEmail(String value) async {
    final prefs = await sharedPreferences;
    prefs.setString(EMAIL, value);
  }
}

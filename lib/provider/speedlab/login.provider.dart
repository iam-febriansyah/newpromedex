import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:galeri_teknologi_bersama/data/local/user.preference.dart';
import 'package:galeri_teknologi_bersama/data/local/user.preference.dart';
import 'package:galeri_teknologi_bersama/data/model/request/login.dart';
import 'package:galeri_teknologi_bersama/data/model/response/login.dart';
import 'package:galeri_teknologi_bersama/data/remote/speedlab/dev.service.dart';
import 'package:galeri_teknologi_bersama/utils/result_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  UserPreference userPreference;

  final DevService devService;
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  LoginProvider({
    this.devService,
  });

  bool _btnLogin;
  ResultState _state;
  String _message = '';

  //
  bool get btnLogin => _btnLogin;
  String get message => _message;
  ResultState get state => _state;

  RequestLogin _requestLogin;
  //
  ResponseLogin _responseLogin;
  ResponseLogin get responseLogin => _responseLogin;

  void setLogin(RequestLogin value) {
    _requestLogin = value;
  }

  void setBtnLogin(bool value) {
    _btnLogin = value;
  }

  Future<dynamic> get fetch => _fetch(_requestLogin);

  Future<dynamic> _fetch(RequestLogin requestLogin) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final result = await devService.login(requestLogin);
      if (result == null) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        var accesTokenFcm = await messaging.getToken();

        userPreference = new UserPreference(
            sharedPreferences: SharedPreferences.getInstance());

        _state = ResultState.HasData;
        notifyListeners();
        _responseLogin = result;
        userPreference.setaccesTokenFcm(accesTokenFcm);

        userPreference.setaccesToken(_responseLogin.accessToken);

        print("token auth user" + await userPreference.accesToken);
        print("token auth fcm" + await userPreference.accesTokenFcm);

        userPreference.setEmail(_responseLogin.dataUser.email);
        userPreference.setPhone(_responseLogin.dataUser.phone);
        userPreference.setName(_responseLogin.dataUser.name);

        return _responseLogin;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'something wrong ..';
    }
  }
}

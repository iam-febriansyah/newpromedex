import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:galeri_teknologi_bersama/data/local/user.preference.dart';
import 'package:galeri_teknologi_bersama/data/model/response/fcm.dart';
import 'package:galeri_teknologi_bersama/data/model/response/listswabber.dart';
import 'package:galeri_teknologi_bersama/data/model/response/menu.dart';
import 'package:galeri_teknologi_bersama/data/model/response/merchant.dart';
import 'package:galeri_teknologi_bersama/data/remote/speedlab/dev.service.dart';
import 'package:galeri_teknologi_bersama/utils/result_state.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuProvider extends ChangeNotifier {
  final DevService devService;
  UserPreference userPreference =
      new UserPreference(sharedPreferences: SharedPreferences.getInstance());
  MenuProvider({
    this.devService,
  }) {
    _fetchMenu();
  }

  //=>
  String _tagFilter = "";
  String get tagFilter => _tagFilter;

  void setTagFilter(String value) {
    _tagFilter = value;
  }

  String _userLocationLatitude = "";
  String get userLocationLatitude => _userLocationLatitude;

  void setuserLocationLatitude(String value) {
    _userLocationLatitude = value;
  }

  String _userLocationLongitude = "";
  String get userLocationLongitude => _userLocationLongitude;

  void setuserLocationLongitude(String value) {
    _userLocationLongitude = value;
  }

  String _userLocationAddres = "";
  String get userLocationAddres => _userLocationAddres;

  void setuserLocationAddres(String value) {
    _userLocationAddres = value;
  }

  //=>
  ResultState _stateMenu;
  String _messageMenu = '';
  String _accesToken = "";
  ResponseMenu _responseMenu;
  //
  String get messageMenu => _messageMenu;
  ResultState get stateMenu => _stateMenu;
  ResponseMenu get responseMenu => _responseMenu;

  Future<dynamic> get fetchMenu => _fetchMenu();

  Future<dynamic> _fetchMenu() async {
    try {
      _stateMenu = ResultState.Loading;
      notifyListeners();
      _accesToken = await userPreference.accesToken;

      Response result = await devService.menu(_accesToken);

      if (result.statusCode == 200) {
        if (result == null) {
          _stateMenu = ResultState.NoData;
          notifyListeners();
          return _messageMenu = 'Empty Data';
        } else {
          _stateMenu = ResultState.HasData;
          notifyListeners();
          return _responseMenu =
              ResponseMenu.fromJson(json.decode(result.body));
        }
      } else {
        _stateMenu = ResultState.Warning;
        notifyListeners();
      }
    } catch (e) {
      _stateMenu = ResultState.Error;
      notifyListeners();
      return _messageMenu = 'connection error ..';
    }
  }

  //->

  ResultState _stateMerchant;
  String _messageMerchant = '';
  ResponseMerchant _responseMerchant;
  //
  String get messageMerchant => _messageMerchant;
  ResultState get stateMerchant => _stateMerchant;
  ResponseMerchant get responseMerchant => _responseMerchant;

  Future<dynamic> get fetchMerchant => _fetchMerchant();

  Future<dynamic> _fetchMerchant() async {
    try {
      _stateMerchant = ResultState.Loading;
      notifyListeners();
      _accesToken = await userPreference.accesToken;

      final result = await devService.merchant(_accesToken);

      if (result == null) {
        _stateMerchant = ResultState.NoData;
        notifyListeners();
        return _messageMerchant = 'Empty Data';
      } else {
        _stateMerchant = ResultState.HasData;
        notifyListeners();
        return _responseMerchant = result;
      }
    } catch (e) {
      _stateMerchant = ResultState.Error;
      notifyListeners();
      return _messageMerchant = 'connection error ..';
    }
  }

  //->

  ResultState _stateListSwabber;
  String _messageListSwabber = '';
  ResponseListSwabber _responseListSwabber;
  //
  String get messageListSwabber => _messageListSwabber;
  ResultState get stateListSwabber => _stateListSwabber;
  ResponseListSwabber get responseListSwabber => _responseListSwabber;

  Future<dynamic> get fetchListSwabber => _fetchListSwabber();

  Future<dynamic> _fetchListSwabber() async {
    try {
      _stateListSwabber = ResultState.Loading;
      notifyListeners();
      _accesToken = await userPreference.accesToken;

      final result = await devService.swabber(_accesToken, "", "");

      if (result == null) {
        _stateListSwabber = ResultState.NoData;
        notifyListeners();
        return _messageListSwabber = 'Empty Data';
      } else {
        _stateListSwabber = ResultState.HasData;

        notifyListeners();
        return _responseListSwabber = result;
      }
    } catch (e) {
      _stateListSwabber = ResultState.Error;
      notifyListeners();
      return _messageListSwabber = 'connection error ..';
    }
  }

  //=>
  ResultState _stateTokenFcm;
  String _messageTokenFcm = '';

  ResponseFcm _responseTokenFcm;
  //
  String get messageTokenFcm => _messageTokenFcm;
  ResultState get stateTokenFcm => _stateTokenFcm;
  ResponseFcm get responseTokenFcm => _responseTokenFcm;

  Future<dynamic> get fetchTokenFcm => _fetchTokenFcm();

  Future<dynamic> _fetchTokenFcm() async {
    try {
      _stateTokenFcm = ResultState.Loading;
      notifyListeners();

      _accesToken = await userPreference.accesToken;
      var accesTokenFcm = await userPreference.accesTokenFcm;

      final result =
          await devService.updateTokenFcm(_accesToken, accesTokenFcm);

      print("token user auth :" + _accesToken);
      print("token user fcm :" + accesTokenFcm);

      if (result == null) {
        _stateTokenFcm = ResultState.NoData;
        notifyListeners();
        return _messageTokenFcm = 'Empty Data';
      } else {
        _stateTokenFcm = ResultState.HasData;
        notifyListeners();
        return _responseTokenFcm = result;
      }
    } catch (e) {
      print("catch  provider");

      _stateTokenFcm = ResultState.Error;
      notifyListeners();
      return _messageTokenFcm = 'connection error ..';
    }
  }
}

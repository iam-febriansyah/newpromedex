import 'package:flutter/material.dart';
import 'package:galeri_teknologi_bersama/data/model/request/register.dart';
import 'package:galeri_teknologi_bersama/data/model/response/register.dart';
import 'package:galeri_teknologi_bersama/data/remote/speedlab/dev.service.dart';
import 'package:galeri_teknologi_bersama/utils/result_state.dart';

class RegisterProvider extends ChangeNotifier {
  final DevService devService;

  RegisterProvider({
    this.devService,
  });

  bool _btnRegister = false;
  ResultState _state;
  String _message = '';
  //
  bool get btnRegister => _btnRegister;
  String get message => _message;
  ResultState get state => _state;

  RequestRegister _requestRegister;
  //
  ResponseRegister _responseRegister;
  ResponseRegister get responseRegister => _responseRegister;

  void setRegister(RequestRegister value) {
    _requestRegister = value;
  }

  void setBtnRegister(bool value) {
    _btnRegister = value;
  }

  Future<dynamic> get fetch => _fetch(_requestRegister);

  Future<dynamic> _fetch(RequestRegister requestRegister) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final result = await devService.register(requestRegister);
      if (result == null) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _responseRegister = result;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'something wrong ..';
    }
  }
}

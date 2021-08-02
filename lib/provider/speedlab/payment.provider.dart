import 'package:flutter/material.dart';
import 'package:galeri_teknologi_bersama/data/local/user.preference.dart';
import 'package:galeri_teknologi_bersama/data/model/request/payment.dart';
import 'package:galeri_teknologi_bersama/data/model/response/payment.dart';

import 'package:galeri_teknologi_bersama/data/remote/speedlab/dev.service.dart';
import 'package:galeri_teknologi_bersama/utils/result_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentProvider extends ChangeNotifier {
  final DevService devService;
  UserPreference userPreference =
      new UserPreference(sharedPreferences: SharedPreferences.getInstance());
  PaymentProvider({
    this.devService,
  });

  ResultState _state;
  String _message = '';
  String get message => _message;
  ResultState get state => _state;
  String _accesToken = "";

  //
  RequestTransaction _requestTransaction;
  List<RequestTransactionDetail> _requestTransactionDetail;
  //

  ResponsePayment _responsePayment;
  ResponsePayment get responsePayment => _responsePayment;

  Future<void> setTransactions(RequestTransaction value) async {
    value.customerEmail = await userPreference.email;
    value.customerName = await userPreference.name;

    value.customerPhone = await userPreference.phone;

    _requestTransaction = value;
  }

  void setTransactionsDetails(List<RequestTransactionDetail> value) {
    _requestTransactionDetail = value;
  }

  Future<dynamic> get fetch =>
      _fetch(_requestTransaction, _requestTransactionDetail);

  Future<dynamic> _fetch(RequestTransaction requestTransaction,
      List<RequestTransactionDetail> requestTransactionDetail) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      _accesToken = await userPreference.accesToken;
      final result = await devService.payment(
          requestTransaction, requestTransactionDetail, _accesToken);
      if (result == null) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();

        return _responsePayment = result;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'connection error..';
    }
  }
}

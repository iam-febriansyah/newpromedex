import 'package:flutter/material.dart';
import 'package:galeri_teknologi_bersama/data/local/user.preference.dart';
import 'package:galeri_teknologi_bersama/data/model/request/payment.dart';
import 'package:galeri_teknologi_bersama/data/model/response/invoicehomecare.dart';
import 'package:galeri_teknologi_bersama/data/model/response/payment.dart';
import 'package:galeri_teknologi_bersama/data/model/response/paymenthome.dart';

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
  ////

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

  /////////////////////////////
  ResultState _statehomecare;
  String _messagehomecare = '';
  String get messagehomecare => _messagehomecare;
  ResultState get statehomecare => _statehomecare;

  //
  RequestTransaction _requestTransactionhomecare;
  List<RequestTransactionDetail> _requestTransactionDetailhomecare;
  ////

  ResponsePaymentHomeCare _responsePaymenthomecare;
  ResponsePaymentHomeCare get responsePaymenthomecare =>
      _responsePaymenthomecare;

  Future<void> setTransactionshomecare(RequestTransaction value) async {
    value.customerEmail = await userPreference.email;
    value.customerName = await userPreference.name;

    value.customerPhone = await userPreference.phone;

    _requestTransactionhomecare = value;
  }

  void setTransactionsDetailshomecare(List<RequestTransactionDetail> value) {
    _requestTransactionDetailhomecare = value;
  }

  Future<dynamic> get fetchhomecare => _fetchhomecare(
      _requestTransactionhomecare, _requestTransactionDetailhomecare);

  Future<dynamic> _fetchhomecare(RequestTransaction requestTransactionhomecare,
      List<RequestTransactionDetail> requestTransactionDetailhomecare) async {
    try {
      _statehomecare = ResultState.Loading;
      notifyListeners();
      _accesToken = await userPreference.accesToken;
      final result = await devService.paymentHomeCare(
          requestTransactionhomecare,
          requestTransactionDetailhomecare,
          _accesToken);
      if (result == null) {
        print("no data _fetchhomecare");

        _statehomecare = ResultState.NoData;
        notifyListeners();
        return _messagehomecare = 'Empty Data';
      } else {
        print("has data _fetchhomecare");
        _statehomecare = ResultState.HasData;
        notifyListeners();

        return _responsePaymenthomecare = result;
      }
    } catch (e) {
      _statehomecare = ResultState.Error;
      notifyListeners();
      return _messagehomecare = 'connection error..';
    }
  }

  ///////////////////////////////////////////////
  ///
  ///
  ///
  ResultState _stateinvoicehomecare;
  String _messageinvoicehomecare = '';
  String get messageinvoicehomecare => _messageinvoicehomecare; // homecare;
  ResultState get stateinvoicehomecare => _stateinvoicehomecare;

  String _invoice;
  String get invoice => _invoice;

  void setInvoice(String value) {
    _invoice = value;
    notifyListeners();
  }

  ResponseInvoiceHomeCare _responseInvoiceHomeCare;
  ResponseInvoiceHomeCare get responseInvoiceHomeCare =>
      _responseInvoiceHomeCare;

  Future<dynamic> get fetchinvoicehomecare => _fetchinvoicehomecare(_invoice);

  Future<dynamic> _fetchinvoicehomecare(String invoice) async {
    try {
      _stateinvoicehomecare = ResultState.Loading;
      notifyListeners();
      _accesToken = await userPreference.accesToken;
      final result = await devService.statusHomeCare(_accesToken, _invoice);
      if (result == null) {
        _stateinvoicehomecare = ResultState.NoData;
        notifyListeners();
        return _messageinvoicehomecare = 'Empty Data';
      } else {
        _stateinvoicehomecare = ResultState.HasData;
        notifyListeners();

        return _responseInvoiceHomeCare = result;
      }
    } catch (e) {
      _stateinvoicehomecare = ResultState.Error;
      notifyListeners();
      return _messageinvoicehomecare = 'connection error..';
    }
  }
}

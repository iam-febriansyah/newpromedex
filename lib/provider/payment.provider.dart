import 'package:flutter/material.dart';
import 'package:galeri_teknologi_bersama/data/model/paymentrequest.dart';
import 'package:galeri_teknologi_bersama/data/model/paymentresponse.dart';

import 'package:galeri_teknologi_bersama/data/remote/speedlab.service.dart';
import 'package:galeri_teknologi_bersama/utils/result_state.dart';

class PaymentProvider extends ChangeNotifier {
  final ApiService apiService;

  PaymentProvider({
    this.apiService,
  });

  ResultState _state;
  String _message = '';
  String get message => _message;
  ResultState get state => _state;

  //
  Transaction _transactions;
  List<ItemOrder> _transactionDetails;
  //

  PaymentResponse _paymentResponse;
  PaymentResponse get paymentResponse => _paymentResponse;

  void setTransactions(Transaction value) {
    _transactions = value;
  }

  void setTransactionsDetails(List<ItemOrder> value) {
    _transactionDetails = value;
  }

  Future<dynamic> get fetch => _fetch(_transactions, _transactionDetails);

  Future<dynamic> _fetch(
      Transaction transactions, List<ItemOrder> transactionDetails) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final result =
          await apiService.progressOrder(transactions, _transactionDetails);
      if (result.statusJson == null) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();

        return _paymentResponse = result;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'connection error..';
    }
  }
}

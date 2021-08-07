import 'dart:convert';

import 'package:galeri_teknologi_bersama/data/model/request/login.dart';
import 'package:galeri_teknologi_bersama/data/model/request/payment.dart';
import 'package:galeri_teknologi_bersama/data/model/request/register.dart';
import 'package:galeri_teknologi_bersama/data/model/response/fcm.dart';
import 'package:galeri_teknologi_bersama/data/model/response/invoicehomecare.dart';
import 'package:galeri_teknologi_bersama/data/model/response/listswabber.dart';
import 'package:galeri_teknologi_bersama/data/model/response/login.dart';
import 'package:galeri_teknologi_bersama/data/model/response/menu.dart';
import 'package:galeri_teknologi_bersama/data/model/response/merchant.dart';
import 'package:galeri_teknologi_bersama/data/model/response/payment.dart';
import 'package:galeri_teknologi_bersama/data/model/response/paymenthome.dart';
import 'package:galeri_teknologi_bersama/data/model/response/register.dart';
import 'package:http/http.dart' as http;

class DevService {
  static final String _baseUrl = 'http://devserver.galeritekno.id:8080/api';
  static final String _register = "/auth/signup";
  static final String _login = "/auth/signin";
  static final String _menus = "/menus";
  static final String _merchant = "/merchants";
  static final String _transaction = "/transaction";
  static final String _listswabber = "/getListSwabbers";
  static final String _updateTokenFcm = "/updateTokenFcm";
  static final String _statusHomeCare = "/statusHomecare";

  Future<dynamic> updateTokenFcm(
      String accesToken, String accesTokenFcm) async {
    Map data = {"token": accesTokenFcm};

    var body = jsonEncode(data);

    final response = await http.post(
      Uri.parse(_baseUrl + _updateTokenFcm),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': accesToken,
      },
      body: body,
    );

    if (response.statusCode == 200) {
      print("succes token fcm " + response.body);
      return ResponseFcm.fromJson(json.decode(response.body));
    } else {
      print("else token fcm " + response.body);
      throw Exception('Failed to load');
    }
  }

  Future<dynamic> statusHomeCare(String accesToken, String invoice) async {
    Map data = {"invoiceNumber": invoice};

    var body = jsonEncode(data);

    final response = await http.post(
      Uri.parse(_baseUrl + _statusHomeCare),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': accesToken,
      },
      body: body,
    );

    if (response.statusCode == 200) {
      print("succes t " + response.body);
      return ResponseInvoiceHomeCare.fromJson(json.decode(response.body));
    } else {
      print("else  " + response.body);
      throw Exception('Failed to load');
    }
  }

  Future payment(
      RequestTransaction requestTransaction,
      List<RequestTransactionDetail> requestTransactionDetail,
      String accesToken) async {
    Map data = {
      "transaction": requestTransaction,
      "transaction_details": requestTransactionDetail
    };

    var body = jsonEncode(data);

    final response = await http.post(
      Uri.parse(_baseUrl + _transaction),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': accesToken,
      },
      body: body,
    );

    if (response.statusCode == 200) {
      print(response.body);
      return ResponsePayment.fromJson(json.decode(response.body));
    } else {
      print("Failed to Post");
      print(response.body);
      throw Exception('Failed to post');
    }
  }

  Future paymentHomeCare(
      RequestTransaction requestTransaction,
      List<RequestTransactionDetail> requestTransactionDetail,
      String accesToken) async {
    Map data = {
      "transaction": requestTransaction,
      "transaction_details": requestTransactionDetail
    };

    var body = jsonEncode(data);

    final response = await http.post(
      Uri.parse(_baseUrl + _transaction),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': accesToken,
      },
      body: body,
    );

    if (response.statusCode == 200) {
      print(response.body);
      return ResponsePaymentHomeCare.fromJson(json.decode(response.body));
    } else {
      print("Failed to Post");
      print(response.body);
      throw Exception('Failed to post');
    }
  }

  Future register(RequestRegister requestRegister) async {
    Map data = {
      "username": requestRegister.username,
      "email": requestRegister.email,
      "password": requestRegister.password,
      "identityNumber": requestRegister.identityNumber,
      "identityParentNumber": "",
      "name": requestRegister.name,
      "gender": requestRegister.gender,
      "birthDay": requestRegister.birthDay,
      "birthPlace": requestRegister.birthPlace,
      "phone": requestRegister.phone,
      "address": requestRegister.address,
      "nationality": "Indonesia"
    };

    var body = jsonEncode(data);

    final response = await http.post(
      Uri.parse(_baseUrl + _register),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      return ResponseRegister.fromJson(json.decode(response.body));
    } else if (response.statusCode == 400) {
      return ResponseRegister.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to post');
    }
  }

  Future login(RequestLogin requestLogin) async {
    Map data = {
      "username": requestLogin.username,
      "password": requestLogin.password,
    };

    var body = jsonEncode(data);

    final response = await http
        .post(
          Uri.parse(_baseUrl + _login),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: body,
        )
        .timeout(Duration(seconds: 5));

    if (response.statusCode == 200) {
      print(response.body);
      return ResponseLogin.fromJson(json.decode(response.body));
    } else {
      print('Failed to post');
      throw Exception('Failed to post');
    }
  }

  Future<dynamic> menu(String accesToken) async {
    final response = await http.get(
      Uri.parse(_baseUrl + _menus),
      headers: <String, String>{
        'Authorization': accesToken,
      },
    );
    if (response.statusCode == 200) {
      print(response.body);
      return response;
    } else if (response.statusCode == 401) {
      print(response.body);
      return response;
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<dynamic> merchant(String accesToken) async {
    final response = await http.get(
      Uri.parse(_baseUrl + _merchant),
      headers: <String, String>{
        'Authorization': accesToken,
      },
    );
    if (response.statusCode == 200) {
      print(response.body);
      return ResponseMerchant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }

  Future swabber(String accesToken, String latitude, String longitude) async {
    Map data = {
      "latitude": "rian121411",
      "longitude": "rian1214",
    };

    var body = jsonEncode(data);

    final response = await http
        .post(
          Uri.parse(_baseUrl + _listswabber),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': accesToken,
          },
          body: body,
        )
        .timeout(Duration(seconds: 10));

    if (response.statusCode == 200) {
      print(response.body);
      return ResponseListSwabber.fromJson(json.decode(response.body));
    } else {
      print('Failed to post');
      throw Exception('Failed to post');
    }
  }
}

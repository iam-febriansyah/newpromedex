// To parse this JSON data, do
//
//     final responsePayment = responsePaymentFromJson(jsonString);

import 'dart:convert';

ResponsePayment responsePaymentFromJson(String str) =>
    ResponsePayment.fromJson(json.decode(str));

String responsePaymentToJson(ResponsePayment data) =>
    json.encode(data.toJson());

class ResponsePayment {
  ResponsePayment({
    this.status,
    this.message,
    this.statusCode,
    this.data,
  });

  bool status;
  String message;
  int statusCode;
  Data data;

  factory ResponsePayment.fromJson(Map<String, dynamic> json) =>
      ResponsePayment(
        status: json["status"],
        message: json["message"],
        statusCode: json["statusCode"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "statusCode": statusCode,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.bank,
    this.transactionId,
    this.va,
    this.orderId,
    this.grossAmount,
    this.expired,
  });

  String bank;
  String transactionId;
  String va;
  String orderId;
  int grossAmount;
  DateTime expired;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        bank: json["bank"],
        transactionId: json["transaction_id"],
        va: json["va"],
        orderId: json["order_id"],
        grossAmount: json["gross_amount"],
        expired: DateTime.parse(json["expired"]),
      );

  Map<String, dynamic> toJson() => {
        "bank": bank,
        "transaction_id": transactionId,
        "va": va,
        "order_id": orderId,
        "gross_amount": grossAmount,
        "expired": expired.toIso8601String(),
      };
}

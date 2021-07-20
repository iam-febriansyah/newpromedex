// To parse this JSON data, do
//
//     final paymentResponse = paymentResponseFromJson(jsonString);

import 'dart:convert';

PaymentResponse paymentResponseFromJson(String str) =>
    PaymentResponse.fromJson(json.decode(str));

String paymentResponseToJson(PaymentResponse data) =>
    json.encode(data.toJson());

class PaymentResponse {
  PaymentResponse({
    this.statusJson,
    this.remarks,
    this.payment,
  });

  bool statusJson;
  String remarks;
  Payment payment;

  factory PaymentResponse.fromJson(Map<String, dynamic> json) =>
      PaymentResponse(
        statusJson: json["status_json"],
        remarks: json["remarks"],
        payment: Payment.fromJson(json["payment"]),
      );

  Map<String, dynamic> toJson() => {
        "status_json": statusJson,
        "remarks": remarks,
        "payment": payment.toJson(),
      };
}

class Payment {
  Payment({
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

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
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

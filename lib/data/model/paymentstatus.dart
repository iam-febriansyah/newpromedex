// To parse this JSON data, do
//
//     final paymentStatus = paymentStatusFromJson(jsonString);

import 'dart:convert';

PaymentStatus paymentStatusFromJson(String str) =>
    PaymentStatus.fromJson(json.decode(str));

String paymentStatusToJson(PaymentStatus data) => json.encode(data.toJson());

class PaymentStatus {
  PaymentStatus({
    this.statusJson,
    this.remarks,
  });

  bool statusJson;
  String remarks;

  factory PaymentStatus.fromJson(Map<String, dynamic> json) => PaymentStatus(
        statusJson: json["status_json"],
        remarks: json["remarks"],
      );

  Map<String, dynamic> toJson() => {
        "status_json": statusJson,
        "remarks": remarks,
      };
}

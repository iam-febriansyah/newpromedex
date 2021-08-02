// To parse this JSON data, do
//
//     final myOrder = myOrderFromJson(jsonString);

import 'dart:convert';

MyOrder myOrderFromJson(String str) => MyOrder.fromJson(json.decode(str));

String myOrderToJson(MyOrder data) => json.encode(data.toJson());

class MyOrder {
  MyOrder({
    this.vaNumber,
    this.clientId,
    this.totalPrice,
    this.invoiceNumber,
    this.channel,
    this.expiredTime,
    this.transactionId,
    this.status,
  });

  String vaNumber;
  String clientId;
  String totalPrice;
  String invoiceNumber;
  String channel;
  String expiredTime;
  String transactionId;
  String status;

  factory MyOrder.fromJson(Map<String, dynamic> json) => MyOrder(
        vaNumber: json["vaNumber"],
        clientId: json["clientId"],
        totalPrice: json["totalPrice"],
        invoiceNumber: json["invoiceNumber"],
        channel: json["channel"],
        expiredTime: json["expiredTime"],
        transactionId: json["transactionId"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "vaNumber": vaNumber,
        "clientId": clientId,
        "totalPrice": totalPrice,
        "invoiceNumber": invoiceNumber,
        "channel": channel,
        "expiredTime": expiredTime,
        "transactionId": transactionId,
        "status": status,
      };
}

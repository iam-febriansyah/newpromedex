// To parse this JSON data, do
//
//     final historyOrder = historyOrderFromJson(jsonString);

import 'dart:convert';

HistoryOrder historyOrderFromJson(String str) =>
    HistoryOrder.fromJson(json.decode(str));

String historyOrderToJson(HistoryOrder data) => json.encode(data.toJson());

class HistoryOrder {
  HistoryOrder({
    this.id,
    this.itemName,
    this.itemProvider,
    this.customerName,
    this.customerPhone,
    this.address,
    this.type,
    this.latitude,
    this.longitude,
    this.channel,
    this.clientId,
    this.expiredTime,
    this.invoiceNumber,
    this.status,
    this.totalPrice,
    this.vaNumber,
  });

  int id;
  String itemName;
  String itemProvider;
  String customerName;
  String customerPhone;
  String address;
  String type;
  String latitude;
  String longitude;
  String channel;
  String clientId;
  String expiredTime;
  String invoiceNumber;
  String status;
  String totalPrice;
  String vaNumber;

  factory HistoryOrder.fromJson(Map<String, dynamic> json) => HistoryOrder(
        id: json["id"],
        itemName: json["itemName"],
        itemProvider: json["itemProvider"],
        customerName: json["customer_name"],
        customerPhone: json["customer_phone"],
        address: json["address"],
        type: json["type"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        channel: json["channel"],
        clientId: json["clientId"],
        expiredTime: json["expiredTime"],
        invoiceNumber: json["invoiceNumber"],
        status: json["status"],
        totalPrice: json["totalPrice"],
        vaNumber: json["vaNumber"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "itemName": itemName,
        "itemProvider": itemProvider,
        "customer_name": customerName,
        "customer_phone": customerPhone,
        "address": address,
        "type": type,
        "latitude": latitude,
        "longitude": longitude,
        "channel": channel,
        "clientId": clientId,
        "expiredTime": expiredTime,
        "invoiceNumber": invoiceNumber,
        "status": status,
        "totalPrice": totalPrice,
        "vaNumber": vaNumber,
      };
}

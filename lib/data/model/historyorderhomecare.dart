// To parse this JSON data, do
//
//     final historyOrderHomeCare = historyOrderHomeCareFromJson(jsonString);

import 'dart:convert';

HistoryOrderHomeCare historyOrderHomeCareFromJson(String str) =>
    HistoryOrderHomeCare.fromJson(json.decode(str));

String historyOrderHomeCareToJson(HistoryOrderHomeCare data) =>
    json.encode(data.toJson());

class HistoryOrderHomeCare {
  HistoryOrderHomeCare({
    this.id,
    this.idReservation,
    this.invoiceNumber,
    this.customerName,
    this.customerEmail,
    this.customerPhone,
    this.address,
    this.latitude,
    this.longitude,
    this.status,
    this.statusString,
    this.reservationType,
    this.transactionId,
    this.vaNumber,
    this.totalPrice,
    this.channel,
    this.expiredTime,
    this.successTime,
    this.idswabber,
    this.name,
    this.phone,
    this.email,
    this.lastUpdateLocation,
  });

  int id;
  String idReservation;
  String invoiceNumber;
  String customerName;
  String customerEmail;
  String customerPhone;
  String address;
  dynamic latitude;
  dynamic longitude;
  String status;
  String statusString;
  String reservationType;
  String transactionId;
  String vaNumber;
  int totalPrice;
  String channel;
  String expiredTime;
  dynamic successTime;
  String idswabber;
  String name;
  String phone;
  String email;
  dynamic lastUpdateLocation;

  factory HistoryOrderHomeCare.fromJson(Map<String, dynamic> json) =>
      HistoryOrderHomeCare(
        id: json["id"],
        idReservation: json["idReservation"],
        invoiceNumber: json["invoiceNumber"],
        customerName: json["customerName"],
        customerEmail: json["customerEmail"],
        customerPhone: json["customerPhone"],
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        status: json["status"],
        statusString: json["status_string"],
        reservationType: json["reservationType"],
        transactionId: json["transactionId"],
        vaNumber: json["vaNumber"],
        totalPrice: json["totalPrice"],
        channel: json["channel"],
        expiredTime: json["expiredTime"],
        successTime: json["successTime"],
        idswabber: json["idswabber"],
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        lastUpdateLocation: json["lastUpdateLocation"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "idReservation": idReservation,
        "invoiceNumber": invoiceNumber,
        "customerName": customerName,
        "customerEmail": customerEmail,
        "customerPhone": customerPhone,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "status": status,
        "status_string": statusString,
        "reservationType": reservationType,
        "transactionId": transactionId,
        "vaNumber": vaNumber,
        "totalPrice": totalPrice,
        "channel": channel,
        "expiredTime": expiredTime,
        "successTime": successTime,
        "idswabber": idswabber,
        "name": name,
        "phone": phone,
        "email": email,
        "lastUpdateLocation": lastUpdateLocation,
      };
}

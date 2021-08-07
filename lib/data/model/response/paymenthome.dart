// To parse this JSON data, do
//
//     final responsePaymentHomeCare = responsePaymentHomeCareFromJson(jsonString);

import 'dart:convert';

ResponsePaymentHomeCare responsePaymentHomeCareFromJson(String str) =>
    ResponsePaymentHomeCare.fromJson(json.decode(str));

String responsePaymentHomeCareToJson(ResponsePaymentHomeCare data) =>
    json.encode(data.toJson());

class ResponsePaymentHomeCare {
  ResponsePaymentHomeCare({
    this.status,
    this.message,
    this.statusCode,
    this.data,
  });

  bool status;
  String message;
  int statusCode;
  Data data;

  factory ResponsePaymentHomeCare.fromJson(Map<String, dynamic> json) =>
      ResponsePaymentHomeCare(
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
    this.createdAt,
    this.id,
    this.invoiceNumber,
    this.customerName,
    this.customerEmail,
    this.customerPhone,
    this.bank,
    this.price,
    this.latitude,
    this.longitude,
    this.address,
    this.status,
    this.reservationType,
    this.idSwabber,
    this.iduser,
    this.createdBy,
    this.remarks,
    this.updatedAt,
    this.updatedBy,
  });

  DateTime createdAt;
  String id;
  String invoiceNumber;
  String customerName;
  String customerEmail;
  String customerPhone;
  String bank;
  int price;
  String latitude;
  String longitude;
  String address;
  int status;
  String reservationType;
  dynamic idSwabber;
  String iduser;
  String createdBy;
  dynamic remarks;
  dynamic updatedAt;
  dynamic updatedBy;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
        invoiceNumber: json["invoiceNumber"],
        customerName: json["customerName"],
        customerEmail: json["customerEmail"],
        customerPhone: json["customerPhone"],
        bank: json["bank"],
        price: json["price"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        address: json["address"],
        status: json["status"],
        reservationType: json["reservationType"],
        idSwabber: json["idSwabber"],
        iduser: json["iduser"],
        createdBy: json["created_by"],
        remarks: json["remarks"],
        updatedAt: json["updated_at"],
        updatedBy: json["updated_by"],
      );

  Map<String, dynamic> toJson() => {
        "created_at": createdAt.toIso8601String(),
        "id": id,
        "invoiceNumber": invoiceNumber,
        "customerName": customerName,
        "customerEmail": customerEmail,
        "customerPhone": customerPhone,
        "bank": bank,
        "price": price,
        "latitude": latitude,
        "longitude": longitude,
        "address": address,
        "status": status,
        "reservationType": reservationType,
        "idSwabber": idSwabber,
        "iduser": iduser,
        "created_by": createdBy,
        "remarks": remarks,
        "updated_at": updatedAt,
        "updated_by": updatedBy,
      };
}

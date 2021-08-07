// To parse this JSON data, do
//
//     final responseInvoiceHomeCare = responseInvoiceHomeCareFromJson(jsonString);

import 'dart:convert';

ResponseInvoiceHomeCare responseInvoiceHomeCareFromJson(String str) =>
    ResponseInvoiceHomeCare.fromJson(json.decode(str));

String responseInvoiceHomeCareToJson(ResponseInvoiceHomeCare data) =>
    json.encode(data.toJson());

class ResponseInvoiceHomeCare {
  ResponseInvoiceHomeCare({
    this.status,
    this.message,
    this.statusCode,
    this.dataReservation,
    this.dataPasiens,
    this.dataPayment,
    this.dataSwabber,
  });

  bool status;
  String message;
  int statusCode;
  DataReservation dataReservation;
  List<DataPasien> dataPasiens;
  DataPayment dataPayment;
  DataSwabber dataSwabber;

  factory ResponseInvoiceHomeCare.fromJson(Map<String, dynamic> json) =>
      ResponseInvoiceHomeCare(
        status: json["status"],
        message: json["message"],
        statusCode: json["statusCode"],
        dataReservation: DataReservation.fromJson(json["dataReservation"]),
        dataPasiens: List<DataPasien>.from(
            json["dataPasiens"].map((x) => DataPasien.fromJson(x))),
        dataPayment: DataPayment.fromJson(json["dataPayment"]),
        dataSwabber: DataSwabber.fromJson(json["dataSwabber"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "statusCode": statusCode,
        "dataReservation": dataReservation.toJson(),
        "dataPasiens": List<dynamic>.from(dataPasiens.map((x) => x.toJson())),
        "dataPayment": dataPayment.toJson(),
        "dataSwabber": dataSwabber.toJson(),
      };
}

class DataPasien {
  DataPasien({
    this.id,
    this.clientId,
    this.iduser,
    this.invoiceNumber,
    this.identityNumber,
    this.identityParentNumber,
    this.name,
    this.gender,
    this.birthDay,
    this.birthPlace,
    this.nationality,
    this.address,
    this.phone,
    this.email,
    this.serviceClientId,
    this.price,
    this.orderType,
    this.dateReservation,
    this.hourReservation,
    this.status,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
  });

  String id;
  int clientId;
  String iduser;
  String invoiceNumber;
  String identityNumber;
  String identityParentNumber;
  String name;
  String gender;
  DateTime birthDay;
  String birthPlace;
  String nationality;
  String address;
  String phone;
  String email;
  int serviceClientId;
  int price;
  String orderType;
  DateTime dateReservation;
  String hourReservation;
  String status;
  DateTime createdAt;
  String createdBy;
  DateTime updatedAt;
  String updatedBy;

  factory DataPasien.fromJson(Map<String, dynamic> json) => DataPasien(
        id: json["id"],
        clientId: json["clientId"],
        iduser: json["iduser"],
        invoiceNumber: json["invoiceNumber"],
        identityNumber: json["identityNumber"],
        identityParentNumber: json["identityParentNumber"],
        name: json["name"],
        gender: json["gender"],
        birthDay: DateTime.parse(json["birthDay"]),
        birthPlace: json["birthPlace"],
        nationality: json["nationality"],
        address: json["address"],
        phone: json["phone"],
        email: json["email"],
        serviceClientId: json["serviceClientId"],
        price: json["price"],
        orderType: json["orderType"],
        dateReservation: DateTime.parse(json["dateReservation"]),
        hourReservation: json["hourReservation"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        createdBy: json["created_by"],
        updatedAt: DateTime.parse(json["updated_at"]),
        updatedBy: json["updated_by"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "clientId": clientId,
        "iduser": iduser,
        "invoiceNumber": invoiceNumber,
        "identityNumber": identityNumber,
        "identityParentNumber": identityParentNumber,
        "name": name,
        "gender": gender,
        "birthDay": birthDay.toIso8601String(),
        "birthPlace": birthPlace,
        "nationality": nationality,
        "address": address,
        "phone": phone,
        "email": email,
        "serviceClientId": serviceClientId,
        "price": price,
        "orderType": orderType,
        "dateReservation":
            "${dateReservation.year.toString().padLeft(4, '0')}-${dateReservation.month.toString().padLeft(2, '0')}-${dateReservation.day.toString().padLeft(2, '0')}",
        "hourReservation": hourReservation,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "created_by": createdBy,
        "updated_at": updatedAt.toIso8601String(),
        "updated_by": updatedBy,
      };
}

class DataPayment {
  DataPayment({
    this.transactionId,
    this.vaNumber,
    this.totalPrice,
    this.channel,
    this.status,
    this.expiredTime,
    this.successTime,
  });

  String transactionId;
  String vaNumber;
  int totalPrice;
  String channel;
  String status;
  DateTime expiredTime;
  dynamic successTime;

  factory DataPayment.fromJson(Map<String, dynamic> json) => DataPayment(
        transactionId: json["transactionId"],
        vaNumber: json["vaNumber"],
        totalPrice: json["totalPrice"],
        channel: json["channel"],
        status: json["status"],
        expiredTime: DateTime.parse(json["expiredTime"]),
        successTime: json["successTime"],
      );

  Map<String, dynamic> toJson() => {
        "transactionId": transactionId,
        "vaNumber": vaNumber,
        "totalPrice": totalPrice,
        "channel": channel,
        "status": status,
        "expiredTime": expiredTime.toIso8601String(),
        "successTime": successTime,
      };
}

class DataReservation {
  DataReservation({
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
  });

  String idReservation;
  String invoiceNumber;
  String customerName;
  String customerEmail;
  String customerPhone;
  String address;
  String latitude;
  String longitude;
  int status;
  String statusString;
  String reservationType;

  factory DataReservation.fromJson(Map<String, dynamic> json) =>
      DataReservation(
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
      );

  Map<String, dynamic> toJson() => {
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
      };
}

class DataSwabber {
  DataSwabber({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.latitude,
    this.longitude,
    this.lastUpdateLocation,
  });

  String id;
  String name;
  String phone;
  String email;
  dynamic latitude;
  dynamic longitude;
  dynamic lastUpdateLocation;

  factory DataSwabber.fromJson(Map<String, dynamic> json) => DataSwabber(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        lastUpdateLocation: json["lastUpdateLocation"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "email": email,
        "latitude": latitude,
        "longitude": longitude,
        "lastUpdateLocation": lastUpdateLocation,
      };
}

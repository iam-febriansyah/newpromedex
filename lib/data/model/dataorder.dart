// To parse this JSON data, do
//
//     final dataOrder = dataOrderFromJson(jsonString);

import 'dart:convert';

DataOrder dataOrderFromJson(String str) => DataOrder.fromJson(json.decode(str));

String dataOrderToJson(DataOrder data) => json.encode(data.toJson());

class DataOrder {
  DataOrder({
    this.transaction,
    this.transactionDetails,
  });

  DataOrderTransaction transaction;
  List<DataOrderTransactionDetail> transactionDetails;

  factory DataOrder.fromJson(Map<String, dynamic> json) => DataOrder(
        transaction: DataOrderTransaction.fromJson(json["transaction"]),
        transactionDetails: List<DataOrderTransactionDetail>.from(
            json["transaction_details"]
                .map((x) => DataOrderTransactionDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "transaction": transaction.toJson(),
        "transaction_details":
            List<dynamic>.from(transactionDetails.map((x) => x.toJson())),
      };
}

class DataOrderTransaction {
  DataOrderTransaction({
    this.channel,
    this.customerEmail,
    this.customerName,
    this.customerPhone,
    this.serviceClientId,
    this.price,
    this.orderType,
    this.dateReservation,
    this.hourReservation,
  });

  String channel;
  String customerEmail;
  String customerName;
  String customerPhone;
  int serviceClientId;
  int price;
  String orderType;
  String dateReservation;
  String hourReservation;

  factory DataOrderTransaction.fromJson(Map<String, dynamic> json) =>
      DataOrderTransaction(
        channel: json["channel"],
        customerEmail: json["customer_email"],
        customerName: json["customer_name"],
        customerPhone: json["customer_phone"],
        serviceClientId: json["serviceClientId"],
        price: json["price"],
        orderType: json["orderType"],
        dateReservation: json["dateReservation"],
        hourReservation: json["hourReservation"],
      );

  Map<String, dynamic> toJson() => {
        "channel": channel,
        "customer_email": customerEmail,
        "customer_name": customerName,
        "customer_phone": customerPhone,
        "serviceClientId": serviceClientId,
        "price": price,
        "orderType": orderType,
        "dateReservation": dateReservation,
        "hourReservation": hourReservation,
      };
}

class DataOrderTransactionDetail {
  DataOrderTransactionDetail({
    this.clientId,
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
  });

  int clientId;
  String identityNumber;
  String identityParentNumber;
  String name;
  String gender;
  String birthDay;
  String birthPlace;
  String nationality;
  String address;
  String phone;
  String email;
  int serviceClientId;
  int price;
  String orderType;
  String dateReservation;
  String hourReservation;

  factory DataOrderTransactionDetail.fromJson(Map<String, dynamic> json) =>
      DataOrderTransactionDetail(
        clientId: json["clientId"],
        identityNumber: json["identityNumber"],
        identityParentNumber: json["identityParentNumber"],
        name: json["name"],
        gender: json["gender"],
        birthDay: json["birthDay"],
        birthPlace: json["birthPlace"],
        nationality: json["nationality"],
        address: json["address"],
        phone: json["phone"],
        email: json["email"],
        serviceClientId: json["serviceClientId"],
        price: json["price"],
        orderType: json["orderType"],
        dateReservation: json["dateReservation"],
        hourReservation: json["hourReservation"],
      );

  Map<String, dynamic> toJson() => {
        "clientId": clientId,
        "identityNumber": identityNumber,
        "identityParentNumber": identityParentNumber,
        "name": name,
        "gender": gender,
        "birthDay": birthDay,
        "birthPlace": birthPlace,
        "nationality": nationality,
        "address": address,
        "phone": phone,
        "email": email,
        "serviceClientId": serviceClientId,
        "price": price,
        "orderType": orderType,
        "dateReservation": dateReservation,
        "hourReservation": hourReservation,
      };
}

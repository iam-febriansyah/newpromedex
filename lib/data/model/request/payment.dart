// To parse this JSON data, do
//
//     final requestPayment = requestPaymentFromJson(jsonString);

import 'dart:convert';

RequestPayment requestPaymentFromJson(String str) =>
    RequestPayment.fromJson(json.decode(str));

String requestPaymentToJson(RequestPayment data) => json.encode(data.toJson());

class RequestPayment {
  RequestPayment({
    this.transaction,
    this.transactionDetails,
  });

  RequestTransaction transaction;
  List<RequestTransactionDetail> transactionDetails;

  factory RequestPayment.fromJson(Map<String, dynamic> json) => RequestPayment(
        transaction: RequestTransaction.fromJson(json["transaction"]),
        transactionDetails: List<RequestTransactionDetail>.from(
            json["transaction_details"]
                .map((x) => RequestTransactionDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "transaction": transaction.toJson(),
        "transaction_details":
            List<dynamic>.from(transactionDetails.map((x) => x.toJson())),
      };
}

class RequestTransaction {
  RequestTransaction({
    this.channel,
    this.customerEmail,
    this.customerName,
    this.customerPhone,
    this.type,
    this.latitude,
    this.longitude,
    this.address,
    this.idswabber,
  });

  String channel;
  String customerEmail;
  String customerName;
  String customerPhone;
  String type;
  String latitude;
  String longitude;
  String address;
  dynamic idswabber;

  factory RequestTransaction.fromJson(Map<String, dynamic> json) =>
      RequestTransaction(
        channel: json["channel"],
        customerEmail: json["customer_email"],
        customerName: json["customer_name"],
        customerPhone: json["customer_phone"],
        type: json["type"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        address: json["address"],
        idswabber: json["idswabber"],
      );

  Map<String, dynamic> toJson() => {
        "channel": channel,
        "customer_email": customerEmail,
        "customer_name": customerName,
        "customer_phone": customerPhone,
        "type": type,
        "latitude": latitude,
        "longitude": longitude,
        "address": address,
        "idswabber": idswabber,
      };
}

class RequestTransactionDetail {
  RequestTransactionDetail({
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

  factory RequestTransactionDetail.fromJson(Map<String, dynamic> json) =>
      RequestTransactionDetail(
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

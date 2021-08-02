// To parse this JSON data, do
//
//     final responseMerchant = responseMerchantFromJson(jsonString);

import 'dart:convert';

ResponseMerchant responseMerchantFromJson(String str) =>
    ResponseMerchant.fromJson(json.decode(str));

String responseMerchantToJson(ResponseMerchant data) =>
    json.encode(data.toJson());

class ResponseMerchant {
  ResponseMerchant({
    this.status,
    this.message,
    this.statusCode,
    this.merchants,
  });

  bool status;
  String message;
  int statusCode;
  List<Merchant> merchants;

  factory ResponseMerchant.fromJson(Map<String, dynamic> json) =>
      ResponseMerchant(
        status: json["status"],
        message: json["message"],
        statusCode: json["statusCode"],
        merchants: List<Merchant>.from(
            json["merchants"].map((x) => Merchant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "statusCode": statusCode,
        "merchants": List<dynamic>.from(merchants.map((x) => x.toJson())),
      };
}

class Merchant {
  Merchant({
    this.itemId,
    this.strBackground,
    this.itemName,
    this.type,
    this.districts,
    this.city,
    this.isOpen,
    this.open,
    this.close,
    this.visitingHours,
    this.tag,
    this.orderType,
    this.channels,
    this.service,
    this.serviceClick,
    this.tagFilter,
  });

  int itemId;
  String strBackground;
  String itemName;
  String type;
  String districts;
  String city;
  bool isOpen;
  int open;
  int close;
  List<int> visitingHours;
  List<String> tag;
  List<String> orderType;
  List<dynamic> channels;
  List<Service> service;
  int serviceClick;
  String tagFilter;

  factory Merchant.fromJson(Map<String, dynamic> json) => Merchant(
        itemId: json["itemID"],
        strBackground: json["strBackground"],
        itemName: json["itemName"],
        type: json["type"],
        districts: json["districts"],
        city: json["city"],
        isOpen: json["isOpen"],
        open: json["open"],
        close: json["close"],
        visitingHours: List<int>.from(json["visiting_hours"].map((x) => x)),
        tag: List<String>.from(json["tag"].map((x) => x)),
        orderType: List<String>.from(json["orderType"].map((x) => x)),
        channels: List<dynamic>.from(json["channels"].map((x) => x)),
        service:
            List<Service>.from(json["service"].map((x) => Service.fromJson(x))),
        serviceClick: json["serviceClick"],
        tagFilter: json["tagFilter"],
      );

  Map<String, dynamic> toJson() => {
        "itemID": itemId,
        "strBackground": strBackground,
        "itemName": itemName,
        "type": type,
        "districts": districts,
        "city": city,
        "isOpen": isOpen,
        "open": open,
        "close": close,
        "visiting_hours": List<dynamic>.from(visitingHours.map((x) => x)),
        "tag": List<dynamic>.from(tag.map((x) => x)),
        "orderType": List<dynamic>.from(orderType.map((x) => x)),
        "channels": List<dynamic>.from(channels.map((x) => x)),
        "service": List<dynamic>.from(service.map((x) => x.toJson())),
        "serviceClick": serviceClick,
        "tagFilter": tagFilter,
      };
}

class Service {
  Service({
    this.serviceClientId,
    this.itemId,
    this.itemName,
    this.metode,
    this.price,
    this.tag,
    this.desc,
    this.strImage1,
    this.homecareMin,
    this.homecareMax,
  });

  String serviceClientId;
  String itemId;
  String itemName;
  dynamic metode;
  int price;
  String tag;
  String desc;
  String strImage1;
  int homecareMin;
  int homecareMax;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        serviceClientId: json["serviceClientId"],
        itemId: json["itemID"],
        itemName: json["itemName"],
        metode: json["metode"],
        price: json["price"],
        tag: json["tag"],
        desc: json["desc"],
        strImage1: json["strImage1"],
        homecareMin: json["homecareMin"],
        homecareMax: json["homecareMax"],
      );

  Map<String, dynamic> toJson() => {
        "serviceClientId": serviceClientId,
        "itemID": itemId,
        "itemName": itemName,
        "metode": metode,
        "price": price,
        "tag": tag,
        "desc": desc,
        "strImage1": strImage1,
        "homecareMin": homecareMin,
        "homecareMax": homecareMax,
      };
}

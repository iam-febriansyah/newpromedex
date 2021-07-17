// To parse this JSON data, do
//
//     final merchant = merchantFromJson(jsonString);

import 'dart:convert';

List<Merchant> merchantFromJson(String str) =>
    List<Merchant>.from(json.decode(str).map((x) => Merchant.fromJson(x)));

String merchantToJson(List<Merchant> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Merchant {
  Merchant({
    this.itemId,
    this.strBackground,
    this.itemName,
    this.type,
    this.districts,
    this.city,
    this.tagQuery,
    this.serviceClick,
    this.isOpen,
    this.open,
    this.close,
    this.visitingHours,
    this.tag,
    this.orderType,
    this.service,
  });

  String itemId;
  String strBackground;
  String itemName;
  String type;
  String districts;
  String city;
  String tagQuery;
  int serviceClick;

  bool isOpen;
  int open;
  int close;
  List<int> visitingHours;
  List<String> tag;
  List<String> orderType;
  List<Service> service;

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
        visitingHours: List<int>.from(json["visiting hours"].map((x) => x)),
        tag: List<String>.from(json["tag"].map((x) => x)),
        orderType: List<String>.from(json["orderType"].map((x) => x)),
        service:
            List<Service>.from(json["service"].map((x) => Service.fromJson(x))),
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
        "visiting hours": List<dynamic>.from(visitingHours.map((x) => x)),
        "tag": List<dynamic>.from(tag.map((x) => x)),
        "orderType": List<dynamic>.from(orderType.map((x) => x)),
        "service": List<dynamic>.from(service.map((x) => x.toJson())),
      };
}

class Service {
  Service({
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

  String itemId;
  String itemName;
  String metode;
  int price;
  String tag;
  String desc;
  String strImage1;
  int homecareMin;
  int homecareMax;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
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

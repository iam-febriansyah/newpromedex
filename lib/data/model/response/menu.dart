// To parse this JSON data, do
//
//     final responseMenu = responseMenuFromJson(jsonString);

import 'dart:convert';

ResponseMenu responseMenuFromJson(String str) =>
    ResponseMenu.fromJson(json.decode(str));

String responseMenuToJson(ResponseMenu data) => json.encode(data.toJson());

class ResponseMenu {
  ResponseMenu({
    this.status,
    this.message,
    this.statusCode,
    this.menus,
  });

  bool status;
  String message;
  int statusCode;
  List<Menu> menus;

  factory ResponseMenu.fromJson(Map<String, dynamic> json) => ResponseMenu(
        status: json["status"],
        message: json["message"],
        statusCode: json["statusCode"],
        menus: List<Menu>.from(json["menus"].map((x) => Menu.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "statusCode": statusCode,
        "menus": List<dynamic>.from(menus.map((x) => x.toJson())),
      };
}

class Menu {
  Menu({
    this.itemId,
    this.itemName,
    this.tag,
    this.collect,
    this.image,
  });

  int itemId;
  String itemName;
  String tag;
  String collect;
  String image;

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        itemId: json["itemID"],
        itemName: json["itemName"],
        tag: json["tag"],
        collect: json["collect"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "itemID": itemId,
        "itemName": itemName,
        "tag": tag,
        "collect": collect,
        "image": image,
      };
}

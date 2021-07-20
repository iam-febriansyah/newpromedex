// To parse this JSON data, do
//
//     final dataOrder = dataOrderFromJson(jsonString);

import 'dart:convert';

import 'package:galeri_teknologi_bersama/data/model/bio.dart';

DataOrder dataOrderFromJson(String str) => DataOrder.fromJson(json.decode(str));

String dataOrderToJson(DataOrder data) => json.encode(data.toJson());

class DataOrder {
  DataOrder(
      {this.phone,
      this.date,
      this.hours,
      this.nameItem,
      this.price,
      this.quantity,
      this.profilPasien});

  String phone;
  String date;
  String hours;
  String nameItem;
  int price;
  int quantity;
  List<Bio> profilPasien;

  factory DataOrder.fromJson(Map<String, dynamic> json) => DataOrder(
        phone: json["phone"],
        date: json["date"],
        hours: json["hours"],
        nameItem: json["nameItem"],
        price: json["price"],
        quantity: json["quantity"],
        profilPasien:
            List<Bio>.from(json["profilPasien"].map((x) => Bio.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "phone": phone,
        "date": date,
        "hours": hours,
        "nameItem": nameItem,
        "price": price,
        "quantity": quantity,
        "service": List<dynamic>.from(profilPasien.map((x) => x.toJson())),
      };
}

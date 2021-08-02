// To parse this JSON data, do
//
//     final responseListSwabber = responseListSwabberFromJson(jsonString);

import 'dart:convert';

ResponseListSwabber responseListSwabberFromJson(String str) =>
    ResponseListSwabber.fromJson(json.decode(str));

String responseListSwabberToJson(ResponseListSwabber data) =>
    json.encode(data.toJson());

class ResponseListSwabber {
  ResponseListSwabber({
    this.status,
    this.message,
    this.statusCode,
    this.listSwabbers,
  });

  bool status;
  String message;
  int statusCode;
  List<ListSwabber> listSwabbers;

  factory ResponseListSwabber.fromJson(Map<String, dynamic> json) =>
      ResponseListSwabber(
        status: json["status"],
        message: json["message"],
        statusCode: json["statusCode"],
        listSwabbers: List<ListSwabber>.from(
            json["listSwabbers"].map((x) => ListSwabber.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "statusCode": statusCode,
        "listSwabbers": List<dynamic>.from(listSwabbers.map((x) => x.toJson())),
      };
}

class ListSwabber {
  ListSwabber({
    this.id,
    this.username,
    this.email,
    this.iddetail,
    this.name,
    this.gender,
    this.phone,
    this.onswab,
    this.online,
    this.latitude,
    this.longitude,
    this.lastLocationUpdate,
  });

  String id;
  String username;
  String email;
  String iddetail;
  String name;
  String gender;
  String phone;
  bool onswab;
  bool online;
  String latitude;
  String longitude;
  String lastLocationUpdate;

  factory ListSwabber.fromJson(Map<String, dynamic> json) => ListSwabber(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        iddetail: json["iddetail"],
        name: json["name"],
        gender: json["gender"],
        phone: json["phone"],
        onswab: json["onswab"],
        online: json["online"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        lastLocationUpdate: json["lastLocationUpdate"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "iddetail": iddetail,
        "name": name,
        "gender": gender,
        "phone": phone,
        "onswab": onswab,
        "online": online,
        "latitude": latitude,
        "longitude": longitude,
        "lastLocationUpdate": lastLocationUpdate
      };
}

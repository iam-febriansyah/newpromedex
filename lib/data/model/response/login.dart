// To parse this JSON data, do
//
//     final responseLogin = responseLoginFromJson(jsonString);

import 'dart:convert';

ResponseLogin responseLoginFromJson(String str) =>
    ResponseLogin.fromJson(json.decode(str));

String responseLoginToJson(ResponseLogin data) => json.encode(data.toJson());

class ResponseLogin {
  ResponseLogin({
    this.status,
    this.statusCode,
    this.message,
    this.accessToken,
    this.dataUser,
  });

  bool status;
  int statusCode;
  String message;
  String accessToken;
  DataUser dataUser;

  factory ResponseLogin.fromJson(Map<String, dynamic> json) => ResponseLogin(
        status: json["status"],
        statusCode: json["statusCode"],
        message: json["message"],
        accessToken: json["accessToken"],
        dataUser: DataUser.fromJson(json["dataUser"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "statusCode": statusCode,
        "message": message,
        "accessToken": accessToken,
        "dataUser": dataUser.toJson(),
      };
}

class DataUser {
  DataUser({
    this.id,
    this.username,
    this.email,
    this.level,
    this.iddetail,
    this.identityNumber,
    this.identityParentNumber,
    this.name,
    this.gender,
    this.birthDay,
    this.birthPlace,
    this.phone,
    this.address,
    this.nationality,
  });

  String id;
  String username;
  String email;
  int level;
  String iddetail;
  String identityNumber;
  String identityParentNumber;
  String name;
  String gender;
  DateTime birthDay;
  String birthPlace;
  String phone;
  String address;
  String nationality;

  factory DataUser.fromJson(Map<String, dynamic> json) => DataUser(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        level: json["level"],
        iddetail: json["iddetail"],
        identityNumber: json["identityNumber"],
        identityParentNumber: json["identityParentNumber"],
        name: json["name"],
        gender: json["gender"],
        birthDay: DateTime.parse(json["birthDay"]),
        birthPlace: json["birthPlace"],
        phone: json["phone"],
        address: json["address"],
        nationality: json["nationality"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "level": level,
        "iddetail": iddetail,
        "identityNumber": identityNumber,
        "identityParentNumber": identityParentNumber,
        "name": name,
        "gender": gender,
        "birthDay":
            "${birthDay.year.toString().padLeft(4, '0')}-${birthDay.month.toString().padLeft(2, '0')}-${birthDay.day.toString().padLeft(2, '0')}",
        "birthPlace": birthPlace,
        "phone": phone,
        "address": address,
        "nationality": nationality,
      };
}

// To parse this JSON data, do
//
//     final requestRegister = requestRegisterFromJson(jsonString);

import 'dart:convert';

RequestRegister requestRegisterFromJson(String str) =>
    RequestRegister.fromJson(json.decode(str));

String requestRegisterToJson(RequestRegister data) =>
    json.encode(data.toJson());

class RequestRegister {
  RequestRegister({
    this.username,
    this.email,
    this.password,
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

  String username;
  String email;
  String password;
  String identityNumber;
  String identityParentNumber;
  String name;
  String gender;
  String birthDay;
  String birthPlace;
  String phone;
  String address;
  String nationality;

  factory RequestRegister.fromJson(Map<String, dynamic> json) =>
      RequestRegister(
        username: json["username"],
        email: json["email"],
        password: json["password"],
        identityNumber: json["identityNumber"],
        identityParentNumber: json["identityParentNumber"],
        name: json["name"],
        gender: json["gender"],
        birthDay: json["birthDay"],
        birthPlace: json["birthPlace"],
        phone: json["phone"],
        address: json["address"],
        nationality: json["nationality"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "password": password,
        "identityNumber": identityNumber,
        "identityParentNumber": identityParentNumber,
        "name": name,
        "gender": gender,
        "birthDay": birthDay,
        "birthPlace": birthPlace,
        "phone": phone,
        "address": address,
        "nationality": nationality,
      };
}

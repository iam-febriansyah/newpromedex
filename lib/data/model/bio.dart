// To parse this JSON data, do
//
//     final bio = bioFromJson(jsonString);

import 'dart:convert';

Bio bioFromJson(String str) => Bio.fromJson(json.decode(str));

String bioToJson(Bio data) => json.encode(data.toJson());

class Bio {
  Bio({
    this.id,
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
  });

  int id;
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

  factory Bio.fromJson(Map<String, dynamic> json) => Bio(
        id: json["id"],
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
      );

  Map<String, dynamic> toJson() => {
        "id": id,
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
      };
}

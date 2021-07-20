// To parse this JSON data, do
//
//     final bio = bioFromJson(jsonString);

import 'dart:convert';

List<Bio> bioFromJson(String str) =>
    List<Bio>.from(json.decode(str).map((x) => Bio.fromJson(x)));

String bioToJson(List<Bio> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Bio {
  Bio({
    this.id,
    this.nik,
    this.name,
    this.isChecked,

    // this.phoneNumber,
    // this.email,
    // this.gender,
    // this.birthPlace,
    // this.birthDate,
    // this.adress,
    // this.country,
  });

  int id;
  String nik;
  String name;
  int isChecked;
  // String phoneNumber;
  // String email;
  // bool gender;
  // String birthPlace;
  // String birthDate;
  // String adress;
  // String country;

  factory Bio.fromJson(Map<String, dynamic> json) => Bio(
        id: json["id"],
        nik: json["nik"],
        name: json["name"],
        isChecked: json["isChecked"],
        // phoneNumber: json["phoneNumber"],
        // email: json["email"],
        // gender: json["gender"],
        // birthPlace: json["birthPlace"],
        // birthDate: json["birthDate"],
        // adress: json["adress"],
        // country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nik": nik,
        "name": name,
        "isChecked": isChecked,
        // "phoneNumber": phoneNumber,
        // "email": email,
        // "gender": gender,
        // "birthPlace": birthPlace,
        // "birthDate": birthDate,
        // "adress": adress,
        // "country": country,
      };
}

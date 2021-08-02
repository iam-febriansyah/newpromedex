// To parse this JSON data, do
//
//     final responseRegister = responseRegisterFromJson(jsonString);

import 'dart:convert';

ResponseRegister responseRegisterFromJson(String str) =>
    ResponseRegister.fromJson(json.decode(str));

String responseRegisterToJson(ResponseRegister data) =>
    json.encode(data.toJson());

class ResponseRegister {
  ResponseRegister({
    this.status,
    this.message,
    this.statusCode,
  });

  bool status;
  String message;
  int statusCode;

  factory ResponseRegister.fromJson(Map<String, dynamic> json) =>
      ResponseRegister(
        status: json["status"],
        message: json["message"],
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "statusCode": statusCode,
      };
}

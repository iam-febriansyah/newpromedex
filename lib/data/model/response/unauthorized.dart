// To parse this JSON data, do
//
//     final responseUnauthorized = responseUnauthorizedFromJson(jsonString);

import 'dart:convert';

ResponseUnauthorized responseUnauthorizedFromJson(String str) =>
    ResponseUnauthorized.fromJson(json.decode(str));

String responseUnauthorizedToJson(ResponseUnauthorized data) =>
    json.encode(data.toJson());

class ResponseUnauthorized {
  ResponseUnauthorized({
    this.status,
    this.statusCode,
    this.message,
  });

  bool status;
  int statusCode;
  String message;

  factory ResponseUnauthorized.fromJson(Map<String, dynamic> json) =>
      ResponseUnauthorized(
        status: json["status"],
        statusCode: json["statusCode"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "statusCode": statusCode,
        "message": message,
      };
}

// To parse this JSON data, do
//
//     final responseFcm = responseFcmFromJson(jsonString);

import 'dart:convert';

ResponseFcm responseFcmFromJson(String str) =>
    ResponseFcm.fromJson(json.decode(str));

String responseFcmToJson(ResponseFcm data) => json.encode(data.toJson());

class ResponseFcm {
  ResponseFcm({
    this.status,
    this.message,
    this.statusCode,
  });

  bool status;
  String message;
  int statusCode;

  factory ResponseFcm.fromJson(Map<String, dynamic> json) => ResponseFcm(
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

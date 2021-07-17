// To parse this JSON data, do
//
//     final userData = userDataFromJson(jsonString);

import 'dart:convert';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
  UserData({
    this.displayName,
    this.email,
    this.phoneNumber,
    this.photoUrl,
    this.providerId,
    this.uid,
  });

  String displayName;
  String email;
  String phoneNumber;
  String photoUrl;
  String providerId;
  String uid;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        displayName: json["displayName"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        photoUrl: json["photoURL"],
        providerId: json["providerId"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "displayName": displayName,
        "email": email,
        "phoneNumber": phoneNumber,
        "photoURL": photoUrl,
        "providerId": providerId,
        "uid": uid,
      };
}

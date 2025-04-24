// To parse this JSON data, do
//
//     final userInfoModel = userInfoModelFromJson(jsonString);

import 'dart:convert';

UserInfoModel userInfoModelFromJson(String str) =>
    UserInfoModel.fromJson(json.decode(str));

String userInfoModelToJson(UserInfoModel data) => json.encode(data.toJson());

class UserInfoModel {
  final String? message;
  final Data? data;
  final int? statusCode;
  final String? status;

  UserInfoModel({
    this.message,
    this.data,
    this.statusCode,
    this.status,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        statusCode: json["status_code"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
        "status_code": statusCode,
        "status": status,
      };
}

class Data {
  final int? id;
  final String? name;
  final String? firstName;
  final String? lastName;
  final String? username;
  final String? email;
  final String? phone;
  final String? userRole;
  final String? status;
  final String? image;
  final String? fcmToken;
  final String? firebaseId;
  final String? googleId;
  final String? appleId;

  Data({
    this.id,
    this.name,
    this.firstName,
    this.lastName,
    this.username,
    this.email,
    this.phone,
    this.userRole,
    this.status,
    this.image,
    this.fcmToken,
    this.firebaseId,
    this.googleId,
    this.appleId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        username: json["username"],
        email: json["email"],
        phone: json["phone"],
        userRole: json["user_role"],
        status: json["status"],
        image: json["image"],
        fcmToken: json["fcm_token"],
        firebaseId: json["firebase_id"],
        googleId: json["google_id"],
        appleId: json["apple_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "first_name": firstName,
        "last_name": lastName,
        "username": username,
        "email": email,
        "phone": phone,
        "user_role": userRole,
        "status": status,
        "image": image,
        "fcm_token": fcmToken,
        "firebase_id": firebaseId,
        "google_id": googleId,
        "apple_id": appleId,
      };
}

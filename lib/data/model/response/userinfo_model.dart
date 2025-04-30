import 'dart:convert';

UserInfoModel userInfoModelFromJson(String str) =>
    UserInfoModel.fromJson(json.decode(str));

String userInfoModelToJson(UserInfoModel data) => json.encode(data.toJson());

class UserInfoModel {
  final String? message;
  final UserData? data;
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
        data: json["data"] == null ? null : UserData.fromJson(json["data"]),
        statusCode: json["status_code"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
        "status_code": statusCode,
        "status": status,
      };

  UserInfoModel copyWith({
    String? message,
    UserData? data,
    int? statusCode,
    String? status,
  }) {
    return UserInfoModel(
      message: message ?? this.message,
      data: data ?? this.data,
      statusCode: statusCode ?? this.statusCode,
      status: status ?? this.status,
    );
  }
}

class UserData {
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

  UserData({
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

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
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

  UserData copyWith({
    int? id,
    String? name,
    String? firstName,
    String? lastName,
    String? username,
    String? email,
    String? phone,
    String? userRole,
    String? status,
    String? image,
    String? fcmToken,
    String? firebaseId,
    String? googleId,
    String? appleId,
  }) {
    return UserData(
      id: id ?? this.id,
      name: name ?? this.name,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      username: username ?? this.username,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      userRole: userRole ?? this.userRole,
      status: status ?? this.status,
      image: image ?? this.image,
      fcmToken: fcmToken ?? this.fcmToken,
      firebaseId: firebaseId ?? this.firebaseId,
      googleId: googleId ?? this.googleId,
      appleId: appleId ?? this.appleId,
    );
  }

  /// Returns the phone number without the +996 country code, if present.
  String get phoneWithoutCountryCode {
    if (phone != null && phone!.startsWith('+996')) {
      return phone!.substring(4); // Remove "+996"
    }
    return phone ?? '';
  }
}

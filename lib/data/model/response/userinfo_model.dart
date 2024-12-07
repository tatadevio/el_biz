import 'dart:convert';

UserInfoModel userInfoModelFromJson(String str) => UserInfoModel.fromJson(json.decode(str));

String userInfoModelToJson(UserInfoModel data) => json.encode(data.toJson());

class UserInfoModel {
  UserInfoModel({
    required this.message,
    required this.data,
    required this.statusCode,
    required this.status,
  });

  String message;
  Data data;
  int statusCode;
  String status;

  factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
    message: json["message"],
    data: Data.fromJson(json["data"]),
    statusCode: json["status_code"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data.toJson(),
    "status_code": statusCode,
    "status": status,
  };
}

class Data {
  Data({
    required this.id,
    required this.customerId,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.bannerImg,
    required this.country,
    required this.city,
    required this.state,
    required this.address,
    required this.status,
    required this.about,
    required this.registered,
    required this.promoLink,
    required this.promoQr,
    required this.screenshot,
    required this.showTheme,
    required this.androidVersion,
    required this.iosVersion,
    required this.countryCode,
    required this.userType,
    required this.disablePackage,
  });

  int id;
  String customerId;
  String name;
  String email;
  String phone;
  String image;
  String bannerImg;
  String country;
  String city;
  String state;
  String address;
  int status;
  String about;
  int registered;
  String promoLink;
  String promoQr;
  int screenshot;
  int showTheme;
  String androidVersion;
  String iosVersion;
  String countryCode;
  String userType;
  int disablePackage;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    customerId: json["customer_id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    image: json["image"],
    bannerImg: json["banner_img"],
    country: json["country"],
    city: json["city"],
    state: json["state"],
    address: json["address"],
    status: json["status"],
    about: json["about"],
    registered: json["registered"],
    promoLink: json["promo_link"],
    promoQr: json["promo_qr"],
    screenshot: json["screenshot"],
    showTheme: json["show_theme"],
    androidVersion: json["android_app_version"]??"",
    iosVersion: json["ios_app_version"]??"",
    countryCode: json["country_code"]??"",
    userType: json["user_type"]??"",
    disablePackage: json["disable_subscription"]??1,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "customer_id": customerId,
    "name": name,
    "email": email,
    "phone": phone,
    "image": image,
    "banner_img": bannerImg,
    "country": country,
    "city": city,
    "state": state,
    "address": address,
    "status": status,
    "about": about,
    "registered": registered,
    "promo_link": promoLink,
    "promo_qr": promoQr,
    "screenshot": screenshot,
    "show_theme": showTheme,
    "android_app_version": androidVersion,
    "ios_app_version": iosVersion,
    "country_code": countryCode,
    "user_type": userType,
    "disable_subscription": disablePackage,
  };
}

// To parse this JSON data, do
//
//     final sellerInfoModel = sellerInfoModelFromJson(jsonString);

import 'dart:convert';

SellerInfoModel sellerInfoModelFromJson(String str) => SellerInfoModel.fromJson(json.decode(str));

String sellerInfoModelToJson(SellerInfoModel data) => json.encode(data.toJson());

class SellerInfoModel {
  String? message;
  Data? data;
  int? statusCode;
  String? status;

  SellerInfoModel({
    this.message,
    this.data,
    this.statusCode,
    this.status,
  });

  factory SellerInfoModel.fromJson(Map<String, dynamic> json) => SellerInfoModel(
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
  int? id;
  String? role;
  String? name;
  String? email;
  String? phone;
  String? image;
  String? bannerImg;
  String? country;
  String? city;
  String? state;
  String? address;
  int? status;
  String? about;
  Company? company;
  bool? isVarified;
  String? followingCount;
  String? followersCount;
  String? productCount;
  bool? isFollow;
  bool? isFavorite;
  bool? isOnline;
  String? lastSeenDif;
  String? lastSeen;

  Data({
    this.id,
    this.role,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.bannerImg,
    this.country,
    this.city,
    this.state,
    this.address,
    this.status,
    this.about,
    this.company,
    this.isVarified,
    this.followingCount,
    this.followersCount,
    this.productCount,
    this.isFollow,
    this.isFavorite,
    this.isOnline,
    this.lastSeenDif,
    this.lastSeen,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        role: json["role"],
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
        company: json["company"] == null && json["company"] != [] ? null : Company.fromJson(json["company"]),
        isVarified: json['is_verified'],
        followingCount: json['followingCount'].toString(),
        followersCount: json['followersCount'].toString(),
        productCount: json['productCount'].toString(),
        isFollow: json['is_follow'],
        isFavorite: json['is_favorite'],
        isOnline: json['is_online'],
        lastSeenDif: json['last_seen_dif'],
        lastSeen: json['last_seen'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "role": role,
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
        "company": company?.toJson(),
        "is_verified": isVarified,
        "followingCount": followingCount,
        "followersCount": followersCount,
        "productCount": productCount,
        "is_follow": isFollow,
        "is_favorite": isFavorite,
        "is_online": isOnline,
        "last_seen_dif": lastSeenDif,
        "last_seen": lastSeen,
      };
}

class Company {
  String? companyName;
  String? companyPhone;
  String? companyAbout;
  String? companyAddress;
  String? passportId;
  String? issuedBy;
  String? nationality;
  String? logo;
  String? banner;
  String? companyLatitude;
  String? companyLongitude;
  Contact? contact;
  ScheduleTime? scheduleTime;

  Company({
    this.companyName,
    this.companyPhone,
    this.companyAbout,
    this.companyAddress,
    this.passportId,
    this.issuedBy,
    this.nationality,
    this.logo,
    this.banner,
    this.companyLatitude,
    this.companyLongitude,
    this.contact,
    this.scheduleTime,
  });

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        companyName: json["company_name"],
        companyPhone: json["company_phone"],
        companyAbout: json["company_about"],
        companyAddress: json["company_address"],
        passportId: json["passport_id"],
        issuedBy: json["issued_by"],
        nationality: json["nationality"],
        logo: json["logo"],
        banner: json["banner"],
        companyLatitude: json["company_latitude"],
        companyLongitude: json["company_longitude"],
        contact: json["contact"] == null || json["contact"].isEmpty ? null : Contact.fromJson(json["contact"]),
        scheduleTime: json["schedule_time"] == null || json["schedule_time"].isEmpty ? null : ScheduleTime.fromJson(json["schedule_time"]),
      );

  Map<String, dynamic> toJson() => {
        "company_name": companyName,
        "company_phone": companyPhone,
        "company_about": companyAbout,
        "company_address": companyAddress,
        "passport_id": passportId,
        "issued_by": issuedBy,
        "nationality": nationality,
        "logo": logo,
        "banner": banner,
        "company_latitude": companyLatitude,
        "company_longitude": companyLongitude,
        "contact": contact?.toJson(),
        "schedule_time": scheduleTime?.toJson(),
      };
}

class Contact {
  List<String>? whatsapp;
  List<String>? telegram;
  List<String>? instagram;
  List<String>? vk;
  List<String>? email;
  List<String>? website;

  Contact({
    this.whatsapp,
    this.telegram,
    this.instagram,
    this.vk,
    this.email,
    this.website,
  });

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        whatsapp: json["whatsapp"] == null ? [] : List<String>.from(json["whatsapp"]!.map((x) => x)),
        telegram: json["telegram"] == null ? [] : List<String>.from(json["telegram"]!.map((x) => x)),
        instagram: json["instagram"] == null ? [] : List<String>.from(json["instagram"]!.map((x) => x)),
        vk: json["vk"] == null ? [] : List<String>.from(json["vk"]!.map((x) => x)),
        email: json["email"] == null ? [] : List<String>.from(json["email"]!.map((x) => x)),
        website: json["website"] == null ? [] : List<String>.from(json["website"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "whatsapp": whatsapp == null ? [] : List<dynamic>.from(whatsapp!.map((x) => x)),
        "telegram": telegram == null ? [] : List<dynamic>.from(telegram!.map((x) => x)),
        "instagram": instagram == null ? [] : List<dynamic>.from(instagram!.map((x) => x)),
        "vk": vk == null ? [] : List<dynamic>.from(vk!.map((x) => x)),
        "email": email == null ? [] : List<dynamic>.from(email!.map((x) => x)),
        "website": website == null ? [] : List<dynamic>.from(website!.map((x) => x)),
      };
}

class ScheduleTime {
  List<String>? day;
  List<String>? openingTime;
  List<String>? closingTime;
  List<String>? isOpen;

  ScheduleTime({
    this.day,
    this.openingTime,
    this.closingTime,
    this.isOpen,
  });

  factory ScheduleTime.fromJson(Map<String, dynamic> json) => ScheduleTime(
        day: json["day"] == null ? [] : List<String>.from(json["day"]!.map((x) => x)),
        openingTime: json["openingTime"] == null ? [] : List<String>.from(json["openingTime"]!.map((x) => x)),
        closingTime: json["closingTime"] == null ? [] : List<String>.from(json["closingTime"]!.map((x) => x)),
        isOpen: json["isOpen"] == null ? [] : List<String>.from(json["isOpen"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "day": day == null ? [] : List<dynamic>.from(day!.map((x) => x)),
        "openingTime": openingTime == null ? [] : List<dynamic>.from(openingTime!.map((x) => x)),
        "closingTime": closingTime == null ? [] : List<dynamic>.from(closingTime!.map((x) => x)),
        "isOpen": isOpen == null ? [] : List<dynamic>.from(isOpen!.map((x) => x)),
      };
}

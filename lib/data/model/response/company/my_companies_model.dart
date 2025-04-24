// To parse this JSON data, do
//
//     final myCompaniesModel = myCompaniesModelFromJson(jsonString);

import 'dart:convert';

MyCompaniesModel myCompaniesModelFromJson(String str) =>
    MyCompaniesModel.fromJson(json.decode(str));

String myCompaniesModelToJson(MyCompaniesModel data) =>
    json.encode(data.toJson());

class MyCompaniesModel {
  final dynamic title;
  final String? message;
  final String? status;
  final String? localizedKey;
  final Data? data;
  final int? statusCode;

  MyCompaniesModel({
    this.title,
    this.message,
    this.status,
    this.localizedKey,
    this.data,
    this.statusCode,
  });

  factory MyCompaniesModel.fromJson(Map<String, dynamic> json) =>
      MyCompaniesModel(
        title: json["title"],
        message: json["message"],
        status: json["status"],
        localizedKey: json["localized_key"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        statusCode: json["status_code"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "message": message,
        "status": status,
        "localized_key": localizedKey,
        "data": data?.toJson(),
        "status_code": statusCode,
      };
}

class Data {
  final List<CompanyItem>? items;
  final int? totalPages;
  final int? currentPage;
  final int? total;
  final int? perPage;
  final int? count;

  Data({
    this.items,
    this.totalPages,
    this.currentPage,
    this.total,
    this.perPage,
    this.count,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        items: json["items"] == null
            ? []
            : List<CompanyItem>.from(
                json["items"]!.map((x) => CompanyItem.fromJson(x))),
        totalPages: json["totalPages"],
        currentPage: json["currentPage"],
        total: json["total"],
        perPage: json["perPage"],
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "totalPages": totalPages,
        "currentPage": currentPage,
        "total": total,
        "perPage": perPage,
        "count": count,
      };
}

class CompanyItem {
  final int? id;
  final String? name;
  final String? email;
  final String? logo;
  final String? banner;
  final String? phone;
  final String? address;
  final String? verificationStatus;
  final String? tinNumber;
  final DateTime? createdAt;
  final Owner? owner;

  CompanyItem({
    this.id,
    this.name,
    this.email,
    this.logo,
    this.banner,
    this.phone,
    this.address,
    this.verificationStatus,
    this.tinNumber,
    this.createdAt,
    this.owner,
  });

  factory CompanyItem.fromJson(Map<String, dynamic> json) => CompanyItem(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        logo: json["logo"],
        banner: json["banner"],
        phone: json["phone"],
        address: json["address"],
        verificationStatus: json["verification_status"],
        tinNumber: json["tin_number"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        owner: json["owner"] == null ? null : Owner.fromJson(json["owner"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "logo": logo,
        "banner": banner,
        "phone": phone,
        "address": address,
        "verification_status": verificationStatus,
        "tin_number": tinNumber,
        "created_at": createdAt?.toIso8601String(),
        "owner": owner?.toJson(),
      };
}

class Owner {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? image;
  final String? status;

  Owner({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.status,
  });

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        image: json["image"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "image": image,
        "status": status,
      };
}

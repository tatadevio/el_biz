// To parse this JSON data, do
//
//     final companyTendersModel = companyTendersModelFromJson(jsonString);

import 'dart:convert';

import 'package:el_biz/data/model/response/chat/chat_list_model.dart';

import '../tender/tender_item_model.dart';

CompanyTendersModel companyTendersModelFromJson(String str) =>
    CompanyTendersModel.fromJson(json.decode(str));

String companyTendersModelToJson(CompanyTendersModel data) =>
    json.encode(data.toJson());

class CompanyTendersModel {
  final dynamic title;
  final String? message;
  final String? status;
  final String? localizedKey;
  final Data? data;
  final int? statusCode;

  CompanyTendersModel({
    this.title,
    this.message,
    this.status,
    this.localizedKey,
    this.data,
    this.statusCode,
  });

  factory CompanyTendersModel.fromJson(Map<String, dynamic> json) =>
      CompanyTendersModel(
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
  final List<TenderItem>? items;
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
            : List<TenderItem>.from(
                json["items"]!.map((x) => TenderItem.fromJson(x))),
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

class Company {
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
  final User? owner;

  Company({
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

  factory Company.fromJson(Map<String, dynamic> json) => Company(
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
        owner: json["owner"] == null ? null : User.fromJson(json["owner"]),
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

// class Owner {
//   final int? id;
//   final String? name;
//   final String? email;
//   final String? phone;
//   final String? image;
//   final String? status;

//   Owner({
//     this.id,
//     this.name,
//     this.email,
//     this.phone,
//     this.image,
//     this.status,
//   });

//   factory Owner.fromJson(Map<String, dynamic> json) => Owner(
//         id: json["id"],
//         name: json["name"],
//         email: json["email"],
//         phone: json["phone"],
//         image: json["image"],
//         status: json["status"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "email": email,
//         "phone": phone,
//         "image": image,
//         "status": status,
//       };
// }

class TenderCategory {
  final int? id;
  final String? name;

  TenderCategory({
    this.id,
    this.name,
  });

  factory TenderCategory.fromJson(Map<String, dynamic> json) => TenderCategory(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

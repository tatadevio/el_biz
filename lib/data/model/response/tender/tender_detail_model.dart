// To parse this JSON data, do
//
//     final tenderDetailModel = tenderDetailModelFromJson(jsonString);

import 'dart:convert';

TenderDetailModel tenderDetailModelFromJson(String str) =>
    TenderDetailModel.fromJson(json.decode(str));

String tenderDetailModelToJson(TenderDetailModel data) =>
    json.encode(data.toJson());

class TenderDetailModel {
  final dynamic title;
  final String? message;
  final String? status;
  final String? localizedKey;
  final Data? data;
  final int? statusCode;

  TenderDetailModel({
    this.title,
    this.message,
    this.status,
    this.localizedKey,
    this.data,
    this.statusCode,
  });

  factory TenderDetailModel.fromJson(Map<String, dynamic> json) =>
      TenderDetailModel(
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
  final int? id;
  final String? title;
  final String? description;
  final String? status;
  final int? budgetFrom;
  final int? budgetTo;
  final String? phone;
  final String? email;
  final String? location;
  final int? quantity;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Company? company;
  final TenderCategory? tenderCategory;
  final List<Media>? media;

  Data({
    this.id,
    this.title,
    this.description,
    this.status,
    this.budgetFrom,
    this.budgetTo,
    this.phone,
    this.email,
    this.location,
    this.quantity,
    this.createdAt,
    this.updatedAt,
    this.company,
    this.tenderCategory,
    this.media,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        status: json["status"],
        budgetFrom: json["budget_from"],
        budgetTo: json["budget_to"],
        phone: json["phone"],
        email: json["email"],
        location: json["location"],
        quantity: json["quantity"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        company:
            json["company"] == null ? null : Company.fromJson(json["company"]),
        tenderCategory: json["tender_category"] == null
            ? null
            : TenderCategory.fromJson(json["tender_category"]),
        media: json["media"] == null
            ? []
            : List<Media>.from(json["media"]!.map((x) => Media.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "status": status,
        "budget_from": budgetFrom,
        "budget_to": budgetTo,
        "phone": phone,
        "email": email,
        "location": location,
        "quantity": quantity,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "company": company?.toJson(),
        "tender_category": tenderCategory?.toJson(),
        "media": media == null
            ? []
            : List<dynamic>.from(media!.map((x) => x.toJson())),
      };
}

class Company {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? logo;
  final String? verificationStatus;
  final Owner? owner;

  Company({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.logo,
    this.verificationStatus,
    this.owner,
  });

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        logo: json["logo"],
        verificationStatus: json["verification_status"],
        owner: json["owner"] == null ? null : Owner.fromJson(json["owner"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "logo": logo,
        "verification_status": verificationStatus,
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

class Media {
  final int? id;
  final int? size;
  final String? url;

  Media({
    this.id,
    this.size,
    this.url,
  });

  factory Media.fromJson(Map<String, dynamic> json) => Media(
        id: json["id"],
        size: json["size"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "size": size,
        "url": url,
      };
}

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

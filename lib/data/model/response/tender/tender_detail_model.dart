// To parse this JSON data, do
//
//     final tenderDetailModel = tenderDetailModelFromJson(jsonString);

import 'dart:convert';

import 'package:el_biz/data/model/response/company/my_companies_model.dart';

TenderDetailModel tenderDetailModelFromJson(String str) =>
    TenderDetailModel.fromJson(json.decode(str));

String tenderDetailModelToJson(TenderDetailModel data) =>
    json.encode(data.toJson());

class TenderDetailModel {
  final String? title;
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

  TenderDetailModel copyWith({
    String? title,
    String? message,
    String? status,
    String? localizedKey,
    Data? data,
    int? statusCode,
  }) =>
      TenderDetailModel(
        title: title ?? this.title,
        message: message ?? this.message,
        status: status ?? this.status,
        localizedKey: localizedKey ?? this.localizedKey,
        data: data ?? this.data,
        statusCode: statusCode ?? this.statusCode,
      );

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
  final CompanyItem? company;
  final TenderCategory? tenderCategory;
  final bool? isFavorite;
  final List<TenderProduct>? tenderProducts;
  final List<Media>? media;
  final String? activeStatus;

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
    this.isFavorite,
    this.tenderProducts,
    this.media,
    this.activeStatus,
  });

  Data copyWith({
    int? id,
    String? title,
    String? description,
    String? status,
    int? budgetFrom,
    int? budgetTo,
    String? phone,
    String? email,
    String? location,
    int? quantity,
    DateTime? createdAt,
    DateTime? updatedAt,
    CompanyItem? company,
    TenderCategory? tenderCategory,
    bool? isFavorite,
    List<TenderProduct>? tenderProducts,
    List<Media>? media,
    String? activeStatus,
  }) =>
      Data(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        status: status ?? this.status,
        budgetFrom: budgetFrom ?? this.budgetFrom,
        budgetTo: budgetTo ?? this.budgetTo,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        location: location ?? this.location,
        quantity: quantity ?? this.quantity,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        company: company ?? this.company,
        tenderCategory: tenderCategory ?? this.tenderCategory,
        isFavorite: isFavorite ?? this.isFavorite,
        tenderProducts: tenderProducts ?? this.tenderProducts,
        media: media ?? this.media,
        activeStatus: activeStatus ?? this.activeStatus,
      );

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
        company: json["company"] == null
            ? null
            : CompanyItem.fromJson(json["company"]),
        tenderCategory: json["tender_category"] == null
            ? null
            : TenderCategory.fromJson(json["tender_category"]),
        isFavorite: json["is_favorite"],
        tenderProducts: json["tender_products"] == null
            ? []
            : List<TenderProduct>.from(
                json["tender_products"]!.map((x) => TenderProduct.fromJson(x))),
        media: json["media"] == null
            ? []
            : List<Media>.from(json["media"]!.map((x) => Media.fromJson(x))),
        activeStatus: json["active_status"],
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
        "is_favorite": isFavorite,
        "tender_products": tenderProducts == null
            ? []
            : List<dynamic>.from(tenderProducts!.map((x) => x.toJson())),
        "media": media == null
            ? []
            : List<dynamic>.from(media!.map((x) => x.toJson())),
        "active_status": activeStatus,
      };
}

// class Company {
//   final int? id;
//   final String? name;
//   final String? email;
//   final String? phone;
//   final String? logo;
//   final String? verificationStatus;
//   final Owner? owner;

//   Company({
//     this.id,
//     this.name,
//     this.email,
//     this.phone,
//     this.logo,
//     this.verificationStatus,
//     this.owner,
//   });

//   Company copyWith({
//     int? id,
//     String? name,
//     String? email,
//     String? phone,
//     String? logo,
//     String? verificationStatus,
//     Owner? owner,
//   }) =>
//       Company(
//         id: id ?? this.id,
//         name: name ?? this.name,
//         email: email ?? this.email,
//         phone: phone ?? this.phone,
//         logo: logo ?? this.logo,
//         verificationStatus: verificationStatus ?? this.verificationStatus,
//         owner: owner ?? this.owner,
//       );

//   factory Company.fromJson(Map<String, dynamic> json) => Company(
//         id: json["id"],
//         name: json["name"],
//         email: json["email"],
//         phone: json["phone"],
//         logo: json["logo"],
//         verificationStatus: json["verification_status"],
//         owner: json["owner"] == null ? null : Owner.fromJson(json["owner"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "email": email,
//         "phone": phone,
//         "logo": logo,
//         "verification_status": verificationStatus,
//         "owner": owner?.toJson(),
//       };
// }

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

  Owner copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? image,
    String? status,
  }) =>
      Owner(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        image: image ?? this.image,
        status: status ?? this.status,
      );

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

  Media copyWith({
    int? id,
    int? size,
    String? url,
  }) =>
      Media(
        id: id ?? this.id,
        size: size ?? this.size,
        url: url ?? this.url,
      );

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

  TenderCategory copyWith({
    int? id,
    String? name,
  }) =>
      TenderCategory(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory TenderCategory.fromJson(Map<String, dynamic> json) => TenderCategory(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class TenderProduct {
  final int? id;
  final String? productName;
  final int? quantity;
  final String? unit;
  final dynamic description;

  TenderProduct({
    this.id,
    this.productName,
    this.quantity,
    this.unit,
    this.description,
  });

  TenderProduct copyWith({
    int? id,
    String? productName,
    int? quantity,
    String? unit,
    dynamic description,
  }) =>
      TenderProduct(
        id: id ?? this.id,
        productName: productName ?? this.productName,
        quantity: quantity ?? this.quantity,
        unit: unit ?? this.unit,
        description: description ?? this.description,
      );

  factory TenderProduct.fromJson(Map<String, dynamic> json) => TenderProduct(
        id: json["id"],
        productName: json["product_name"],
        quantity: json["quantity"],
        unit: json["unit"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_name": productName,
        "quantity": quantity,
        "unit": unit,
        "description": description,
      };
}

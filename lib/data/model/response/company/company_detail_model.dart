// To parse this JSON data, do
//
//     final companyDetailModel = companyDetailModelFromJson(jsonString);

import 'dart:convert';

CompanyDetailModel companyDetailModelFromJson(String str) =>
    CompanyDetailModel.fromJson(json.decode(str));

String companyDetailModelToJson(CompanyDetailModel data) =>
    json.encode(data.toJson());

class CompanyDetailModel {
  final dynamic title;
  final String? message;
  final String? status;
  final String? localizedKey;
  final Data? data;
  final int? statusCode;

  CompanyDetailModel({
    this.title,
    this.message,
    this.status,
    this.localizedKey,
    this.data,
    this.statusCode,
  });

  factory CompanyDetailModel.fromJson(Map<String, dynamic> json) =>
      CompanyDetailModel(
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
  final String? rating;
  final String? description;
  final String? workingTime;
  final String? legalEntity;
  final String? okpo;
  final List<String>? searchTags;
  final String? aboutCompany;

  Data(
      {this.id,
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
      this.rating,
      this.description,
      this.workingTime,
      this.legalEntity,
      this.okpo,
      this.searchTags,
      this.aboutCompany});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        logo: json["logo"],
        banner: json["banner"], // banner image
        phone: json["phone"],
        address: json["address"],
        verificationStatus: json["verification_status"],
        tinNumber: json["tin_number"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        owner: json["owner"] == null ? null : Owner.fromJson(json["owner"]),
        rating: json["reviews_avg_rating"], // rating
        description: json["description"],
        workingTime: json["working_time"],
        legalEntity: json["legal_entity"],
        okpo: json["okpo"],
        searchTags: json["search_tags"] == null
            ? null
            : List<String>.from(json["search_tags"].map((x) => x)),
        aboutCompany: json["about_company"],
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
        "reviews_avg_rating": rating,
        "description": description,
        "working_time": workingTime,
        "legal_entity": legalEntity,
        "okpo": okpo,
        "search_tags": searchTags,
        "about_company": aboutCompany,
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

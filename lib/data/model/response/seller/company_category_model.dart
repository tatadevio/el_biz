// To parse this JSON data, do
//
//     final companyCategoryModel = companyCategoryModelFromJson(jsonString);

import 'dart:convert';

CompanyCategoryModel companyCategoryModelFromJson(String str) => CompanyCategoryModel.fromJson(json.decode(str));

String companyCategoryModelToJson(CompanyCategoryModel data) => json.encode(data.toJson());

class CompanyCategoryModel {
  String? title;
  String? message;
  String? status;
  String? localizedKey;
  Data? data;
  int? statusCode;

  CompanyCategoryModel({
    this.title,
    this.message,
    this.status,
    this.localizedKey,
    this.data,
    this.statusCode,
  });

  factory CompanyCategoryModel.fromJson(Map<String, dynamic> json) => CompanyCategoryModel(
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
  List<CompanyCategoryItem>? items;
  int? totalPages;
  int? currentPage;
  int? total;
  int? perPage;
  int? count;

  Data({
    this.items,
    this.totalPages,
    this.currentPage,
    this.total,
    this.perPage,
    this.count,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    items: json["items"] == null ? [] : List<CompanyCategoryItem>.from(json["items"]!.map((x) => CompanyCategoryItem.fromJson(x))),
    totalPages: json["totalPages"],
    currentPage: json["currentPage"],
    total: json["total"],
    perPage: json["perPage"],
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
    "totalPages": totalPages,
    "currentPage": currentPage,
    "total": total,
    "perPage": perPage,
    "count": count,
  };
}

class CompanyCategoryItem {
  int? id;
  String? name;
  DateTime? createdAt;

  CompanyCategoryItem({
    this.id,
    this.name,
    this.createdAt,
  });

  factory CompanyCategoryItem.fromJson(Map<String, dynamic> json) => CompanyCategoryItem(
    id: json["id"],
    name: json["name"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "created_at": createdAt?.toIso8601String(),
  };
}

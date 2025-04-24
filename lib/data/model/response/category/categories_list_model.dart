// To parse this JSON data, do
//
//     final categoriesListModel = categoriesListModelFromJson(jsonString);

import 'dart:convert';

CategoriesListModel categoriesListModelFromJson(String str) =>
    CategoriesListModel.fromJson(json.decode(str));

String categoriesListModelToJson(CategoriesListModel data) =>
    json.encode(data.toJson());

class CategoriesListModel {
  final String? message;
  final Data? data;
  final int? statusCode;
  final String? status;

  CategoriesListModel({
    this.message,
    this.data,
    this.statusCode,
    this.status,
  });

  factory CategoriesListModel.fromJson(Map<String, dynamic> json) =>
      CategoriesListModel(
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
  final List<CategoryItem>? items;
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
            : List<CategoryItem>.from(
                json["items"]!.map((x) => CategoryItem.fromJson(x))),
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

class CategoryItem {
  final int? id;
  final String? name;
  final String? slug;
  final String? description;
  final String? image;
  final int? parentId;
  final String? status;

  CategoryItem({
    this.id,
    this.name,
    this.slug,
    this.description,
    this.image,
    this.parentId,
    this.status,
  });

  factory CategoryItem.fromJson(Map<String, dynamic> json) => CategoryItem(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        description: json["description"],
        image: json["image"],
        parentId: json["parent_id"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "description": description,
        "image": image,
        "parent_id": parentId,
        "status": status,
      };
}

// To parse this JSON data, do
//
//     final favoriteProductsModel = favoriteProductsModelFromJson(jsonString);

import 'dart:convert';

import 'package:el_biz/data/model/response/company/company_product_model.dart';

FavoriteProductsModel favoriteProductsModelFromJson(String str) =>
    FavoriteProductsModel.fromJson(json.decode(str));

String favoriteProductsModelToJson(FavoriteProductsModel data) =>
    json.encode(data.toJson());

class FavoriteProductsModel {
  final List<CompanyProductItem>? items;
  final int? totalPages;
  final int? currentPage;
  final int? total;
  final int? perPage;
  final int? count;

  FavoriteProductsModel({
    this.items,
    this.totalPages,
    this.currentPage,
    this.total,
    this.perPage,
    this.count,
  });

  FavoriteProductsModel copyWith({
    List<CompanyProductItem>? items,
    int? totalPages,
    int? currentPage,
    int? total,
    int? perPage,
    int? count,
  }) =>
      FavoriteProductsModel(
        items: items ?? this.items,
        totalPages: totalPages ?? this.totalPages,
        currentPage: currentPage ?? this.currentPage,
        total: total ?? this.total,
        perPage: perPage ?? this.perPage,
        count: count ?? this.count,
      );

  factory FavoriteProductsModel.fromJson(Map<String, dynamic> json) =>
      FavoriteProductsModel(
        items: json["items"] == null
            ? []
            : List<CompanyProductItem>.from(
                json["items"]!.map((x) => CompanyProductItem.fromJson(x))),
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

class User {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? image;
  final String? status;

  User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.status,
  });

  User copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? image,
    String? status,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        image: image ?? this.image,
        status: status ?? this.status,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
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

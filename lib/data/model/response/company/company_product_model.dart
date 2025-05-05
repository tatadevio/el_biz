// To parse this JSON data, do
//
//     final companyProductModel = companyProductModelFromJson(jsonString);

import 'dart:convert';

CompanyProductModel companyProductModelFromJson(String str) =>
    CompanyProductModel.fromJson(json.decode(str));

String companyProductModelToJson(CompanyProductModel data) =>
    json.encode(data.toJson());

class CompanyProductModel {
  final String? message;
  final Data? data;
  final int? statusCode;
  final String? status;

  CompanyProductModel({
    this.message,
    this.data,
    this.statusCode,
    this.status,
  });

  CompanyProductModel copyWith({
    String? message,
    Data? data,
    int? statusCode,
    String? status,
  }) =>
      CompanyProductModel(
        message: message ?? this.message,
        data: data ?? this.data,
        statusCode: statusCode ?? this.statusCode,
        status: status ?? this.status,
      );

  factory CompanyProductModel.fromJson(Map<String, dynamic> json) =>
      CompanyProductModel(
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
  final List<CompanyProductItem>? items;
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

  Data copyWith({
    List<CompanyProductItem>? items,
    int? totalPages,
    int? currentPage,
    int? total,
    int? perPage,
    int? count,
  }) =>
      Data(
        items: items ?? this.items,
        totalPages: totalPages ?? this.totalPages,
        currentPage: currentPage ?? this.currentPage,
        total: total ?? this.total,
        perPage: perPage ?? this.perPage,
        count: count ?? this.count,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        items: json["items"] == null
            ? []
            : List<CompanyProductItem>.from(json["items"]!.map((x) => CompanyProductItem.fromJson(x))),
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

class CompanyProductItem {
  final int? id;
  final String? name;
  final String? slug;
  final int? price;
  final String? quantity;
  final String? image;
  final User? user;
  final bool? isFavorite;

  CompanyProductItem({
    this.id,
    this.name,
    this.slug,
    this.price,
    this.quantity,
    this.image,
    this.user,
    this.isFavorite,
  });

  CompanyProductItem copyWith({
    int? id,
    String? name,
    String? slug,
    int? price,
    String? quantity,
    String? image,
    User? user,
    bool? isFavorite,
  }) =>
      CompanyProductItem(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        price: price ?? this.price,
        quantity: quantity ?? this.quantity,
        image: image ?? this.image,
        user: user ?? this.user,
        isFavorite: isFavorite?? this.isFavorite,
      );

  factory CompanyProductItem.fromJson(Map<String, dynamic> json) => CompanyProductItem(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        price: json["price"],
        quantity: json["quantity"],
        image: json["image"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        isFavorite: json["is_favorite"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "price": price,
        "quantity": quantity,
        "image": image,
        "user": user?.toJson(),
        "is_favorite": isFavorite,
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

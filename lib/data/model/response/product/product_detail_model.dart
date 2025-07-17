// To parse this JSON data, do
//
//     final productDetailModel = productDetailModelFromJson(jsonString);

import 'dart:convert';

import 'package:el_biz/data/model/response/company/my_companies_model.dart';

import '../chat/chat_list_model.dart';

ProductDetailModel productDetailModelFromJson(String str) =>
    ProductDetailModel.fromJson(json.decode(str));

String productDetailModelToJson(ProductDetailModel data) =>
    json.encode(data.toJson());

class ProductDetailModel {
  final String? message;
  final Data? data;
  final int? statusCode;
  final String? status;

  ProductDetailModel({
    this.message,
    this.data,
    this.statusCode,
    this.status,
  });

  ProductDetailModel copyWith({
    String? message,
    Data? data,
    int? statusCode,
    String? status,
  }) =>
      ProductDetailModel(
        message: message ?? this.message,
        data: data ?? this.data,
        statusCode: statusCode ?? this.statusCode,
        status: status ?? this.status,
      );

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) =>
      ProductDetailModel(
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
  final int? id;
  final String? name;
  final String? slug;
  final String? brand;
  final String? description;
  final int? price;
  final String? quantity;
  final int? isAvailable;
  final String? dimention;
  final String? weight;
  final String? countryOfOrigin;
  final String? searchKeywords;
  final String? material;
  final String? status;
  final int? categoryId;
  final String? categoryIds;
  final String? image;
  final List<ProductDetailImages>? images;
  final User? user;
  final CompanyItem? company;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  bool? isFavorite;
  final double? reviewAvgRating;

  Data({
    this.id,
    this.name,
    this.slug,
    this.brand,
    this.description,
    this.price,
    this.quantity,
    this.isAvailable,
    this.dimention,
    this.weight,
    this.countryOfOrigin,
    this.searchKeywords,
    this.material,
    this.status,
    this.categoryId,
    this.categoryIds,
    this.image,
    this.images,
    this.user,
    this.company,
    this.createdAt,
    this.updatedAt,
    this.isFavorite,
    this.reviewAvgRating,
  });

  Data copyWith({
    int? id,
    String? name,
    String? slug,
    String? brand,
    String? description,
    int? price,
    String? quantity,
    int? isAvailable,
    String? dimention,
    String? weight,
    String? countryOfOrigin,
    String? searchKeywords,
    String? material,
    String? status,
    int? categoryId,
    String? categoryIds,
    String? image,
    List<ProductDetailImages>? images,
    User? user,
    CompanyItem? company,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isFavorite,
    double? reviewAvgRating,
  }) =>
      Data(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        brand: brand ?? this.brand,
        description: description ?? this.description,
        price: price ?? this.price,
        quantity: quantity ?? this.quantity,
        isAvailable: isAvailable ?? this.isAvailable,
        dimention: dimention ?? this.dimention,
        weight: weight ?? this.weight,
        countryOfOrigin: countryOfOrigin ?? this.countryOfOrigin,
        searchKeywords: searchKeywords ?? this.searchKeywords,
        material: material ?? this.material,
        status: status ?? this.status,
        categoryId: categoryId ?? this.categoryId,
        categoryIds: categoryIds ?? this.categoryIds,
        image: image ?? this.image,
        images: images ?? this.images,
        user: user ?? this.user,
        company: company ?? this.company,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        isFavorite: isFavorite ?? this.isFavorite,
        reviewAvgRating: reviewAvgRating ?? this.reviewAvgRating,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        brand: json["brand"],
        description: json["description"],
        price: json["price"],
        quantity: json["quantity"],
        isAvailable: json["is_available"],
        dimention: json["dimention"],
        weight: json["weight"],
        countryOfOrigin: json["country_of_origin"],
        searchKeywords: json["search_keywords"],
        material: json["material"],
        status: json["status"],
        categoryId: json["category_id"],
        categoryIds: json["category_ids"],
        image: json["image"],
        images: json["images"] == null
            ? []
            : List<ProductDetailImages>.from(
                json["images"]!.map((x) => ProductDetailImages.fromJson(x))),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        company: json["company"] == null
            ? null
            : CompanyItem.fromJson(json["company"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        isFavorite: json["is_favorite"],
        reviewAvgRating: json["reviews_avg_rating"] == null
            ? 0
            : double.tryParse(json["reviews_avg_rating"].toString()) ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "brand": brand,
        "description": description,
        "price": price,
        "quantity": quantity,
        "is_available": isAvailable,
        "dimention": dimention,
        "weight": weight,
        "country_of_origin": countryOfOrigin,
        "search_keywords": searchKeywords,
        "material": material,
        "status": status,
        "category_id": categoryId,
        "category_ids": categoryIds,
        "image": image,
        "images": images == null
            ? []
            : List<dynamic>.from(images!.map((x) => x.toJson())),
        "user": user?.toJson(),
        "company": company?.toJson(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "is_favorite": isFavorite,
        "reviews_avg_rating": reviewAvgRating,
      };
}

// class Company {
//   final int? id;
//   final String? name;
//   final String? email;
//   final String? phone;
//   final String? logo;
//   final String? verificationStatus;
//   final User? owner;

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
//     User? owner,
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
//         owner: json["owner"] == null ? null : User.fromJson(json["owner"]),
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

// class User {
//   final int? id;
//   final String? name;
//   final String? email;
//   final String? phone;
//   final String? image;
//   final String? status;

//   User({
//     this.id,
//     this.name,
//     this.email,
//     this.phone,
//     this.image,
//     this.status,
//   });

//   User copyWith({
//     int? id,
//     String? name,
//     String? email,
//     String? phone,
//     String? image,
//     String? status,
//   }) =>
//       User(
//         id: id ?? this.id,
//         name: name ?? this.name,
//         email: email ?? this.email,
//         phone: phone ?? this.phone,
//         image: image ?? this.image,
//         status: status ?? this.status,
//       );

//   factory User.fromJson(Map<String, dynamic> json) => User(
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

class ProductDetailImages {
  final int? id;
  final String? thumb;
  final String? small;
  final String? large;

  ProductDetailImages({
    this.id,
    this.thumb,
    this.small,
    this.large,
  });

  ProductDetailImages copyWith({
    int? id,
    String? thumb,
    String? small,
    String? large,
  }) =>
      ProductDetailImages(
        id: id ?? this.id,
        thumb: thumb ?? this.thumb,
        small: small ?? this.small,
        large: large ?? this.large,
      );

  factory ProductDetailImages.fromJson(Map<String, dynamic> json) =>
      ProductDetailImages(
        id: json["id"],
        thumb: json["thumb"],
        small: json["small"],
        large: json["large"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "thumb": thumb,
        "small": small,
        "large": large,
      };
}

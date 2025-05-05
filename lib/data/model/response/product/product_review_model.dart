// To parse this JSON data, do
//
//     final productReviewsModel = productReviewsModelFromJson(jsonString);

import 'dart:convert';

ProductReviewsModel productReviewsModelFromJson(String str) =>
    ProductReviewsModel.fromJson(json.decode(str));

String productReviewsModelToJson(ProductReviewsModel data) =>
    json.encode(data.toJson());

class ProductReviewsModel {
  final dynamic title;
  final String? message;
  final String? status;
  final String? localizedKey;
  final Data? data;
  final int? statusCode;

  ProductReviewsModel({
    this.title,
    this.message,
    this.status,
    this.localizedKey,
    this.data,
    this.statusCode,
  });

  ProductReviewsModel copyWith({
    dynamic title,
    String? message,
    String? status,
    String? localizedKey,
    Data? data,
    int? statusCode,
  }) =>
      ProductReviewsModel(
        title: title ?? this.title,
        message: message ?? this.message,
        status: status ?? this.status,
        localizedKey: localizedKey ?? this.localizedKey,
        data: data ?? this.data,
        statusCode: statusCode ?? this.statusCode,
      );

  factory ProductReviewsModel.fromJson(Map<String, dynamic> json) =>
      ProductReviewsModel(
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
  final List<ProductReviewItem>? items;
  final int? totalPages;
  final int? currentPage;
  final int? total;
  final int? perPage;
  final int? count;
  final double? averageRating;
  final int? totalReviews;
  final int? total5Rating;
  final int? total4Rating;
  final int? total3Rating;
  final int? total2Rating;
  final int? total1Rating;

  Data({
    this.items,
    this.totalPages,
    this.currentPage,
    this.total,
    this.perPage,
    this.count,
    this.averageRating,
    this.totalReviews,
    this.total5Rating,
    this.total4Rating,
    this.total3Rating,
    this.total2Rating,
    this.total1Rating,
  });

  Data copyWith({
    List<ProductReviewItem>? items,
    int? totalPages,
    int? currentPage,
    int? total,
    int? perPage,
    int? count,
    double? averageRating,
    int? totalReviews,
    int? total5Rating,
    int? total4Rating,
    int? total3Rating,
    int? total2Rating,
    int? total1Rating,
  }) =>
      Data(
        items: items ?? this.items,
        totalPages: totalPages ?? this.totalPages,
        currentPage: currentPage ?? this.currentPage,
        total: total ?? this.total,
        perPage: perPage ?? this.perPage,
        count: count ?? this.count,
        averageRating: averageRating ?? this.averageRating,
        totalReviews: totalReviews ?? this.totalReviews,
        total5Rating: total5Rating ?? this.total5Rating,
        total4Rating: total4Rating ?? this.total4Rating,
        total3Rating: total3Rating ?? this.total3Rating,
        total2Rating: total2Rating ?? this.total2Rating,
        total1Rating: total1Rating ?? this.total1Rating,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        items: json["items"] == null
            ? []
            : List<ProductReviewItem>.from(
                json["items"]!.map((x) => ProductReviewItem.fromJson(x))),
        totalPages: json["totalPages"],
        currentPage: json["currentPage"],
        total: json["total"],
        perPage: json["perPage"],
        count: json["count"],
        averageRating: json["average_rating"]?.toDouble(),
        totalReviews: json["total_reviews"],
        total5Rating: json["total_5_rating"],
        total4Rating: json["total_4_rating"],
        total3Rating: json["total_3_rating"],
        total2Rating: json["total_2_rating"],
        total1Rating: json["total_1_rating"],
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
        "average_rating": averageRating,
        "total_reviews": totalReviews,
        "total_5_rating": total5Rating,
        "total_4_rating": total4Rating,
        "total_3_rating": total3Rating,
        "total_2_rating": total2Rating,
        "total_1_rating": total1Rating,
      };

  int get maximumRating {
    return [
      total1Rating ?? 0,
      total2Rating ?? 0,
      total3Rating ?? 0,
      total4Rating ?? 0,
      total5Rating ?? 0,
    ].reduce((a, b) => a > b ? a : b);
  }
}

class ProductReviewItem {
  final int? id;
  final User? user;
  final Product? product;
  final String? review;
  final int? rating;
  final int? isApproved;
  final List<String>? images;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<dynamic>? answers;

  ProductReviewItem({
    this.id,
    this.user,
    this.product,
    this.review,
    this.rating,
    this.isApproved,
    this.images,
    this.createdAt,
    this.updatedAt,
    this.answers,
  });

  ProductReviewItem copyWith({
    int? id,
    User? user,
    Product? product,
    String? review,
    int? rating,
    int? isApproved,
    List<String>? images,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<dynamic>? answers,
  }) =>
      ProductReviewItem(
        id: id ?? this.id,
        user: user ?? this.user,
        product: product ?? this.product,
        review: review ?? this.review,
        rating: rating ?? this.rating,
        isApproved: isApproved ?? this.isApproved,
        images: images ?? this.images,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        answers: answers ?? this.answers,
      );

  factory ProductReviewItem.fromJson(Map<String, dynamic> json) =>
      ProductReviewItem(
        id: json["id"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        product:
            json["product"] == null ? null : Product.fromJson(json["product"]),
        review: json["review"],
        rating: json["rating"],
        isApproved: json["is_approved"],
        images: json["images"] == null
            ? []
            : List<String>.from(json["images"]!.map((x) => x)),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        answers: json["answers"] == null
            ? []
            : List<dynamic>.from(json["answers"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user?.toJson(),
        "product": product?.toJson(),
        "review": review,
        "rating": rating,
        "is_approved": isApproved,
        "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "answers":
            answers == null ? [] : List<dynamic>.from(answers!.map((x) => x)),
      };
}

class Product {
  final int? id;
  final String? name;
  final String? slug;
  final int? price;
  final String? quantity;
  final String? image;
  final User? user;
  final bool? isFavorite;

  Product({
    this.id,
    this.name,
    this.slug,
    this.price,
    this.quantity,
    this.image,
    this.user,
    this.isFavorite,
  });

  Product copyWith({
    int? id,
    String? name,
    String? slug,
    int? price,
    String? quantity,
    String? image,
    User? user,
    bool? isFavorite,
  }) =>
      Product(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        price: price ?? this.price,
        quantity: quantity ?? this.quantity,
        image: image ?? this.image,
        user: user ?? this.user,
        isFavorite: isFavorite ?? this.isFavorite,
      );

  factory Product.fromJson(Map<String, dynamic> json) => Product(
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

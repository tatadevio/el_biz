// To parse this JSON data, do
//
//     final companyReviewsModel = companyReviewsModelFromJson(jsonString);

import 'dart:convert';

CompanyReviewsModel companyReviewsModelFromJson(String str) =>
    CompanyReviewsModel.fromJson(json.decode(str));

String companyReviewsModelToJson(CompanyReviewsModel data) =>
    json.encode(data.toJson());

class CompanyReviewsModel {
  final dynamic title;
  final String? message;
  final String? status;
  final String? localizedKey;
  final Data? data;
  final int? statusCode;

  CompanyReviewsModel({
    this.title,
    this.message,
    this.status,
    this.localizedKey,
    this.data,
    this.statusCode,
  });

  factory CompanyReviewsModel.fromJson(Map<String, dynamic> json) =>
      CompanyReviewsModel(
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
  final List<ReviewItem>? items;
  final int? totalPages;
  final int? currentPage;
  final int? total;
  final int? perPage;
  final int? count;

  final String? averageRating;
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

  int get maximumRating {
    return [
      total1Rating ?? 0,
      total2Rating ?? 0,
      total3Rating ?? 0,
      total4Rating ?? 0,
      total5Rating ?? 0,
    ].reduce((a, b) => a > b ? a : b);
  }

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        items: json["items"] == null
            ? []
            : List<ReviewItem>.from(
                json["items"]!.map((x) => ReviewItem.fromJson(x))),
        totalPages: json["totalPages"],
        currentPage: json["currentPage"],
        total: json["total"],
        perPage: json["perPage"],
        count: json["count"],
        averageRating: json["average_rating"],
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
}

class ReviewItem {
  final int? id;
  final int? rating;
  final String? review;
  final DateTime? createdAt;
  final List<Image>? images;
  final List<Reply>? reply;
  final User? user;

  ReviewItem({
    this.id,
    this.rating,
    this.review,
    this.createdAt,
    this.images,
    this.reply,
    this.user,
  });

  ReviewItem copyWith({
    int? id,
    int? rating,
    String? review,
    DateTime? createdAt,
    List<Image>? images,
    List<Reply>? reply,
    User? user,
  }) {
    return ReviewItem(
      id: id ?? this.id,
      rating: rating ?? this.rating,
      review: review ?? this.review,
      createdAt: createdAt ?? this.createdAt,
      images: images ?? this.images,
      reply: reply ?? this.reply,
      user: user ?? this.user,
    );
  }

  factory ReviewItem.fromJson(Map<String, dynamic> json) => ReviewItem(
        id: json["id"],
        rating: json["rating"],
        review: json["review"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        images: json["images"] == null
            ? []
            : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
        reply: json["reply"] == null
            ? []
            : List<Reply>.from(json["reply"]!.map((x) => Reply.fromJson(x))),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "rating": rating,
        "review": review,
        "created_at": createdAt?.toIso8601String(),
        "images": images == null
            ? []
            : List<dynamic>.from(images!.map((x) => x.toJson())),
        "reply": reply == null
            ? []
            : List<dynamic>.from(reply!.map((x) => x.toJson())),
        "user": user?.toJson(),
      };
}

class Image {
  final String? url;
  final String? thumb;

  Image({
    this.url,
    this.thumb,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        url: json["url"],
        thumb: json["thumb"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "thumb": thumb,
      };
}

class Reply {
  final int? id;
  final String? answer;
  final DateTime? createdAt;

  Reply({
    this.id,
    this.answer,
    this.createdAt,
  });

  factory Reply.fromJson(Map<String, dynamic> json) => Reply(
        id: json["id"],
        answer: json["answer"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "answer": answer,
        "created_at": createdAt?.toIso8601String(),
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

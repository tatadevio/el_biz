// To parse this JSON data, do
//
//     final postDetailModel = postDetailModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

PostDetailModel postDetailModelFromJson(String str) => PostDetailModel.fromJson(json.decode(str));

String postDetailModelToJson(PostDetailModel data) => json.encode(data.toJson());

class PostDetailModel {
  PostDetailModel({
    required this.message,
    required this.data,
    required this.statusCode,
    required this.status,
  });

  String message;
  Data data;
  int statusCode;
  String status;

  factory PostDetailModel.fromJson(Map<String, dynamic> json) => PostDetailModel(
    message: json["message"],
    data: Data.fromJson(json["data"]),
    statusCode: json["status_code"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data.toJson(),
    "status_code": statusCode,
    "status": status,
  };
}

class Data {
  Data({
    required this.id,
    required this.title,
    required this.image,
    required this.description,
    required this.totalLike,
    required this.viewsCount,
    required this.currentUserLike,
    required this.createdAt,
  });

  int id;
  String title;
  String image;
  String description;
  int totalLike;
  int viewsCount;
  int currentUserLike;
  DateTime createdAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    title: json["title"],
    image: json["image"],
    description: json["description"],
    totalLike: json["total_like"],
    viewsCount: json["views_count"],
    currentUserLike: json["current_user_like"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "image": image,
    "description": description,
    "total_like": totalLike,
    "views_count": viewsCount,
    "current_user_like": currentUserLike,
    "created_at": "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
  };
}

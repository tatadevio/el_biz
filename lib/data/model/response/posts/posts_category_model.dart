// // To parse this JSON data, do
// //
// //     final postsCategoryModel = postsCategoryModelFromJson(jsonString);

// import 'package:meta/meta.dart';
// import 'dart:convert';

// PostsCategoryModel postsCategoryModelFromJson(String str) => PostsCategoryModel.fromJson(json.decode(str));

// String postsCategoryModelToJson(PostsCategoryModel data) => json.encode(data.toJson());

// class PostsCategoryModel {
//   PostsCategoryModel({
//     required this.message,
//     required this.data,
//     required this.statusCode,
//     required this.status,
//   });

//   String message;
//   Data data;
//   int statusCode;
//   String status;

//   factory PostsCategoryModel.fromJson(Map<String, dynamic> json) => PostsCategoryModel(
//     message: json["message"],
//     data: Data.fromJson(json["data"]),
//     statusCode: json["status_code"],
//     status: json["status"],
//   );

//   Map<String, dynamic> toJson() => {
//     "message": message,
//     "data": data.toJson(),
//     "status_code": statusCode,
//     "status": status,
//   };
// }

// class Data {
//   Data({
//     required this.items,
//     required this.totalPages,
//     required this.currentPage,
//     required this.total,
//     required this.perPage,
//     required this.count,
//   });

//   List<PostsCategoryItem> items;
//   int totalPages;
//   int currentPage;
//   int total;
//   int perPage;
//   int count;

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//     items: List<PostsCategoryItem>.from(json["items"].map((x) => PostsCategoryItem.fromJson(x))),
//     totalPages: json["totalPages"],
//     currentPage: json["currentPage"],
//     total: json["total"],
//     perPage: json["perPage"],
//     count: json["count"],
//   );

//   Map<String, dynamic> toJson() => {
//     "items": List<dynamic>.from(items.map((x) => x.toJson())),
//     "totalPages": totalPages,
//     "currentPage": currentPage,
//     "total": total,
//     "perPage": perPage,
//     "count": count,
//   };
// }

// class PostsCategoryItem {
//   PostsCategoryItem({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.image,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   int id;
//   String name;
//   String description;
//   String image;
//   DateTime createdAt;
//   DateTime updatedAt;

//   factory PostsCategoryItem.fromJson(Map<String, dynamic> json) => PostsCategoryItem(
//     id: json["id"],
//     name: json["name"],
//     description: json["description"],
//     image: json["image"]??"",
//     createdAt: DateTime.parse(json["created_at"]),
//     updatedAt: DateTime.parse(json["updated_at"]),
//   );

//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "description": description,
//     "image": image,
//     "created_at": "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
//     "updated_at": updatedAt.toIso8601String(),
//   };
// }

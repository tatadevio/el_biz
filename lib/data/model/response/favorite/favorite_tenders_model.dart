// To parse this JSON data, do
//
//     final favoriteTendersModel = favoriteTendersModelFromJson(jsonString);

import 'dart:convert';

import 'package:el_biz/data/model/response/tender/tender_item_model.dart';

FavoriteTendersModel favoriteTendersModelFromJson(String str) =>
    FavoriteTendersModel.fromJson(json.decode(str));

String favoriteTendersModelToJson(FavoriteTendersModel data) =>
    json.encode(data.toJson());

class FavoriteTendersModel {
  final List<TenderItem>? items;
  final int? totalPages;
  final int? currentPage;
  final int? total;
  final int? perPage;
  final int? count;

  FavoriteTendersModel({
    this.items,
    this.totalPages,
    this.currentPage,
    this.total,
    this.perPage,
    this.count,
  });

  FavoriteTendersModel copyWith({
    List<TenderItem>? items,
    int? totalPages,
    int? currentPage,
    int? total,
    int? perPage,
    int? count,
  }) =>
      FavoriteTendersModel(
        items: items ?? this.items,
        totalPages: totalPages ?? this.totalPages,
        currentPage: currentPage ?? this.currentPage,
        total: total ?? this.total,
        perPage: perPage ?? this.perPage,
        count: count ?? this.count,
      );

  factory FavoriteTendersModel.fromJson(Map<String, dynamic> json) =>
      FavoriteTendersModel(
        items: json["items"] == null
            ? []
            : List<TenderItem>.from(json["items"]!.map((x) => TenderItem.fromJson(x))),
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

// class Item {
//   final int? id;
//   final String? title;
//   final String? description;
//   final String? status;
//   final String? activeStatus;
//   final int? budgetFrom;
//   final int? budgetTo;
//   final String? location;
//   final int? quantity;
//   final DateTime? createdAt;
//   final bool? isFavorite;

//   Item({
//     this.id,
//     this.title,
//     this.description,
//     this.status,
//     this.activeStatus,
//     this.budgetFrom,
//     this.budgetTo,
//     this.location,
//     this.quantity,
//     this.createdAt,
//     this.isFavorite,
//   });

//   Item copyWith({
//     int? id,
//     String? title,
//     String? description,
//     String? status,
//     String? activeStatus,
//     int? budgetFrom,
//     int? budgetTo,
//     String? location,
//     int? quantity,
//     DateTime? createdAt,
//     bool? isFavorite,
//   }) =>
//       Item(
//         id: id ?? this.id,
//         title: title ?? this.title,
//         description: description ?? this.description,
//         status: status ?? this.status,
//         activeStatus: activeStatus ?? this.activeStatus,
//         budgetFrom: budgetFrom ?? this.budgetFrom,
//         budgetTo: budgetTo ?? this.budgetTo,
//         location: location ?? this.location,
//         quantity: quantity ?? this.quantity,
//         createdAt: createdAt ?? this.createdAt,
//         isFavorite: isFavorite ?? this.isFavorite,
//       );

//   factory Item.fromJson(Map<String, dynamic> json) => Item(
//         id: json["id"],
//         title: json["title"],
//         description: json["description"],
//         status: json["status"],
//         activeStatus: json["active_status"],
//         budgetFrom: json["budget_from"],
//         budgetTo: json["budget_to"],
//         location: json["location"],
//         quantity: json["quantity"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         isFavorite: json["is_favorite"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "title": title,
//         "description": description,
//         "status": status,
//         "active_status": activeStatus,
//         "budget_from": budgetFrom,
//         "budget_to": budgetTo,
//         "location": location,
//         "quantity": quantity,
//         "created_at": createdAt?.toIso8601String(),
//         "is_favorite": isFavorite,
//       };
// }

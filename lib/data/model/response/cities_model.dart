// To parse this JSON data, do
//
//     final citesModel = citesModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

CitesModel citesModelFromJson(String str) => CitesModel.fromJson(json.decode(str));

String citesModelToJson(CitesModel data) => json.encode(data.toJson());

class CitesModel {
  CitesModel({
    required this.title,
    required this.message,
    required this.status,
    required this.localizedKey,
    required this.data,
    required this.statusCode,
  });

  String title;
  String message;
  String status;
  String localizedKey;
  Data data;
  int statusCode;

  factory CitesModel.fromJson(Map<String, dynamic> json) => CitesModel(
    title: json["title"],
    message: json["message"],
    status: json["status"],
    localizedKey: json["localized_key"],
    data: Data.fromJson(json["data"]),
    statusCode: json["status_code"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "message": message,
    "status": status,
    "localized_key": localizedKey,
    "data": data.toJson(),
    "status_code": statusCode,
  };
}

class Data {
  Data({
    required this.items,
    required this.totalPages,
    required this.currentPage,
    required this.total,
    required this.perPage,
    required this.count,
  });

  List<CityItem> items;
  int totalPages;
  int currentPage;
  int total;
  int perPage;
  int count;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    items: List<CityItem>.from(json["items"].map((x) => CityItem.fromJson(x))),
    totalPages: json["totalPages"],
    currentPage: json["currentPage"],
    total: json["total"],
    perPage: json["perPage"],
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "totalPages": totalPages,
    "currentPage": currentPage,
    "total": total,
    "perPage": perPage,
    "count": count,
  };
}

class CityItem {
  CityItem({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
  });

  int id;
  String name;
  String latitude;
  String longitude;
  DateTime createdAt;

  factory CityItem.fromJson(Map<String, dynamic> json) => CityItem(
    id: json["id"],
    name: json["name"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "latitude": latitude,
    "longitude": longitude,
    "created_at": createdAt.toIso8601String(),
  };
}

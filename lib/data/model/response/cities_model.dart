// To parse this JSON data, do
//
//     final citiesModel = citiesModelFromJson(jsonString);

import 'dart:convert';

CitiesModel citiesModelFromJson(String str) =>
    CitiesModel.fromJson(json.decode(str));

String citiesModelToJson(CitiesModel data) => json.encode(data.toJson());

class CitiesModel {
  final dynamic title;
  final String? message;
  final String? status;
  final String? localizedKey;
  final Data? data;
  final int? statusCode;

  CitiesModel({
    this.title,
    this.message,
    this.status,
    this.localizedKey,
    this.data,
    this.statusCode,
  });

  CitiesModel copyWith({
    dynamic title,
    String? message,
    String? status,
    String? localizedKey,
    Data? data,
    int? statusCode,
  }) =>
      CitiesModel(
        title: title ?? this.title,
        message: message ?? this.message,
        status: status ?? this.status,
        localizedKey: localizedKey ?? this.localizedKey,
        data: data ?? this.data,
        statusCode: statusCode ?? this.statusCode,
      );

  factory CitiesModel.fromJson(Map<String, dynamic> json) => CitiesModel(
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
  final List<CityItem>? items;
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
    List<CityItem>? items,
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
            : List<CityItem>.from(json["items"]!.map((x) => CityItem.fromJson(x))),
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

class CityItem {
  final int? id;
  final String? name;

  CityItem({
    this.id,
    this.name,
  });

  CityItem copyWith({
    int? id,
    String? name,
  }) =>
      CityItem(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory CityItem.fromJson(Map<String, dynamic> json) => CityItem(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

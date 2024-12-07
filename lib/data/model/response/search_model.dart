// To parse this JSON data, do
//
//     final searchResultModel = searchResultModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SearchResultModel searchResultModelFromJson(String str) => SearchResultModel.fromJson(json.decode(str));

String searchResultModelToJson(SearchResultModel data) => json.encode(data.toJson());

class SearchResultModel {
  SearchResultModel({
    required this.message,
    required this.data,
    required this.statusCode,
    required this.status,
  });

  String message;
  Data data;
  int statusCode;
  String status;

  factory SearchResultModel.fromJson(Map<String, dynamic> json) => SearchResultModel(
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
    required this.items,
    required this.totalPages,
    required this.currentPage,
    required this.total,
    required this.perPage,
    required this.count,
  });

  List<SearchItem> items;
  int totalPages;
  int currentPage;
  int total;
  int perPage;
  int count;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    items: List<SearchItem>.from(json["items"].map((x) => SearchItem.fromJson(x))),
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

class SearchItem {
  SearchItem({
    required this.id,
    required this.title,
    required this.query,
    required this.type,
  });

  int id;
  String title;
  String query;
  int type;

  factory SearchItem.fromJson(Map<String, dynamic> json) => SearchItem(
    id: json["id"],
    title: json["title"],
    query: json["query"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "query": query,
    "type": type,
  };
}

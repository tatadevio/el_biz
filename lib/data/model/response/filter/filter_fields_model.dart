// To parse this JSON data, do
//
//     final filterFieldsModel = filterFieldsModelFromJson(jsonString);

import 'dart:convert';

FilterFieldsModel filterFieldsModelFromJson(String str) =>
    FilterFieldsModel.fromJson(json.decode(str));

String filterFieldsModelToJson(FilterFieldsModel data) =>
    json.encode(data.toJson());

class FilterFieldsModel {
  final String? message;
  final Data? data;
  final int? statusCode;
  final String? status;

  FilterFieldsModel({
    this.message,
    this.data,
    this.statusCode,
    this.status,
  });

  FilterFieldsModel copyWith({
    String? message,
    Data? data,
    int? statusCode,
    String? status,
  }) =>
      FilterFieldsModel(
        message: message ?? this.message,
        data: data ?? this.data,
        statusCode: statusCode ?? this.statusCode,
        status: status ?? this.status,
      );

  factory FilterFieldsModel.fromJson(Map<String, dynamic> json) =>
      FilterFieldsModel(
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
  final List<SearchTag>? searchTags;
  final List<String>? dimentions;

  Data({
    this.searchTags,
    this.dimentions,
  });

  Data copyWith({
    List<SearchTag>? searchTags,
    List<String>? dimentions,
  }) =>
      Data(
        searchTags: searchTags ?? this.searchTags,
        dimentions: dimentions ?? this.dimentions,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        searchTags: json["search_tags"] == null
            ? []
            : List<SearchTag>.from(
                json["search_tags"]!.map((x) => SearchTag.fromJson(x))),
        dimentions: json["dimentions"] == null
            ? []
            : List<String>.from(json["dimentions"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "search_tags": searchTags == null
            ? []
            : List<dynamic>.from(searchTags!.map((x) => x.toJson())),
        "dimentions": dimentions == null
            ? []
            : List<dynamic>.from(dimentions!.map((x) => x)),
      };
}

class SearchTag {
  final String? searchKeywords;

  SearchTag({
    this.searchKeywords,
  });

  SearchTag copyWith({
    String? searchKeywords,
  }) =>
      SearchTag(
        searchKeywords: searchKeywords ?? this.searchKeywords,
      );

  factory SearchTag.fromJson(Map<String, dynamic> json) => SearchTag(
        searchKeywords: json["search_keywords"],
      );

  Map<String, dynamic> toJson() => {
        "search_keywords": searchKeywords,
      };
}

// To parse this JSON data, do
//
//     final companyAuctionsModel = companyAuctionsModelFromJson(jsonString);

import 'dart:convert';

import 'package:el_biz/data/model/response/auction/auctions_list_model.dart';

CompanyAuctionsModel companyAuctionsModelFromJson(String str) =>
    CompanyAuctionsModel.fromJson(json.decode(str));

String companyAuctionsModelToJson(CompanyAuctionsModel data) =>
    json.encode(data.toJson());

class CompanyAuctionsModel {
  final String? message;
  final String? status;
  final String? localizedKey;
  final CompanyAuctionsData? data;
  final int? statusCode;

  CompanyAuctionsModel({
    this.message,
    this.status,
    this.localizedKey,
    this.data,
    this.statusCode,
  });

  CompanyAuctionsModel copyWith({
    String? message,
    String? status,
    String? localizedKey,
    CompanyAuctionsData? data,
    int? statusCode,
  }) =>
      CompanyAuctionsModel(
        message: message ?? this.message,
        status: status ?? this.status,
        localizedKey: localizedKey ?? this.localizedKey,
        data: data ?? this.data,
        statusCode: statusCode ?? this.statusCode,
      );

  factory CompanyAuctionsModel.fromJson(Map<String, dynamic> json) =>
      CompanyAuctionsModel(
        message: json["message"],
        status: json["status"],
        localizedKey: json["localized_key"],
        data: json["data"] == null ? null : CompanyAuctionsData.fromJson(json["data"]),
        statusCode: json["status_code"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "localized_key": localizedKey,
        "data": data?.toJson(),
        "status_code": statusCode,
      };
}

class CompanyAuctionsData {
  final List<AuctionListItem>? items;
  final int? totalPages;
  final int? currentPage;
  final int? total;
  final int? perPage;
  final int? count;

  CompanyAuctionsData({
    this.items,
    this.totalPages,
    this.currentPage,
    this.total,
    this.perPage,
    this.count,
  });

  CompanyAuctionsData copyWith({
    List<AuctionListItem>? items,
    int? totalPages,
    int? currentPage,
    int? total,
    int? perPage,
    int? count,
  }) =>
      CompanyAuctionsData(
        items: items ?? this.items,
        totalPages: totalPages ?? this.totalPages,
        currentPage: currentPage ?? this.currentPage,
        total: total ?? this.total,
        perPage: perPage ?? this.perPage,
        count: count ?? this.count,
      );

  factory CompanyAuctionsData.fromJson(Map<String, dynamic> json) => CompanyAuctionsData(
        items: json["items"] == null
            ? []
            : List<AuctionListItem>.from(json["items"]!.map((x) => AuctionListItem.fromJson(x))),
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


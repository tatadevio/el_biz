// To parse this JSON data, do
//
//     final mySalesModel = mySalesModelFromJson(jsonString);

import 'dart:convert';

import 'package:el_biz/data/model/response/company/my_companies_model.dart';

MySalesModel mySalesModelFromJson(String str) =>
    MySalesModel.fromJson(json.decode(str));

String mySalesModelToJson(MySalesModel data) => json.encode(data.toJson());

class MySalesModel {
  final String? message;
  final String? status;
  final String? localizedKey;
  final Data? data;
  final int? statusCode;

  MySalesModel({
    this.message,
    this.status,
    this.localizedKey,
    this.data,
    this.statusCode,
  });

  MySalesModel copyWith({
    String? message,
    String? status,
    String? localizedKey,
    Data? data,
    int? statusCode,
  }) =>
      MySalesModel(
        message: message ?? this.message,
        status: status ?? this.status,
        localizedKey: localizedKey ?? this.localizedKey,
        data: data ?? this.data,
        statusCode: statusCode ?? this.statusCode,
      );

  factory MySalesModel.fromJson(Map<String, dynamic> json) => MySalesModel(
        message: json["message"],
        status: json["status"],
        localizedKey: json["localized_key"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
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

class Data {
  final List<CompanyItem>? items;
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
    List<CompanyItem>? items,
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
            : List<CompanyItem>.from(
                json["items"]!.map((x) => CompanyItem.fromJson(x))),
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

class Owner {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? image;
  final String? status;
  final String? fcmToken;

  Owner({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.status,
    this.fcmToken,
  });

  Owner copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? image,
    String? status,
    String? fcmToken,
  }) =>
      Owner(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        image: image ?? this.image,
        status: status ?? this.status,
        fcmToken: fcmToken ?? this.fcmToken,
      );

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        image: json["image"],
        status: json["status"],
        fcmToken: json["fcm_token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "image": image,
        "status": status,
        "fcm_token": fcmToken,
      };
}

// To parse this JSON data, do
//
//     final myAccountsModel = myAccountsModelFromJson(jsonString);

import 'dart:convert';

MyAccountsModel myAccountsModelFromJson(String str) =>
    MyAccountsModel.fromJson(json.decode(str));

String myAccountsModelToJson(MyAccountsModel data) =>
    json.encode(data.toJson());

class MyAccountsModel {
  final dynamic title;
  final String? message;
  final String? status;
  final String? localizedKey;
  final Data? data;
  final int? statusCode;

  MyAccountsModel({
    this.title,
    this.message,
    this.status,
    this.localizedKey,
    this.data,
    this.statusCode,
  });

  factory MyAccountsModel.fromJson(Map<String, dynamic> json) =>
      MyAccountsModel(
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
  final List<AccountItem>? items;
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        items: json["items"] == null
            ? []
            : List<AccountItem>.from(
                json["items"]!.map((x) => AccountItem.fromJson(x))),
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

class AccountItem {
  final int? id;
  final String? accountName;
  final String? accountNumber;
  final String? bic;
  final int? primaryAccount;

  AccountItem({
    this.id,
    this.accountName,
    this.accountNumber,
    this.bic,
    this.primaryAccount,
  });

  factory AccountItem.fromJson(Map<String, dynamic> json) => AccountItem(
        id: json["id"],
        accountName: json["account_name"],
        accountNumber: json["account_number"],
        bic: json["bic"],
        primaryAccount: json["primary_account"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "account_name": accountName,
        "account_number": accountNumber,
        "bic": bic,
        "primary_account": primaryAccount,
      };

  AccountItem copyWith({
    int? id,
    String? accountName,
    String? accountNumber,
    String? bic,
    int? primaryAccount,
  }) {
    return AccountItem(
      id: id ?? this.id,
      accountName: accountName ?? this.accountName,
      accountNumber: accountNumber ?? this.accountNumber,
      bic: bic ?? this.bic,
      primaryAccount: primaryAccount ?? this.primaryAccount,
    );
  }
}

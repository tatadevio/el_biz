// To parse this JSON data, do
//
//     final bankModel = bankModelFromJson(jsonString);

import 'dart:convert';

BankModel bankModelFromJson(String str) => BankModel.fromJson(json.decode(str));

String bankModelToJson(BankModel data) => json.encode(data.toJson());

class BankModel {
  BankModel({
    required this.message,
    required this.data,
    required this.statusCode,
    required this.status,
  });

  String message;
  Data data;
  int statusCode;
  String status;

  factory BankModel.fromJson(Map<String, dynamic> json) => BankModel(
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

  List<BankItem> items;
  int totalPages;
  int currentPage;
  int total;
  int perPage;
  int count;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    items: List<BankItem>.from(json["items"].map((x) => BankItem.fromJson(x))),
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

class BankItem {
  BankItem({
    required this.id,
    required this.bankName,
    required this.accountName,
    required this.accountNumber,
    required this.image,
  });

  int id;
  String bankName;
  String accountName;
  String accountNumber;
  String image;

  factory BankItem.fromJson(Map<String, dynamic> json) => BankItem(
    id: json["id"],
    bankName: json["branch_name"],
    accountName: json["account_name"],
    accountNumber: json["account_number"],
    image: json["image"]??"",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "branch_name": bankName,
    "account_name": accountName,
    "account_number": accountNumber,
    "image": image,
  };
}

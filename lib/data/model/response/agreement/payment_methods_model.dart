// To parse this JSON data, do
//
//     final paymentMethodsModel = paymentMethodsModelFromJson(jsonString);

import 'dart:convert';

PaymentMethodsModel paymentMethodsModelFromJson(String str) =>
    PaymentMethodsModel.fromJson(json.decode(str));

String paymentMethodsModelToJson(PaymentMethodsModel data) =>
    json.encode(data.toJson());

class PaymentMethodsModel {
  final String? title;
  final String? message;
  final String? status;
  final String? localizedKey;
  final Data? data;
  final int? statusCode;

  PaymentMethodsModel({
    this.title,
    this.message,
    this.status,
    this.localizedKey,
    this.data,
    this.statusCode,
  });

  PaymentMethodsModel copyWith({
    String? title,
    String? message,
    String? status,
    String? localizedKey,
    Data? data,
    int? statusCode,
  }) =>
      PaymentMethodsModel(
        title: title ?? this.title,
        message: message ?? this.message,
        status: status ?? this.status,
        localizedKey: localizedKey ?? this.localizedKey,
        data: data ?? this.data,
        statusCode: statusCode ?? this.statusCode,
      );

  factory PaymentMethodsModel.fromJson(Map<String, dynamic> json) =>
      PaymentMethodsModel(
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
  final List<PaymentMethod>? items;
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
    List<PaymentMethod>? items,
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
            : List<PaymentMethod>.from(json["items"]!.map((x) => PaymentMethod.fromJson(x))),
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

class PaymentMethod {
  final int? id;
  final String? name;
  final String? type;
  final String? description;
  final bool? isDefault;
  final String? image;
  final int? nsp;

  PaymentMethod({
    this.id,
    this.name,
    this.type,
    this.description,
    this.isDefault,
    this.image,
    this.nsp,
  });

  PaymentMethod copyWith({
    int? id,
    String? name,
    String? type,
    String? description,
    bool? isDefault,
    String? image,
    int? nsp,
  }) =>
      PaymentMethod(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
        description: description ?? this.description,
        isDefault: isDefault ?? this.isDefault,
        image: image ?? this.image,
        nsp: nsp ?? this.nsp,
      );

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        description: json["description"],
        isDefault: json["is_default"],
        image: json["image"],
        nsp: json["nsp"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "description": description,
        "is_default": isDefault,
        "image": image,
        "nsp": nsp,
      };
}

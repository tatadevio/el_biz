// To parse this JSON data, do
//
//     final getBuyOfferModel = getBuyOfferModelFromJson(jsonString);

import 'dart:convert';

GetBuyOfferModel getBuyOfferModelFromJson(String str) =>
    GetBuyOfferModel.fromJson(json.decode(str));

String getBuyOfferModelToJson(GetBuyOfferModel data) =>
    json.encode(data.toJson());

class GetBuyOfferModel {
  final bool? success;
  final List<BuyOfferData>? data;

  GetBuyOfferModel({
    this.success,
    this.data,
  });

  GetBuyOfferModel copyWith({
    bool? success,
    List<BuyOfferData>? data,
  }) =>
      GetBuyOfferModel(
        success: success ?? this.success,
        data: data ?? this.data,
      );

  factory GetBuyOfferModel.fromJson(Map<String, dynamic> json) =>
      GetBuyOfferModel(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<BuyOfferData>.from(
                json["data"]!.map((x) => BuyOfferData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class BuyOfferData {
  final int? id;
  final Company? user;
  final Company? company;
  final String? offerPrice;
  final String? message;
  final String? status;
  final String? sellerMessage;
  final String? respondedAt;
  final String? expiresAt;
  final String? createdAt;

  BuyOfferData({
    this.id,
    this.user,
    this.company,
    this.offerPrice,
    this.message,
    this.status,
    this.sellerMessage,
    this.respondedAt,
    this.expiresAt,
    this.createdAt,
  });

  BuyOfferData copyWith({
    int? id,
    Company? user,
    Company? company,
    String? offerPrice,
    String? message,
    String? status,
    String? sellerMessage,
    String? respondedAt,
    String? expiresAt,
    String? createdAt,
  }) =>
      BuyOfferData(
        id: id ?? this.id,
        user: user ?? this.user,
        company: company ?? this.company,
        offerPrice: offerPrice ?? this.offerPrice,
        message: message ?? this.message,
        status: status ?? this.status,
        sellerMessage: sellerMessage ?? this.sellerMessage,
        respondedAt: respondedAt ?? this.respondedAt,
        expiresAt: expiresAt ?? this.expiresAt,
        createdAt: createdAt ?? this.createdAt,
      );

  factory BuyOfferData.fromJson(Map<String, dynamic> json) => BuyOfferData(
        id: json["id"],
        user: json["user"] == null ? null : Company.fromJson(json["user"]),
        company:
            json["company"] == null ? null : Company.fromJson(json["company"]),
        offerPrice: json["offer_price"],
        message: json["message"],
        status: json["status"],
        sellerMessage: json["seller_message"],
        respondedAt: json["responded_at"],
        expiresAt: json["expires_at"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user?.toJson(),
        "company": company?.toJson(),
        "offer_price": offerPrice,
        "message": message,
        "status": status,
        "seller_message": sellerMessage,
        "responded_at": respondedAt,
        "expires_at": expiresAt,
        "created_at": createdAt,
      };
}

class Company {
  final int? id;
  final String? name;

  Company({
    this.id,
    this.name,
  });

  Company copyWith({
    int? id,
    String? name,
  }) =>
      Company(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

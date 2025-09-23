// To parse this JSON data, do
//
//     final auctionBidsModel = auctionBidsModelFromJson(jsonString);

import 'dart:convert';

AuctionBidsModel auctionBidsModelFromJson(String str) =>
    AuctionBidsModel.fromJson(json.decode(str));

String auctionBidsModelToJson(AuctionBidsModel data) =>
    json.encode(data.toJson());

class AuctionBidsModel {
  final String? message;
  final String? status;
  final String? localizedKey;
  final AuctionBidsData? data;
  final int? statusCode;

  AuctionBidsModel({
    this.message,
    this.status,
    this.localizedKey,
    this.data,
    this.statusCode,
  });

  AuctionBidsModel copyWith({
    String? message,
    String? status,
    String? localizedKey,
    AuctionBidsData? data,
    int? statusCode,
  }) =>
      AuctionBidsModel(
        message: message ?? this.message,
        status: status ?? this.status,
        localizedKey: localizedKey ?? this.localizedKey,
        data: data ?? this.data,
        statusCode: statusCode ?? this.statusCode,
      );

  factory AuctionBidsModel.fromJson(Map<String, dynamic> json) =>
      AuctionBidsModel(
        message: json["message"],
        status: json["status"],
        localizedKey: json["localized_key"],
        data: json["data"] == null
            ? null
            : AuctionBidsData.fromJson(json["data"]),
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

class AuctionBidsData {
  final List<AuctionBidItem>? items;
  final int? totalPages;
  final int? currentPage;
  final int? total;
  final int? perPage;
  final int? count;

  AuctionBidsData({
    this.items,
    this.totalPages,
    this.currentPage,
    this.total,
    this.perPage,
    this.count,
  });

  AuctionBidsData copyWith({
    List<AuctionBidItem>? items,
    int? totalPages,
    int? currentPage,
    int? total,
    int? perPage,
    int? count,
  }) =>
      AuctionBidsData(
        items: items ?? this.items,
        totalPages: totalPages ?? this.totalPages,
        currentPage: currentPage ?? this.currentPage,
        total: total ?? this.total,
        perPage: perPage ?? this.perPage,
        count: count ?? this.count,
      );

  factory AuctionBidsData.fromJson(Map<String, dynamic> json) =>
      AuctionBidsData(
        items: json["items"] == null
            ? []
            : List<AuctionBidItem>.from(
                json["items"]!.map((x) => AuctionBidItem.fromJson(x))),
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

class AuctionBidItem {
  final int? id;
  final int? auctionId;
  final String? bidAmount;
  final String? totalPrice;
  final String? previousTotalPrice;
  final String? status;
  final String? percentageIncrease;
  final bool? isCancellable;
  final bool? isOutbid;
  final String? timeSinceBid;
  final dynamic cancelledAt;
  final dynamic outbidAt;
  final User? user;
  final dynamic company;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  AuctionBidItem({
    this.id,
    this.auctionId,
    this.bidAmount,
    this.totalPrice,
    this.previousTotalPrice,
    this.status,
    this.percentageIncrease,
    this.isCancellable,
    this.isOutbid,
    this.timeSinceBid,
    this.cancelledAt,
    this.outbidAt,
    this.user,
    this.company,
    this.createdAt,
    this.updatedAt,
  });

  AuctionBidItem copyWith({
    int? id,
    int? auctionId,
    String? bidAmount,
    String? totalPrice,
    String? previousTotalPrice,
    String? status,
    String? percentageIncrease,
    bool? isCancellable,
    bool? isOutbid,
    String? timeSinceBid,
    dynamic cancelledAt,
    dynamic outbidAt,
    User? user,
    dynamic company,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      AuctionBidItem(
        id: id ?? this.id,
        auctionId: auctionId ?? this.auctionId,
        bidAmount: bidAmount ?? this.bidAmount,
        totalPrice: totalPrice ?? this.totalPrice,
        previousTotalPrice: previousTotalPrice ?? this.previousTotalPrice,
        status: status ?? this.status,
        percentageIncrease: percentageIncrease ?? this.percentageIncrease,
        isCancellable: isCancellable ?? this.isCancellable,
        isOutbid: isOutbid ?? this.isOutbid,
        timeSinceBid: timeSinceBid ?? this.timeSinceBid,
        cancelledAt: cancelledAt ?? this.cancelledAt,
        outbidAt: outbidAt ?? this.outbidAt,
        user: user ?? this.user,
        company: company ?? this.company,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory AuctionBidItem.fromJson(Map<String, dynamic> json) => AuctionBidItem(
        id: json["id"],
        auctionId: json["auction_id"],
        bidAmount: json["bid_amount"],
        totalPrice: json["total_price"],
        previousTotalPrice: json["previous_total_price"],
        status: json["status"],
        percentageIncrease: json["percentage_increase"].toString(),
        isCancellable: json["is_cancellable"],
        isOutbid: json["is_outbid"],
        timeSinceBid: json["time_since_bid"],
        cancelledAt: json["cancelled_at"],
        outbidAt: json["outbid_at"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        company: json["company"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "auction_id": auctionId,
        "bid_amount": bidAmount,
        "total_price": totalPrice,
        "previous_total_price": previousTotalPrice,
        "status": status,
        "percentage_increase": percentageIncrease,
        "is_cancellable": isCancellable,
        "is_outbid": isOutbid,
        "time_since_bid": timeSinceBid,
        "cancelled_at": cancelledAt,
        "outbid_at": outbidAt,
        "user": user?.toJson(),
        "company": company,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class User {
  final int? id;
  final String? name;

  User({
    this.id,
    this.name,
  });

  User copyWith({
    int? id,
    String? name,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

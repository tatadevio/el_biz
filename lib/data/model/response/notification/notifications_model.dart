// To parse this JSON data, do
//
//     final notificationsModel = notificationsModelFromJson(jsonString);

import 'dart:convert';

NotificationsModel notificationsModelFromJson(String str) =>
    NotificationsModel.fromJson(json.decode(str));

String notificationsModelToJson(NotificationsModel data) =>
    json.encode(data.toJson());

class NotificationsModel {
  final String? message;
  final NotificationsModelData? data;
  final int? statusCode;
  final String? status;

  NotificationsModel({
    this.message,
    this.data,
    this.statusCode,
    this.status,
  });

  NotificationsModel copyWith({
    String? message,
    NotificationsModelData? data,
    int? statusCode,
    String? status,
  }) =>
      NotificationsModel(
        message: message ?? this.message,
        data: data ?? this.data,
        statusCode: statusCode ?? this.statusCode,
        status: status ?? this.status,
      );

  factory NotificationsModel.fromJson(Map<String, dynamic> json) =>
      NotificationsModel(
        message: json["message"],
        data: json["data"] == null
            ? null
            : NotificationsModelData.fromJson(json["data"]),
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

class NotificationsModelData {
  final List<NotificationItem>? items;
  final int? totalPages;
  final int? currentPage;
  final int? total;
  final int? perPage;
  final int? count;

  NotificationsModelData({
    this.items,
    this.totalPages,
    this.currentPage,
    this.total,
    this.perPage,
    this.count,
  });

  NotificationsModelData copyWith({
    List<NotificationItem>? items,
    int? totalPages,
    int? currentPage,
    int? total,
    int? perPage,
    int? count,
  }) =>
      NotificationsModelData(
        items: items ?? this.items,
        totalPages: totalPages ?? this.totalPages,
        currentPage: currentPage ?? this.currentPage,
        total: total ?? this.total,
        perPage: perPage ?? this.perPage,
        count: count ?? this.count,
      );

  factory NotificationsModelData.fromJson(Map<String, dynamic> json) =>
      NotificationsModelData(
        items: json["items"] == null
            ? []
            : List<NotificationItem>.from(
                json["items"]!.map((x) => NotificationItem.fromJson(x))),
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

class NotificationItem {
  final int? id;
  final String? title;
  final String? body;
  final String? type;
  final ItemData? data;
  final bool? isRead;
  final String? readAt;
  final int? userId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? timeAgo;

  NotificationItem({
    this.id,
    this.title,
    this.body,
    this.type,
    this.data,
    this.isRead,
    this.readAt,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.timeAgo,
  });

  NotificationItem copyWith({
    int? id,
    String? title,
    String? body,
    String? type,
    ItemData? data,
    bool? isRead,
    String? readAt,
    int? userId,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? timeAgo,
  }) =>
      NotificationItem(
        id: id ?? this.id,
        title: title ?? this.title,
        body: body ?? this.body,
        type: type ?? this.type,
        data: data ?? this.data,
        isRead: isRead ?? this.isRead,
        readAt: readAt ?? this.readAt,
        userId: userId ?? this.userId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        timeAgo: timeAgo ?? this.timeAgo,
      );

  factory NotificationItem.fromJson(Map<String, dynamic> json) =>
      NotificationItem(
        id: json["id"],
        title: json["title"],
        body: json["body"],
        type: json["type"],
        data: json["data"] == null ? null : ItemData.fromJson(json["data"]),
        isRead: json["is_read"],
        readAt: json["read_at"],
        userId: json["user_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        timeAgo: json["time_ago"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "body": body,
        "type": type,
        "data": data?.toJson(),
        "is_read": isRead,
        "read_at": readAt,
        "user_id": userId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "time_ago": timeAgo,
      };
}

class ItemData {
  final int? tenderId;
  final String? tenderTitle;
  final String? companyId;
  final String? companyName;
  final int? productId;
  final String? productName;
  final String? price;
  final int? contractId;
  final dynamic contractNumber;
  final String? directorName;

  ItemData({
    this.tenderId,
    this.tenderTitle,
    this.companyId,
    this.companyName,
    this.productId,
    this.productName,
    this.price,
    this.contractId,
    this.contractNumber,
    this.directorName,
  });

  ItemData copyWith({
    int? tenderId,
    String? tenderTitle,
    String? companyId,
    String? companyName,
    int? productId,
    String? productName,
    String? price,
    int? contractId,
    dynamic contractNumber,
    String? directorName,
  }) =>
      ItemData(
        tenderId: tenderId ?? this.tenderId,
        tenderTitle: tenderTitle ?? this.tenderTitle,
        companyId: companyId ?? this.companyId,
        companyName: companyName ?? this.companyName,
        productId: productId ?? this.productId,
        productName: productName ?? this.productName,
        price: price ?? this.price,
        contractId: contractId ?? this.contractId,
        contractNumber: contractNumber ?? this.contractNumber,
        directorName: directorName ?? this.directorName,
      );

  factory ItemData.fromJson(Map<String, dynamic> json) => ItemData(
        tenderId: json["tender_id"],
        tenderTitle: json["tender_title"],
        companyId: json["company_id"],
        companyName: json["company_name"],
        productId: json["product_id"],
        productName: json["product_name"],
        price: json["price"],
        contractId: json["contract_id"],
        contractNumber: json["contract_number"],
        directorName: json["director_name"],
      );

  Map<String, dynamic> toJson() => {
        "tender_id": tenderId,
        "tender_title": tenderTitle,
        "company_id": companyId,
        "company_name": companyName,
        "product_id": productId,
        "product_name": productName,
        "price": price,
        "contract_id": contractId,
        "contract_number": contractNumber,
        "director_name": directorName,
      };
}

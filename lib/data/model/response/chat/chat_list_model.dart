// To parse this JSON data, do
//
//     final chatListModel = chatListModelFromJson(jsonString);

import 'dart:convert';

ChatListModel chatListModelFromJson(String str) =>
    ChatListModel.fromJson(json.decode(str));

String chatListModelToJson(ChatListModel data) => json.encode(data.toJson());

class ChatListModel {
  final bool? success;
  final List<ChatData>? data;
  final Pagination? pagination;

  ChatListModel({
    this.success,
    this.data,
    this.pagination,
  });

  ChatListModel copyWith({
    bool? success,
    List<ChatData>? data,
    Pagination? pagination,
  }) =>
      ChatListModel(
        success: success ?? this.success,
        data: data ?? this.data,
        pagination: pagination ?? this.pagination,
      );

  factory ChatListModel.fromJson(Map<String, dynamic> json) => ChatListModel(
        success: json["success"],
        data: json["data"] == null
            ? []
            : List<ChatData>.from(
                json["data"]!.map((x) => ChatData.fromJson(x))),
        pagination: json["pagination"] == null
            ? null
            : Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "pagination": pagination?.toJson(),
      };
}

class ChatData {
  final int? chatId;
  final String? firebaseChatId;
  final Product? product;
  final User? user;
  final Company? company;
  final LastMessage? lastMessage;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ChatData({
    this.chatId,
    this.firebaseChatId,
    this.product,
    this.user,
    this.company,
    this.lastMessage,
    this.createdAt,
    this.updatedAt,
  });

  ChatData copyWith({
    int? chatId,
    String? firebaseChatId,
    Product? product,
    User? user,
    Company? company,
    LastMessage? lastMessage,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      ChatData(
        chatId: chatId ?? this.chatId,
        firebaseChatId: firebaseChatId ?? this.firebaseChatId,
        product: product ?? this.product,
        user: user ?? this.user,
        company: company ?? this.company,
        lastMessage: lastMessage ?? this.lastMessage,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory ChatData.fromJson(Map<String, dynamic> json) => ChatData(
        chatId: json["chat_id"],
        firebaseChatId: json["firebase_chat_id"],
        product:
            json["product"] == null ? null : Product.fromJson(json["product"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        company:
            json["company"] == null ? null : Company.fromJson(json["company"]),
        lastMessage: json["last_message"] == null
            ? null
            : LastMessage.fromJson(json["last_message"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "chat_id": chatId,
        "firebase_chat_id": firebaseChatId,
        "product": product?.toJson(),
        "user": user?.toJson(),
        "company": company?.toJson(),
        "last_message": lastMessage?.toJson(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Company {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? logo;
  final String? verificationStatus;
  final User? owner;

  Company({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.logo,
    this.verificationStatus,
    this.owner,
  });

  Company copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? logo,
    String? verificationStatus,
    User? owner,
  }) =>
      Company(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        logo: logo ?? this.logo,
        verificationStatus: verificationStatus ?? this.verificationStatus,
        owner: owner ?? this.owner,
      );

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        logo: json["logo"],
        verificationStatus: json["verification_status"],
        owner: json["owner"] == null ? null : User.fromJson(json["owner"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "logo": logo,
        "verification_status": verificationStatus,
        "owner": owner?.toJson(),
      };
}

class User {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? image;
  final String? status;
  final String? fcmToken;

  User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.status,
    this.fcmToken,
  });

  User copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? image,
    String? status,
    String? fcmToken,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        image: image ?? this.image,
        status: status ?? this.status,
        fcmToken: fcmToken ?? this.fcmToken,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
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

class LastMessage {
  final String? message;
  final DateTime? createdAt;
  final String? senderId;

  LastMessage({
    this.message,
    this.createdAt,
    this.senderId,
  });

  LastMessage copyWith({
    String? message,
    DateTime? createdAt,
    String? senderId,
  }) =>
      LastMessage(
        message: message ?? this.message,
        createdAt: createdAt ?? this.createdAt,
        senderId: senderId ?? this.senderId,
      );

  factory LastMessage.fromJson(Map<String, dynamic> json) => LastMessage(
        message: json["message"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        senderId: json["sender_id"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "created_at": createdAt?.toIso8601String(),
        "sender_id": senderId,
      };
}

class Product {
  final int? id;
  final String? name;
  final String? description;
  final String? slug;
  final int? price;
  final String? quantity;
  final String? image;
  final User? user;
  final bool? isFavorite;
  final String? status;
  final String? reviewsAvgRating;

  Product({
    this.id,
    this.name,
    this.description,
    this.slug,
    this.price,
    this.quantity,
    this.image,
    this.user,
    this.isFavorite,
    this.status,
    this.reviewsAvgRating,
  });

  Product copyWith({
    int? id,
    String? name,
    String? description,
    String? slug,
    int? price,
    String? quantity,
    String? image,
    User? user,
    bool? isFavorite,
    String? status,
    String? reviewsAvgRating,
  }) =>
      Product(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        slug: slug ?? this.slug,
        price: price ?? this.price,
        quantity: quantity ?? this.quantity,
        image: image ?? this.image,
        user: user ?? this.user,
        isFavorite: isFavorite ?? this.isFavorite,
        status: status ?? this.status,
        reviewsAvgRating: reviewsAvgRating ?? this.reviewsAvgRating,
      );

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        slug: json["slug"],
        price: json["price"],
        quantity: json["quantity"],
        image: json["image"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        isFavorite: json["is_favorite"],
        status: json["status"],
        reviewsAvgRating: json["reviews_avg_rating"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "slug": slug,
        "price": price,
        "quantity": quantity,
        "image": image,
        "user": user?.toJson(),
        "is_favorite": isFavorite,
        "status": status,
        "reviews_avg_rating": reviewsAvgRating,
      };
}

class Pagination {
  final int? currentPage;
  final int? lastPage;
  final int? perPage;
  final int? total;

  Pagination({
    this.currentPage,
    this.lastPage,
    this.perPage,
    this.total,
  });

  Pagination copyWith({
    int? currentPage,
    int? lastPage,
    int? perPage,
    int? total,
  }) =>
      Pagination(
        currentPage: currentPage ?? this.currentPage,
        lastPage: lastPage ?? this.lastPage,
        perPage: perPage ?? this.perPage,
        total: total ?? this.total,
      );

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        currentPage: json["current_page"],
        lastPage: json["last_page"],
        perPage: json["per_page"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "last_page": lastPage,
        "per_page": perPage,
        "total": total,
      };
}

// To parse this JSON data, do
//
//     final chatListModel = chatListModelFromJson(jsonString);

import 'dart:convert';

import '../company/company_product_model.dart';

ChatListModel chatListModelFromJson(String str) =>
    ChatListModel.fromJson(json.decode(str));

String chatListModelToJson(ChatListModel data) => json.encode(data.toJson());

class ChatListModel {
  final String? message;
  final Data? data;
  final int? statusCode;
  final String? status;

  ChatListModel({
    this.message,
    this.data,
    this.statusCode,
    this.status,
  });

  ChatListModel copyWith({
    String? message,
    Data? data,
    int? statusCode,
    String? status,
  }) =>
      ChatListModel(
        message: message ?? this.message,
        data: data ?? this.data,
        statusCode: statusCode ?? this.statusCode,
        status: status ?? this.status,
      );

  factory ChatListModel.fromJson(Map<String, dynamic> json) => ChatListModel(
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
  final List<ChatItem>? items;
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
    List<ChatItem>? items,
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
            : List<ChatItem>.from(
                json["items"]!.map((x) => ChatItem.fromJson(x))),
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

class ChatItem {
  final int? chatId;
  final String? firebaseChatId;
  final ProductListItem? product;
  final User? user;
  final Company? company;
  final String? lastMessage;
  final DateTime? lastMessageDate;
  final int? userUnreadCount;
  final int? productOwnerUnreadCount;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ChatItem({
    this.chatId,
    this.firebaseChatId,
    this.product,
    this.user,
    this.company,
    this.lastMessage,
    this.lastMessageDate,
    this.userUnreadCount,
    this.productOwnerUnreadCount,
    this.createdAt,
    this.updatedAt,
  });

  ChatItem copyWith({
    int? chatId,
    String? firebaseChatId,
    ProductListItem? product,
    User? user,
    Company? company,
    String? lastMessage,
    DateTime? lastMessageDate,
    int? userUnreadCount,
    int? productOwnerUnreadCount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      ChatItem(
        chatId: chatId ?? this.chatId,
        firebaseChatId: firebaseChatId ?? this.firebaseChatId,
        product: product ?? this.product,
        user: user ?? this.user,
        company: company ?? this.company,
        lastMessage: lastMessage ?? this.lastMessage,
        lastMessageDate: lastMessageDate ?? this.lastMessageDate,
        userUnreadCount: userUnreadCount ?? this.userUnreadCount,
        productOwnerUnreadCount:
            productOwnerUnreadCount ?? this.productOwnerUnreadCount,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory ChatItem.fromJson(Map<String, dynamic> json) => ChatItem(
        chatId: json["chat_id"],
        firebaseChatId: json["firebase_chat_id"],
        product: json["product"] == null
            ? null
            : ProductListItem.fromJson(json["product"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        company:
            json["company"] == null ? null : Company.fromJson(json["company"]),
        lastMessage: json["last_message"],
        lastMessageDate: json["last_message_date"] == null
            ? null
            : DateTime.parse(json["last_message_date"]),
        userUnreadCount: json["user_unread_count"],
        productOwnerUnreadCount: json["product_owner_unread_count"],
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
        "last_message": lastMessage,
        "last_message_date": lastMessageDate?.toIso8601String(),
        "user_unread_count": userUnreadCount,
        "product_owner_unread_count": productOwnerUnreadCount,
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

// class Product {
//   final int? id;
//   final String? name;
//   final String? description;
//   final String? slug;
//   final int? price;
//   final String? quantity;
//   final String? image;
//   final User? user;
//   final bool? isFavorite;
//   final String? status;
//   final String? reviewsAvgRating;

//   Product({
//     this.id,
//     this.name,
//     this.description,
//     this.slug,
//     this.price,
//     this.quantity,
//     this.image,
//     this.user,
//     this.isFavorite,
//     this.status,
//     this.reviewsAvgRating,
//   });

//   Product copyWith({
//     int? id,
//     String? name,
//     String? description,
//     String? slug,
//     int? price,
//     String? quantity,
//     String? image,
//     User? user,
//     bool? isFavorite,
//     String? status,
//     String? reviewsAvgRating,
//   }) =>
//       Product(
//         id: id ?? this.id,
//         name: name ?? this.name,
//         description: description ?? this.description,
//         slug: slug ?? this.slug,
//         price: price ?? this.price,
//         quantity: quantity ?? this.quantity,
//         image: image ?? this.image,
//         user: user ?? this.user,
//         isFavorite: isFavorite ?? this.isFavorite,
//         status: status ?? this.status,
//         reviewsAvgRating: reviewsAvgRating ?? this.reviewsAvgRating,
//       );

//   factory Product.fromJson(Map<String, dynamic> json) => Product(
//         id: json["id"],
//         name: json["name"],
//         description: json["description"],
//         slug: json["slug"],
//         price: json["price"],
//         quantity: json["quantity"],
//         image: json["image"],
//         user: json["user"] == null ? null : User.fromJson(json["user"]),
//         isFavorite: json["is_favorite"],
//         status: json["status"],
//         reviewsAvgRating: json["reviews_avg_rating"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "description": description,
//         "slug": slug,
//         "price": price,
//         "quantity": quantity,
//         "image": image,
//         "user": user?.toJson(),
//         "is_favorite": isFavorite,
//         "status": status,
//         "reviews_avg_rating": reviewsAvgRating,
//       };
// }

// To parse this JSON data, do
//
//     final chattingTicketModel = chattingTicketModelFromJson(jsonString);

import 'dart:convert';

ChattingTicketModel chattingTicketModelFromJson(String str) => ChattingTicketModel.fromJson(json.decode(str));

String chattingTicketModelToJson(ChattingTicketModel data) => json.encode(data.toJson());

class ChattingTicketModel {
  String message;
  Data data;
  int statusCode;
  String status;

  ChattingTicketModel({
    required this.message,
    required this.data,
    required this.statusCode,
    required this.status,
  });

  factory ChattingTicketModel.fromJson(Map<String, dynamic> json) => ChattingTicketModel(
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
  List<TicketItem> items;
  int totalPages;
  int currentPage;
  int total;
  int perPage;
  int count;

  Data({
    required this.items,
    required this.totalPages,
    required this.currentPage,
    required this.total,
    required this.perPage,
    required this.count,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    items: List<TicketItem>.from(json["items"].map((x) => TicketItem.fromJson(x))),
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

class TicketItem {
  String chatId;
  int id;
  String name;
  int price;
  String image;
  String currency;
  String status;
  DateTime createdAt;
  String lastMessage;
  int lastSeen;
  int totalUnseen;
  Seller user;
  Seller seller;

  TicketItem({
    required this.chatId,
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.currency,
    required this.status,
    required this.createdAt,
    required this.lastMessage,
    required this.lastSeen,
    required this.totalUnseen,
    required this.user,
    required this.seller,
  });

  factory TicketItem.fromJson(Map<String, dynamic> json) => TicketItem(
    chatId: json["chat_id"],
    id: json["id"],
    name: json["name"],
    price: json["price"],
    image: json["image"],
    currency: json["currency"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    lastMessage: json["last_message"],
    lastSeen: json["last_seen"],
    totalUnseen: json["total_unseen"],
    user: Seller.fromJson(json["user"]),
    seller: Seller.fromJson(json["seller"]),
  );

  Map<String, dynamic> toJson() => {
    "chat_id": chatId,
    "id": id,
    "name": name,
    "price": price,
    "image": image,
    "currency": currency,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "last_message": lastMessage,
    "last_seen": lastSeen,
    "total_unseen": totalUnseen,
    "user": user.toJson(),
    "seller": seller.toJson(),
  };
}

class Seller {
  int id;
  String name;
  String phone;
  String image;

  Seller({
    required this.id,
    required this.name,
    required this.phone,
    required this.image,
  });

  factory Seller.fromJson(Map<String, dynamic> json) => Seller(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone": phone,
    "image": image,
  };
}

// // To parse this JSON data, do
// //
// //     final chatModel = chatModelFromJson(jsonString);

// import 'dart:convert';

// ChatModel chatModelFromJson(String str) => ChatModel.fromJson(json.decode(str));

// String chatModelToJson(ChatModel data) => json.encode(data.toJson());

// class ChatModel {
//   String message;
//   Data data;
//   int statusCode;
//   String status;

//   ChatModel({
//     required this.message,
//     required this.data,
//     required this.statusCode,
//     required this.status,
//   });

//   factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
//     message: json["message"],
//     data: Data.fromJson(json["data"]),
//     statusCode: json["status_code"],
//     status: json["status"],
//   );

//   Map<String, dynamic> toJson() => {
//     "message": message,
//     "data": data.toJson(),
//     "status_code": statusCode,
//     "status": status,
//   };
// }

// class Data {
//   List<ChatList> items;
//   int totalPages;
//   int currentPage;
//   int total;
//   int perPage;
//   int count;
//   Receiver receiver;
//   Product product;

//   Data({
//     required this.items,
//     required this.totalPages,
//     required this.currentPage,
//     required this.total,
//     required this.perPage,
//     required this.count,
//     required this.receiver,
//     required this.product,
//   });

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//     items: List<ChatList>.from(json["items"].map((x) => ChatList.fromJson(x))),
//     totalPages: json["totalPages"],
//     currentPage: json["currentPage"],
//     total: json["total"],
//     perPage: json["perPage"],
//     count: json["count"],
//     receiver: Receiver.fromJson(json["receiver"]),
//     product: Product.fromJson(json["product"]),
//   );

//   Map<String, dynamic> toJson() => {
//     "items": List<dynamic>.from(items.map((x) => x.toJson())),
//     "totalPages": totalPages,
//     "currentPage": currentPage,
//     "total": total,
//     "perPage": perPage,
//     "count": count,
//     "receiver": receiver.toJson(),
//     "product": product.toJson(),
//   };
// }

// class ChatList {
//   int id;
//   Product senderId;
//   Product receiverId;
//   String type;
//   String message;
//   String image;
//   DateTime createdAt;
//   DateTime updatedAt;

//   ChatList({
//     required this.id,
//     required this.senderId,
//     required this.receiverId,
//     required this.type,
//     required this.message,
//     required this.image,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory ChatList.fromJson(Map<String, dynamic> json) => ChatList(
//     id: json["id"],
//     senderId: Product.fromJson(json["sender_id"]),
//     receiverId: Product.fromJson(json["receiver_id"]),
//     type: json["type"],
//     message: json["message"],
//     image: json["image"],
//     createdAt: DateTime.parse(json["created_at"]),
//     updatedAt: DateTime.parse(json["updated_at"]),
//   );

//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "sender_id": senderId.toJson(),
//     "receiver_id": receiverId.toJson(),
//     "type": type,
//     "message": message,
//     "image": image,
//     "created_at": createdAt.toIso8601String(),
//     "updated_at": updatedAt.toIso8601String(),
//   };
// }

// class Product {
//   int id;
//   String name;
//   String image;
//   int? price;

//   Product({
//     required this.id,
//     required this.name,
//     required this.image,
//     this.price,
//   });

//   factory Product.fromJson(Map<String, dynamic> json) => Product(
//     id: json["id"],
//     name: json["name"] ??"",
//     image: json["image"],
//     price: json["price"],
//   );

//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "image": image,
//     "price": price,
//   };
// }

// class Receiver {
//   int currentId;
//   int id;
//   String name;
//   String phone;
//   String image;

//   Receiver({
//     required this.currentId,
//     required this.id,
//     required this.name,
//     required this.phone,
//     required this.image,
//   });

//   factory Receiver.fromJson(Map<String, dynamic> json) => Receiver(
//     currentId: json["current_id"],
//     id: json["id"],
//     name: json["name"],
//     phone: json["phone"],
//     image: json["image"],
//   );

//   Map<String, dynamic> toJson() => {
//     "current_id": currentId,
//     "id": id,
//     "name": name,
//     "phone": phone,
//     "image": image,
//   };
// }

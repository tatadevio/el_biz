// // To parse this JSON data, do
// //
// //     final SellerModel = SellerModelFromJson(jsonString);

// import 'package:meta/meta.dart';
// import 'dart:convert';

// import '../product/product_model.dart';

// SellerModel sellerModelFromJson(String str) => SellerModel.fromJson(json.decode(str));

// String sellerModelToJson(SellerModel data) => json.encode(data.toJson());

// class SellerModel {
//   SellerModel({
//     required this.message,
//     required this.data,
//     required this.statusCode,
//     required this.status,
//   });

//   String message;
//   Data data;
//   int statusCode;
//   String status;

//   factory SellerModel.fromJson(Map<String, dynamic> json) => SellerModel(
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
//   Data({
//     required this.items,
//     required this.manager,
//     required this.totalPages,
//     required this.currentPage,
//     required this.total,
//     required this.perPage,
//     required this.count,
//   });

//   List<ProductItem> items;
//   Manager manager;
//   int totalPages;
//   int currentPage;
//   int total;
//   int perPage;
//   int count;

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//     items: List<ProductItem>.from(json["items"].map((x) => ProductItem.fromJson(x))),
//     manager: Manager.fromJson(json["manager"]),
//     totalPages: json["totalPages"],
//     currentPage: json["currentPage"],
//     total: json["total"],
//     perPage: json["perPage"],
//     count: json["count"],
//   );

//   Map<String, dynamic> toJson() => {
//     "items": List<dynamic>.from(items.map((x) => x.toJson())),
//     "manager": manager.toJson(),
//     "totalPages": totalPages,
//     "currentPage": currentPage,
//     "total": total,
//     "perPage": perPage,
//     "count": count,
//   };
// }



// class AssignManager {
//   AssignManager({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.phone,
//     required this.image,
//     required this.bannerImg,
//     required this.role,
//   });

//   int id;
//   String name;
//   String email;
//   String phone;
//   String image;
//   String bannerImg;
//   String role;

//   factory AssignManager.fromJson(Map<String, dynamic> json) => AssignManager(
//     id: json["id"],
//     name: json["name"],
//     email: json["email"],
//     phone: json["phone"],
//     image: json["image"],
//     bannerImg: json["banner_img"],
//     role: json["role"],
//   );

//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "email": email,
//     "phone": phone,
//     "image": image,
//     "banner_img": bannerImg,
//     "role": role,
//   };
// }

// class Attribute {
//   Attribute({
//     required this.title,
//     required this.value,
//   });

//   String title;
//   String value;

//   factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
//     title: json["title"],
//     value: json["value"],
//   );

//   Map<String, dynamic> toJson() => {
//     "title": title,
//     "value": value,
//   };
// }

// class Gallery {
//   Gallery({
//     required this.image,
//   });

//   String image;

//   factory Gallery.fromJson(Map<String, dynamic> json) => Gallery(
//     image: json["image"],
//   );

//   Map<String, dynamic> toJson() => {
//     "image": image,
//   };
// }

// class Manager {
//   Manager({
//     required this.id,
//     required this.role,
//     required this.name,
//     required this.email,
//     required this.phone,
//     required this.image,
//     required this.bannerImg,
//     required this.country,
//     required this.city,
//     required this.state,
//     required this.address,
//     required this.status,
//     required this.about,
//   });

//   int id;
//   String role;
//   String name;
//   String email;
//   String phone;
//   String image;
//   String bannerImg;
//   String country;
//   String city;
//   String state;
//   String address;
//   int status;
//   String about;

//   factory Manager.fromJson(Map<String, dynamic> json) => Manager(
//     id: json["id"],
//     role: json["role"],
//     name: json["name"],
//     email: json["email"],
//     phone: json["phone"],
//     image: json["image"],
//     bannerImg: json["banner_img"],
//     country: json["country"],
//     city: json["city"],
//     state: json["state"],
//     address: json["address"],
//     status: json["status"],
//     about: json["about"],
//   );

//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "role": role,
//     "name": name,
//     "email": email,
//     "phone": phone,
//     "image": image,
//     "banner_img": bannerImg,
//     "country": country,
//     "city": city,
//     "state": state,
//     "address": address,
//     "status": status,
//     "about": about,
//   };
// }

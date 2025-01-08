// To parse this JSON data, do
//
//     final editAdsModel = editAdsModelFromJson(jsonString);

import 'dart:convert';

EditAdsModel editAdsModelFromJson(String str) =>
    EditAdsModel.fromJson(json.decode(str));

String editAdsModelToJson(EditAdsModel data) => json.encode(data.toJson());

class EditAdsModel {
  EditAdsModel({
    required this.message,
    required this.data,
    required this.statusCode,
    required this.status,
  });

  String message;
  EditAdsItem data;
  int statusCode;
  String status;

  factory EditAdsModel.fromJson(Map<String, dynamic> json) => EditAdsModel(
        message: json["message"],
        data: EditAdsItem.fromJson(json["data"]),
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

class EditAdsItem {
  EditAdsItem({
    required this.id,
    required this.categoryId,
    required this.cityId,
    required this.currency,
    required this.price,
    required this.name,
    required this.isValidDiscount,
    required this.discountRemainingDays,
    required this.priceAfterDiscount,
    required this.discount,
    required this.discountStartDate,
    required this.attribute,
    required this.parentCats,
    required this.discountEndDate,
    required this.description,
    required this.galleries,
    required this.status,
    required this.phone,
    required this.createdAt,
    required this.socialLink,
    required this.additionalInfo,
    required this.whatsappNumber,
    required this.phoneCountryCode,
    required this.whatsappCountryCode,
    required this.enablePhone,
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  int id;
  int categoryId;
  int cityId;
  String currency;
  String price;
  String name;
  bool isValidDiscount;
  int discountRemainingDays;
  String priceAfterDiscount;
  int discount;
  DateTime discountStartDate;
  List<Attribute> attribute;
  List<ParentCat> parentCats;
  DateTime discountEndDate;
  String description;
  List<Gallery> galleries;
  String status;
  String phone;
  DateTime createdAt;
  String socialLink;
  String additionalInfo;
  String whatsappNumber;
  String phoneCountryCode;
  String whatsappCountryCode;
  int enablePhone;
  String latitude;
  String longitude;
  String address;

  factory EditAdsItem.fromJson(Map<String, dynamic> json) => EditAdsItem(
        id: json["id"],
        categoryId: json["category_id"],
        cityId: json["city_id"],
        currency: json["currency"],
        price: json["price"],
        name: json["name"],
        isValidDiscount: json["is_valid_discount"],
        discountRemainingDays: json["discount_remaining_days"],
        priceAfterDiscount: json["price_after_discount"],
        discount: json["discount"],
        discountStartDate: DateTime.parse(json["discount_start_date"]),
        attribute: List<Attribute>.from(
            json["attribute"].map((x) => Attribute.fromJson(x))),
        parentCats: List<ParentCat>.from(
            json["parent_cats"].map((x) => ParentCat.fromJson(x))),
        discountEndDate: DateTime.parse(json["discount_end_date"]),
        description: json["description"],
        galleries: List<Gallery>.from(
            json["galleries"].map((x) => Gallery.fromJson(x))),
        status: json["status"],
        phone: json["phone"],
        createdAt: DateTime.parse(json["created_at"]),
        socialLink: json["social_link"],
        additionalInfo: json["addtional_information"],
        whatsappNumber: json["whatsapp_number"],
        phoneCountryCode: json["phone_country_code"],
        whatsappCountryCode: json["whatsapp_country_code"],
        enablePhone: json["enable_phone"],
        latitude: json['latitude'],
        longitude: json['longitude'],
        address: json['address'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "city_id": cityId,
        "currency": currency,
        "price": price,
        "name": name,
        "is_valid_discount": isValidDiscount,
        "discount_remaining_days": discountRemainingDays,
        "price_after_discount": priceAfterDiscount,
        "discount": discount,
        "discount_start_date": discountStartDate.toIso8601String(),
        "attribute": List<dynamic>.from(attribute.map((x) => x.toJson())),
        "parent_cats": List<dynamic>.from(parentCats.map((x) => x.toJson())),
        "discount_end_date": discountEndDate.toIso8601String(),
        "description": description,
        "galleries": List<dynamic>.from(galleries.map((x) => x.toJson())),
        "status": status,
        "phone": phone,
        "created_at": createdAt.toIso8601String(),
        "social_link": socialLink,
        "addtional_information": additionalInfo,
        "whatsapp_number": phone,
        "phone_country_code": phoneCountryCode,
        "whatsapp_country_code": whatsappCountryCode,
        "enable_phone": enablePhone,
        "latitude": latitude,
        "longitude": longitude,
        "address": address,
      };
}

class Attribute {
  Attribute({
    required this.title,
    required this.option,
    required this.id,
  });

  String title;
  String option;
  int id;

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
        title: json["title"],
        option: json["option"] ?? "",
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "option": option,
        "id": id,
      };
}

class Gallery {
  Gallery({
    required this.image,
    required this.id,
  });

  String image;
  int id;

  factory Gallery.fromJson(Map<String, dynamic> json) => Gallery(
        image: json["image"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "image": image,
        "id": id,
      };
}

class ParentCat {
  ParentCat({
    required this.id,
    required this.title,
  });

  int id;
  String title;

  factory ParentCat.fromJson(Map<String, dynamic> json) => ParentCat(
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
      };
}

class SocialLink {
  String value;

  SocialLink({
    required this.value,
  });

  factory SocialLink.fromJson(Map<String, dynamic> json) => SocialLink(
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
      };
}

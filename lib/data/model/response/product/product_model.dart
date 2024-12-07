
import 'dart:convert';

ProductListModel productListModelFromJson(String str) => ProductListModel.fromJson(json.decode(str));

String productListModelToJson(ProductListModel data) => json.encode(data.toJson());

class ProductListModel {
  ProductListModel({
    required this.message,
    required this.data,
    required this.statusCode,
    required this.status,
  });

  String message;
  Data data;
  int statusCode;
  String status;

  factory ProductListModel.fromJson(Map<String, dynamic> json) => ProductListModel(
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
  Data({
    required this.items,
    required this.totalPages,
    required this.currentPage,
    required this.total,
    required this.perPage,
    required this.count,
  });

  List<ProductItem> items;
  int totalPages;
  int currentPage;
  int total;
  int perPage;
  int count;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    items: List<ProductItem>.from(json["items"].map((x) => ProductItem.fromJson(x))),
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

class ProductItem {
  ProductItem({
    required this.id,
    required this.name,
    required this.price,
    required this.exchangePrice,
    required this.exchangePriceAfterDiscount,
    required this.currency,
    required this.isValidDiscount,
    required this.discountRemainingDays,
    required this.priceAfterDiscount,
    required this.discount,
    required this.discountStartDate,
    required this.attribute,
    required this.discountEndDate,
    required this.description,
    required this.galleries,
    required this.likes,
    required this.favorites,
    required this.viewsCount,
    required this.status,
    required this.chatStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.seller,
    required this.ownerStatus,
    required this.isVip,
    required this.vipStatus,
    required this.socialLink,
    required this.additionalInfo,
    required this.whatsapp,
    required this.phone,
    required this.city,
    required this.category,
    required this.latitude,
    required this.longitude,
    required this.phoneCountryCode,
    required this.whatsappCountryCode,
    required this.address,
  });

  int id;
  String name;
  String price;
  String exchangePrice;
  String exchangePriceAfterDiscount;
  String currency;
  bool isValidDiscount;
  int discountRemainingDays;
  String priceAfterDiscount;
  int discount;
  String discountStartDate;
  List<Attribute> attribute;
  String discountEndDate;
  String description;
  List<Gallery> galleries;
  int likes;
  int favorites;
  int viewsCount;
  String status;
  String chatStatus;
  DateTime createdAt;
  DateTime updatedAt;
  Seller seller;
  String ownerStatus;
  bool isVip;
  String vipStatus;
  String socialLink;
  String additionalInfo;
  String whatsapp;
  String phone;
  String city;
  Category category;
  String latitude;
  String longitude;
  String phoneCountryCode;
  String whatsappCountryCode;
  String address;


  factory ProductItem.fromJson(Map<String, dynamic> json) => ProductItem(
    id: json["id"],
    name: json["name"],
    price: json["price"],
      exchangePrice: json["exchange_price"],
      exchangePriceAfterDiscount: json["exchange_price_after_discount"],
    currency: json["currency"],
    isValidDiscount: json["is_valid_discount"],
    discountRemainingDays: json["discount_remaining_days"],
    priceAfterDiscount: json["price_after_discount"],
    discount: json["discount"],
    discountStartDate: json["discount_start_date"],
    attribute: List<Attribute>.from(json["attribute"].map((x) => Attribute.fromJson(x))),
    discountEndDate: json["discount_end_date"],
    description: json["description"],
    galleries: List<Gallery>.from(json["galleries"].map((x) => Gallery.fromJson(x))),
    likes: json["likes"],
    favorites: json["favorites"],
    viewsCount: json["views_count"],
    status: json["status"],
    chatStatus: json["chat_status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    seller: Seller.fromJson(json["seller"]),
    ownerStatus: json['owner_status'],
    isVip: json['is_vip'],
    vipStatus: json['vip_status'],
    socialLink: json['social_link'],
    additionalInfo: json['addtional_information'],
    whatsapp: json['whatsapp_number'],
    phone: json['phone'],
    city: json['city_name'],

    category: Category.fromJson(json["category"]),
    latitude: json['latitude'],
    longitude: json['longitude'],
    phoneCountryCode: json['phone_country_code'],
    whatsappCountryCode: json['whatsapp_country_code'],
    address: json['address'],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "exchange_price": exchangePrice,
    "exchange_price_after_discount": exchangePriceAfterDiscount,
    "currency": currency,
    "is_valid_discount": isValidDiscount,
    "discount_remaining_days": discountRemainingDays,
    "price_after_discount": priceAfterDiscount,
    "discount": discount,
    "discount_start_date": discountStartDate,
    "attribute": List<dynamic>.from(attribute.map((x) => x.toJson())),
    "discount_end_date": discountEndDate,
    "description": description,
    "galleries": List<dynamic>.from(galleries.map((x) => x.toJson())),
    "likes": likes,
    "favorites": favorites,
    "views_count": viewsCount,
    "status": status,
    "chat_status": chatStatus,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "seller": seller.toJson(),
    "owner_status": ownerStatus,
    "is_vip": isVip,
    "vip_status": vipStatus,
    "social_link": socialLink,
    "addtional_information": additionalInfo,
    "whatsapp_number": whatsapp,
    "phone": phone,
    "city_name": city,
    "category": category.toJson(),
    "latitude": latitude,
    "longitude": longitude,
    "phone_country_code": phoneCountryCode,
    "whatsapp_country_code": whatsappCountryCode,
    "address": address,
  };
}

class Category {
  int id;
  String name;
  String description;
  String image;
  String icon;

  Category({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.icon,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    image: json["image"],
    icon: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "image": image,
    "icon": icon,
  };
}


class Attribute {
  Attribute({
    required this.title,
    required this.option,
  });

  String title;
  String option;

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
    title: json["title"],
    option: json["value"]??"",
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "value": option,
  };
}

class Gallery {
  Gallery({
    required this.image,
  });

  String image;

  factory Gallery.fromJson(Map<String, dynamic> json) => Gallery(
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "image": image,
  };
}
class Seller {
  Seller({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.bannerImg,
  });

  int id;
  String name;
  String email;
  String phone;
  String image;
  String bannerImg;

  factory Seller.fromJson(Map<String, dynamic> json) => Seller(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    image: json["image"],
    bannerImg: json["banner_img"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "image": image,
    "banner_img": bannerImg,
  };
}
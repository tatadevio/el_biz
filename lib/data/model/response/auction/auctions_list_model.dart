// To parse this JSON data, do
//
//     final auctionsListModel = auctionsListModelFromJson(jsonString);

import 'dart:convert';

import '../product/product_detail_model.dart';

AuctionsListModel auctionsListModelFromJson(String str) =>
    AuctionsListModel.fromJson(json.decode(str));

String auctionsListModelToJson(AuctionsListModel data) =>
    json.encode(data.toJson());

class AuctionsListModel {
  final String? message;
  final String? status;
  final String? localizedKey;
  final AuctionListData? data;
  final int? statusCode;

  AuctionsListModel({
    this.message,
    this.status,
    this.localizedKey,
    this.data,
    this.statusCode,
  });

  AuctionsListModel copyWith({
    String? message,
    String? status,
    String? localizedKey,
    AuctionListData? data,
    int? statusCode,
  }) =>
      AuctionsListModel(
        message: message ?? this.message,
        status: status ?? this.status,
        localizedKey: localizedKey ?? this.localizedKey,
        data: data ?? this.data,
        statusCode: statusCode ?? this.statusCode,
      );

  factory AuctionsListModel.fromJson(Map<String, dynamic> json) =>
      AuctionsListModel(
        message: json["message"],
        status: json["status"],
        localizedKey: json["localized_key"],
        data: json["data"] == null
            ? null
            : AuctionListData.fromJson(json["data"]),
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

class AuctionListData {
  final List<AuctionListItem>? items;
  final int? totalPages;
  final int? currentPage;
  final int? total;
  final int? perPage;
  final int? count;

  AuctionListData({
    this.items,
    this.totalPages,
    this.currentPage,
    this.total,
    this.perPage,
    this.count,
  });

  AuctionListData copyWith({
    List<AuctionListItem>? items,
    int? totalPages,
    int? currentPage,
    int? total,
    int? perPage,
    int? count,
  }) =>
      AuctionListData(
        items: items ?? this.items,
        totalPages: totalPages ?? this.totalPages,
        currentPage: currentPage ?? this.currentPage,
        total: total ?? this.total,
        perPage: perPage ?? this.perPage,
        count: count ?? this.count,
      );

  factory AuctionListData.fromJson(Map<String, dynamic> json) =>
      AuctionListData(
        items: json["items"] == null
            ? []
            : List<AuctionListItem>.from(
                json["items"]!.map((x) => AuctionListItem.fromJson(x))),
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

// class AuctionListItem {
//   final int? id;
//   final String? title;
//   final String? status;
//   final String? productPrice;
//   final String? currentTotalPrice;
//   final String? buyoutPrice;
//   final DateTime? startDate;
//   final DateTime? endDate;
//   final String? timeRemaining;
//   final bool? isActive;
//   final String? canBeBidOn;
//   final int? bidCount;
//   final String? participantCount;
//   final String? location;
//   final bool? freeShipping;
//   final String? paymentMethod;
//   final Category? category;
//   final Company? company;
//   final Company? creator;
//   final List<dynamic>? images;
//   final String? carBrand;
//   final String? carModel;
//   final String? carGeneration;
//   final String? carMileage;
//   final String? carCustomsCleared;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;

//   AuctionListItem({
//     this.id,
//     this.title,
//     this.status,
//     this.productPrice,
//     this.currentTotalPrice,
//     this.buyoutPrice,
//     this.startDate,
//     this.endDate,
//     this.timeRemaining,
//     this.isActive,
//     this.canBeBidOn,
//     this.bidCount,
//     this.participantCount,
//     this.location,
//     this.freeShipping,
//     this.paymentMethod,
//     this.category,
//     this.company,
//     this.creator,
//     this.images,
//     this.carBrand,
//     this.carModel,
//     this.carGeneration,
//     this.carMileage,
//     this.carCustomsCleared,
//     this.createdAt,
//     this.updatedAt,
//   });

//   AuctionListItem copyWith({
//     int? id,
//     String? title,
//     String? status,
//     String? productPrice,
//     String? currentTotalPrice,
//     String? buyoutPrice,
//     DateTime? startDate,
//     DateTime? endDate,
//     String? timeRemaining,
//     bool? isActive,
//     String? canBeBidOn,
//     int? bidCount,
//     String? participantCount,
//     String? location,
//     bool? freeShipping,
//     String? paymentMethod,
//     Category? category,
//     Company? company,
//     Company? creator,
//     List<dynamic>? images,
//     String? carBrand,
//     String? carModel,
//     String? carGeneration,
//     String? carMileage,
//     String? carCustomsCleared,
//     DateTime? createdAt,
//     DateTime? updatedAt,
//   }) =>
//       AuctionListItem(
//         id: id ?? this.id,
//         title: title ?? this.title,
//         status: status ?? this.status,
//         productPrice: productPrice ?? this.productPrice,
//         currentTotalPrice: currentTotalPrice ?? this.currentTotalPrice,
//         buyoutPrice: buyoutPrice ?? this.buyoutPrice,
//         startDate: startDate ?? this.startDate,
//         endDate: endDate ?? this.endDate,
//         timeRemaining: timeRemaining ?? this.timeRemaining,
//         isActive: isActive ?? this.isActive,
//         canBeBidOn: canBeBidOn ?? this.canBeBidOn,
//         bidCount: bidCount ?? this.bidCount,
//         participantCount: participantCount ?? this.participantCount,
//         location: location ?? this.location,
//         freeShipping: freeShipping ?? this.freeShipping,
//         paymentMethod: paymentMethod ?? this.paymentMethod,
//         category: category ?? this.category,
//         company: company ?? this.company,
//         creator: creator ?? this.creator,
//         images: images ?? this.images,
//         carBrand: carBrand ?? this.carBrand,
//         carModel: carModel ?? this.carModel,
//         carGeneration: carGeneration ?? this.carGeneration,
//         carMileage: carMileage ?? this.carMileage,
//         carCustomsCleared: carCustomsCleared ?? this.carCustomsCleared,
//         createdAt: createdAt ?? this.createdAt,
//         updatedAt: updatedAt ?? this.updatedAt,
//       );

//   factory AuctionListItem.fromJson(Map<String, dynamic> json) => AuctionListItem(
//         id: json["id"],
//         title: json["title"],
//         status: json["status"],
//         productPrice: json["product_price"],
//         currentTotalPrice: json["current_total_price"],
//         buyoutPrice: json["buyout_price"],
//         startDate: json["start_date"] == null
//             ? null
//             : DateTime.parse(json["start_date"]),
//         endDate:
//             json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
//         timeRemaining: json["time_remaining"],
//         isActive: json["is_active"],
//         canBeBidOn: json["can_be_bid_on"],
//         bidCount: json["bid_count"],
//         participantCount: json["participant_count"],
//         location: json["location"],
//         freeShipping: json["free_shipping"],
//         paymentMethod: json["payment_method"],
//         category: json["category"] == null
//             ? null
//             : Category.fromJson(json["category"]),
//         company:
//             json["company"] == null ? null : Company.fromJson(json["company"]),
//         creator:
//             json["creator"] == null ? null : Company.fromJson(json["creator"]),
//         images: json["images"] == null
//             ? []
//             : List<dynamic>.from(json["images"]!.map((x) => x)),
//         carBrand: json["car_brand"],
//         carModel: json["car_model"],
//         carGeneration: json["car_generation"],
//         carMileage: json["car_mileage"],
//         carCustomsCleared: json["car_customs_cleared"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "title": title,
//         "status": status,
//         "product_price": productPrice,
//         "current_total_price": currentTotalPrice,
//         "buyout_price": buyoutPrice,
//         "start_date": startDate?.toIso8601String(),
//         "end_date": endDate?.toIso8601String(),
//         "time_remaining": timeRemaining,
//         "is_active": isActive,
//         "can_be_bid_on": canBeBidOn,
//         "bid_count": bidCount,
//         "participant_count": participantCount,
//         "location": location,
//         "free_shipping": freeShipping,
//         "payment_method": paymentMethod,
//         "category": category?.toJson(),
//         "company": company?.toJson(),
//         "creator": creator?.toJson(),
//         "images":
//             images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
//         "car_brand": carBrand,
//         "car_model": carModel,
//         "car_generation": carGeneration,
//         "car_mileage": carMileage,
//         "car_customs_cleared": carCustomsCleared,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//       };
// }
class AuctionListItem {
  final int? id;
  final String? title;
  final String? status;
  final String? productPrice;
  final String? currentTotalPrice;
  final String? buyoutPrice;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? timeRemaining;
  final bool? isActive;
  final String? canBeBidOn;
  final int? bidCount;
  final String? participantCount;
  final String? location;
  final bool? freeShipping;
  final String? paymentMethod;
  final ProductDetailData? product;
  final Category? category;
  final CreatorClass? company;
  final CreatorClass? creator;
  final List<dynamic>? images;
  final String? carBrand;
  final String? carModel;
  final String? carGeneration;
  final String? carMileage;
  final String? carCustomsCleared;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool? isFavorite;

  AuctionListItem({
    this.id,
    this.title,
    this.status,
    this.productPrice,
    this.currentTotalPrice,
    this.buyoutPrice,
    this.startDate,
    this.endDate,
    this.timeRemaining,
    this.isActive,
    this.canBeBidOn,
    this.bidCount,
    this.participantCount,
    this.location,
    this.freeShipping,
    this.paymentMethod,
    this.product,
    this.category,
    this.company,
    this.creator,
    this.images,
    this.carBrand,
    this.carModel,
    this.carGeneration,
    this.carMileage,
    this.carCustomsCleared,
    this.createdAt,
    this.updatedAt,
    this.isFavorite,
  });

  AuctionListItem copyWith({
    int? id,
    String? title,
    String? status,
    String? productPrice,
    String? currentTotalPrice,
    String? buyoutPrice,
    DateTime? startDate,
    DateTime? endDate,
    String? timeRemaining,
    bool? isActive,
    String? canBeBidOn,
    int? bidCount,
    String? participantCount,
    String? location,
    bool? freeShipping,
    String? paymentMethod,
    ProductDetailData? product,
    Category? category,
    CreatorClass? company,
    CreatorClass? creator,
    List<dynamic>? images,
    String? carBrand,
    String? carModel,
    String? carGeneration,
    String? carMileage,
    String? carCustomsCleared,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isFavorite,
  }) =>
      AuctionListItem(
        id: id ?? this.id,
        title: title ?? this.title,
        status: status ?? this.status,
        productPrice: productPrice ?? this.productPrice,
        currentTotalPrice: currentTotalPrice ?? this.currentTotalPrice,
        buyoutPrice: buyoutPrice ?? this.buyoutPrice,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        timeRemaining: timeRemaining ?? this.timeRemaining,
        isActive: isActive ?? this.isActive,
        canBeBidOn: canBeBidOn ?? this.canBeBidOn,
        bidCount: bidCount ?? this.bidCount,
        participantCount: participantCount ?? this.participantCount,
        location: location ?? this.location,
        freeShipping: freeShipping ?? this.freeShipping,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        product: product ?? this.product,
        category: category ?? this.category,
        company: company ?? this.company,
        creator: creator ?? this.creator,
        images: images ?? this.images,
        carBrand: carBrand ?? this.carBrand,
        carModel: carModel ?? this.carModel,
        carGeneration: carGeneration ?? this.carGeneration,
        carMileage: carMileage ?? this.carMileage,
        carCustomsCleared: carCustomsCleared ?? this.carCustomsCleared,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        isFavorite: isFavorite ?? this.isFavorite,
      );

  factory AuctionListItem.fromJson(Map<String, dynamic> json) =>
      AuctionListItem(
        id: json["id"],
        title: json["title"],
        status: json["status"],
        productPrice: json["product_price"],
        currentTotalPrice: json["current_total_price"],
        buyoutPrice: json["buyout_price"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        timeRemaining: json["time_remaining"],
        isActive: json["is_active"],
        canBeBidOn: json["can_be_bid_on"],
        bidCount: json["bid_count"],
        participantCount: json["participant_count"],
        location: json["location"],
        freeShipping: json["free_shipping"],
        paymentMethod: json["payment_method"],
        product: json["product"] == null
            ? null
            : ProductDetailData.fromJson(json["product"]),
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
        company: json["company"] == null
            ? null
            : CreatorClass.fromJson(json["company"]),
        creator: json["creator"] == null
            ? null
            : CreatorClass.fromJson(json["creator"]),
        images: json["images"] == null
            ? []
            : List<dynamic>.from(json["images"]!.map((x) => x)),
        carBrand: json["car_brand"],
        carModel: json["car_model"],
        carGeneration: json["car_generation"],
        carMileage: json["car_mileage"],
        carCustomsCleared: json["car_customs_cleared"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        isFavorite: json["is_favorite"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "status": status,
        "product_price": productPrice,
        "current_total_price": currentTotalPrice,
        "buyout_price": buyoutPrice,
        "start_date": startDate?.toIso8601String(),
        "end_date": endDate?.toIso8601String(),
        "time_remaining": timeRemaining,
        "is_active": isActive,
        "can_be_bid_on": canBeBidOn,
        "bid_count": bidCount,
        "participant_count": participantCount,
        "location": location,
        "free_shipping": freeShipping,
        "payment_method": paymentMethod,
        "product": product?.toJson(),
        "category": category?.toJson(),
        "company": company?.toJson(),
        "creator": creator?.toJson(),
        "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "car_brand": carBrand,
        "car_model": carModel,
        "car_generation": carGeneration,
        "car_mileage": carMileage,
        "car_customs_cleared": carCustomsCleared,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "is_favorite": isFavorite,
      };
}

class Category {
  final int? id;
  final String? name;
  final String? slug;

  Category({
    this.id,
    this.name,
    this.slug,
  });

  Category copyWith({
    int? id,
    String? name,
    String? slug,
  }) =>
      Category(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
      );

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
      };
}

class Company {
  final int? id;
  final String? name;
  final String? type;

  Company({
    this.id,
    this.name,
    this.type,
  });

  Company copyWith({
    int? id,
    String? name,
    String? type,
  }) =>
      Company(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
      );

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        id: json["id"],
        name: json["name"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
      };
}

class CreatorClass {
  final int? id;
  final String? name;
  final String? type;

  CreatorClass({
    this.id,
    this.name,
    this.type,
  });

  CreatorClass copyWith({
    int? id,
    String? name,
    String? type,
  }) =>
      CreatorClass(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
      );

  factory CreatorClass.fromJson(Map<String, dynamic> json) => CreatorClass(
        id: json["id"],
        name: json["name"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
      };
}

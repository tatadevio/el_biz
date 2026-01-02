// To parse this JSON data, do
//
//     final auctionDetailModel = auctionDetailModelFromJson(jsonString);

import 'dart:convert';

import '../product/product_detail_model.dart';

AuctionDetailModel auctionDetailModelFromJson(String str) =>
    AuctionDetailModel.fromJson(json.decode(str));

String auctionDetailModelToJson(AuctionDetailModel data) =>
    json.encode(data.toJson());

class AuctionDetailModel {
  final bool? success;
  final AuctionDetailData? data;
  final bool? isWinner;
  final bool? canBid;
  final int? minimumNextBid;

  AuctionDetailModel({
    this.success,
    this.data,
    this.isWinner,
    this.canBid,
    this.minimumNextBid,
  });

  AuctionDetailModel copyWith({
    bool? success,
    AuctionDetailData? data,
    bool? isWinner,
    bool? canBid,
    int? minimumNextBid,
  }) =>
      AuctionDetailModel(
        success: success ?? this.success,
        data: data ?? this.data,
        isWinner: isWinner ?? this.isWinner,
        canBid: canBid ?? this.canBid,
        minimumNextBid: minimumNextBid ?? this.minimumNextBid,
      );

  factory AuctionDetailModel.fromJson(Map<String, dynamic> json) =>
      AuctionDetailModel(
        success: json["success"],
        data: json["data"] == null
            ? null
            : AuctionDetailData.fromJson(json["data"]),
        isWinner: json["is_winner"],
        canBid: json["can_bid"],
        minimumNextBid: json["minimum_next_bid"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
        "is_winner": isWinner,
        "can_bid": canBid,
        "minimum_next_bid": minimumNextBid,
      };
}

class AuctionDetailData {
  final int? id;
  final String? title;
  final String? status;
  final String? productPrice;
  final String? currentTotalPrice;
  final String? buyoutPrice;
  final String? minimumIncrement;
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
  final String? bidCancellationHours;
  final bool? autoCloseOnBuyout;
  final String? searchKeywords;
  final List<String>? tags;
  final Category? category;
  final Company? company;
  final Company? creator;
  final ProductDetailData? product;
  final List<dynamic>? images;
  final String? carBrand;
  final String? carModel;
  final String? carGeneration;
  final String? carMileage;
  final String? carCustomsCleared;

  final List<Review>? reviews;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? targetPrice;
  final String? higestBitPrice;
  final List<Bid>? bids;
  bool? isFavorite;
  final CreatorClass? winner;
  final bool? canMakeBuyOffer;

  AuctionDetailData({
    this.id,
    this.title,
    this.status,
    this.productPrice,
    this.currentTotalPrice,
    this.buyoutPrice,
    this.minimumIncrement,
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
    this.bidCancellationHours,
    this.autoCloseOnBuyout,
    this.searchKeywords,
    this.tags,
    this.category,
    this.company,
    this.creator,
    this.product,
    this.images,
    this.carBrand,
    this.carModel,
    this.carGeneration,
    this.carMileage,
    this.carCustomsCleared,
    this.reviews,
    this.createdAt,
    this.updatedAt,
    this.targetPrice,
    this.higestBitPrice,
    this.bids,
    this.isFavorite,
    this.winner,
    this.canMakeBuyOffer,
  });

  AuctionDetailData copyWith({
    int? id,
    String? title,
    String? status,
    String? productPrice,
    String? currentTotalPrice,
    String? buyoutPrice,
    String? minimumIncrement,
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
    String? bidCancellationHours,
    bool? autoCloseOnBuyout,
    String? searchKeywords,
    List<String>? tags,
    Category? category,
    Company? company,
    Company? creator,
    ProductDetailData? product,
    List<dynamic>? images,
    String? carBrand,
    String? carModel,
    String? carGeneration,
    String? carMileage,
    String? carCustomsCleared,
    List<Bid>? bids,
    List<Review>? reviews,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? targetPrice,
    String? higestBitPrice,
    bool? isFavorite,
    CreatorClass? winner,
    bool? canMakeBuyOffer,
  }) =>
      AuctionDetailData(
        id: id ?? this.id,
        title: title ?? this.title,
        status: status ?? this.status,
        productPrice: productPrice ?? this.productPrice,
        currentTotalPrice: currentTotalPrice ?? this.currentTotalPrice,
        buyoutPrice: buyoutPrice ?? this.buyoutPrice,
        minimumIncrement: minimumIncrement ?? this.minimumIncrement,
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
        bidCancellationHours: bidCancellationHours ?? this.bidCancellationHours,
        autoCloseOnBuyout: autoCloseOnBuyout ?? this.autoCloseOnBuyout,
        searchKeywords: searchKeywords ?? this.searchKeywords,
        tags: tags ?? this.tags,
        category: category ?? this.category,
        company: company ?? this.company,
        creator: creator ?? this.creator,
        product: product ?? this.product,
        images: images ?? this.images,
        carBrand: carBrand ?? this.carBrand,
        carModel: carModel ?? this.carModel,
        carGeneration: carGeneration ?? this.carGeneration,
        carMileage: carMileage ?? this.carMileage,
        carCustomsCleared: carCustomsCleared ?? this.carCustomsCleared,
        bids: bids ?? this.bids,
        reviews: reviews ?? this.reviews,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        targetPrice: targetPrice ?? this.targetPrice,
        higestBitPrice: higestBitPrice ?? this.higestBitPrice,
        isFavorite: isFavorite ?? this.isFavorite,
        winner: winner ?? this.winner,
        canMakeBuyOffer: canMakeBuyOffer ?? this.canMakeBuyOffer,
      );

  factory AuctionDetailData.fromJson(Map<String, dynamic> json) =>
      AuctionDetailData(
        id: json["id"],
        title: json["title"],
        status: json["status"],
        productPrice: json["product_price"],
        currentTotalPrice: json["current_total_price"],
        buyoutPrice: json["buyout_price"],
        minimumIncrement: json["minimum_increment"],
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
        bidCancellationHours: json["bid_cancellation_hours"],
        autoCloseOnBuyout: json["auto_close_on_buyout"],
        searchKeywords: json["search_keywords"],
        tags: json["tags"] == null
            ? []
            : List<String>.from(json["tags"]!.map((x) => x)),
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
        company:
            json["company"] == null ? null : Company.fromJson(json["company"]),
        creator:
            json["creator"] == null ? null : Company.fromJson(json["creator"]),
        product: json["product"] == null
            ? null
            : ProductDetailData.fromJson(json["product"]),
        images: json["images"] == null
            ? []
            : List<dynamic>.from(json["images"]!.map((x) => x)),
        carBrand: json["car_brand"],
        carModel: json["car_model"],
        carGeneration: json["car_generation"],
        carMileage: json["car_mileage"],
        carCustomsCleared: json["car_customs_cleared"],
        bids: json["bids"] == null
            ? []
            : List<Bid>.from(json["bids"]!.map((x) => Bid.fromJson(x))),
        reviews: json["reviews"] == null
            ? []
            : List<Review>.from(
                json["reviews"]!.map((x) => Review.fromJson(x))),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        targetPrice: json["target_price"],
        higestBitPrice: json["higest_bit_price"],
        isFavorite: json["is_favorite"] ?? false,
        winner: json["winner"] == null
            ? null
            : CreatorClass.fromJson(json["winner"]),
        canMakeBuyOffer: json["can_make_buy_offer"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "status": status,
        "product_price": productPrice,
        "current_total_price": currentTotalPrice,
        "buyout_price": buyoutPrice,
        "minimum_increment": minimumIncrement,
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
        "bid_cancellation_hours": bidCancellationHours,
        "auto_close_on_buyout": autoCloseOnBuyout,
        "search_keywords": searchKeywords,
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        "category": category?.toJson(),
        "company": company?.toJson(),
        "creator": creator?.toJson(),
        "product": product?.toJson(),
        "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "car_brand": carBrand,
        "car_model": carModel,
        "car_generation": carGeneration,
        "car_mileage": carMileage,
        "car_customs_cleared": carCustomsCleared,
        "bids": bids == null
            ? []
            : List<dynamic>.from(bids!.map((x) => x.toJson())),
        "reviews": reviews == null
            ? []
            : List<dynamic>.from(reviews!.map((x) => x.toJson())),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "target_price": targetPrice,
        "higest_bit_price": higestBitPrice,
        "is_favorite": isFavorite,
        "winner": winner?.toJson(),
        "can_make_buy_offer": canMakeBuyOffer,
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

class Review {
  final int? id;
  final BidUser? user;
  final dynamic company;
  final String? comment;
  final int? rating;
  final String? ratingStars;
  final DateTime? reviewedAt;
  final DateTime? createdAt;

  Review({
    this.id,
    this.user,
    this.company,
    this.comment,
    this.rating,
    this.ratingStars,
    this.reviewedAt,
    this.createdAt,
  });

  Review copyWith({
    int? id,
    BidUser? user,
    dynamic company,
    String? comment,
    int? rating,
    String? ratingStars,
    DateTime? reviewedAt,
    DateTime? createdAt,
  }) =>
      Review(
        id: id ?? this.id,
        user: user ?? this.user,
        company: company ?? this.company,
        comment: comment ?? this.comment,
        rating: rating ?? this.rating,
        ratingStars: ratingStars ?? this.ratingStars,
        reviewedAt: reviewedAt ?? this.reviewedAt,
        createdAt: createdAt ?? this.createdAt,
      );

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"],
        user: json["user"] == null ? null : BidUser.fromJson(json["user"]),
        company: json["company"],
        comment: json["comment"],
        rating: json["rating"],
        ratingStars: json["rating_stars"],
        reviewedAt: json["reviewed_at"] == null
            ? null
            : DateTime.parse(json["reviewed_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user?.toJson(),
        "company": company,
        "comment": comment,
        "rating": rating,
        "rating_stars": ratingStars,
        "reviewed_at": reviewedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
      };
}

class Bid {
  final int? id;
  final BidUser? user;
  final dynamic company;
  final String? bidAmount;
  final String? totalPrice;
  final String? percentageIncrease;
  final DateTime? createdAt;
  final String? timeSinceBid;

  Bid({
    this.id,
    this.user,
    this.company,
    this.bidAmount,
    this.totalPrice,
    this.percentageIncrease,
    this.createdAt,
    this.timeSinceBid,
  });

  Bid copyWith({
    int? id,
    BidUser? user,
    dynamic company,
    String? bidAmount,
    String? totalPrice,
    String? percentageIncrease,
    DateTime? createdAt,
    String? timeSinceBid,
  }) =>
      Bid(
        id: id ?? this.id,
        user: user ?? this.user,
        company: company ?? this.company,
        bidAmount: bidAmount ?? this.bidAmount,
        totalPrice: totalPrice ?? this.totalPrice,
        percentageIncrease: percentageIncrease ?? this.percentageIncrease,
        createdAt: createdAt ?? this.createdAt,
        timeSinceBid: timeSinceBid ?? this.timeSinceBid,
      );

  factory Bid.fromJson(Map<String, dynamic> json) => Bid(
        id: json["id"],
        user: json["user"] == null ? null : BidUser.fromJson(json["user"]),
        company: json["company"],
        bidAmount: json["bid_amount"],
        totalPrice: json["total_price"],
        percentageIncrease: json["percentage_increase"].toString(),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        timeSinceBid: json["time_since_bid"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user?.toJson(),
        "company": company,
        "bid_amount": bidAmount,
        "total_price": totalPrice,
        "percentage_increase": percentageIncrease,
        "created_at": createdAt?.toIso8601String(),
        "time_since_bid": timeSinceBid,
      };
}

class BidUser {
  final int? id;
  final String? name;

  BidUser({
    this.id,
    this.name,
  });

  BidUser copyWith({
    int? id,
    String? name,
  }) =>
      BidUser(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory BidUser.fromJson(Map<String, dynamic> json) => BidUser(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Category {
  final int? id;
  final String? name;
  final String? slug;
  final String? description;
  final String? brand;

  Category({
    this.id,
    this.name,
    this.slug,
    this.description,
    this.brand,
  });

  Category copyWith({
    int? id,
    String? name,
    String? slug,
    String? description,
    String? brand,
  }) =>
      Category(
        id: id ?? this.id,
        name: name ?? this.name,
        slug: slug ?? this.slug,
        description: description ?? this.description,
        brand: brand ?? this.brand,
      );

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        description: json["description"],
        brand: json["brand"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "description": description,
        "brand": brand,
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

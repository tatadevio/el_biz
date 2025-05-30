import 'package:el_biz/data/model/response/category/categories_list_model.dart';
import 'package:el_biz/data/model/response/cities_model.dart';
// To parse this JSON data, do
//
//     final companyDetailModel = companyDetailModelFromJson(jsonString);

import 'dart:convert';

CompanyDetailModel companyDetailModelFromJson(String str) =>
    CompanyDetailModel.fromJson(json.decode(str));

String companyDetailModelToJson(CompanyDetailModel data) =>
    json.encode(data.toJson());

class CompanyDetailModel {
  final dynamic title;
  final String? message;
  final String? status;
  final String? localizedKey;
  final Data? data;
  final int? statusCode;

  CompanyDetailModel({
    this.title,
    this.message,
    this.status,
    this.localizedKey,
    this.data,
    this.statusCode,
  });

  CompanyDetailModel copyWith({
    dynamic title,
    String? message,
    String? status,
    String? localizedKey,
    Data? data,
    int? statusCode,
  }) =>
      CompanyDetailModel(
        title: title ?? this.title,
        message: message ?? this.message,
        status: status ?? this.status,
        localizedKey: localizedKey ?? this.localizedKey,
        data: data ?? this.data,
        statusCode: statusCode ?? this.statusCode,
      );

  factory CompanyDetailModel.fromJson(Map<String, dynamic> json) =>
      CompanyDetailModel(
        title: json["title"],
        message: json["message"],
        status: json["status"],
        localizedKey: json["localized_key"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        statusCode: json["status_code"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "message": message,
        "status": status,
        "localized_key": localizedKey,
        "data": data?.toJson(),
        "status_code": statusCode,
      };
}

class Data {
  final int? id;
  final String? name;
  final String? email;
  final String? logo;
  final String? banner;
  final String? description;
  final String? phone;
  final String? address;
  final String? verificationStatus;
  final String? tinNumber;
  final String? aboutCompany;
  final String? legalEntity;
  final List<String>? searchTags;
  final String? okpo;
  final DateTime? createdAt;
  final String? reviewsAvgRating;
  final Owner? owner;
  final WorkingHours? workingHours;
  final LunchBreak? lunchBreak;
  final List<String>? phoneNumbers;
  final List<Contact>? contacts;
  final String? street;
  final String? house;
  final String? office;
  final String? postalCode;
  final CityItem? city;
  final List<CategoryItem>? categories;

  Data({
    this.id,
    this.name,
    this.email,
    this.logo,
    this.banner,
    this.description,
    this.phone,
    this.address,
    this.verificationStatus,
    this.tinNumber,
    this.aboutCompany,
    this.legalEntity,
    this.searchTags,
    this.okpo,
    this.createdAt,
    this.reviewsAvgRating,
    this.owner,
    this.workingHours,
    this.lunchBreak,
    this.phoneNumbers,
    this.contacts,
    this.street,
    this.house,
    this.office,
    this.postalCode,
    this.city,
    this.categories,
  });

  Data copyWith({
    int? id,
    String? name,
    String? email,
    String? logo,
    String? banner,
    String? description,
    String? phone,
    String? address,
    String? verificationStatus,
    String? tinNumber,
    String? aboutCompany,
    String? legalEntity,
    List<String>? searchTags,
    String? okpo,
    DateTime? createdAt,
    String? reviewsAvgRating,
    Owner? owner,
    WorkingHours? workingHours,
    LunchBreak? lunchBreak,
    List<String>? phoneNumbers,
    List<Contact>? contacts,
    String? street,
    String? house,
    String? office,
    String? postalCode,
    CityItem? city,
    List<CategoryItem>? categories,
  }) =>
      Data(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        logo: logo ?? this.logo,
        banner: banner ?? this.banner,
        description: description ?? this.description,
        phone: phone ?? this.phone,
        address: address ?? this.address,
        verificationStatus: verificationStatus ?? this.verificationStatus,
        tinNumber: tinNumber ?? this.tinNumber,
        aboutCompany: aboutCompany ?? this.aboutCompany,
        legalEntity: legalEntity ?? this.legalEntity,
        searchTags: searchTags ?? this.searchTags,
        okpo: okpo ?? this.okpo,
        createdAt: createdAt ?? this.createdAt,
        reviewsAvgRating: reviewsAvgRating ?? this.reviewsAvgRating,
        owner: owner ?? this.owner,
        workingHours: workingHours ?? this.workingHours,
        lunchBreak: lunchBreak ?? this.lunchBreak,
        phoneNumbers: phoneNumbers ?? this.phoneNumbers,
        contacts: contacts ?? this.contacts,
        street: street ?? this.street,
        house: house ?? this.house,
        office: office ?? this.office,
        postalCode: postalCode ?? this.postalCode,
        city: city ?? this.city,
        categories: categories ?? this.categories,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        logo: json["logo"],
        banner: json["banner"],
        description: json["description"],
        phone: json["phone"],
        address: json["address"],
        verificationStatus: json["verification_status"],
        tinNumber: json["tin_number"],
        aboutCompany: json["about_company"],
        legalEntity: json["legal_entity"],
        searchTags: json["search_tags"] == null
            ? []
            : List<String>.from(json["search_tags"]!.map((x) => x)),
        okpo: json["okpo"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        reviewsAvgRating: json["reviews_avg_rating"],
        owner: json["owner"] == null ? null : Owner.fromJson(json["owner"]),

        // <-- Safely handle working_hours as Map or empty
        workingHours: (json["working_hours"] is Map<String, dynamic>)
            ? WorkingHours.fromJson(json["working_hours"])
            : null,

        // <-- Safely handle lunch_break as Map or empty
        lunchBreak: (json["lunch_break"] is Map<String, dynamic>)
            ? LunchBreak.fromJson(json["lunch_break"])
            : null,

        // <-- Safely handle phone_numbers as List<String> or empty list
        phoneNumbers: (json["phone_numbers"] is List)
            ? List<String>.from(json["phone_numbers"].map((x) => x.toString()))
            : [],

        // <-- Safely handle contacts as List<Contact> or empty list
        contacts: (json["contacts"] is List)
            ? List<Contact>.from(
                json["contacts"].map((x) => Contact.fromJson(x)))
            : [],
        // workingHours: json["working_hours"] == null
        //     ? null
        //     : WorkingHours.fromJson(json["working_hours"]),
        // lunchBreak: json["lunch_break"] == null
        //     ? null
        //     : LunchBreak.fromJson(json["lunch_break"]),
        // phoneNumbers: json["phone_numbers"] == null
        //     ? []
        //     : List<String>.from(json["phone_numbers"]!.map((x) => x)),
        // contacts: json["contacts"] == null
        //     ? []
        //     : List<Contact>.from(
        //         json["contacts"]!.map((x) => Contact.fromJson(x))),
        street: json["street"],
        house: json["house"],
        office: json["office"],
        postalCode: json["postal_code"],
        city: json["city"] == null ? null : CityItem.fromJson(json["city"]),
        categories: json["categories"] == null
            ? []
            : List<CategoryItem>.from(
                json["categories"]!.map((x) => CategoryItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "logo": logo,
        "banner": banner,
        "description": description,
        "phone": phone,
        "address": address,
        "verification_status": verificationStatus,
        "tin_number": tinNumber,
        "about_company": aboutCompany,
        "legal_entity": legalEntity,
        "search_tags": searchTags == null
            ? []
            : List<dynamic>.from(searchTags!.map((x) => x)),
        "okpo": okpo,
        "created_at": createdAt?.toIso8601String(),
        "reviews_avg_rating": reviewsAvgRating,
        "owner": owner?.toJson(),
        "working_hours": workingHours?.toJson(),
        "lunch_break": lunchBreak?.toJson(),
        "phone_numbers": phoneNumbers == null
            ? []
            : List<dynamic>.from(phoneNumbers!.map((x) => x)),
        "contacts": contacts == null
            ? []
            : List<dynamic>.from(contacts!.map((x) => x.toJson())),
        "street": street,
        "house": house,
        "office": office,
        "postal_code": postalCode,
        "city": city?.toJson(),
        "categories": categories == null
            ? []
            : List<dynamic>.from(categories!.map((x) => x.toJson())),
      };
}

// class Category {
//   final int? id;
//   final String? name;
//   final String? slug;
//   final String? description;
//   final String? image;
//   final int? parentId;
//   final String? status;

//   Category({
//     this.id,
//     this.name,
//     this.slug,
//     this.description,
//     this.image,
//     this.parentId,
//     this.status,
//   });

//   Category copyWith({
//     int? id,
//     String? name,
//     String? slug,
//     String? description,
//     String? image,
//     int? parentId,
//     String? status,
//   }) =>
//       Category(
//         id: id ?? this.id,
//         name: name ?? this.name,
//         slug: slug ?? this.slug,
//         description: description ?? this.description,
//         image: image ?? this.image,
//         parentId: parentId ?? this.parentId,
//         status: status ?? this.status,
//       );

//   factory Category.fromJson(Map<String, dynamic> json) => Category(
//         id: json["id"],
//         name: json["name"],
//         slug: json["slug"],
//         description: json["description"],
//         image: json["image"],
//         parentId: json["parent_id"],
//         status: json["status"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "slug": slug,
//         "description": description,
//         "image": image,
//         "parent_id": parentId,
//         "status": status,
//       };
// }

// class City {
//   final int? id;
//   final String? name;

//   City({
//     this.id,
//     this.name,
//   });

//   City copyWith({
//     int? id,
//     String? name,
//   }) =>
//       City(
//         id: id ?? this.id,
//         name: name ?? this.name,
//       );

//   factory City.fromJson(Map<String, dynamic> json) => City(
//         id: json["id"],
//         name: json["name"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//       };
// }

class Contact {
  final String? name;
  final String? contact;

  Contact({
    this.name,
    this.contact,
  });

  Contact copyWith({
    String? name,
    String? contact,
  }) =>
      Contact(
        name: name ?? this.name,
        contact: contact ?? this.contact,
      );

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        name: json["name"],
        contact: json["contact"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "contact": contact,
      };
}

class LunchBreak {
  final String? open;
  final String? close;

  LunchBreak({
    this.open,
    this.close,
  });

  LunchBreak copyWith({
    String? open,
    String? close,
  }) =>
      LunchBreak(
        open: open ?? this.open,
        close: close ?? this.close,
      );

  factory LunchBreak.fromJson(Map<String, dynamic> json) => LunchBreak(
        open: json["open"],
        close: json["close"],
      );

  Map<String, dynamic> toJson() => {
        "open": open,
        "close": close,
      };
}

class Owner {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? image;
  final String? status;

  Owner({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.status,
  });

  Owner copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? image,
    String? status,
  }) =>
      Owner(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        image: image ?? this.image,
        status: status ?? this.status,
      );

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        image: json["image"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "image": image,
        "status": status,
      };
}

class WorkingHours {
  final LunchBreak? monday;
  final LunchBreak? tuesday;
  final LunchBreak? wednesday;
  final LunchBreak? thursday;
  final LunchBreak? friday;
  final LunchBreak? saturday;
  final LunchBreak? sunday;

  WorkingHours({
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
    this.saturday,
    this.sunday,
  });

  WorkingHours copyWith({
    LunchBreak? monday,
    LunchBreak? tuesday,
    LunchBreak? wednesday,
    LunchBreak? thursday,
    LunchBreak? friday,
    LunchBreak? saturday,
    LunchBreak? sunday,
  }) =>
      WorkingHours(
        monday: monday ?? this.monday,
        tuesday: tuesday ?? this.tuesday,
        wednesday: wednesday ?? this.wednesday,
        thursday: thursday ?? this.thursday,
        friday: friday ?? this.friday,
        saturday: saturday ?? this.saturday,
        sunday: sunday ?? this.sunday,
      );

  factory WorkingHours.fromJson(Map<String, dynamic> json) => WorkingHours(
        monday:
            json["monday"] == null ? null : LunchBreak.fromJson(json["monday"]),
        tuesday: json["tuesday"] == null
            ? null
            : LunchBreak.fromJson(json["tuesday"]),
        wednesday: json["wednesday"] == null
            ? null
            : LunchBreak.fromJson(json["wednesday"]),
        thursday: json["thursday"] == null
            ? null
            : LunchBreak.fromJson(json["thursday"]),
        friday:
            json["friday"] == null ? null : LunchBreak.fromJson(json["friday"]),
        saturday: json["saturday"] == null
            ? null
            : LunchBreak.fromJson(json["saturday"]),
        sunday:
            json["sunday"] == null ? null : LunchBreak.fromJson(json["sunday"]),
      );

  Map<String, dynamic> toJson() => {
        "monday": monday?.toJson(),
        "tuesday": tuesday?.toJson(),
        "wednesday": wednesday?.toJson(),
        "thursday": thursday?.toJson(),
        "friday": friday?.toJson(),
        "saturday": saturday?.toJson(),
        "sunday": sunday?.toJson(),
      };
}

import 'package:el_biz/data/model/response/bank_model.dart';
import 'package:image_picker/image_picker.dart';

import '../response/category/categories_list_model.dart';
import '../response/cities_model.dart';
import 'timing_date_model.dart';

class AddCompanyModel {
  String? tinNumber;
  String? companyName;
  String? companyNumber;
  XFile? companyLogo;
  XFile? companyBanner;
  String? description;
  List<String>? keywords;
  CityItem? city;
  // address
  String? street;
  String? house;
  String? office;
  String? postalCode;
  String? workingHours;
  List<String>? phoneNumbers;
  String? email;
  List<OtherContacts>? otherContacts;
  List<BankItem>? bankData;
  XFile? certificateDocument;
  List<XFile>? otherDocuments;
  List<DaySchedule>? schedule;
  DaySchedule? lunchBreak;
  List<CategoryItem>? categories;
  String? aboutCompany;

  AddCompanyModel({
    this.tinNumber,
    this.companyName,
    this.companyNumber,
    this.companyLogo,
    this.companyBanner,
    this.description,
    this.keywords,
    this.city,
    this.street,
    this.house,
    this.office,
    this.postalCode,
    this.workingHours,
    this.phoneNumbers,
    this.email,
    this.otherContacts,
    this.bankData,
    this.certificateDocument,
    this.otherDocuments,
    this.schedule,
    this.lunchBreak,
    this.categories,
    this.aboutCompany,
  });

  // Factory method for JSON deserialization
  factory AddCompanyModel.fromJson(Map<String, dynamic> json) {
    return AddCompanyModel(
      tinNumber: json['tinNumber'],
      companyName: json['companyName'],
      companyNumber: json['companyNumber'],
      companyLogo:
          json['companyLogo'] != null ? XFile(json['companyLogo']) : null,
      companyBanner:
          json['companyBanner'] != null ? XFile(json['companyBanner']) : null,
      description: json['description'],
      keywords:
          json['keywords'] != null ? List<String>.from(json['keywords']) : null,
      city: CityItem.fromJson(
        json['city'],
      ),
      street: json['street'],
      house: json['house'],
      office: json['office'],
      postalCode: json['postalCode'],
      workingHours: json['workingHours'],
      phoneNumbers: json['phoneNumbers'] != null
          ? List<String>.from(json['phoneNumbers'])
          : null,
      email: json['email'],
      otherContacts: json['otherContacts'] != null
          ? (json['otherContacts'] as List)
              .map((e) => OtherContacts.fromJson(e))
              .toList()
          : null,
      bankData: json['bankData'] != null
          ? (json['bankData'] as List).map((e) => BankItem.fromJson(e)).toList()
          : null,
      certificateDocument: json['certificateDocument'] != null
          ? XFile(json['certificateDocument'])
          : null,
      otherDocuments: json['otherDocuments'] != null
          ? (json['otherDocuments'] as List).map((e) => XFile(e)).toList()
          : null,
      // schedule: json['bankData'] != null
      // ? (json['bankData'] as List).map((e) => DaySchedule.toma(e)).toList()
      // : null,
      categories: json['categories'] != null
          ? (json['categories'] as List)
              .map((e) => CategoryItem.fromJson(e))
              .toList()
          : null,
      aboutCompany: json['aboutCompany'],
    );
  }

  // Method for JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'tinNumber': tinNumber,
      'companyName': companyName,
      'companyNumber': companyNumber,
      'companyLogo': companyLogo?.path,
      'companyBanner': companyBanner?.path,
      'description': description,
      'keywords': keywords,
      'city': city?.toJson(),
      'street': street,
      'house': house,
      'office': office,
      'postalCode': postalCode,
      'workingHours': workingHours,
      'phoneNumbers': phoneNumbers,
      'email': email,
      'otherContacts': otherContacts?.map((e) => e.toJson()).toList(),
      'bankData': bankData?.map((e) => e.toJson()).toList(),
      // bankData?.toJson(),
      'certificateDocument': certificateDocument?.path,
      'otherDocuments': otherDocuments?.map((e) => e.path).toList(),
      'categories': categories?.map((e) => e.toJson()).toList(),
      'aboutCompany': aboutCompany,
    };
  }

  // Copy with method
  AddCompanyModel copyWith({
    String? tinNumber,
    String? companyName,
    String? companyNumber,
    XFile? companyLogo,
    XFile? companyBanner,
    String? description,
    List<String>? keywords,
    CityItem? city,
    String? street,
    String? house,
    String? office,
    String? postalCode,
    String? workingHours,
    List<String>? phoneNumbers,
    String? email,
    List<OtherContacts>? otherContacts,
    List<BankItem>? bankData,
    XFile? certificateDocument,
    List<XFile>? otherDocuments,
    List<DaySchedule>? schedule,
    DaySchedule? lunchBreak,
    List<CategoryItem>? categories,
    String? aboutCompany,
  }) {
    return AddCompanyModel(
      tinNumber: tinNumber ?? this.tinNumber,
      companyName: companyName ?? this.companyName,
      companyNumber: companyNumber ?? this.companyNumber,
      companyLogo: companyLogo ?? this.companyLogo,
      companyBanner: companyBanner ?? this.companyBanner,
      description: description ?? this.description,
      keywords: keywords ?? this.keywords,
      city: city ?? this.city,
      street: street ?? this.street,
      house: house ?? this.house,
      office: office ?? this.office,
      postalCode: postalCode ?? this.postalCode,
      workingHours: workingHours ?? this.workingHours,
      phoneNumbers: phoneNumbers ?? this.phoneNumbers,
      email: email ?? this.email,
      otherContacts: otherContacts ?? this.otherContacts,
      bankData: bankData ?? this.bankData,
      certificateDocument: certificateDocument ?? this.certificateDocument,
      otherDocuments: otherDocuments ?? this.otherDocuments,
      schedule: schedule ?? this.schedule,
      lunchBreak: lunchBreak ?? this.lunchBreak,
      categories: categories ?? this.categories,
      aboutCompany: aboutCompany ?? this.aboutCompany,
    );
  }

  @override
  String toString() {
    return 'AddCompanyModel(companyName: $companyName, companyNumber: $companyNumber, email: $email, categories: $categories, tinNumber: $tinNumber)';
  }
}

// OtherContacts Model
class OtherContacts {
  final String? id;
  final String? contactName;
  final String? contactNumber;

  OtherContacts({
    required this.id,
    required this.contactName,
    required this.contactNumber,
  });

  // Factory method for JSON deserialization
  factory OtherContacts.fromJson(Map<String, dynamic> json) {
    return OtherContacts(
      id: json['id'],
      contactName: json['contactName'],
      contactNumber: json['contactNumber'],
    );
  }

  // Method for JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'contactName': contactName,
      'contactNumber': contactNumber,
    };
  }

  @override
  String toString() {
    return 'OtherContacts(id: $id, contactName: $contactName, contactNumber: $contactNumber)';
  }
}

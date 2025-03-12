import 'package:el_biz/data/model/response/bank_model.dart';
import 'package:image_picker/image_picker.dart';

class AddCompanyModel {
  String? companyName;
  String? companyNumber;
  XFile? companyLogo;
  XFile? companyBanner;
  String? description;
  List<String>? keywords;
  String? city;
  // address
  String? street;
  String? house;
  String? office;
  String? postalCode;
  String? workingHours;
  List<String>? phoneNumbers;
  String? email;
  List<OtherContacts>? otherContacts;
  BankItem? bankData;
  XFile? certificateDocument;
  List<XFile>? otherDocuments;

  AddCompanyModel({
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
  });

  // Factory method for JSON deserialization
  factory AddCompanyModel.fromJson(Map<String, dynamic> json) {
    return AddCompanyModel(
      companyName: json['companyName'],
      companyNumber: json['companyNumber'],
      companyLogo:
          json['companyLogo'] != null ? XFile(json['companyLogo']) : null,
      companyBanner:
          json['companyBanner'] != null ? XFile(json['companyBanner']) : null,
      description: json['description'],
      keywords:
          json['keywords'] != null ? List<String>.from(json['keywords']) : null,
      city: json['city'],
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
      bankData:
          json['bankData'] != null ? BankItem.fromJson(json['bankData']) : null,
      certificateDocument: json['certificateDocument'] != null
          ? XFile(json['certificateDocument'])
          : null,
      otherDocuments: json['otherDocuments'] != null
          ? (json['otherDocuments'] as List).map((e) => XFile(e)).toList()
          : null,
    );
  }

  // Method for JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'companyName': companyName,
      'companyNumber': companyNumber,
      'companyLogo': companyLogo?.path,
      'companyBanner': companyBanner?.path,
      'description': description,
      'keywords': keywords,
      'city': city,
      'street': street,
      'house': house,
      'office': office,
      'postalCode': postalCode,
      'workingHours': workingHours,
      'phoneNumbers': phoneNumbers,
      'email': email,
      'otherContacts': otherContacts?.map((e) => e.toJson()).toList(),
      'bankData': bankData?.toJson(),
      'certificateDocument': certificateDocument?.path,
      'otherDocuments': otherDocuments?.map((e) => e.path).toList(),
    };
  }

  // Copy with method
  AddCompanyModel copyWith({
    String? companyName,
    String? companyNumber,
    XFile? companyLogo,
    XFile? companyBanner,
    String? description,
    List<String>? keywords,
    String? city,
    String? street,
    String? house,
    String? office,
    String? postalCode,
    String? workingHours,
    List<String>? phoneNumbers,
    String? email,
    List<OtherContacts>? otherContacts,
    BankItem? bankData,
    XFile? certificateDocument,
    List<XFile>? otherDocuments,
  }) {
    return AddCompanyModel(
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
    );
  }

  @override
  String toString() {
    return 'AddCompanyModel(companyName: $companyName, companyNumber: $companyNumber, email: $email)';
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

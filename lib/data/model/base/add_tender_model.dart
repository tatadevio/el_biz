import 'package:el_biz/data/model/response/category/categories_list_model.dart';
import 'package:el_biz/data/model/response/company/my_companies_model.dart';
import 'package:image_picker/image_picker.dart';

import '../response/tender/tender_detail_model.dart';

class AddTenderModel {
  String? id;
  String? whatToBuy;
  List<XFile>? images;
  String? shortDescription;
  List<TenderProduct>? product;
  String? budgetStart;
  String? budgetEnd;
  String? phone;
  String? email;
  List<CategoryItem>? categories;
  CompanyItem? selectedCompany;
  List<Media>? uploadedImages;
  List<Media>? deleteImages;

  AddTenderModel({
    this.id,
    this.whatToBuy,
    this.images,
    this.shortDescription,
    this.product,
    this.budgetStart,
    this.budgetEnd,
    this.phone,
    this.email,
    this.categories,
    this.selectedCompany,
    this.uploadedImages,
    this.deleteImages,
  });

  factory AddTenderModel.fromJson(Map<String, dynamic> json) {
    return AddTenderModel(
      id: json['id'],
      whatToBuy: json['whatToBuy'],
      images: (json['images'] as List<dynamic>?)?.map((x) => XFile(x)).toList(),
      shortDescription: json['shortDescription'],
      product: (json['product'] as List<dynamic>?)
          ?.map((x) => TenderProduct.fromJson(x))
          .toList(),
      budgetStart: json['budgetStart'],
      budgetEnd: json['budgetEnd'],
      phone: json['phone'],
      email: json['email'],
      categories: json['categories'],
      selectedCompany: CompanyItem.fromJson(json['company']),
      uploadedImages: (json['uploadedImages'] as List<dynamic>?)?.cast<Media>(),
      deleteImages: (json['deleteImages'] as List<dynamic>?)?.cast<Media>(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'whatToBuy': whatToBuy,
      'images': images?.map((x) => x.path).toList(),
      'shortDescription': shortDescription,
      'product': product?.map((x) => x.toJson()).toList(),
      'budgetStart': budgetStart,
      'budgetEnd': budgetEnd,
      'phone': phone,
      'email': email,
      "categories": categories,
      "company": selectedCompany,
      "uploadedImages": uploadedImages,
      "deleteImages": deleteImages,
    };
  }

  AddTenderModel copyWith({
    String? id,
    String? whatToBuy,
    List<XFile>? images,
    String? shortDescription,
    List<TenderProduct>? product,
    String? budgetStart,
    String? budgetEnd,
    String? phone,
    String? email,
    List<CategoryItem>? categories,
    CompanyItem? selectedCompany,
    List<Media>? uploadedImages,
    List<Media>? deleteImages,
  }) {
    return AddTenderModel(
      id: id ?? this.id,
      whatToBuy: whatToBuy ?? this.whatToBuy,
      images: images ?? this.images,
      shortDescription: shortDescription ?? this.shortDescription,
      product: product ?? this.product,
      budgetStart: budgetStart ?? this.budgetStart,
      budgetEnd: budgetEnd ?? this.budgetEnd,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      categories: categories ?? this.categories,
      selectedCompany: selectedCompany ?? this.selectedCompany,
      uploadedImages: uploadedImages ?? this.uploadedImages,
      deleteImages: deleteImages ?? this.deleteImages,
    );
  }
}

class TenderProduct {
  final String? id;
  final String? productName;
  final int? quantity;

  TenderProduct({
    this.id,
    this.productName,
    this.quantity,
  });

  factory TenderProduct.fromJson(Map<String, dynamic> json) {
    return TenderProduct(
      id: json['id'],
      productName: json['productName'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productName': productName,
      'quantity': quantity,
    };
  }
}

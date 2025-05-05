import 'package:el_biz/data/model/response/category/categories_list_model.dart';
import 'package:el_biz/data/model/response/company/my_companies_model.dart';
import 'package:el_biz/data/model/response/materials_model.dart';
import 'package:el_biz/data/model/response/product/product_detail_model.dart';
import 'package:image_picker/image_picker.dart';

class AddProductModel {
  String? brandName;
  String? productName;
  String? productCode;
  String? price;
  String? currency;
  String? quantity;
  String? quantityUnit;
  String? dimensions;
  String? dimensionsUnit;
  String? weight;
  String? weightUnit;
  String? region;
  String? description;
  String? keywords;
  List<String>? size;
  String? availability;
  List<XFile>? productImages;
  MaterialItem? material;
  CategoryItem? category;
  CompanyItem? company;
  List<ProductDetailImages>? productUploadedImages;
  List<ProductDetailImages>? deleteProductImages;

  // Constructor
  AddProductModel({
    this.brandName,
    this.productName,
    this.productCode,
    this.price,
    this.currency,
    this.quantity,
    this.quantityUnit,
    this.dimensions,
    this.dimensionsUnit,
    this.weight,
    this.weightUnit,
    this.region,
    this.description,
    this.keywords,
    this.size,
    this.availability,
    this.productImages,
    this.material,
    this.category,
    this.company,
    this.productUploadedImages,
    this.deleteProductImages,
  });

  // Factory method for JSON deserialization
  factory AddProductModel.fromJson(Map<String, dynamic> json) {
    return AddProductModel(
      brandName: json['brandName'],
      productName: json['productName'],
      productCode: json['productCode'],
      price: json['price'],
      currency: json['currency'],
      quantity: json['quantity'],
      quantityUnit: json['quantityUnit'],
      dimensions: json['dimensions'],
      dimensionsUnit: json['dimensionsUnit'],
      weight: json['weight'],
      weightUnit: json['weightUnit'],
      region: json['region'],
      description: json['description'],
      keywords: json['keywords'],
      size: (json['size'] as List<dynamic>?)?.cast<String>(),
      availability: json['availability'],
      productImages: (json['productImages'] as List<dynamic>?)?.cast<XFile>(),
      material: MaterialItem.fromJson(
        json['material'],
      ),
      category: CategoryItem.fromJson(json['category']),
      company: CompanyItem.fromJson(json['company']),
      productUploadedImages: (json['productUploadedImages'] as List<dynamic>?)
          ?.cast<ProductDetailImages>(),
      deleteProductImages: (json['deleteProductImages'] as List<dynamic>?)
          ?.cast<ProductDetailImages>(),
    );
  }

  // Method for JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'brandName': brandName,
      'productName': productName,
      'productCode': productCode,
      'price': price,
      'currency': currency,
      'quantity': quantity,
      'quantityUnit': quantityUnit,
      'dimensions': dimensions,
      'dimensionsUnit': dimensionsUnit,
      'weight': weight,
      'weightUnit': weightUnit,
      'region': region,
      'description': description,
      'keywords': keywords,
      'size': size,
      'availability': availability,
      'productImages': productImages,
      "material": material,
      "category": category,
      "company": company,
      "productUploadedImages": productUploadedImages,
      "deleteProductImages": deleteProductImages,
    };
  }

  // CopyWith method for immutability
  AddProductModel copyWith({
    String? brandName,
    String? productName,
    String? productCode,
    String? price,
    String? currency,
    String? quantity,
    String? quantityUnit,
    String? dimensions,
    String? dimensionsUnit,
    String? weight,
    String? weightUnit,
    String? region,
    String? description,
    String? keywords,
    List<String>? size,
    String? availability,
    List<XFile>? productImages,
    MaterialItem? material,
    CategoryItem? category,
    CompanyItem? company,
    List<ProductDetailImages>? productUploadedImages,
    List<ProductDetailImages>? deleteProductImages,
  }) {
    return AddProductModel(
      brandName: brandName ?? this.brandName,
      productName: productName ?? this.productName,
      productCode: productCode ?? this.productCode,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      quantity: quantity ?? this.quantity,
      quantityUnit: quantityUnit ?? this.quantityUnit,
      dimensions: dimensions ?? this.dimensions,
      dimensionsUnit: dimensionsUnit ?? this.dimensionsUnit,
      weight: weight ?? this.weight,
      weightUnit: weightUnit ?? this.weightUnit,
      region: region ?? this.region,
      description: description ?? this.description,
      keywords: keywords ?? this.keywords,
      size: size ?? this.size,
      availability: availability ?? this.availability,
      productImages: productImages ?? this.productImages,
      material: material ?? this.material,
      category: category ?? this.category,
      company: company ?? this.company,
      productUploadedImages:
          productUploadedImages ?? this.productUploadedImages,
      deleteProductImages: deleteProductImages ?? this.deleteProductImages,
    );
  }

  // Override toString for debugging
  @override
  String toString() {
    return 'AddProductModel(brandName: $brandName, productName: $productName, productCode: $productCode, price: $price, currency: $currency, quantity: $quantity, quantityUnit: $quantityUnit, dimensions: $dimensions, dimensionsUnit: $dimensionsUnit, weight: $weight, weightUnit: $weightUnit, region: $region, description: $description, keywords: $keywords, size: $size, availability: $availability, productImages: $productImages, material: $material, productUploadedImages: $productUploadedImages, deleteProductImages: $deleteProductImages)';
  }
}

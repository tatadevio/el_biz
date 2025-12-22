// To parse this JSON data, do
//
//     final productImportErrorModel = productImportErrorModelFromJson(jsonString);

import 'dart:convert';

ProductImportErrorModel productImportErrorModelFromJson(String str) =>
    ProductImportErrorModel.fromJson(json.decode(str));

String productImportErrorModelToJson(ProductImportErrorModel data) =>
    json.encode(data.toJson());

class ProductImportErrorModel {
  final bool? success;
  final ProductImportErrorModelData? data;

  ProductImportErrorModel({
    this.success,
    this.data,
  });

  ProductImportErrorModel copyWith({
    bool? success,
    ProductImportErrorModelData? data,
  }) =>
      ProductImportErrorModel(
        success: success ?? this.success,
        data: data ?? this.data,
      );

  factory ProductImportErrorModel.fromJson(Map<String, dynamic> json) =>
      ProductImportErrorModel(
        success: json["success"],
        data: json["data"] == null
            ? null
            : ProductImportErrorModelData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
      };
}

class ProductImportErrorModelData {
  final int? importId;
  final String? filename;
  final int? totalErrors;
  final List<Error>? errors;

  ProductImportErrorModelData({
    this.importId,
    this.filename,
    this.totalErrors,
    this.errors,
  });

  ProductImportErrorModelData copyWith({
    int? importId,
    String? filename,
    int? totalErrors,
    List<Error>? errors,
  }) =>
      ProductImportErrorModelData(
        importId: importId ?? this.importId,
        filename: filename ?? this.filename,
        totalErrors: totalErrors ?? this.totalErrors,
        errors: errors ?? this.errors,
      );

  factory ProductImportErrorModelData.fromJson(Map<String, dynamic> json) =>
      ProductImportErrorModelData(
        importId: json["import_id"],
        filename: json["filename"],
        totalErrors: json["total_errors"],
        errors: json["errors"] == null
            ? []
            : List<Error>.from(json["errors"]!.map((x) => Error.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "import_id": importId,
        "filename": filename,
        "total_errors": totalErrors,
        "errors": errors == null
            ? []
            : List<dynamic>.from(errors!.map((x) => x.toJson())),
      };
}

class Error {
  final int? row;
  final String? message;
  final ErrorData? data;

  Error({
    this.row,
    this.message,
    this.data,
  });

  Error copyWith({
    int? row,
    String? message,
    ErrorData? data,
  }) =>
      Error(
        row: row ?? this.row,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        row: json["row"],
        message: json["message"] ?? '',
        data: json["data"] == null ? null : ErrorData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "row": row,
        "message": message,
        "data": data?.toJson(),
      };
}

class ErrorData {
  final String? name;
  final String? price;
  final int? quantity;
  final int? status;
  final String? brand;
  final String? description;
  final String? isAvailable;
  final String? dimension;
  final String? weight;
  final String? countryOfOrigin;
  final String? searchKeywords;
  final String? material;

  ErrorData({
    this.name,
    this.price,
    this.quantity,
    this.status,
    this.brand,
    this.description,
    this.isAvailable,
    this.dimension,
    this.weight,
    this.countryOfOrigin,
    this.searchKeywords,
    this.material,
  });

  ErrorData copyWith({
    String? name,
    String? price,
    int? quantity,
    int? status,
    String? brand,
    String? description,
    String? isAvailable,
    String? dimension,
    String? weight,
    String? countryOfOrigin,
    String? searchKeywords,
    String? material,
  }) =>
      ErrorData(
        name: name ?? this.name,
        price: price ?? this.price,
        quantity: quantity ?? this.quantity,
        status: status ?? this.status,
        brand: brand ?? this.brand,
        description: description ?? this.description,
        isAvailable: isAvailable ?? this.isAvailable,
        dimension: dimension ?? this.dimension,
        weight: weight ?? this.weight,
        countryOfOrigin: countryOfOrigin ?? this.countryOfOrigin,
        searchKeywords: searchKeywords ?? this.searchKeywords,
        material: material ?? this.material,
      );

  factory ErrorData.fromJson(Map<String, dynamic> json) => ErrorData(
        name: json["name"],
        price: json["price"].toString(),
        quantity: json["quantity"],
        status: json["status"],
        brand: json["brand"].toString(),
        description: json["description"].toString(),
        isAvailable: json["is_available"].toString(),
        dimension: json["dimension"].toString(),
        weight: json["weight"].toString(),
        countryOfOrigin: json["country_of_origin"].toString(),
        searchKeywords: json["search_keywords"].toString(),
        material: json["material"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
        "quantity": quantity,
        "status": status,
        "brand": brand,
        "description": description,
        "is_available": isAvailable,
        "dimension": dimension,
        "weight": weight,
        "country_of_origin": countryOfOrigin,
        "search_keywords": searchKeywords,
        "material": material,
      };
}

// enum CountryOfOrigin { NEPAL }

// final countryOfOriginValues = EnumValues({"Nepal": CountryOfOrigin.NEPAL});

// enum Description { HIGH_QUALITY_ITEM }

// final descriptionValues =
//     EnumValues({"High-quality item": Description.HIGH_QUALITY_ITEM});

// enum Dimension { THE_100_X50_X75_CM }

// final dimensionValues =
//     EnumValues({"100x50x75 cm": Dimension.THE_100_X50_X75_CM});

// enum IsAvailable { YES }

// final isAvailableValues = EnumValues({"yes": IsAvailable.YES});

// enum Material { WOOD }

// final materialValues = EnumValues({"Wood": Material.WOOD});

// enum SearchKeywords { FURNITURE_HOME }

// final searchKeywordsValues =
//     EnumValues({"furniture, home": SearchKeywords.FURNITURE_HOME});

// enum Message { PRICE_MUST_BE_A_VALID_NUMBER }

// final messageValues = EnumValues(
//     {"Price must be a valid number": Message.PRICE_MUST_BE_A_VALID_NUMBER});

// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;

//   EnumValues(this.map);

//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }

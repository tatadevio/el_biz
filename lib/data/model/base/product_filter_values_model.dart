class ProductFilterValuesModel {
  final String? categoryId;
  final String? keywords;
  final String? highRating;
  final String? materials;
  final String? dimensions;
  final String? price;
  final String? priceMin;
  final String? priceMax;

  const ProductFilterValuesModel({
    this.categoryId,
    this.keywords,
    this.highRating,
    this.materials,
    this.dimensions,
    this.price,
    this.priceMin,
    this.priceMax,
  });

  ProductFilterValuesModel copyWith({
    String? categoryId,
    String? keywords,
    String? highRating,
    String? materials,
    String? dimensions,
    String? price,
    String? priceMin,
    String? priceMax,
  }) {
    return ProductFilterValuesModel(
      categoryId: categoryId ?? this.categoryId,
      keywords: keywords ?? this.keywords,
      highRating: highRating ?? this.highRating,
      materials: materials ?? this.materials,
      dimensions: dimensions ?? this.dimensions,
      price: price ?? this.price,
      priceMin: priceMin ?? this.priceMin,
      priceMax: priceMax ?? this.priceMax,
    );
  }

  factory ProductFilterValuesModel.fromJson(Map<String, dynamic> json) {
    return ProductFilterValuesModel(
      categoryId: json['categoryId'] ?? '',
      keywords: json['keywords'] ?? '',
      highRating: json['highRating'] ?? '',
      materials: json['materials'] ?? '',
      dimensions: json['dimensions'] ?? '',
      price: json['price'] ?? '',
      priceMin: json['priceMin'] ?? '',
      priceMax: json['priceMax'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'keywords': keywords,
      'highRating': highRating,
      'materials': materials,
      'dimensions': dimensions,
      'price': price,
      'priceMin': priceMin,
      'priceMax': priceMax,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductFilterValuesModel &&
          runtimeType == other.runtimeType &&
          categoryId == other.categoryId &&
          keywords == other.keywords &&
          highRating == other.highRating &&
          materials == other.materials &&
          dimensions == other.dimensions &&
          price == other.price &&
          priceMin == other.priceMin &&
          priceMax == other.priceMax;

  @override
  int get hashCode =>
      categoryId.hashCode ^
      keywords.hashCode ^
      highRating.hashCode ^
      materials.hashCode ^
      dimensions.hashCode ^
      price.hashCode ^
      priceMin.hashCode ^
      priceMax.hashCode;
}

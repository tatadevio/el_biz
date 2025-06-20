class TenderFilterValuesModel {
  final String? categoryId;
  final String? minQuantity;
  final String? maxQuantity;
  final String? profileType;
  final String? city;
  final String? minBudget;
  final String? maxBudget;

  const TenderFilterValuesModel({
    this.categoryId,
    this.minQuantity,
    this.maxQuantity,
    this.profileType,
    this.city,
    this.minBudget,
    this.maxBudget,
  });

  TenderFilterValuesModel copyWith({
    String? categoryId,
    String? minQuantity,
    String? maxQuantity,
    String? profileType,
    String? city,
    String? minBudget,
    String? maxBudget,
  }) {
    return TenderFilterValuesModel(
      categoryId: categoryId ?? this.categoryId,
      minQuantity: minQuantity ?? this.minQuantity,
      maxQuantity: maxQuantity ?? this.maxQuantity,
      profileType: profileType ?? this.profileType,
      city: city ?? this.city,
      minBudget: minBudget ?? this.minBudget,
      maxBudget: maxBudget ?? this.maxBudget,
    );
  }

  factory TenderFilterValuesModel.fromJson(Map<String, dynamic> json) {
    return TenderFilterValuesModel(
      categoryId: json['categoryId'] ?? '',
      minQuantity: json['minQuantity'] ?? '',
      maxQuantity: json['maxQuantity'] ?? '',
      profileType: json['profileType'] ?? '',
      city: json['city'] ?? '',
      minBudget: json['minBudget'] ?? '',
      maxBudget: json['maxBudget'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'minQuantity': minQuantity,
      'maxQuantity': maxQuantity,
      'profileType': profileType,
      'city': city,
      'minBudget': minBudget,
      'maxBudget': maxBudget,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TenderFilterValuesModel &&
          runtimeType == other.runtimeType &&
          categoryId == other.categoryId &&
          minQuantity == other.minQuantity &&
          maxQuantity == other.maxQuantity &&
          profileType == other.profileType &&
          city == other.city &&
          minBudget == other.minBudget &&
          maxBudget == other.maxBudget;

  @override
  int get hashCode =>
      categoryId.hashCode ^
      minQuantity.hashCode ^
      maxQuantity.hashCode ^
      profileType.hashCode ^
      city.hashCode ^
      minBudget.hashCode ^
      maxBudget.hashCode;
}

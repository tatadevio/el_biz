class CompanyFilterValuesModel {
  final String? categoryId;
  final String? keywords;
  final String? highRating;
  final String? city;
  final bool? isVerified;

  const CompanyFilterValuesModel({
    this.categoryId,
    this.keywords,
    this.highRating,
    this.city,
    this.isVerified,
  });

  CompanyFilterValuesModel copyWith({
    String? categoryId,
    String? keywords,
    String? highRating,
    String? city,
    bool? isVerified,
  }) {
    return CompanyFilterValuesModel(
      categoryId: categoryId ?? this.categoryId,
      keywords: keywords ?? this.keywords,
      highRating: highRating ?? this.highRating,
      city: city ?? this.city,
      isVerified: isVerified ?? this.isVerified,
    );
  }

  factory CompanyFilterValuesModel.fromJson(Map<String, dynamic> json) {
    return CompanyFilterValuesModel(
      categoryId: json['categoryId'] ?? '',
      keywords: json['keywords'] ?? '',
      highRating: json['highRating'] ?? '',
      city: json['city'] ?? '',
      isVerified: json['isVerified'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'keywords': keywords,
      'highRating': highRating,
      'city': city,
      'isVerified': isVerified,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CompanyFilterValuesModel &&
          runtimeType == other.runtimeType &&
          categoryId == other.categoryId &&
          keywords == other.keywords &&
          highRating == other.highRating &&
          city == other.city &&
          isVerified == other.isVerified;

  @override
  int get hashCode =>
      categoryId.hashCode ^
      keywords.hashCode ^
      highRating.hashCode ^
      city.hashCode ^
      isVerified.hashCode;
}

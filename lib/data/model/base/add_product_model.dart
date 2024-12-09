class AddProductModel {
  final String? brandName;
  final String? productName;
  final String? productCode;
  final String? price;
  final String? currency;
  final String? quantity;
  final String? quantityUnit;
  final String? dimensions;
  final String? dimensionsUnit;
  final String? weight;
  final String? weightUnit;
  final String? region;
  final String? description;
  final String? keywords;
  final String? size;

  // Constructor
  const AddProductModel({
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
      size: json['size'],
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
    String? size,
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
    );
  }

  // Override toString for debugging
  @override
  String toString() {
    return 'AddProductModel(brandName: $brandName, productName: $productName, productCode: $productCode, price: $price, currency: $currency, quantity: $quantity, quantityUnit: $quantityUnit, dimensions: $dimensions, dimensionsUnit: $dimensionsUnit, weight: $weight, weightUnit: $weightUnit, region: $region, description: $description, keywords: $keywords, size: $size)';
  }
}

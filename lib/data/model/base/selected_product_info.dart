import 'package:el_biz/data/model/response/company/company_product_model.dart';

class SelectedProductInfo {
  final ProductListItem product;
  final int totalQuantity;
  final int unitPrice;
  final int subtotal;

  SelectedProductInfo({
    required this.product,
    required this.totalQuantity,
    required this.unitPrice,
    required this.subtotal,
  });

  // Optional: Convert to JSON (if needed)
  Map<String, dynamic> toJson() {
    return {
      'product':
          product.toJson(), // Assumes ProductListItem has a toJson() method
      'totalQuantity': totalQuantity,
      'unitPrice': unitPrice,
      'subtotal': subtotal,
    };
  }

  // Optional: Create from JSON (if needed)
  factory SelectedProductInfo.fromJson(Map<String, dynamic> json) {
    return SelectedProductInfo(
      product: ProductListItem.fromJson(json['product']),
      totalQuantity: json['totalQuantity'],
      unitPrice: json['unitPrice'],
      subtotal: json['subtotal'],
    );
  }

  @override
  String toString() {
    return 'SelectedProductInfo(product: ${product.name}, totalQuantity: $totalQuantity, unitPrice: $unitPrice, subtotal: $subtotal)';
  }
}

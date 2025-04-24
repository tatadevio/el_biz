import '../company/company_tenders_model.dart';

class TenderItem {
  final int? id;
  final String? title;
  final String? description;
  final String? quantity;
  final String? status;
  final int? budgetFrom;
  final int? budgetTo;
  final String? location;
  final DateTime? createdAt;
  final Company? company;
  final TenderCategory? tenderCategory;

  TenderItem({
    this.id,
    this.title,
    this.description,
    this.quantity,
    this.status,
    this.budgetFrom,
    this.budgetTo,
    this.location,
    this.createdAt,
    this.company,
    this.tenderCategory,
  });

  factory TenderItem.fromJson(Map<String, dynamic> json) => TenderItem(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        quantity: (json["quantity"] ?? '0').toString(),
        status: json["status"],
        budgetFrom: json["budget_from"],
        budgetTo: json["budget_to"],
        location: json["location"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        company:
            json["company"] == null ? null : Company.fromJson(json["company"]),
        tenderCategory: json["tender_category"] == null
            ? null
            : TenderCategory.fromJson(json["tender_category"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "quantity": quantity,
        "status": status,
        "budget_from": budgetFrom,
        "budget_to": budgetTo,
        "location": location,
        "created_at": createdAt?.toIso8601String(),
        "company": company?.toJson(),
        "tender_category": tenderCategory?.toJson(),
      };
}

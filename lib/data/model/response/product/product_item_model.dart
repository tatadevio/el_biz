import '../company/company_detail_model.dart';

class ProductItem {
  final int? id;
  final String? name;
  final String? email;
  final String? logo;
  final String? banner;
  final String? phone;
  final String? address;
  final String? verificationStatus;
  final String? tinNumber;
  final DateTime? createdAt;
  final Owner? owner;

  ProductItem({
    this.id,
    this.name,
    this.email,
    this.logo,
    this.banner,
    this.phone,
    this.address,
    this.verificationStatus,
    this.tinNumber,
    this.createdAt,
    this.owner,
  });

  factory ProductItem.fromJson(Map<String, dynamic> json) => ProductItem(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        logo: json["logo"],
        banner: json["banner"],
        phone: json["phone"],
        address: json["address"],
        verificationStatus: json["verification_status"],
        tinNumber: json["tin_number"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        owner: json["owner"] == null ? null : Owner.fromJson(json["owner"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "logo": logo,
        "banner": banner,
        "phone": phone,
        "address": address,
        "verification_status": verificationStatus,
        "tin_number": tinNumber,
        "created_at": createdAt?.toIso8601String(),
        "owner": owner?.toJson(),
      };
}

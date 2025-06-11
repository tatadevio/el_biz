// To parse this JSON data, do
//
//     final mySalesModel = mySalesModelFromJson(jsonString);

import 'dart:convert';

MySalesModel mySalesModelFromJson(String str) =>
    MySalesModel.fromJson(json.decode(str));

String mySalesModelToJson(MySalesModel data) => json.encode(data.toJson());

class MySalesModel {
  final dynamic title;
  final String? message;
  final String? status;
  final String? localizedKey;
  final Data? data;
  final int? statusCode;

  MySalesModel({
    this.title,
    this.message,
    this.status,
    this.localizedKey,
    this.data,
    this.statusCode,
  });

  MySalesModel copyWith({
    dynamic title,
    String? message,
    String? status,
    String? localizedKey,
    Data? data,
    int? statusCode,
  }) =>
      MySalesModel(
        title: title ?? this.title,
        message: message ?? this.message,
        status: status ?? this.status,
        localizedKey: localizedKey ?? this.localizedKey,
        data: data ?? this.data,
        statusCode: statusCode ?? this.statusCode,
      );

  factory MySalesModel.fromJson(Map<String, dynamic> json) => MySalesModel(
        title: json["title"],
        message: json["message"],
        status: json["status"],
        localizedKey: json["localized_key"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        statusCode: json["status_code"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "message": message,
        "status": status,
        "localized_key": localizedKey,
        "data": data?.toJson(),
        "status_code": statusCode,
      };
}

class Data {
  final List<ContractListItem>? items;
  final int? totalPages;
  final int? currentPage;
  final int? total;
  final int? perPage;
  final int? count;

  Data({
    this.items,
    this.totalPages,
    this.currentPage,
    this.total,
    this.perPage,
    this.count,
  });

  Data copyWith({
    List<ContractListItem>? items,
    int? totalPages,
    int? currentPage,
    int? total,
    int? perPage,
    int? count,
  }) =>
      Data(
        items: items ?? this.items,
        totalPages: totalPages ?? this.totalPages,
        currentPage: currentPage ?? this.currentPage,
        total: total ?? this.total,
        perPage: perPage ?? this.perPage,
        count: count ?? this.count,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        items: json["items"] == null
            ? []
            : List<ContractListItem>.from(
                json["items"]!.map((x) => ContractListItem.fromJson(x))),
        totalPages: json["totalPages"],
        currentPage: json["currentPage"],
        total: json["total"],
        perPage: json["perPage"],
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "totalPages": totalPages,
        "currentPage": currentPage,
        "total": total,
        "perPage": perPage,
        "count": count,
      };
}

class ContractListItem {
  final int? id;
  final String? contractType;
  final String? paymentMethod;
  final int? tenderId;
  final int? productId;
  final int? buyerId;
  final int? sellerId;
  final String? contractName;
  final String? vatRate;
  final String? vatAmount;
  final String? npsRate;
  final String? npsAmount;
  final String? subtotal;
  final String? totalAmount;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Buyer? buyer;
  final Buyer? seller;
  final List<ContractProduct>? contractProducts;
  final List<dynamic>? documents;

  ContractListItem({
    this.id,
    this.contractType,
    this.paymentMethod,
    this.tenderId,
    this.productId,
    this.buyerId,
    this.sellerId,
    this.contractName,
    this.vatRate,
    this.vatAmount,
    this.npsRate,
    this.npsAmount,
    this.subtotal,
    this.totalAmount,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.buyer,
    this.seller,
    this.contractProducts,
    this.documents,
  });

  ContractListItem copyWith({
    int? id,
    String? contractType,
    String? paymentMethod,
    int? tenderId,
    int? productId,
    int? buyerId,
    int? sellerId,
    String? contractName,
    String? vatRate,
    String? vatAmount,
    String? npsRate,
    String? npsAmount,
    String? subtotal,
    String? totalAmount,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    Buyer? buyer,
    Buyer? seller,
    List<ContractProduct>? contractProducts,
    List<dynamic>? documents,
  }) =>
      ContractListItem(
        id: id ?? this.id,
        contractType: contractType ?? this.contractType,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        tenderId: tenderId ?? this.tenderId,
        productId: productId ?? this.productId,
        buyerId: buyerId ?? this.buyerId,
        sellerId: sellerId ?? this.sellerId,
        contractName: contractName ?? this.contractName,
        vatRate: vatRate ?? this.vatRate,
        vatAmount: vatAmount ?? this.vatAmount,
        npsRate: npsRate ?? this.npsRate,
        npsAmount: npsAmount ?? this.npsAmount,
        subtotal: subtotal ?? this.subtotal,
        totalAmount: totalAmount ?? this.totalAmount,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        buyer: buyer ?? this.buyer,
        seller: seller ?? this.seller,
        contractProducts: contractProducts ?? this.contractProducts,
        documents: documents ?? this.documents,
      );

  factory ContractListItem.fromJson(Map<String, dynamic> json) =>
      ContractListItem(
        id: json["id"],
        contractType: json["contract_type"],
        paymentMethod: json["payment_method"],
        tenderId: json["tender_id"],
        productId: json["product_id"],
        buyerId: json["buyer_id"],
        sellerId: json["seller_id"],
        contractName: json["contract_name"],
        vatRate: json["vat_rate"],
        vatAmount: json["vat_amount"],
        npsRate: json["nps_rate"],
        npsAmount: json["nps_amount"],
        subtotal: json["subtotal"],
        totalAmount: json["total_amount"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        buyer: json["buyer"] == null ? null : Buyer.fromJson(json["buyer"]),
        seller: json["seller"] == null ? null : Buyer.fromJson(json["seller"]),
        contractProducts: json["contract_products"] == null
            ? []
            : List<ContractProduct>.from(json["contract_products"]!
                .map((x) => ContractProduct.fromJson(x))),
        documents: json["documents"] == null
            ? []
            : List<dynamic>.from(json["documents"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "contract_type": contractType,
        "payment_method": paymentMethod,
        "tender_id": tenderId,
        "product_id": productId,
        "buyer_id": buyerId,
        "seller_id": sellerId,
        "contract_name": contractName,
        "vat_rate": vatRate,
        "vat_amount": vatAmount,
        "nps_rate": npsRate,
        "nps_amount": npsAmount,
        "subtotal": subtotal,
        "total_amount": totalAmount,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "buyer": buyer?.toJson(),
        "seller": seller?.toJson(),
        "contract_products": contractProducts == null
            ? []
            : List<dynamic>.from(contractProducts!.map((x) => x.toJson())),
        "documents": documents == null
            ? []
            : List<dynamic>.from(documents!.map((x) => x)),
      };
}

class Buyer {
  final int? id;
  final Name? name;
  final FirstName? firstName;
  final LastName? lastName;
  final Username? username;
  final Email? email;
  final String? phone;
  final UserRole? userRole;
  final Status? status;
  final String? image;
  final String? fcmToken;
  final String? firebaseId;
  final String? googleId;
  final String? appleId;

  Buyer({
    this.id,
    this.name,
    this.firstName,
    this.lastName,
    this.username,
    this.email,
    this.phone,
    this.userRole,
    this.status,
    this.image,
    this.fcmToken,
    this.firebaseId,
    this.googleId,
    this.appleId,
  });

  Buyer copyWith({
    int? id,
    Name? name,
    FirstName? firstName,
    LastName? lastName,
    Username? username,
    Email? email,
    String? phone,
    UserRole? userRole,
    Status? status,
    String? image,
    String? fcmToken,
    String? firebaseId,
    String? googleId,
    String? appleId,
  }) =>
      Buyer(
        id: id ?? this.id,
        name: name ?? this.name,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        username: username ?? this.username,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        userRole: userRole ?? this.userRole,
        status: status ?? this.status,
        image: image ?? this.image,
        fcmToken: fcmToken ?? this.fcmToken,
        firebaseId: firebaseId ?? this.firebaseId,
        googleId: googleId ?? this.googleId,
        appleId: appleId ?? this.appleId,
      );

  factory Buyer.fromJson(Map<String, dynamic> json) => Buyer(
        id: json["id"],
        name: nameValues.map[json["name"]]!,
        firstName: firstNameValues.map[json["first_name"]]!,
        lastName: lastNameValues.map[json["last_name"]]!,
        username: usernameValues.map[json["username"]]!,
        email: emailValues.map[json["email"]]!,
        phone: json["phone"],
        userRole: userRoleValues.map[json["user_role"]]!,
        status: statusValues.map[json["status"]]!,
        image: json["image"],
        fcmToken: json["fcm_token"],
        firebaseId: json["firebase_id"],
        googleId: json["google_id"],
        appleId: json["apple_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": nameValues.reverse[name],
        "first_name": firstNameValues.reverse[firstName],
        "last_name": lastNameValues.reverse[lastName],
        "username": usernameValues.reverse[username],
        "email": emailValues.reverse[email],
        "phone": phone,
        "user_role": userRoleValues.reverse[userRole],
        "status": statusValues.reverse[status],
        "image": image,
        "fcm_token": fcmToken,
        "firebase_id": firebaseId,
        "google_id": googleId,
        "apple_id": appleId,
      };
}

enum Email { ADMIN_GMAIL_COM, EMAIL1_GMAIL_COM, EMAIL2_GAMIL_COM }

final emailValues = EnumValues({
  "admin@gmail.com": Email.ADMIN_GMAIL_COM,
  "email1@gmail.com": Email.EMAIL1_GMAIL_COM,
  "email2@gamil.com": Email.EMAIL2_GAMIL_COM
});

enum FirstName { ADMIN, NEW, TATADEV }

final firstNameValues = EnumValues({
  "Admin": FirstName.ADMIN,
  "New": FirstName.NEW,
  "tatadev": FirstName.TATADEV
});

enum LastName { ADMIN, C, TEST }

final lastNameValues = EnumValues(
    {"admin": LastName.ADMIN, "c": LastName.C, "Test": LastName.TEST});

enum Name { ADMIN_ADMIN, NEW_TEST, TATADEV_C }

final nameValues = EnumValues({
  "Admin admin": Name.ADMIN_ADMIN,
  "New Test": Name.NEW_TEST,
  "tatadev c": Name.TATADEV_C
});

enum Status { PENDING }

final statusValues = EnumValues({"pending": Status.PENDING});

enum UserRole { ADMIN, USER }

final userRoleValues =
    EnumValues({"admin": UserRole.ADMIN, "user": UserRole.USER});

enum Username { ADMIN, NEW_TEST, TATADEV_C }

final usernameValues = EnumValues({
  "admin": Username.ADMIN,
  "new-test": Username.NEW_TEST,
  "tatadev-c": Username.TATADEV_C
});

class ContractProduct {
  final int? id;
  final int? productId;
  final String? productName;
  final int? quantity;
  final String? unitPrice;
  final String? totalAmount;
  final String? vatRate;
  final String? vatAmount;
  final String? npsRate;
  final String? npsAmount;
  final String? subtotal;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ContractProduct({
    this.id,
    this.productId,
    this.productName,
    this.quantity,
    this.unitPrice,
    this.totalAmount,
    this.vatRate,
    this.vatAmount,
    this.npsRate,
    this.npsAmount,
    this.subtotal,
    this.createdAt,
    this.updatedAt,
  });

  ContractProduct copyWith({
    int? id,
    int? productId,
    String? productName,
    int? quantity,
    String? unitPrice,
    String? totalAmount,
    String? vatRate,
    String? vatAmount,
    String? npsRate,
    String? npsAmount,
    String? subtotal,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      ContractProduct(
        id: id ?? this.id,
        productId: productId ?? this.productId,
        productName: productName ?? this.productName,
        quantity: quantity ?? this.quantity,
        unitPrice: unitPrice ?? this.unitPrice,
        totalAmount: totalAmount ?? this.totalAmount,
        vatRate: vatRate ?? this.vatRate,
        vatAmount: vatAmount ?? this.vatAmount,
        npsRate: npsRate ?? this.npsRate,
        npsAmount: npsAmount ?? this.npsAmount,
        subtotal: subtotal ?? this.subtotal,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory ContractProduct.fromJson(Map<String, dynamic> json) =>
      ContractProduct(
        id: json["id"],
        productId: json["product_id"],
        productName: json["product_name"],
        quantity: json["quantity"],
        unitPrice: json["unit_price"],
        totalAmount: json["total_amount"],
        vatRate: json["vat_rate"],
        vatAmount: json["vat_amount"],
        npsRate: json["nps_rate"],
        npsAmount: json["nps_amount"],
        subtotal: json["subtotal"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "product_name": productName,
        "quantity": quantity,
        "unit_price": unitPrice,
        "total_amount": totalAmount,
        "vat_rate": vatRate,
        "vat_amount": vatAmount,
        "nps_rate": npsRate,
        "nps_amount": npsAmount,
        "subtotal": subtotal,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

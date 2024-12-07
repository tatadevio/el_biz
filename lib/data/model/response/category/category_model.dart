
import 'dart:convert';

CategoryListModel categoryListModelFromJson(String str) => CategoryListModel.fromJson(json.decode(str));

String categoryListModelToJson(CategoryListModel data) => json.encode(data.toJson());

class CategoryListModel {
  CategoryListModel({
    required this.message,
    required this.data,
    required this.statusCode,
    required this.status,
  });

  String message;
  Data data;
  int statusCode;
  String status;

  factory CategoryListModel.fromJson(Map<String, dynamic> json) => CategoryListModel(
    message: json["message"],
    data: Data.fromJson(json["data"]),
    statusCode: json["status_code"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": data.toJson(),
    "status_code": statusCode,
    "status": status,
  };
}

class Data {
  Data({
    required this.items,
    required this.totalPages,
    required this.currentPage,
    required this.total,
    required this.perPage,
    required this.count,
  });

  List<CategoriesItem> items;
  int totalPages;
  int currentPage;
  int total;
  int perPage;
  int count;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    items: List<CategoriesItem>.from(json["items"].map((x) => CategoriesItem.fromJson(x))),
    totalPages: json["totalPages"],
    currentPage: json["currentPage"],
    total: json["total"],
    perPage: json["perPage"],
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "totalPages": totalPages,
    "currentPage": currentPage,
    "total": total,
    "perPage": perPage,
    "count": count,
  };
}

class CategoriesItem {
  CategoriesItem({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.bgColor,
    required this.textColor,
    required this.childs,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  String description;
  String image;
  String bgColor;
  String textColor;
  List<CategoriesItem> childs;
  DateTime createdAt;
  DateTime updatedAt;

  factory CategoriesItem.fromJson(Map<String, dynamic> json) => CategoriesItem(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    image: json["image"],
    bgColor: json["bg_color"],
    textColor: json["text_color"],
    childs: List<CategoriesItem>.from(json["childs"].map((x) => CategoriesItem.fromJson(x))),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "image": image,
    "bg_color": bgColor,
    "text_color": textColor,
    "childs": List<dynamic>.from(childs.map((x) => x.toJson())),
    "created_at": "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
    "updated_at": updatedAt.toIso8601String(),
  };
}

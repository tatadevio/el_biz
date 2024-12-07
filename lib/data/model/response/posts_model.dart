import 'dart:convert';

PostModel postModelFromJson(String str) => PostModel.fromJson(json.decode(str));

String postModelToJson(PostModel data) => json.encode(data.toJson());

class PostModel {
  PostModel({
    required this.message,
    required this.data,
    required this.statusCode,
    required this.status,
  });

  String message;
  Data data;
  int statusCode;
  String status;

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
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

  List<PostsItem> items;
  int totalPages;
  int currentPage;
  int total;
  int perPage;
  int count;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    items: List<PostsItem>.from(json["items"].map((x) => PostsItem.fromJson(x))),
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

class PostsItem {
  PostsItem({
    required this.id,
    required this.title,
    required this.image,
    required this.description,
    required this.totalLike,
    required this.currentUserLike,
    required this.viewsCount,
    required this.createdAt,
  });

  int id;
  String title;
  String image;
  String description;
  int totalLike;
  int currentUserLike;
  int viewsCount;
  DateTime createdAt;

  factory PostsItem.fromJson(Map<String, dynamic> json) => PostsItem(
    id: json["id"],
    title: json["title"],
    image: json["image"],
    description: json["description"],
    totalLike: json["total_like"],
    currentUserLike: json["current_user_like"],
    viewsCount: json["views_count"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "image": image,
    "description": description,
    "total_like": totalLike,
    "current_user_like": currentUserLike,
    "views_count": viewsCount,
    "created_at": "${createdAt.year.toString().padLeft(4, '0')}-${createdAt.month.toString().padLeft(2, '0')}-${createdAt.day.toString().padLeft(2, '0')}",
  };
}

import 'dart:convert';

BannersModel bannersModelFromJson(String str) => BannersModel.fromJson(json.decode(str));

String bannersModelToJson(BannersModel data) => json.encode(data.toJson());

class BannersModel {
  BannersModel({
    required this.title,
    required this.message,
    required this.status,
    required this.localizedKey,
    required this.data,
    required this.statusCode,
  });

  String title;
  String message;
  String status;
  String localizedKey;
  Data data;
  int statusCode;

  factory BannersModel.fromJson(Map<String, dynamic> json) => BannersModel(
        title: json["title"],
        message: json["message"],
        status: json["status"],
        localizedKey: json["localized_key"],
        data: Data.fromJson(json["data"]),
        statusCode: json["status_code"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "message": message,
        "status": status,
        "localized_key": localizedKey,
        "data": data.toJson(),
        "status_code": statusCode,
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

  List<BannersItem> items;
  int totalPages;
  int currentPage;
  int total;
  int perPage;
  int count;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        items: List<BannersItem>.from(json["items"].map((x) => BannersItem.fromJson(x))),
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

class BannersItem {
  BannersItem({
    required this.id,
    required this.itemId,
    required this.link,
    required this.banner,
    required this.type,
    required this.title,
  });

  int id;
  int itemId;
  String link;
  String banner;
  String type;
  String title;

  factory BannersItem.fromJson(Map<String, dynamic> json) => BannersItem(
        id: json["id"],
        itemId: json["item_id"],
        link: json["link"],
        banner: json["banner"],
        type: json["type"] ?? 'link',
        title: json["title"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "item_id": itemId,
        "link": link,
        "banner": banner,
        "type": type,
        "title": title,
      };
}

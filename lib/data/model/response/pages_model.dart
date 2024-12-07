
import 'dart:convert';

PagesModel pagesModelFromJson(String str) => PagesModel.fromJson(json.decode(str));

String pagesModelToJson(PagesModel data) => json.encode(data.toJson());

class PagesModel {
  PagesModel({
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

  factory PagesModel.fromJson(Map<String, dynamic> json) => PagesModel(
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
    required this.title,
    required this.description,
  });

  String title;
  String description;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    title: json["title"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
  };
}


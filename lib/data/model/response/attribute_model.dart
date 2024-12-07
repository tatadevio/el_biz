// To parse this JSON data, do
//
//     final attributeModel = attributeModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AttributeModel attributeModelFromJson(String str) => AttributeModel.fromJson(json.decode(str));

String attributeModelToJson(AttributeModel data) => json.encode(data.toJson());

class AttributeModel {
  AttributeModel({
    required this.message,
    required this.data,
    required this.statusCode,
    required this.status,
  });

  String message;
  List<AttributeData> data;
  int statusCode;
  String status;

  factory AttributeModel.fromJson(Map<String, dynamic> json) => AttributeModel(
    message: json["message"],
    data: List<AttributeData>.from(json["data"].map((x) => AttributeData.fromJson(x))),
    statusCode: json["status_code"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "status_code": statusCode,
    "status": status,
  };
}

class AttributeData {
  AttributeData({
    required this.id,
    required this.name,
    required this.type,
    required this.isRequired,
    required this.options,
  });

  int id;
  String name;
  String type;
  int isRequired;
  List<Option> options;

  factory AttributeData.fromJson(Map<String, dynamic> json) => AttributeData(
    id: json["id"],
    name: json["name"],
    type: json["type"],
    isRequired: json["is_required"],
    options: List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "type": type,
    "is_required": isRequired,
    "options": List<dynamic>.from(options.map((x) => x.toJson())),
  };
}

class Option {
  Option({
    required this.id,
    required this.name,
  });

  int id;
  String name;

  factory Option.fromJson(Map<String, dynamic> json) => Option(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

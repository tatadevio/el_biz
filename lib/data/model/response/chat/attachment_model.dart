// To parse this JSON data, do
//
//     final attachmentModel = attachmentModelFromJson(jsonString);

import 'dart:convert';

AttachmentModel attachmentModelFromJson(String str) =>
    AttachmentModel.fromJson(json.decode(str));

String attachmentModelToJson(AttachmentModel data) =>
    json.encode(data.toJson());

class AttachmentModel {
  final int? id;
  final String? url;
  final String? type;
  final int? size;

  AttachmentModel({
    this.id,
    this.url,
    this.type,
    this.size,
  });

  AttachmentModel copyWith({
    int? id,
    String? url,
    String? type,
    int? size,
  }) =>
      AttachmentModel(
        id: id ?? this.id,
        url: url ?? this.url,
        type: type ?? this.type,
        size: size ?? this.size,
      );

  factory AttachmentModel.fromJson(Map<String, dynamic> json) =>
      AttachmentModel(
        id: json["id"],
        url: json["url"],
        type: json["type"],
        size: json["size"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "type": type,
        "size": size,
      };
}

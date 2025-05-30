// To parse this JSON data, do
//
//     final companyDocumentModel = companyDocumentModelFromJson(jsonString);

import 'dart:convert';

CompanyDocumentModel companyDocumentModelFromJson(String str) =>
    CompanyDocumentModel.fromJson(json.decode(str));

String companyDocumentModelToJson(CompanyDocumentModel data) =>
    json.encode(data.toJson());

class CompanyDocumentModel {
  final dynamic title;
  final String? message;
  final String? status;
  final String? localizedKey;
  final Data? data;
  final int? statusCode;

  CompanyDocumentModel({
    this.title,
    this.message,
    this.status,
    this.localizedKey,
    this.data,
    this.statusCode,
  });

  CompanyDocumentModel copyWith({
    dynamic title,
    String? message,
    String? status,
    String? localizedKey,
    Data? data,
    int? statusCode,
  }) =>
      CompanyDocumentModel(
        title: title ?? this.title,
        message: message ?? this.message,
        status: status ?? this.status,
        localizedKey: localizedKey ?? this.localizedKey,
        data: data ?? this.data,
        statusCode: statusCode ?? this.statusCode,
      );

  factory CompanyDocumentModel.fromJson(Map<String, dynamic> json) =>
      CompanyDocumentModel(
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
  final List<DocumentItem>? items;
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
    List<DocumentItem>? items,
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
            : List<DocumentItem>.from(
                json["items"]!.map((x) => DocumentItem.fromJson(x))),
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

class DocumentItem {
  final int? id;
  final String? name;
  final String? type;
  final String? size;
  final int? companyId;
  final String? documentType;
  final String? filePath;
  final DateTime? createdAt;

  DocumentItem({
    this.id,
    this.name,
    this.type,
    this.size,
    this.companyId,
    this.documentType,
    this.filePath,
    this.createdAt,
  });

  DocumentItem copyWith({
    int? id,
    String? name,
    String? type,
    String? size,
    int? companyId,
    String? documentType,
    String? filePath,
    DateTime? createdAt,
  }) =>
      DocumentItem(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
        size: size ?? this.size,
        companyId: companyId ?? this.companyId,
        documentType: documentType ?? this.documentType,
        filePath: filePath ?? this.filePath,
        createdAt: createdAt ?? this.createdAt,
      );

  factory DocumentItem.fromJson(Map<String, dynamic> json) => DocumentItem(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        size: json["size"],
        companyId: json["company_id"],
        documentType: json["document_type"],
        filePath: json["file_path"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "size": size,
        "company_id": companyId,
        "document_type": documentType,
        "file_path": filePath,
        "created_at": createdAt?.toIso8601String(),
      };
}

// To parse this JSON data, do
//
//     final importProductsModel = importProductsModelFromJson(jsonString);

import 'dart:convert';

ImportProductsModel importProductsModelFromJson(String str) =>
    ImportProductsModel.fromJson(json.decode(str));

String importProductsModelToJson(ImportProductsModel data) =>
    json.encode(data.toJson());

class ImportProductsModel {
  final bool? success;
  final String? message;
  final Data? data;

  ImportProductsModel({
    this.success,
    this.message,
    this.data,
  });

  ImportProductsModel copyWith({
    bool? success,
    String? message,
    Data? data,
  }) =>
      ImportProductsModel(
        success: success ?? this.success,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory ImportProductsModel.fromJson(Map<String, dynamic> json) =>
      ImportProductsModel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  final int? id;
  final String? filename;
  final String? status;
  final Progress? progress;
  final Metrics? metrics;
  // final List<dynamic>? summary;
  final Timestamps? timestamps;
  final User? user;

  Data({
    this.id,
    this.filename,
    this.status,
    this.progress,
    this.metrics,
    // this.summary,
    this.timestamps,
    this.user,
  });

  Data copyWith({
    int? id,
    String? filename,
    String? status,
    Progress? progress,
    Metrics? metrics,
    // List<dynamic>? summary,
    Timestamps? timestamps,
    User? user,
  }) =>
      Data(
        id: id ?? this.id,
        filename: filename ?? this.filename,
        status: status ?? this.status,
        progress: progress ?? this.progress,
        metrics: metrics ?? this.metrics,
        // summary: summary ?? this.summary,
        timestamps: timestamps ?? this.timestamps,
        user: user ?? this.user,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        filename: json["filename"],
        status: json["status"],
        progress: json["progress"] == null
            ? null
            : Progress.fromJson(json["progress"]),
        metrics:
            json["metrics"] == null ? null : Metrics.fromJson(json["metrics"]),
        // summary: json["summary"] == null
        //     ? []
        //     : List<dynamic>.from(json["summary"]!.map((x) => x)),
        timestamps: json["timestamps"] == null
            ? null
            : Timestamps.fromJson(json["timestamps"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "filename": filename,
        "status": status,
        "progress": progress?.toJson(),
        "metrics": metrics?.toJson(),
        // "summary":
        // summary == null ? [] : List<dynamic>.from(summary!.map((x) => x)),
        "timestamps": timestamps?.toJson(),
        "user": user?.toJson(),
      };
}

class Metrics {
  final String? successRate;
  final int? errorCount;

  Metrics({
    this.successRate,
    this.errorCount,
  });

  Metrics copyWith({
    String? successRate,
    int? errorCount,
  }) =>
      Metrics(
        successRate: successRate ?? this.successRate,
        errorCount: errorCount ?? this.errorCount,
      );

  factory Metrics.fromJson(Map<String, dynamic> json) => Metrics(
        successRate: json["success_rate"].toString(),
        errorCount: json["error_count"],
      );

  Map<String, dynamic> toJson() => {
        "success_rate": successRate.toString(),
        "error_count": errorCount,
      };
}

class Progress {
  final int? totalRows;
  final int? processedRows;
  final int? successfulRows;
  final int? failedRows;
  final String? percentage;

  Progress({
    this.totalRows,
    this.processedRows,
    this.successfulRows,
    this.failedRows,
    this.percentage,
  });

  Progress copyWith({
    int? totalRows,
    int? processedRows,
    int? successfulRows,
    int? failedRows,
    String? percentage,
  }) =>
      Progress(
        totalRows: totalRows ?? this.totalRows,
        processedRows: processedRows ?? this.processedRows,
        successfulRows: successfulRows ?? this.successfulRows,
        failedRows: failedRows ?? this.failedRows,
        percentage: percentage ?? this.percentage,
      );

  factory Progress.fromJson(Map<String, dynamic> json) => Progress(
        totalRows: json["total_rows"],
        processedRows: json["processed_rows"],
        successfulRows: json["successful_rows"],
        failedRows: json["failed_rows"],
        percentage: json["percentage"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "total_rows": totalRows,
        "processed_rows": processedRows,
        "successful_rows": successfulRows,
        "failed_rows": failedRows,
        "percentage": percentage.toString(),
      };
}

class Timestamps {
  final String? createdAt;
  final String? startedAt;
  final String? completedAt;
  final String? durationSeconds;

  Timestamps({
    this.createdAt,
    this.startedAt,
    this.completedAt,
    this.durationSeconds,
  });

  Timestamps copyWith({
    String? createdAt,
    String? startedAt,
    String? completedAt,
    String? durationSeconds,
  }) =>
      Timestamps(
        createdAt: createdAt ?? this.createdAt,
        startedAt: startedAt ?? this.startedAt,
        completedAt: completedAt ?? this.completedAt,
        durationSeconds: durationSeconds ?? this.durationSeconds,
      );

  factory Timestamps.fromJson(Map<String, dynamic> json) => Timestamps(
        createdAt: json["created_at"],
        startedAt: json["started_at"],
        completedAt: json["completed_at"],
        durationSeconds: json["duration_seconds"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "created_at": createdAt,
        "started_at": startedAt,
        "completed_at": completedAt,
        "duration_seconds": durationSeconds,
      };
}

class User {
  final int? id;
  final String? name;

  User({
    this.id,
    this.name,
  });

  User copyWith({
    int? id,
    String? name,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

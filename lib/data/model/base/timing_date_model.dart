class DaySchedule {
   String day;
   String openingTime;
   String closingTime;
   bool isOpen;

  DaySchedule({
    required this.day,
    required this.openingTime,
    required this.closingTime,
    required this.isOpen,
  });

  /// Convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'openingTime': openingTime,
      'closingTime': closingTime,
      'isOpen': isOpen,
    };
  }

  /// Create model from JSON
  factory DaySchedule.fromJson(Map<String, dynamic> json) {
    return DaySchedule(
      day: json['day'] ?? '',
      openingTime: json['openingTime'] ?? '',
      closingTime: json['closingTime'] ?? '',
      isOpen: json['isOpen'] ?? false,
    );
  }

  /// Create a copy of the current object with updated values
  DaySchedule copyWith({
    String? day,
    String? openingTime,
    String? closingTime,
    bool? isOpen,
  }) {
    return DaySchedule(
      day: day ?? this.day,
      openingTime: openingTime ?? this.openingTime,
      closingTime: closingTime ?? this.closingTime,
      isOpen: isOpen ?? this.isOpen,
    );
  }
}

class ContactInfoModel {
   String type;
   String value;

  ContactInfoModel({
    required this.type,
    required this.value,
  });

  /// Convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'value': value,
    };
  }

  /// Create model from JSON
  factory ContactInfoModel.fromJson(Map<String, dynamic> json) {
    return ContactInfoModel(
      type: json['type'] ?? '',
      value: json['value'] ?? '',
    );
  }

  /// Create a copy with updated values
  ContactInfoModel copyWith({
    String? type,
    String? value,
  }) {
    return ContactInfoModel(
      type: type ?? this.type,
      value: value ?? this.value,
    );
  }

  /// Optional: Better string representation
  @override
  String toString() => 'ContactInfoModel(type: $type, value: $value)';

  /// Optional: Equality and hashCode overrides
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContactInfoModel &&
          runtimeType == other.runtimeType &&
          type == other.type &&
          value == other.value;

  @override
  int get hashCode => type.hashCode ^ value.hashCode;
}

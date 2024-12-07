class ValidationError {
  final String message;
  final String status;
  final int statusCode;
  final Map<String, List<String>> data; // Dynamic data keys

  ValidationError({
    required this.message,
    required this.status,
    required this.statusCode,
    required this.data,
  });

  // Factory method to create an instance from a JSON map
  factory ValidationError.fromJson(Map<String, dynamic> json) {
    // Parsing the 'data' field as a Map<String, List<String>>
    Map<String, List<String>> parsedData = {};
    if (json['data'] != null) {
      json['data'].forEach((key, value) {
        parsedData[key] = List<String>.from(value);
      });
    }

    return ValidationError(
      message: json['message'] ?? 'Unknown error',
      status: json['status'] ?? 'Unknown status',
      statusCode: json['status_code'] ?? 0,
      data: parsedData,
    );
  }

  // Method to convert the instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'status': status,
      'status_code': statusCode,
      'data': data,
    };
  }
}

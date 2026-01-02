import '../data/model/base/api_error.dart';

class ApiErrorService {
  /// Normalize any API error response
  static NormalizedApiError normalize(dynamic errorResponse) {
    final Map<String, List<String>> fieldErrors = {};
    final List<String> allMessages = [];

    if (errorResponse == null) {
      return NormalizedApiError(
        allMessages: allMessages,
        fieldErrors: fieldErrors,
      );
    }

    // Handle validation errors
    if (errorResponse is Map &&
        errorResponse['errors'] != null &&
        errorResponse['errors'] is Map) {
      final errors = errorResponse['errors'] as Map;

      errors.forEach((key, value) {
        if (value is List) {
          final messages = value.map((e) => e.toString()).toList();

          fieldErrors[key.toString()] = messages;
          allMessages.addAll(messages);
        }
      });
    }

    // Fallback main message
    if (allMessages.isEmpty && errorResponse is Map) {
      final message = errorResponse['message'];
      if (message != null && message.toString().isNotEmpty) {
        allMessages.add(message.toString());
      }
    }

    return NormalizedApiError(
      allMessages: allMessages,
      fieldErrors: fieldErrors,
    );
  }

  /// Create a user-friendly string
  static String toUserMessage(
    NormalizedApiError error, {
    String separator = '\n',
  }) {
    return error.allMessages.join(separator);
  }
}

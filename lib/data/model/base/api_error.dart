class NormalizedApiError {
  final List<String> allMessages;
  final Map<String, List<String>> fieldErrors;

  NormalizedApiError({
    required this.allMessages,
    required this.fieldErrors,
  });

  bool get hasErrors => allMessages.isNotEmpty;
}

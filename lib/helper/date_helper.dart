import 'package:intl/intl.dart';

String formatDateInRu(String dateStr) {
  DateTime dateTime = DateTime.parse(dateStr);
  var formatter = DateFormat("d MMM yyyy", "ru_RU"); // Russian format
  return formatter.format(dateTime);
}

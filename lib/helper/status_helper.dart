import 'package:get/get.dart';

class StatusHelper {
  static String getStatus(String status) {
    if (status.toLowerCase() == "signed") {
      return "status_signed".tr;
    } else if (status.toLowerCase() == "declined") {
      return "status_declined".tr;
    } else if (status.toLowerCase() == "pending") {
      return "status_pending".tr;
    } else if (status.toLowerCase() == "processing") {
      return "status_processing".tr;
    } else if (status.toLowerCase() == "rejected") {
      return "status_declined".tr;
    } else if (status.toLowerCase() == "paid") {
      return "status_paid".tr;
    } else if (status.toLowerCase() == "unpaid") {
      return "status_unpaid".tr;
    }
    return status.tr;
  }
}

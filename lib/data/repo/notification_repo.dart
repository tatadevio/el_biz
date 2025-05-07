import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/appConstant.dart';
import '../api/api_client.dart';

class NotificationRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  NotificationRepo(this.apiClient, this.sharedPreferences);

  Future<Response> getNotifications(int page) async {
    return await apiClient
        .getData("${AppConstants.notificationUrl}?page=$page");
  }
}

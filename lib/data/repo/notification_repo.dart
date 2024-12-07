import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_client.dart';

class NotificationRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  NotificationRepo(this.apiClient, this.sharedPreferences);
}

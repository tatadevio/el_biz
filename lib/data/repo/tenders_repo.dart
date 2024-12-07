import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_client.dart';

class TendersRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  TendersRepo(this.apiClient, this.sharedPreferences);
}

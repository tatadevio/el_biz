import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_client.dart';

class PublicTenderRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  PublicTenderRepo(this.apiClient, this.sharedPreferences);
}

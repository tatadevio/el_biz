import 'package:shared_preferences/shared_preferences.dart';

import '../../api/api_client.dart';

class AuctionsRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuctionsRepo(this.apiClient, this.sharedPreferences);
}

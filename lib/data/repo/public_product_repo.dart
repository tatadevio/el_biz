

import 'package:el_biz/data/api/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PublicProductRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  PublicProductRepo(this.apiClient, this.sharedPreferences);
}
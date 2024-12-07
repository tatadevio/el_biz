import 'package:el_biz/data/api/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompnayRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  CompnayRepo(this.apiClient, this.sharedPreferences);
}

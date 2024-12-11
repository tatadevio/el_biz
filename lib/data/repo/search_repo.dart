import 'package:el_biz/data/api/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  SearchRepo(this.apiClient, this.sharedPreferences);
}

import 'package:el_biz/data/api/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReviewRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  ReviewRepo(this.apiClient, this.sharedPreferences);
}

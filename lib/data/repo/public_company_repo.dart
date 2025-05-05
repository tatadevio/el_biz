import 'package:shared_preferences/shared_preferences.dart';
import '../api/api_client.dart';

class PublicCompanyRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  PublicCompanyRepo(this.apiClient, this.sharedPreferences);
}

import 'package:el_biz/data/api/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContractRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  ContractRepo(this.apiClient, this.sharedPreferences);
}

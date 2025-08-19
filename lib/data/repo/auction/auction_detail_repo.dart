import 'package:el_biz/data/api/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuctionDetailRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuctionDetailRepo(this.apiClient, this.sharedPreferences);
}

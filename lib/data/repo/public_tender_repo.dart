import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/appConstant.dart';
import '../api/api_client.dart';

class PublicTenderRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  PublicTenderRepo(this.apiClient, this.sharedPreferences);

  Future<Response> companyTenders(int page) async {
    return await apiClient.getData(
        "${AppConstants.publicTendersUrl}?order_by=company&order_direction=asc&page=$page");
  }
}

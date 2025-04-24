import 'package:el_biz/data/api/api_client.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/appConstant.dart';

class TinRepo {
  final ApiClient apiClient;

  final SharedPreferences sharedPreferences;

  TinRepo(this.apiClient, this.sharedPreferences);
  Future<Response> verifyTinNumber(String tinNumber) async {
    return await apiClient
        .getData("${AppConstants.verifyTinNumberUrl}/$tinNumber");
  }
}

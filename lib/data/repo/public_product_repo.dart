import 'package:el_biz/data/api/api_client.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/appConstant.dart';

class PublicProductRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  PublicProductRepo(this.apiClient, this.sharedPreferences);

  Future<Response> getPublicProducts(int page) async {
    return await apiClient
        .getData("${AppConstants.publicProductUrl}?page=$page");
  }
}

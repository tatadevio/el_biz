import 'package:el_biz/data/api/api_client.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/appConstant.dart';

class SearchRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  SearchRepo(this.apiClient, this.sharedPreferences);



  Future<Response> searchProduct(String search, int page) async {
    return await apiClient
        .getData("${AppConstants.publicProductUrl}?search=$search&page=$page");
  }

  Future<Response> toggleFavorite(String id) async {
    return await apiClient.postData(AppConstants.favoriteToggleUrl, {
      "type": "Product",
      "id": id,
    });
  }
}

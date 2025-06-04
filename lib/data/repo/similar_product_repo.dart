import 'package:el_biz/data/api/api_client.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/appConstant.dart';

class SimilarProductRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  SimilarProductRepo(this.apiClient, this.sharedPreferences);

  Future<Response> getSimilarProducts(String productId, int page) async {
    return await apiClient
        .getData("${AppConstants.relatedProductsUrl}/$productId?page=$page");
  }
}

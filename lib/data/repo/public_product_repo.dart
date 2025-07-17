import 'package:el_biz/data/api/api_client.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/appConstant.dart';

class PublicProductRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  PublicProductRepo(this.apiClient, this.sharedPreferences);

  Future<Response> getPublicProducts(int page, String orderBy, String direction) async {
    return await apiClient
        .getData("${AppConstants.publicProductUrl}?page=$page&order_by=$orderBy&order_direction=$direction");
  }

  Future<Response> getPublicFilterProducts(
      {required String categoryId,
      required String keywords,
      required String highRating,
      required String materials,
      required String priceMin,
      required String priceMax,
      required String dimensions,
     required  int page}) async {
    return await apiClient.getData(
        "${AppConstants.publicProductUrl}?category_id=$categoryId&price_min=$priceMin&price_max=$priceMax&search_keywords=$keywords&high_rating=$highRating&materials=$materials&dimensions=$dimensions&page=$page");
  }

  Future<Response> toggleFavorite(String id) async {
    return await apiClient.postData(AppConstants.favoriteToggleUrl, {
      "type": "Product",
      "id": id,
    });
  }
}

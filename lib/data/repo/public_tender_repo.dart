import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/appConstant.dart';
import '../api/api_client.dart';

class PublicTenderRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  PublicTenderRepo(this.apiClient, this.sharedPreferences);

  Future<Response> companyTenders(
      int page, String direction, String orderBy) async {
    return await apiClient.getData(
        "${AppConstants.publicTendersUrl}?order_direction=$direction&order_by=$orderBy&page=$page");

    // order_by = company , created_at
  }

  Future<Response> toggleFavorite(String id, {String type = "Tender"}) async {
    return await apiClient.postData(AppConstants.favoriteToggleUrl, {
      "type": type,
      "id": id,
    });
  }

  Future<Response> getPublicFilterTenders(
      {required String categoryId,
      required String minQuantity,
      required String maxQuantity,
      required String profileType,
      required String city,
      required String minBudget,
      required String maxBudget,
      required int page}) async {
    return await apiClient.getData(
        "${AppConstants.publicTendersUrl}?category_id=$categoryId&budget_min=$minBudget&budget_max=$maxBudget&profile_type=$profileType&min_quantity=$minQuantity&max_quantity=$maxQuantity&city=$city&page=$page");
  }
}

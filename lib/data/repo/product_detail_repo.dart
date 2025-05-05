import 'package:el_biz/data/api/api_client.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/appConstant.dart';

class ProductDetailRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  const ProductDetailRepo(this.apiClient, this.sharedPreferences);
  Future<Response> getDetail(String id) async {
    return await apiClient.getData("${AppConstants.productDetailUrl}/$id");
  }

  Future<Response> toggleFavorite(String id) async {
    return await apiClient.postData(AppConstants.favoriteToggleUrl, {
      "type": "Product",
      "id": id,
    });
  }

  Future<Response> changeProductStatus(String id, String status) async {
    return await apiClient.postData(
        "${AppConstants.productStatusChangeUrl}/$id", {"status": status});
  }
}

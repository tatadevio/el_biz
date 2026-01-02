import 'package:el_biz/data/api/api_client.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/appConstant.dart';

class MyProductsRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  MyProductsRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> getMyProducts(
      int page, String orderBy, String direction) async {
    return await apiClient.getData(
        "${AppConstants.myProductsUrl}?page=$page&order_by=$orderBy&order_direction=$direction");
  }
}

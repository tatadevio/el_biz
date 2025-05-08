import 'package:el_biz/data/api/api_client.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/appConstant.dart';

class TenderDetailRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  TenderDetailRepo(this.apiClient, this.sharedPreferences);

  Future<Response> getTenderDetail(String id) async {
    return await apiClient.getData("${AppConstants.tendersUrl}/$id");
  }

  Future<Response> changeTenderStatus(String id, String status) async {
    return await apiClient.postData(
        "${AppConstants.tendersUrl}/$id/active-status",
        {"active_status": status});
  }

  Future<Response> toggleFavorite(String id) async {
    return await apiClient.postData(AppConstants.favoriteToggleUrl, {
      "type": "Tender",
      "id": id,
    });
  }
}

import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/appConstant.dart';
import '../api/api_client.dart';

class SearchTenderRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  SearchTenderRepo(this.apiClient, this.sharedPreferences);

  Future<Response> searchTender(String search, int page) async {
    return await apiClient
        .getData("${AppConstants.publicTendersUrl}?search=$search&page=$page");
  }

  Future<Response> toggleFavorite(String id, {String type = "Tender"}) async {
    return await apiClient.postData(AppConstants.favoriteToggleUrl, {
      "type": type,
      "id": id,
    });
  }
}

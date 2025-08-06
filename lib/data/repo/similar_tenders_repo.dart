import 'package:el_biz/data/api/api_client.dart';
import 'package:el_biz/utils/appConstant.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SimilarTendersRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  SimilarTendersRepo(
      {required this.apiClient, required this.sharedPreferences});

  Future<Response> getSimilarTenders(String tenderId, int currentPage) async {
    final res = await apiClient.getData(
      '${AppConstants.similarTendersUrl}/$tenderId?page=$currentPage',
    );
    return res;
  }

  Future<Response> toggleFavorite(String id, {String type = "Tender"}) async {
    return await apiClient.postData(AppConstants.favoriteToggleUrl, {
      "type": type,
      "id": id,
    });
  }
}

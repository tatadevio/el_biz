import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/appConstant.dart';
import '../../api/api_client.dart';

class AuctionsRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuctionsRepo(this.apiClient, this.sharedPreferences);

  Future<Response> getAuctions(int page,
      {String orderBy = 'created_at', String direction = 'desc'}) async {
    return await apiClient.getData(
        "${AppConstants.publicAuctionsUrl}?page=$page&order_by=$orderBy&sort_order=$direction");
  }

  Future<Response> toggleFavorite(String id) async {
    return await apiClient.postData(AppConstants.favoriteToggleUrl, {
      "type": "Auction",
      "id": id,
    });
  }
}

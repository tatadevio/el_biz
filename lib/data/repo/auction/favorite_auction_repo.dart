import 'package:el_biz/data/api/api_client.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/appConstant.dart';

class FavoriteAuctionRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  FavoriteAuctionRepo(this.apiClient, this.sharedPreferences);

  Future<Response> toggleFavorite(String id) async {
    return await apiClient.postData(AppConstants.favoriteToggleUrl, {
      "type": "Auction",
      "id": id,
    });
  }
}

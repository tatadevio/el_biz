import 'package:el_biz/data/api/api_client.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/appConstant.dart';

class SearchAuctionRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  SearchAuctionRepo(this.apiClient, this.sharedPreferences);

  Future<Response> searchAuction(String search, int page) async {
    return await apiClient
        .getData("${AppConstants.publicAuctionsUrl}?search=$search&page=$page");
  }

  Future<Response> toggleFavorite(String id, {String type = "Auction"}) async {
    return await apiClient.postData(AppConstants.favoriteToggleUrl, {
      "type": type,
      "id": id,
    });
  }
}

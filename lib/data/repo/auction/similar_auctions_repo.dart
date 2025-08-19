import 'package:el_biz/data/api/api_client.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/appConstant.dart';

class SimilarAuctionsRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  SimilarAuctionsRepo(this.apiClient, this.sharedPreferences);

  Future<Response> getSimilarAuctions(String auctionId, int currentPage) async {
    final res = await apiClient.getData(
      '${AppConstants.similarAuctionsUrl}/$auctionId?page=$currentPage',
    );
    return res;
  }

  Future<Response> toggleFavorite(String id, {String type = "Auction"}) async {
    return await apiClient.postData(AppConstants.favoriteToggleUrl, {
      "type": type,
      "id": id,
    });
  }
}

import 'package:el_biz/data/api/api_client.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/appConstant.dart';

class AuctionReviewRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuctionReviewRepo(this.apiClient, this.sharedPreferences);

  Future<Response> addAuctionReview(int auctionId, String review) async {
    return await apiClient.postData(
        "${AppConstants.publicAuctionsUrl}/$auctionId/review",
        {"comment": review, "rating": 5});
  }
}

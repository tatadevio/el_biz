import 'package:el_biz/data/api/api_client.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/appConstant.dart';

class AuctionBidRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuctionBidRepo(this.apiClient, this.sharedPreferences);

  Future<Response> addAuctionBid(int auctionId, double bidAmount) async {
    return await apiClient.postData(
        "${AppConstants.publicAuctionsUrl}/$auctionId/bid",
        {"bid_amount": bidAmount});
  }

  Future<Response> cancelAuctionBid(int auctionId, int bidId) async {
    return await apiClient.postData(
        "${AppConstants.publicAuctionsUrl}/$auctionId/cancel-bid",
        {"bid_id": bidId});
  }
}

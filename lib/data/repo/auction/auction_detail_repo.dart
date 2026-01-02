import 'package:el_biz/data/api/api_client.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/appConstant.dart';

class AuctionDetailRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuctionDetailRepo(this.apiClient, this.sharedPreferences);

  Future<Response> getAuctionDetail(int auctionId) async {
    return await apiClient
        .getData("${AppConstants.publicAuctionsUrl}/$auctionId");
  }

  Future<Response> openAuctionBid(int auctionId) async {
    return await apiClient
        .postData("${AppConstants.publicAuctionsUrl}/$auctionId/open", {});
  }

  Future<Response> closeAuctionBid(int auctionId) async {
    return await apiClient
        .postData("${AppConstants.publicAuctionsUrl}/$auctionId/close", {});
  }
}

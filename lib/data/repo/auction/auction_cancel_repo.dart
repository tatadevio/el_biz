import 'package:el_biz/data/api/api_client.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/appConstant.dart';

class AuctionCancelRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AuctionCancelRepo(this.apiClient, this.sharedPreferences);

  Future<Response> cancelAuction(int auctionId) async {
    return await apiClient
        .postData("${AppConstants.publicAuctionsUrl}/$auctionId/cancel", {});
  }

  Future<Response> publishCanceledAuction(int auctionId) async {
    return await apiClient
        .postData("${AppConstants.publicAuctionsUrl}/$auctionId/publish", {});
  }
}

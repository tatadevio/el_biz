import 'package:el_biz/data/api/api_client.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/appConstant.dart';

class AuctionBidsListRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuctionBidsListRepo(this.apiClient, this.sharedPreferences);

  Future<Response> getAuctionBids(int auctionId) async {
    return await apiClient.getData(
      "${AppConstants.publicAuctionsUrl}/$auctionId/bids",
    );
  }
}

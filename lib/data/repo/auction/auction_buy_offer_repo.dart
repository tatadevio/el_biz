import 'package:el_biz/data/api/api_client.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/appConstant.dart';

class AuctionBuyOfferRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuctionBuyOfferRepo(this.apiClient, this.sharedPreferences);

  Future<Response> buyOffer(int auctionId, double offerAmount) async {
    return await apiClient
        .postData("${AppConstants.publicAuctionsUrl}/$auctionId/buy-offer", {
      "offer_price": offerAmount,
    });
  }
}

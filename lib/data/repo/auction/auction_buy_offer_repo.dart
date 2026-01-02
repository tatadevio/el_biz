import 'package:el_biz/data/api/api_client.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/appConstant.dart';

class AuctionBuyOfferRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuctionBuyOfferRepo(this.apiClient, this.sharedPreferences);

  Future<Response> buyOffer(int auctionId, double offerAmount) async {
    return await apiClient.postData(
        "${AppConstants.publicAuctionsUrl}/$auctionId/buy-offer",
        {"offer_price": offerAmount, "message": "", "expiration_hours": 1});
  }

  Future<Response> getBuyOffers(int auctionId) async {
    return await apiClient
        .getData("${AppConstants.publicAuctionsUrl}/$auctionId/buy-offers");
  }

  Future<Response> respondToBuyOffer(int offerId) async {
    return await apiClient.postData(
      "${AppConstants.publicAuctionsUrl}/buy-offers/$offerId/respond",
      {
        "action": "accept",
        "seller_message": "",
      },
    );
  }
}

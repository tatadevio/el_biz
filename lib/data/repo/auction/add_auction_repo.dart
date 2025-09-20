import 'package:el_biz/data/api/api_client.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/appConstant.dart';

class AddAuctionRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AddAuctionRepo(
    this.apiClient,
    this.sharedPreferences,
  );

  Future<Response> addNewAuction(Map auctionData) async {
    return await apiClient.postData(AppConstants.addAuctionUrl, auctionData);
  }
}

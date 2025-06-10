import 'package:el_biz/data/api/api_client.dart';
import 'package:el_biz/utils/appConstant.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchCompanyRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  SearchCompanyRepo(this.apiClient, this.sharedPreferences);

  Future<Response> searchCompany(String search, int page) async {
    return await apiClient.getData(
        "${AppConstants.publicCompaniesUrl}?search=$search&page=$page");
  }
  // Future<Response> toggleFavorite(String id) async {
  //   return await apiClient.postData(AppConstants.favoriteToggleUrl, {
  //     "type": "Company",
  //     "id": id,
  //   });
  // }
}

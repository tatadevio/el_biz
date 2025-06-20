import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/appConstant.dart';
import '../api/api_client.dart';

class PublicCompanyRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  PublicCompanyRepo(this.apiClient, this.sharedPreferences);

  Future<Response> getMyCompanies(int page) async {
    return await apiClient
        .getData("${AppConstants.publicCompaniesUrl}?page=$page");
  }

  Future<Response> getNewMyCompanies(int page) async {
    return await apiClient.getData(
        "${AppConstants.publicCompaniesUrl}?order_by=created_at&order_direction=desc&page=$page");
  }

  Future<Response> getPublicFilterCompanies(
      {required String categoryId,
      required String keywords,
      required String highRating,
      required String city,
      required String isVerified,
      required int page}) async {
    //here apply filter
    return await apiClient.getData(
        "${AppConstants.publicCompaniesUrl}?category_id=$categoryId&search_keywords=$keywords&high_rating=$highRating&city=$city&isVarified=$isVerified&page=$page");
  }
}

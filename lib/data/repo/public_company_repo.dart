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
}

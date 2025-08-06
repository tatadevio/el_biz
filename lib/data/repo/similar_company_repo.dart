import 'package:el_biz/data/api/api_client.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/appConstant.dart';

class SimilarCompanyRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  SimilarCompanyRepo(this.apiClient, this.sharedPreferences);

  Future<Response> getSimilarCompanies(String companyId, int currentPage) async {
    return await apiClient.getData(
        "${AppConstants.relatedCompaniesUrl}/$companyId?page=$currentPage");
  }
}
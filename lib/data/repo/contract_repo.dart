import 'package:el_biz/data/api/api_client.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/appConstant.dart';

class ContractRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  ContractRepo(this.apiClient, this.sharedPreferences);

  Future<Response> getCompanySales(String companyId, int currentPage) async {
    return await apiClient.getData(
      '${AppConstants.contractCompanyUrl}/$companyId/sales?page=$currentPage',
    );
  }

  Future<Response> getCompanyPurchases(
      String companyId, int currentPage) async {
    return await apiClient.getData(
      '${AppConstants.contractCompanyUrl}/$companyId/purchases?page=$currentPage',
    );
  }
}

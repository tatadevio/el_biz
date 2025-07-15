import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/appConstant.dart';
import '../api/api_client.dart';

class AccountRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  AccountRepo(this.apiClient, this.sharedPreferences);

  Future<Response> getMyAccounts(int page) async {
    return await apiClient
        .getData("${AppConstants.myAccountsUrl}?page=$page&perPage=20");
  }

  Future<Response> addAccount(
      String accountName, String accountNumber, String bic) async {
    return await apiClient.postData(AppConstants.addAccountUrl, {
      'account_name': accountName,
      'account_number': accountNumber,
      'bic': bic,
    });
  }

  Future<Response> updateAccount(
      String id, String accountName, String accountNumber, String bic) async {
    return await apiClient.postData("${AppConstants.updateAccountUrl}/$id", {
      'account_name': accountName,
      'account_number': accountNumber,
      'bic': bic,
    });
  }

  Future<Response> deleteAccount(String id) async {
    return await apiClient.deleteData(
      "${AppConstants.deleteAccountUrl}/$id",
    );
  }

  Future<Response> makePrimaryAccount(int id) async {
    return await apiClient
        .postData("${AppConstants.makePrimaryAccountUrl}/$id", {});
  }
}

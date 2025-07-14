import 'package:el_biz/data/api/api_client.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/appConstant.dart';

class AgreementRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AgreementRepo(this.apiClient, this.sharedPreferences);

  Future<Response> getPaymentMethod() async {
    return await apiClient.getData(AppConstants.paymentMethodUrl);
  }

  Future<Response> addAgreement(Map<String, dynamic> agreement) async {
    return await apiClient.postData(AppConstants.storeContractUrl, agreement);
  }

  Future<Response> updateAgreement(
      Map<String, dynamic> agreement, String contractId) async {
    print('this is my url = ${AppConstants.updateContractUrl}/$contractId');
    return await apiClient.postData(
      '${AppConstants.updateContractUrl}/$contractId',
      agreement,
    );
  }

  Future<Response> getMySales(int currentPage) async {
    return await apiClient.getData(
      '${AppConstants.mySalesCompaniesUrl}?page=$currentPage',
    );
  }

  Future<Response> getMyPurchases(int currentPage) async {
    return await apiClient.getData(
      '${AppConstants.myPurchasesCompaniesUrl}?page=$currentPage',
    );
  }

  Future<Response> searchMySales(String search, int currentPage) async {
    return await apiClient.getData(
      '${AppConstants.mySalesCompaniesUrl}?search=$search&page=$currentPage',
    );
  }

  Future<Response> searchMyPurchases(String search, int currentPage) async {
    return await apiClient.getData(
      '${AppConstants.myPurchasesCompaniesUrl}?search=$search&page=$currentPage',
    );
  }
}

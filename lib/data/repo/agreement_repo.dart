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
}

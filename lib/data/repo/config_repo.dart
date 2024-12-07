import 'package:get/get.dart';

import '../../utils/appConstant.dart';
import '../api/api_client.dart';

class ConfigRepo {
  final ApiClient apiClient;

  ConfigRepo(this.apiClient);

  Future<Response> getPrivacy() async {
    return await apiClient.getData(AppConstants.privacyUrl);
  }

  Future<Response> getTerms() async {
    return await apiClient.getData(AppConstants.termsUrl);
  }

  Future<Response> getAbout() async {
    return await apiClient.getData(AppConstants.aboutUrl);
  }

  Future<Response> getConfig() async {
    return await apiClient.getData(AppConstants.configUrl);
  }
}

import 'package:el_biz/data/api/api_client.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/appConstant.dart';

class FilterFieldsRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  const FilterFieldsRepo(this.apiClient, this.sharedPreferences);

  Future<Response> getFilterFields() async {
    return await apiClient.getData(AppConstants.filterFieldsUrl);
  }
}

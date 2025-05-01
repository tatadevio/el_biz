import 'package:el_biz/data/api/api_client.dart';
import 'package:get/get.dart' show Response;
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/appConstant.dart';

class MaterialRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  const MaterialRepo(this.apiClient, this.sharedPreferences);

    Future<Response> getMaterials(int page) async {
    return await apiClient.getData("${AppConstants.materialsUrl}?page=$page");
  }
}
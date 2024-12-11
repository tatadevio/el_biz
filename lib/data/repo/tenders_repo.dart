import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/appConstant.dart';
import '../api/api_client.dart';

class TendersRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  TendersRepo(this.apiClient, this.sharedPreferences);

  // Future<Response> fetchAllTenders(int offSet) async {
  //   return await apiClient.getData();
  // }
}

import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/appConstant.dart';
import '../api/api_client.dart';

class HomeRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  HomeRepo(this.apiClient, this.sharedPreferences);

  Future<Response> getHomeData() async {
    return await apiClient.getData(AppConstants.homePageUrl);
  }

  Future<Response> getBanners() async {
    return await apiClient.getData(AppConstants.bannersUrl);
  }

  Future<Response> getStoryList() async {
    return await apiClient.getData(AppConstants.storiesDetailUrl);
  }
}

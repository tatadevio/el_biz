import 'package:get/get.dart';

import '../../utils/appConstant.dart';
import '../api/api_client.dart';

class FavoriteRepo {
  final ApiClient apiClient;

  FavoriteRepo(this.apiClient);

  Future<Response> getSearchFavorite() async {
    return await apiClient.getData(AppConstants.searchFavoriteUrl);
  }

  Future<Response> saveSearch(String title, String path, String type) async {
    return await apiClient.postData(AppConstants.saveSearchUrl,
        {"title": title, "result": path, "type": type});
  }

  Future<Response> deleteSearch(String id) async {
    return await apiClient.deleteData("${AppConstants.deleteSearchUrl}/$id");
  }

  Future<Response> getFavoiriteUsers({int? page = 1}) async {
    return await apiClient
        .getData('${AppConstants.favoriteUsersUri}?page=$page');
  }

  Future<Response> followSeller(String id) async {
    return await apiClient.postData(
        AppConstants.followSellerUri, {"id": id, "followable_type": "User"});
  }

  Future<Response> unFollowSeller(String id) async {
    return await apiClient.postData(
        AppConstants.unFollowSellerUri, {"id": id, "followable_type": "User"});
  }
}

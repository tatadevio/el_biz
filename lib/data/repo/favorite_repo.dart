import 'package:get/get_connect/http/src/response/response.dart';

import '../../utils/appConstant.dart';
import '../api/api_client.dart';

class FavoriteRepo {
  final ApiClient apiClient;

  FavoriteRepo(this.apiClient);

  Future<Response> getFavoriteProducts(int page) async {
    return await apiClient
        .getData("${AppConstants.favoriteProductsUrl}?page=$page");
  }

  Future<Response> getFavoriteTenders(int page) async {
    return await apiClient
        .getData("${AppConstants.favoriteTendersUrl}?page=$page");
  }

  // Future<Response> saveSearch(String title, String path, String type) async {
  //   return await apiClient.postData(AppConstants.saveSearchUrl,
  //       {"title": title, "result": path, "type": type});
  // }

  // Future<Response> deleteSearch(String id) async {
  //   return await apiClient.deleteData("${AppConstants.deleteSearchUrl}/$id");
  // }

  // Future<Response> getFavoiriteUsers({int? page = 1}) async {
  //   return await apiClient
  //       .getData('${AppConstants.favoriteUsersUri}?page=$page');
  // }

  // Future<Response> followSeller(String id) async {
  //   return await apiClient.postData(
  //       AppConstants.followSellerUri, {"id": id, "followable_type": "User"});
  // }

  // Future<Response> unFollowSeller(String id) async {
  //   return await apiClient.postData(
  //       AppConstants.unFollowSellerUri, {"id": id, "followable_type": "User"});
  // }
}

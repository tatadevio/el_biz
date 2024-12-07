import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../utils/appConstant.dart';
import '../api/api_client.dart';
import 'dart:io';

class SellerRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  SellerRepo(this.apiClient, this.sharedPreferences);

  Future<Response> getSellerProductList(String id) async {
    return await apiClient.getData("${AppConstants.sellerProductListUrl}/$id");
  }

  Future<Response> getCompanyCategory() async {
    return await apiClient.getData(AppConstants.companyCategoryUrl);
  }

  Future<Response> getSellerInfoUrl(String id) async {
    return await apiClient.getData("${AppConstants.sellerInfoUrl}$id");
  }

  Future<Response> changeStatus(String id, String status) async {
    return await apiClient.postData("${AppConstants.changeStatusUrl}/$id", {"status": status});
  }

  Future<Response> registerSeller(Map<String, String> value) async {
    return await apiClient.postData(AppConstants.registerSellerUrl, value);
  }

  Future<Response> addToFav(String id) async {
    return await apiClient.postData(AppConstants.addToFavoriteUrl, {"id": id, "favourable_type": "User"});
  }

  Future<Response> removeFromFav(String id) async {
    return await apiClient.postData(AppConstants.removeFavoriteUrl, {"id": id, "favourable_type": "User"});
  }

  Future<Response> followSeller(String id) async {
    return await apiClient.postData(AppConstants.followSellerUri, {"id": id, "followable_type": "User"});
  }

  Future<Response> unFollowSeller(String id) async {
    return await apiClient.postData(AppConstants.unFollowSellerUri, {"id": id, "followable_type": "User"});
  }

  Future<Response> deleteFollower(String id) async {
    return await apiClient.postData("${AppConstants.deleteFollowerUri}/$id", {}
        // {"id": id, "followable_type": "User"},
        );
  }

  Future<Response> getMyFollowers(int? page) async {
    return await apiClient.getData('${AppConstants.myFollowersUri}?page=${page ?? 1}');
  }

  Future<Response> getMyFollowings(int? page) async {
    return await apiClient.getData('${AppConstants.myFollowingsUri}?page=${page ?? 1}');
  }

  Future<Response> getSellerFollowers(int? page, int sellerId) async {
    return await apiClient.getData('${AppConstants.sellerFollowersUri}/$sellerId?page=${page ?? 1}');
  }

  Future<Response> getSellerFollowings(int? page, int sellerId) async {
    return await apiClient.getData('${AppConstants.sellerFollowingsUri}/$sellerId?page=${page ?? 1}');
  }

  // Future completeProfile(String id, XFile logoImage, XFile bannerImage,
  //     Map<String, String> value) async {
  //   String? token = sharedPreferences.getString("token");
  //   Uri url = id == ""
  //       ? Uri.parse(
  //           '${AppConstants.baseUrl}${AppConstants.completeSellerUrl}',
  //         )
  //       : Uri.parse(
  //           '${AppConstants.baseUrl}${AppConstants.completeSellerUrl}',
  //         );
  //   http.MultipartRequest request = http.MultipartRequest('POST', url);
  //   request.headers.addAll({
  //     'Authorization': 'Bearer $token',
  //   });

  //   File file0 = File(logoImage.path);
  //   request.files.add(http.MultipartFile(
  //       'logo', file0.readAsBytes().asStream(), file0.lengthSync(),
  //       filename: file0.path.split('/').last));

  //   File file1 = File(bannerImage.path);
  //   request.files.add(http.MultipartFile(
  //       'banner', file1.readAsBytes().asStream(), file1.lengthSync(),
  //       filename: file1.path.split('/').last));

  //   Map<String, String> _fields = {};
  //   _fields.addAll(value);

  //   request.fields.addAll(_fields);
  //   print('=====> ${request.url.path}\n' + request.fields.toString());
  //   http.StreamedResponse response = await request.send();
  //   var res = await http.Response.fromStream(response);
  //   print('=====Response body is here==>${res.body}');
  //   try {
  //     return res;
  //   } catch (e) {
  //     return res;
  //   }
  //   //return await apiClient.getData(AppConstants.courseDetailUrl+"/"+id);
  // }
}

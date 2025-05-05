import 'package:el_biz/data/api/api_client.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/appConstant.dart';

class ProductReviewRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  const ProductReviewRepo(this.apiClient, this.sharedPreferences);

  Future<Response> productReviews(String productId, int page) async {
    return await apiClient.getData(
        "${AppConstants.productReviewsUrl}/$productId?page=$page");
  }

  Future<Response> addProductReviewReply(String reviewId, String reply) async {
    return await apiClient
        .postData("${AppConstants.productReviewsUrl}/$reviewId/reply", {
      "answer": reply,
    });
  }

  Future<Response> deleteProductReview(String reviewId) async {
    return await apiClient
        .deleteData("${AppConstants.productReviewDeleteUrl}/$reviewId");
  }
}

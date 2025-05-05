import 'package:el_biz/data/api/api_client.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/appConstant.dart';

class CompnayDetailRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  CompnayDetailRepo(this.apiClient, this.sharedPreferences);

  Future<Response> companyDetailById(String id) async {
    return await apiClient.getData("${AppConstants.companyDetailUrl}/$id");
  }

  Future<Response> deleteCompanyDocument(String documentId) async {
    return await apiClient
        .deleteData("${AppConstants.deleteCompanyDocumentUrl}/$documentId");
  }

  Future<Response> companyProducts(String companyId, int page) async {
    return await apiClient
        .getData("${AppConstants.companyProductsUrl}/$companyId?page=$page");
  }

  Future<Response> companyDocuments(String companyId) async {
    return await apiClient
        .getData("${AppConstants.companyDocumentsUrl}/$companyId");
  }

  Future<Response> companyTenders(String companyId) async {
    return await apiClient
        .getData("${AppConstants.companyDetailUrl}/$companyId/tenders");
  }

  Future<Response> companyReviews(String companyId, int page) async {
    return await apiClient.getData(
        "${AppConstants.companyDetailUrl}/$companyId/reviews?page=$page");
  }

  Future<Response> addCompanyReviewReply(String reviewId, String reply) async {
    return await apiClient
        .postData("${AppConstants.companyReviewsReplyUrl}/$reviewId/reply", {
      "answer": reply,
    });
  }

  Future<Response> deleteCompanyReview(String reviewId) async {
    return await apiClient
        .deleteData("${AppConstants.companyReviewsDeleteUrl}/$reviewId");
  }

  Future<Response> toggleFavorite(String id) async {
    return await apiClient.postData(AppConstants.favoriteToggleUrl, {
      "type": "Product",
      "id": id,
    });
  }
}

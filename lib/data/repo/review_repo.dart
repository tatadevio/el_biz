import 'package:el_biz/data/api/api_client.dart';
import 'package:el_biz/utils/appConstant.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ReviewRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  ReviewRepo(this.apiClient, this.sharedPreferences);

  Future<Response> submitReview({
    required String companyId,
    required int rating,
    required String review,
    required List<XFile> images,
  }) async {
    print('this is rating value sending to api: $rating');
    Map<String, String> fields = {
      'review': review,
      'rating': rating.toString(),
    };

    List<http.MultipartFile> files = [];

    for (var image in images) {
      files.add(await http.MultipartFile.fromPath('images[]', image.path));
    }

    return await apiClient.postMultipartData(
      '${AppConstants.addCompanyReviewUrl}/$companyId',
      fields: fields,
      files: files,
    );
  }

  Future<Response> submitProductReview({
    required String productId,
    required int rating,
    required String review,
    required List<XFile> images,
  }) async {
    print('this is rating value sending to api: $rating');
    Map<String, String> fields = {
      'product_id': productId,
      'review': review,
      'rating': rating.toString(),
    };

    List<http.MultipartFile> files = [];

    for (var image in images) {
      files.add(await http.MultipartFile.fromPath('images[]', image.path));
    }

    return await apiClient.postMultipartData(
      AppConstants.addProductReviewUrl,
      fields: fields,
      files: files,
    );
  }
}

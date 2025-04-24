import 'package:get/get_connect/http/src/response/response.dart';

import '../../utils/appConstant.dart';
import '../api/api_client.dart';


class CategoryRepo {
  final ApiClient apiClient;

  CategoryRepo(this.apiClient);

  Future<Response> getCategory() async {
    return await apiClient.getData(AppConstants.categoriesUrl);
  }

  // Future<Response> getCategoryFilter() async {
  //   return await apiClient.getData("${AppConstants.categoryProductUrl}?type=filter");
  // }

  Future<Response> categoryDetail(String id) async {
    return await apiClient.getData("${AppConstants.categoryDetailUrl}/$id");
  }

  
}

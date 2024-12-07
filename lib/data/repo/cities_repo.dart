import 'package:get/get_connect/http/src/response/response.dart';

import '../../utils/appConstant.dart';
import '../api/api_client.dart';

class CitiesRepo {
  final ApiClient apiClient;

  CitiesRepo(this.apiClient);

  Future<Response> getCities(String pageSize) async {
    return await apiClient.getData(
      "${AppConstants.citiesUrl}?perPage=$pageSize",
    );
  }
}

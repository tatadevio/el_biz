import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_client.dart';

class PackageRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  PackageRepo(this.apiClient, this.sharedPreferences);

  // Future<Response> getPackages(String type) async {
  //   return await apiClient.getData(AppConstants.packagesUrl);
  // }

  // Future<Response> buySubscribtion({
  //   required String productId,
  //   required String packageId,
  //   required String day,
  //   required String paymentType,
  // }) async {
  //   return await apiClient.postData(AppConstants.adPromotionUrl, {"product_id": productId, "package_id": packageId, "days": day != "0" ? day : "1", "payment_type": paymentType});
  // }
}

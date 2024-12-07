import 'package:get/get.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/appConstant.dart';
import '../api/api_client.dart';
import '../model/response/product/add_attribute_model.dart';

class ProductRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  ProductRepo(this.apiClient, this.sharedPreferences);

  Future<Response> getProduct(String type, String pageSize) async {
    return await apiClient.getData("${AppConstants.productUrl}$type&page=$pageSize");
  }

  Future<Response> getProductWithCatId(String id) async {
    return await apiClient.getData("${AppConstants.productWithCatId}$id");
  }

  Future<Response> getFilterProduct(String id, String sortBy, String minPrice, String maxPrice, List<AddAttribute> addAttribute, List<AddAttributeMulti> addAttributeMulti, List<AddAttributeInt> addAttributeInt) async {
    List<String> value = [];
    for (int i = 0; i < addAttributeMulti.length; i++) {
      value.add("&multi_attributes[${addAttributeMulti[i].id}]=${addAttributeMulti[i].answer.removeAllWhitespace}");
    }

    for (int i = 0; i < addAttribute.length; i++) {
      value.add("&attributes[${addAttribute[i].id}]=${addAttribute[i].answer}");
    }

    for (int i = 0; i < addAttributeInt.length; i++) {
      if (i % 2 == 0) {
        value.add("&attributes[${addAttributeInt[i].id}][from]=${addAttributeInt[i].answer}");
      } else {
        value.add("&attributes[${addAttributeInt[i].id}][to]=${addAttributeInt[i].answer}");
      }
    }
    print(value
        .toSet()
        .toString()
        .removeAllWhitespace
        .replaceAll(
          "{",
          "",
        )
        .replaceAll("}", ""));
    print(value.length);

    String params = value
        .toSet()
        .toString()
        .removeAllWhitespace
        .replaceAll(
          "{",
          "",
        )
        .replaceAll("}", "");

    return await apiClient.getData("${AppConstants.productWithCatId}"
        "$id&sort_by=$sortBy&min_price=$minPrice&max_price=$maxPrice$params");
  }

  Future<Response> getFilterProductWithFav(String query) async {
    return await apiClient.getData("api/v1/products$query");
  }

  Future<Response> searchProduct(String query) async {
    return await apiClient.getData("${AppConstants.productWithCatId}"
        "&search=$query");
  }

  Future<Response> getCatProduct(String id) async {
    return await apiClient.getData(AppConstants.productUrl);
  }

  Future<Response> getFavProduct(String pageSize) async {
    return await apiClient.getData("${AppConstants.favoritesProductUrl}?page=$pageSize&per_page=20");
  }

  Future<Response> getRelatedProduct(String id) async {
    return await apiClient.getData("${AppConstants.relatedProductUrl}/$id");
  }

  Future<Response> productDetail(String id) async {
    return await apiClient.getData("${AppConstants.productUrl}/$id");
  }

  Future<Response> getReportList(String id) async {
    return await apiClient.getData("${AppConstants.productReportList}/$id");
  }

  Future<Response> addReport(String id, String comment, String description) async {
    return await apiClient.postData("${AppConstants.addReport}/$id", {"report": comment, "description": description});
  }

  Future<Response> addToFav(String id) async {
    return await apiClient.postData(AppConstants.addToFavoriteUrl, {"id": id, "favourable_type": "Product"});
  }

  Future<Response> removeFromFav(String id) async {
    return await apiClient.postData(AppConstants.removeFavoriteUrl, {"id": id, "favourable_type": "Product"});
  }

  Future<Response> getLikesProduct() async {
    return await apiClient.getData(AppConstants.myLikesProduct);
  }

  Future<Response> addToLike(String id) async {
    return await apiClient.postData(AppConstants.likeProductUrl, {"id": id, "likeable_type": "Product"});
  }

  Future<Response> removeFromLike(String id) async {
    return await apiClient.postData(AppConstants.removeFromLikeProductUrl, {"id": id, "likeable_type": "Product"});
  }
}

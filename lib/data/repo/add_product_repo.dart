import 'dart:developer';

import 'package:el_biz/data/api/api_client.dart';
import 'package:el_biz/data/model/base/add_product_model.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/appConstant.dart';

class AddProductRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AddProductRepo(this.apiClient, this.sharedPreferences);

  Future<Response> addNewProduct(AddProductModel addProductModel,
      {bool? isUpdate = false, String? productId}) async {
    Map<String, String> fields = {
      'name': addProductModel.productName ?? '',
      'brand': addProductModel.brandName ?? '',
      'description': addProductModel.description ?? '',
      'company_id': addProductModel.company?.id.toString() ?? '',
      'category_id': addProductModel.category?.id.toString() ?? '',
      'status': 'published', //draft , published
      'quantity': addProductModel.quantity ?? '',
      'is_available': addProductModel.availability ?? '0',
      'dimention': addProductModel.dimensions ?? '',
      'weight': addProductModel.weight ?? '',
      'country_of_origin': addProductModel.region ?? '',
      'search_keywords': addProductModel.keywords ?? '',
      'material': addProductModel.material?.name ?? '',
      'price': addProductModel.price ?? '',
    };

    log('this is new product price = ${addProductModel.price ?? ''}');

    // Add category_ids[] dynamically
    // for (CategoryItem category in addCompanyModel.categories!) {
    //   fields['category_ids[]'] = category.id.toString();
    // }

    List<http.MultipartFile> files = [];
    if (addProductModel.productImages != null &&
        addProductModel.productImages!.isNotEmpty) {
      for (XFile image in addProductModel.productImages!) {
        files.add(await http.MultipartFile.fromPath('images[]', image.path));
      }
    }

    return await apiClient.postMultipartData(
      isUpdate == true
          ? "${AppConstants.productUpdateUrl}/$productId"
          : AppConstants.addProductUrl,
      fields: fields,
      files: files,
    );
  }

  Future<Response> deleteProductImage(
    String productId,
    String imageId,
  ) async {
    return await apiClient.postData(
        "${AppConstants.deleteProductImageUrl}/$productId",
        {"image_id": imageId});
  }

  Future<Response> getCategoryById(
    String categoryId,
  ) async {
    return await apiClient
        .getData("${AppConstants.categoryDetailUrl}/$categoryId");
  }
}

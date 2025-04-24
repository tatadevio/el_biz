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

  Future<Response> addNewProduct(AddProductModel addProductModel) async {
    Map<String, String> fields = {
      'name': addProductModel.productName ?? '',
      'brand': addProductModel.brandName ?? '',
      'description': addProductModel.description ?? '',
      'company_id': ' 1  ',
      'category_id': ' 2  ',
      'status': 'active',
      'quantity': addProductModel.quantity ?? '',
      // 'is_available': addProductModel.availability == '1' ? true : false,
      'dimention': addProductModel.dimensions ?? '',
      'weight': addProductModel.weight ?? '',
      'country_of_origin': addProductModel.region ?? '',
      'search_keywords': addProductModel.keywords ?? '',
      'material': ' Plastic',
      // 'status': 'draft',
      // 'is_available': '1',
      'price': addProductModel.price ?? '',
    };

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
      AppConstants.addProductUrl,
      fields: fields,
      files: files,
    );
  }
}

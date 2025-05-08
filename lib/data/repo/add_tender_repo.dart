import 'package:el_biz/data/api/api_client.dart';
import 'package:el_biz/data/model/base/add_tender_model.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/appConstant.dart';

class AddTenderRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AddTenderRepo(this.apiClient, this.sharedPreferences);

  Future<Response> addNewTender(AddTenderModel addTenderModel,
      {bool? isUpdate = false, String? tenderId}) async {
    print('this is the tender detail : ${addTenderModel.toJson()}');
    Map<String, String> fields = {
      'title': addTenderModel.whatToBuy ?? '',
      // 'name' : addTenderModel.whatToBuy ?? '',
      'description': addTenderModel.shortDescription ?? '',
      'location': ' Test Location',
      'budget_from': addTenderModel.budgetStart ?? '',
      'budget_to': addTenderModel.budgetEnd ?? '',
      'phone': addTenderModel.phone ?? '',
      'email': addTenderModel.email ?? '',
      'tender_category_id': addTenderModel.categories!.first.id.toString(),
      // "category_id": addTenderModel.categories!.first.id.toString(),
      'company_id': addTenderModel.selectedCompany?.id.toString() ?? '',
      // new fields added form the validation
      "quantity": '2'
    };

    //   {
    //      'title': ' Test Tender',
    // 'description': ' Test Description',
    // 'location': ' Test Location',
    // 'budget_from': ' 1000',
    // 'budget_to': ' 2000',
    // 'phone': ' 1234567890',
    // 'email': ' test@example.com',
    // 'tender_category_id': '1',
    // 'tender_products[0][product_name]': ' Product 1',
    // 'tender_products[0][quantity]': ' 10',
    // 'tender_products[0][unit]': ' pcs',
    // 'company_id': '1'
    //   }

    if (addTenderModel.product != null && addTenderModel.product!.isNotEmpty)
      // ignore: curly_braces_in_flow_control_structures
      for (int i = 0; i < addTenderModel.product!.length; i++) {
        final product = addTenderModel.product![i];
        fields['tender_products[$i][product_name]'] = product.productName ?? '';
        fields['tender_products[$i][quantity]'] = product.quantity.toString();
        fields['tender_products[$i][unit]'] = 'pcs';
      }

    List<http.MultipartFile> files = [];
    if (addTenderModel.images != null && addTenderModel.images!.isNotEmpty) {
      for (XFile image in addTenderModel.images!) {
        files.add(await http.MultipartFile.fromPath('images[]', image.path));
      }
    }

    return await apiClient.postMultipartData(
      isUpdate == true
          ? "${AppConstants.udpateTenderUrl}/$tenderId"
          : AppConstants.addTenderUrl,
      fields: fields,
      files: files,
    );
  }

  Future<Response> deleteTenderImage(
    String tenderId,
    String imageId,
  ) async {
    return await apiClient
        .deleteData("${AppConstants.tendersUrl}/$tenderId/images/$imageId");
  }
}

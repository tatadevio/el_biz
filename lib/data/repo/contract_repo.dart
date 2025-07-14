import 'package:el_biz/data/api/api_client.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/appConstant.dart';
import 'package:http/http.dart' as http;

class ContractRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  ContractRepo(this.apiClient, this.sharedPreferences);

  Future<Response> getCompanySales(String companyId, int currentPage) async {
    return await apiClient.getData(
      '${AppConstants.contractCompanyUrl}/$companyId/sales?page=$currentPage',
    );
  }

  Future<Response> getCompanyPurchases(
      String companyId, int currentPage) async {
    return await apiClient.getData(
      '${AppConstants.contractCompanyUrl}/$companyId/purchases?page=$currentPage',
    );
  }

  Future<Response> signContract(
      String contractId, String directorName, XFile signatureFile) async {
    Map<String, String> fields = {
      'director_name': directorName,
      'terms_and_condition': '1',
    };

    List<http.MultipartFile> files = [];
    files.add(
        await http.MultipartFile.fromPath('signature', signatureFile.path));

    return await apiClient.postMultipartData(
      "${AppConstants.signContractUrl}/$contractId",
      fields: fields,
      files: files,
    );
  }

  Future<Response> updateContractStatus(
      String contractId, String status) async {
    return await apiClient.postData(
      "${AppConstants.updateContractStatusUrl}/$contractId",
      {'status': status},
    );
  }

  Future<Response> updatePaymentStatus(String contractId, String status) async {
    return await apiClient
        .postData("${AppConstants.contractUrl}/$contractId/payment-status", {
      "payment_status": status,
    });
  }

  Future<Response> addPaymentData(
      String contractId, String note, String imagePath) async {
    List<http.MultipartFile> files = [];
    files.add(await http.MultipartFile.fromPath('payment_slip', imagePath));

    return await apiClient.postMultipartData(
      "${AppConstants.contractUrl}/$contractId/upload-payment-slip",
      files: files,
      fields: {
        'note': note,
      },
    );
  }
}

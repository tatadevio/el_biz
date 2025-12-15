import 'dart:io';

import 'package:el_biz/data/api/api_client.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/appConstant.dart';

class ProductImportRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  ProductImportRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> importProductTemplate() async {
    return await apiClient.getData(
      AppConstants.importProductTemplate,
    );
  }
  // List<http.MultipartFile> files = [];

  //       files.add(await http.MultipartFile.fromPath(
  //       'banner', addCompanyModel.companyBanner!.path));

  Future<Response> addImportProducts(
      FilePickerResult file, String categoryId, String companyId) async {
    List<http.MultipartFile> allFiles = [];
    for (var f in file.files) {
      allFiles.add(
        await http.MultipartFile.fromPath(
          'file',
          f.path!,
          filename: f.name,
        ),
      );
    }
    return await apiClient.postMultipartData(
      fields: {
        'category_id': categoryId,
        'company_id': companyId,
      },
      files: allFiles,
      AppConstants.importProductUpload,
    );
  }

  // List<http.MultipartFile> filesFromPicker(FilePickerResult result) {
  //   return result.files.map((f) {
  //     return http.MultipartFile.fromBytes(
  //       'file', // name expected by backend
  //       f.bytes!, // Uint8List
  //       filename: f.name,
  //     );
  //   }).toList();
  // }
}

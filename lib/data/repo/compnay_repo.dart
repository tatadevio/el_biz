import 'package:el_biz/bloc/company/company_bloc.dart';
import 'package:el_biz/data/api/api_client.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/appConstant.dart';
import '../model/base/add_company_model.dart';
import '../model/response/category/categories_list_model.dart';
import 'package:http/http.dart' as http;

class CompnayRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  CompnayRepo(this.apiClient, this.sharedPreferences);

  Future<Response> getMyCompanies() async {
    // missing pagination

    return await apiClient.getData(AppConstants.myCompaniesUrl);
  }

  Future<Response> deleteCompany(String id) async {
    return await apiClient.deleteData("${AppConstants.companyDeleteUrl}/$id");
  }

  Future<Response> addNewCompany(AddCompanyModel addCompanyModel) async {
    Map<String, String> fields = {
      'name': addCompanyModel.companyName ?? '',
      'tin_number': addCompanyModel.tinNumber ?? '',
      'phone': addCompanyModel.phoneNumbers?.first ?? '',
      'email': addCompanyModel.email ?? '',
      'address':
          '${addCompanyModel.house} ${addCompanyModel.street}, ${addCompanyModel.city}',
      'okpo': addCompanyModel.companyNumber ?? '',
      'search_tags': addCompanyModel.keywords?.join(',') ?? '',
      'description': addCompanyModel.description ?? '',
    };

    // Add category_ids[] dynamically
    for (CategoryItem category in addCompanyModel.categories!) {
      fields['category_ids[]'] = category.id.toString();
    }

    List<http.MultipartFile> files = [];
    if (addCompanyModel.companyLogo != null) {
      files.add(await http.MultipartFile.fromPath(
          'logo', addCompanyModel.companyLogo!.path));
    }

    if (addCompanyModel.companyBanner != null) {
      files.add(await http.MultipartFile.fromPath(
          'banner', addCompanyModel.companyBanner!.path));
    }

    return await apiClient.postMultipartData(
      AppConstants.addCompanyUrl,
      fields: fields,
      files: files,
    );
  }

  Future<Response> addNewCompanyDocument(
      AddCompanyModel addCompanyModel) async {
    Map<String, String> fields = {
      'name': addCompanyModel.companyName ?? '',
    };

    // // Add category_ids[] dynamically
    // for (CategoryItem category in addCompanyModel.categories!) {
    //   fields['category_ids[]'] = category.id.toString();
    // }

    List<http.MultipartFile> files = [];

    if (addCompanyModel.certificateDocument != null) {
      files.add(await http.MultipartFile.fromPath(
          'certificate_document', addCompanyModel.certificateDocument!.path));
    }

    if (addCompanyModel.otherDocuments != null &&
        addCompanyModel.otherDocuments!.isNotEmpty) {
      for (XFile file in addCompanyModel.otherDocuments!) {
        files.add(
            await http.MultipartFile.fromPath('other_documents[]', file.path));
      }
    }

    return await apiClient.postMultipartData(
      AppConstants.addCompanyDocumentUrl,
      fields: fields,
      files: files,
    );
  }

  // Future<Response> companyDetailById(String id) async {
  //   return await apiClient.getData("${AppConstants.companyDetailUrl}/$id");
  // }
}

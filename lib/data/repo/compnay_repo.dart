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
          '${addCompanyModel.house} ${addCompanyModel.street}, ${addCompanyModel.city?.name}',
      'okpo': addCompanyModel.companyNumber ?? '',
      'search_tags': addCompanyModel.keywords?.join(',') ?? '',
      'description': addCompanyModel.description ?? '',
      'about_company': 'our comapny is good',
      'city_id': addCompanyModel.city?.id.toString() ?? '',
      'street': addCompanyModel.street ?? '',
      'house': addCompanyModel.house ?? '',
      'office': addCompanyModel.office ?? '',
      'postal_code': addCompanyModel.postalCode ?? '',
      'lunch_break[open]': addCompanyModel.lunchBreak?.isOpen == true
          ? addCompanyModel.lunchBreak?.openingTime ?? ''
          : '',
      // '12:00',
      'lunch_break[close]': addCompanyModel.lunchBreak?.isOpen == true
          ? addCompanyModel.lunchBreak?.openingTime ?? ''
          : '',
      // '13:00',
    };

    // Add category_ids[] dynamically
    for (CategoryItem category in addCompanyModel.categories!) {
      fields['category_ids[]'] = category.id.toString();
    }
    if (addCompanyModel.phoneNumbers != null &&
        addCompanyModel.phoneNumbers!.isNotEmpty) {
      for (String number in addCompanyModel.phoneNumbers!) {
        fields['phone_numbers[]'] = number;
      }
    }

    if (addCompanyModel.bankData != null &&
        addCompanyModel.bankData!.isNotEmpty) {
      for (int i = 0; i < addCompanyModel.bankData!.length; i++) {
        final bank = addCompanyModel.bankData![i];
        fields['accounts[$i][account_name]'] = bank.accountName;
        fields['accounts[$i][account_number]'] = bank.accountNumber;
        fields['accounts[$i][bic]'] = bank.bankName;
      }
    }

    if (addCompanyModel.otherContacts != null &&
        addCompanyModel.otherContacts!.isNotEmpty) {
      for (int i = 0; i < addCompanyModel.otherContacts!.length; i++) {
        fields['contacts[$i][name]'] =
            addCompanyModel.otherContacts![i].contactName ?? '';
        fields['contacts[$i][contact]'] =
            addCompanyModel.otherContacts![i].contactNumber ?? '';
      }
    }

    if (addCompanyModel.schedule != null &&
        addCompanyModel.schedule!.isNotEmpty) {
      for (var day in addCompanyModel.schedule!) {
        //   'working_hours[monday][open]': '09:00',
        // 'working_hours[monday][close]': '18:00',
        // 'working_hours[tuesday][open]': '09:00',
        // 'working_hours[tuesday][close]': '18:00',
        // 'working_hours[wednesday][open]': '09:00',
        // 'working_hours[wednesday][close]': '18:00',
        // 'working_hours[thursday][open]': '09:00',
        // 'working_hours[thursday][close]': '18:00',
        // 'working_hours[friday][open]': '09:00',
        // 'working_hours[friday][close]': '18:00',
        // 'working_hours[saturday][open]': '10:00',
        // 'working_hours[saturday][close]': '14:00',
        // 'working_hours[sunday][open]': '',
        // 'working_hours[sunday][close]': '',
        fields['working_hours[${day.day}][open]'] =
            day.isOpen ? day.openingTime : '';
        fields['working_hours[${day.day}][close]'] =
            day.isOpen ? day.closingTime : '';
      }
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

    if (addCompanyModel.certificateDocument != null) {
      files.add(await http.MultipartFile.fromPath(
          'certificate', addCompanyModel.certificateDocument!.path));
    }

    if (addCompanyModel.otherDocuments != null &&
        addCompanyModel.otherDocuments!.isNotEmpty) {
      for (var document in addCompanyModel.otherDocuments!) {
        files.add(await http.MultipartFile.fromPath(
            'other_documents[]', document.path));
      }
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

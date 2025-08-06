import 'dart:developer';

import 'package:el_biz/data/api/api_client.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/appConstant.dart';
import '../model/base/add_company_model.dart';
import 'package:http/http.dart' as http;

class CompnayRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  CompnayRepo(this.apiClient, this.sharedPreferences);

  Future<Response> getMyCompanies(int currentPage) async {
    // missing pagination

    return await apiClient
        .getData("${AppConstants.myCompaniesUrl}?perPage=30&page=$currentPage");
  }

  Future<Response> deleteCompany(String id) async {
    return await apiClient.deleteData("${AppConstants.companyDeleteUrl}/$id");
  }

  Future<Response> addNewCompany(AddCompanyModel addCompanyModel,
      {bool isUpdate = false, String? companyId}) async {
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
      'about_company': addCompanyModel.aboutCompany ?? '',
      'city_id': addCompanyModel.city?.id.toString() ?? '',
      'street': addCompanyModel.street ?? '',
      'house': addCompanyModel.house ?? '',
      'office': addCompanyModel.office ?? '',
      'postal_code': addCompanyModel.postalCode ?? '',
      'lunch_break[open]': addCompanyModel.lunchBreak?.isOpen == true
          ? addCompanyModel.lunchBreak?.openingTime ?? ''
          : '',
      'lunch_break[close]': addCompanyModel.lunchBreak?.isOpen == true
          ? addCompanyModel.lunchBreak?.closingTime ?? ''
          : '',
    };

    // Add category_ids[] dynamically
    // for (CategoryItem category in addCompanyModel.categories!) {
    //   fields['category_ids[]'] = category.id.toString();
    // }
    for (int i = 0; i < addCompanyModel.categories!.length; i++) {
      fields['category_ids[$i]'] = addCompanyModel.categories![i].id.toString();
    }
    if (addCompanyModel.phoneNumbers != null &&
        addCompanyModel.phoneNumbers!.isNotEmpty) {
      for (int i = 0; i < addCompanyModel.phoneNumbers!.length; i++) {
        fields['phone_numbers[$i]'] = addCompanyModel.phoneNumbers![i];
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
        fields['working_hours[${day.day.toLowerCase()}][open]'] =
            day.isOpen ? day.openingTime : '';
        fields['working_hours[${day.day.toLowerCase()}][close]'] =
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

    log('this is the fields data for update company : $fields');

    return await apiClient.postMultipartData(
        isUpdate
            ? "${AppConstants.updateCompanyUrl}/$companyId"
            : AppConstants.addCompanyUrl,
        fields: fields,
        files: files);
  }

  // var headers = {'Accept': 'application/json', 'Authorization': '••••••'};

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

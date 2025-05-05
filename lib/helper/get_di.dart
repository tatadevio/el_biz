import 'dart:async';
import 'dart:convert';

import 'package:el_biz/bloc/material/material_bloc.dart';
import 'package:el_biz/bloc/product_detail/product_detail_bloc.dart';
import 'package:el_biz/bloc/product_review/product_review_bloc.dart';
import 'package:el_biz/bloc/tender_detail/tender_detail_bloc.dart';
import 'package:el_biz/data/repo/add_tender_repo.dart';
import 'package:el_biz/data/repo/compnay_repo.dart';
import 'package:el_biz/data/repo/contract_repo.dart';
import 'package:el_biz/data/repo/material_repo.dart';
import 'package:el_biz/data/repo/notification_repo.dart';
import 'package:el_biz/data/repo/product_detail_repo.dart';
import 'package:el_biz/data/repo/product_review_repo.dart';
import 'package:el_biz/data/repo/review_repo.dart';
import 'package:el_biz/data/repo/search_repo.dart';
import 'package:el_biz/data/repo/tender_detail_repo.dart';
import 'package:el_biz/data/repo/tenders_repo.dart';
import 'package:flutter/services.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import '../bloc/account/account_bloc.dart';
import '../bloc/add_product/add_product_bloc.dart';
import '../bloc/add_tender/add_tender_bloc.dart';
import '../bloc/company_detail/company_detail_bloc.dart';
import '../bloc/tin_number/tin_bloc.dart';
import '../data/api/api_client.dart';
import '../data/model/base/language_model.dart';
import '../data/repo/account_repo.dart';
import '../data/repo/add_product_repo.dart';
import '../data/repo/auth_repo.dart';
import '../data/repo/category_repo.dart';
import '../data/repo/chat_repo.dart';
import '../data/repo/cities_repo.dart';
import '../data/repo/config_repo.dart';
import '../data/repo/favorite_repo.dart';
import '../data/repo/home_repo.dart';
import '../data/repo/post_ad_repo.dart';
import '../data/repo/product_repo.dart';
import '../data/repo/seller_repo.dart';
import '../data/repo/tin_repo.dart';
import '../data/repo/user_repo.dart';
import '../data/repo/company_detail_repo.dart';
import '../utils/appConstant.dart';

Future<Map<String, Map<String, String>>> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);

  Get.lazyPut(
      () => ApiClient(
          appBaseUrl: AppConstants.baseUrl, sharedPreferences: Get.find()),
      fenix: true);
  Get.lazyPut<ConfigRepo>(() => ConfigRepo(Get.find()), fenix: true);
  Get.lazyPut<AuthRepo>(() => AuthRepo(Get.find(), Get.find()), fenix: true);
  Get.lazyPut<UserRepo>(() => UserRepo(Get.find(), Get.find()), fenix: true);
  Get.lazyPut<HomeRepo>(() => HomeRepo(Get.find(), Get.find()), fenix: true);
  Get.lazyPut<ProductRepo>(() => ProductRepo(Get.find(), Get.find()),
      fenix: true);
  Get.lazyPut<CategoryRepo>(() => CategoryRepo(Get.find()), fenix: true);
  Get.lazyPut<CitiesRepo>(() => CitiesRepo(Get.find()), fenix: true);
  Get.lazyPut<ChatRepo>(() => ChatRepo(Get.find()), fenix: true);
  Get.lazyPut<PostAdRepo>(() => PostAdRepo(Get.find(), Get.find()),
      fenix: true);
  Get.lazyPut<FavoriteRepo>(() => FavoriteRepo(Get.find()), fenix: true);
  Get.lazyPut<SellerRepo>(() => SellerRepo(Get.find(), Get.find()),
      fenix: true);
  Get.lazyPut<TendersRepo>(() => TendersRepo(Get.find(), Get.find()),
      fenix: true);
  Get.lazyPut<NotificationRepo>(() => NotificationRepo(Get.find(), Get.find()),
      fenix: true);
  Get.lazyPut<ReviewRepo>(() => ReviewRepo(Get.find(), Get.find()),
      fenix: true);
  Get.lazyPut<ContractRepo>(() => ContractRepo(Get.find(), Get.find()),
      fenix: true);
  Get.lazyPut<CompnayRepo>(() => CompnayRepo(Get.find(), Get.find()),
      fenix: true);
  Get.lazyPut<SearchRepo>(() => SearchRepo(Get.find(), Get.find()),
      fenix: true);
  Get.lazyPut<UserRepo>(() => UserRepo(Get.find(), Get.find()), fenix: true);
  Get.lazyPut<CompnayDetailRepo>(
      () => CompnayDetailRepo(Get.find(), Get.find()),
      fenix: true);
  Get.lazyPut<AccountRepo>(() => AccountRepo(Get.find(), Get.find()),
      fenix: true);
  Get.lazyPut<TinRepo>(() => TinRepo(Get.find(), Get.find()), fenix: true);
  Get.lazyPut<AddProductRepo>(() => AddProductRepo(Get.find(), Get.find()),
      fenix: true);
  Get.lazyPut<AddTenderRepo>(() => AddTenderRepo(Get.find(), Get.find()),
      fenix: true);
  Get.lazyPut<TenderDetailRepo>(() => TenderDetailRepo(Get.find(), Get.find()),
      fenix: true);
  Get.lazyPut<MaterialRepo>(() => MaterialRepo(Get.find(), Get.find()),
      fenix: true);
  Get.lazyPut<ProductDetailRepo>(
      () => ProductDetailRepo(Get.find(), Get.find()),
      fenix: true);
  Get.lazyPut<ProductReviewRepo>(
      () => ProductReviewRepo(Get.find(), Get.find()),
      fenix: true);

  // get bloc
  Get.lazyPut<CompanyDetailBloc>(() => CompanyDetailBloc(Get.find()),
      fenix: true);
  Get.lazyPut<AccountBloc>(() => AccountBloc(Get.find()), fenix: true);
  Get.lazyPut<TinBloc>(() => TinBloc(Get.find()), fenix: true);
  Get.lazyPut<AddProductBloc>(() => AddProductBloc(Get.find()), fenix: true);
  Get.lazyPut<AddTenderBloc>(() => AddTenderBloc(Get.find()), fenix: true);
  Get.lazyPut<TenderDetailBloc>(() => TenderDetailBloc(Get.find()),
      fenix: true);
  Get.lazyPut<MaterialBloc>(() => MaterialBloc(Get.find()), fenix: true);
  Get.lazyPut<ProductDetailBloc>(() => ProductDetailBloc(Get.find()),
      fenix: true);
  Get.lazyPut<ProductReviewBloc>(() => ProductReviewBloc(Get.find()),
      fenix: true);
////////
  ///
  ///
  ///

  // Get.lazyPut<AuthController>(() => AuthController(authRepo: Get.find()), fenix: true);
  // Get.lazyPut<NetworkConnectivityController>(() => NetworkConnectivityController(), fenix: true);
  // Get.lazyPut<ConfigController>(() => ConfigController(Get.find()), fenix: true);
  // Get.lazyPut<UserController>(() => UserController(Get.find(), Get.find()), fenix: true);
  // Get.lazyPut<HomeController>(() => HomeController(Get.find()), fenix: true);
  // Get.lazyPut<HomeController>(() => HomeController(Get.find()), fenix: true);
  // Get.lazyPut<ProductController>(() => ProductController(Get.find()), fenix: true);
  // Get.lazyPut<CategoryController>(() => CategoryController(Get.find()), fenix: true);
  // Get.lazyPut<ProductDetailController>(() => ProductDetailController(Get.find()), fenix: true);
  // Get.lazyPut<CitiesController>(() => CitiesController(Get.find()), fenix: true);
  // Get.lazyPut<ChatController>(() => ChatController(Get.find()), fenix: true);
  // Get.lazyPut<PostAdController>(() => PostAdController(Get.find()), fenix: true);
  // Get.lazyPut<FavoriteController>(() => FavoriteController(Get.find()), fenix: true);
  // Get.lazyPut<SellerController>(() => SellerController(Get.find()), fenix: true);
  // Get.lazyPut<TendersBloc>(() => TendersBloc(Get.find()), fenix: true);
  // Get.lazyPut<NotificationController>(() => NotificationController(Get.find()), fenix: true);
  // Get.lazyPut<ReviewController>(() => ReviewController(Get.find()), fenix: true);
  // Get.lazyPut<ContractsController>(() => ContractsController(Get.find()), fenix: true);
  // Get.lazyPut<CompanyController>(() => CompanyController(Get.find()), fenix: true);

  // Get.lazyPut<LocalizationController>(() => LocalizationController(sharedPreferences: Get.find(), apiClient: Get.find()), fenix: true);

  // Retrieving localized data
  Map<String, Map<String, String>> _languages = Map();
  for (LanguageModel languageModel in AppConstants.languages) {
    String jsonStringValues = await rootBundle
        .loadString('assets/language/${languageModel.languageCode}.json');
    Map<String, dynamic> _mappedJson = json.decode(jsonStringValues);
    Map<String, String> _json = Map();
    _mappedJson.forEach((key, value) {
      _json[key] = value.toString();
    });
    _languages['${languageModel.languageCode}_${languageModel.countryCode}'] =
        _json;
  }
  return _languages;
}

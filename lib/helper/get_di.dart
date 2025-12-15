import 'dart:async';
import 'dart:convert';

import 'package:el_biz/bloc/auction/add_auction/add_auction_bloc.dart';
import 'package:el_biz/bloc/agreement/agreement_bloc.dart';
import 'package:el_biz/bloc/auction/auction_bid/auction_bid_bloc.dart';
import 'package:el_biz/bloc/auction/auction_buy_offer/auction_buy_offer_bloc.dart';
import 'package:el_biz/bloc/auction/auction_cancel/auction_cancel_bloc.dart';
import 'package:el_biz/bloc/auction/auction_review/auction_review_bloc.dart';
import 'package:el_biz/bloc/auction/favorite_auciton/favorite_auction_bloc.dart';
import 'package:el_biz/bloc/filter_fields/filter_fields_bloc.dart';
import 'package:el_biz/bloc/material/material_bloc.dart';
import 'package:el_biz/bloc/product_detail/product_detail_bloc.dart';
import 'package:el_biz/bloc/product_import/product_import_bloc.dart';
import 'package:el_biz/bloc/product_review/product_review_bloc.dart';
import 'package:el_biz/bloc/public_company/public_company_bloc.dart';
import 'package:el_biz/bloc/public_product/public_product_bloc.dart';
import 'package:el_biz/bloc/public_tender/public_tender_bloc.dart';
import 'package:el_biz/bloc/search_company/search_company_bloc.dart';
import 'package:el_biz/bloc/search_tender/search_tender_bloc.dart';
import 'package:el_biz/bloc/similar_products/similar_products_bloc.dart';
import 'package:el_biz/bloc/tender_detail/tender_detail_bloc.dart';
import 'package:el_biz/data/repo/add_tender_repo.dart';
import 'package:el_biz/data/repo/agreement_repo.dart';
import 'package:el_biz/data/repo/auction/add_auction_repo.dart';
import 'package:el_biz/data/repo/auction/auction_bid_repo.dart';
import 'package:el_biz/data/repo/auction/auction_buy_offer_repo.dart';
import 'package:el_biz/data/repo/auction/auction_cancel_repo.dart';
import 'package:el_biz/data/repo/auction/auction_review_repo.dart';
import 'package:el_biz/data/repo/auction/favorite_auction_repo.dart';
import 'package:el_biz/data/repo/auction/search_auction_repo.dart';
import 'package:el_biz/data/repo/compnay_repo.dart';
import 'package:el_biz/data/repo/contract_repo.dart';
import 'package:el_biz/data/repo/filter_fields_repo.dart';
import 'package:el_biz/data/repo/material_repo.dart';
import 'package:el_biz/data/repo/notification_repo.dart';
import 'package:el_biz/data/repo/product_detail_repo.dart';
import 'package:el_biz/data/repo/product_import_repo.dart';
import 'package:el_biz/data/repo/product_review_repo.dart';
import 'package:el_biz/data/repo/public_company_repo.dart';
import 'package:el_biz/data/repo/public_product_repo.dart';
import 'package:el_biz/data/repo/public_tender_repo.dart';
import 'package:el_biz/data/repo/review_repo.dart';
import 'package:el_biz/data/repo/search_company_repo.dart';
import 'package:el_biz/data/repo/search_repo.dart';
import 'package:el_biz/data/repo/search_tender_repo.dart';
import 'package:el_biz/data/repo/similar_product_repo.dart';
import 'package:el_biz/data/repo/tender_detail_repo.dart';
import 'package:el_biz/data/repo/tenders_repo.dart';
import 'package:flutter/services.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import '../bloc/account/account_bloc.dart';
import '../bloc/add_product/add_product_bloc.dart';
import '../bloc/add_tender/add_tender_bloc.dart';
import '../bloc/auction/auction_bids_list/auction_bids_list_bloc.dart';
import '../bloc/auction/auction_detail/auction_detail_bloc.dart';
import '../bloc/auction/auctions/auctions_bloc.dart';
import '../bloc/auction/search_auction/search_auction_bloc.dart';
import '../bloc/auction/similar_auctions/similar_auctions_bloc.dart';
import '../bloc/company_detail/company_detail_bloc.dart';
import '../bloc/similar_companies/similar_companies_bloc.dart';
import '../bloc/similar_tenders/similar_tenders_bloc.dart';
import '../bloc/tin_number/tin_bloc.dart';
import '../data/api/api_client.dart';
import '../data/model/base/language_model.dart';
import '../data/repo/account_repo.dart';
import '../data/repo/add_product_repo.dart';
import '../data/repo/auction/auction_bids_list_repo.dart';
import '../data/repo/auction/auction_detail_repo.dart';
import '../data/repo/auction/auctions_repo.dart';
import '../data/repo/auction/similar_auctions_repo.dart';
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
import '../data/repo/similar_company_repo.dart';
import '../data/repo/similar_tenders_repo.dart';
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
  Get.lazyPut<PublicCompanyRepo>(
      () => PublicCompanyRepo(Get.find(), Get.find()),
      fenix: true);
  Get.lazyPut<PublicProductRepo>(
      () => PublicProductRepo(Get.find(), Get.find()),
      fenix: true);
  Get.lazyPut<PublicTenderRepo>(() => PublicTenderRepo(Get.find(), Get.find()),
      fenix: true);
  Get.lazyPut<FilterFieldsRepo>(() => FilterFieldsRepo(Get.find(), Get.find()),
      fenix: true);
  Get.lazyPut<SimilarProductRepo>(
      () => SimilarProductRepo(Get.find(), Get.find()),
      fenix: true);
  Get.lazyPut<SearchCompanyRepo>(
      () => SearchCompanyRepo(Get.find(), Get.find()),
      fenix: true);
  Get.lazyPut<AgreementRepo>(() => AgreementRepo(Get.find(), Get.find()),
      fenix: true);
  Get.lazyPut<SearchTenderRepo>(() => SearchTenderRepo(Get.find(), Get.find()),
      fenix: true);
  Get.lazyPut<SimilarCompanyRepo>(
      () => SimilarCompanyRepo(Get.find(), Get.find()),
      fenix: true);
  Get.lazyPut<SimilarTendersRepo>(
      () => SimilarTendersRepo(
          apiClient: Get.find(), sharedPreferences: Get.find()),
      fenix: true);
  Get.lazyPut<AuctionsRepo>(() => AuctionsRepo(Get.find(), Get.find()),
      fenix: true);
  Get.lazyPut<AuctionDetailRepo>(
      () => AuctionDetailRepo(Get.find(), Get.find()),
      fenix: true);
  Get.lazyPut<SimilarAuctionsRepo>(
      () => SimilarAuctionsRepo(Get.find(), Get.find()),
      fenix: true);
  Get.lazyPut<SearchAuctionRepo>(
      () => SearchAuctionRepo(Get.find(), Get.find()),
      fenix: true);
  Get.lazyPut<AddAuctionRepo>(() => AddAuctionRepo(Get.find(), Get.find()),
      fenix: true);
  Get.lazyPut<AuctionBidRepo>(() => AuctionBidRepo(Get.find(), Get.find()),
      fenix: true);
  Get.lazyPut<AuctionBidsListRepo>(
      () => AuctionBidsListRepo(Get.find(), Get.find()),
      fenix: true);
  Get.lazyPut<AuctionReviewRepo>(
      () => AuctionReviewRepo(Get.find(), Get.find()),
      fenix: true);
  Get.lazyPut<AuctionCancelRepo>(
      () => AuctionCancelRepo(Get.find(), Get.find()),
      fenix: true);
  Get.lazyPut<AuctionBuyOfferRepo>(
      () => AuctionBuyOfferRepo(Get.find(), Get.find()),
      fenix: true);
  Get.lazyPut<FavoriteAuctionRepo>(
      () => FavoriteAuctionRepo(Get.find(), Get.find()),
      fenix: true);
  Get.lazyPut<ProductImportRepo>(
      () => ProductImportRepo(
          apiClient: Get.find(), sharedPreferences: Get.find()),
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
  Get.lazyPut<PublicCompanyBloc>(() => PublicCompanyBloc(Get.find()),
      fenix: true);
  Get.lazyPut<PublicProductBloc>(() => PublicProductBloc(Get.find()),
      fenix: true);
  Get.lazyPut<PublicTenderBloc>(() => PublicTenderBloc(Get.find()),
      fenix: true);
  Get.lazyPut<FilterFieldsBloc>(() => FilterFieldsBloc(Get.find()),
      fenix: true);
  Get.lazyPut<SimilarProductsBloc>(() => SimilarProductsBloc(Get.find()),
      fenix: true);
  Get.lazyPut<SearchCompanyBloc>(() => SearchCompanyBloc(Get.find()),
      fenix: true);
  Get.lazyPut<AgreementBloc>(() => AgreementBloc(Get.find()), fenix: true);
  Get.lazyPut<SearchTenderBloc>(() => SearchTenderBloc(Get.find()),
      fenix: true);
  Get.lazyPut<SimilarCompaniesBloc>(() => SimilarCompaniesBloc(Get.find()),
      fenix: true);
  Get.lazyPut<SimilarTendersBloc>(() => SimilarTendersBloc(Get.find()),
      fenix: true);
  Get.lazyPut<AuctionsBloc>(() => AuctionsBloc(Get.find()), fenix: true);
  Get.lazyPut<SearchAuctionBloc>(() => SearchAuctionBloc(Get.find()),
      fenix: true);
  Get.lazyPut<AuctionDetailBloc>(() => AuctionDetailBloc(Get.find()),
      fenix: true);
  Get.lazyPut<SimilarAuctionsBloc>(() => SimilarAuctionsBloc(Get.find()),
      fenix: true);
  Get.lazyPut<AddAuctionBloc>(() => AddAuctionBloc(Get.find()), fenix: true);
  Get.lazyPut<AuctionBidBloc>(() => AuctionBidBloc(Get.find()), fenix: true);
  Get.lazyPut<AuctionBidsListBloc>(() => AuctionBidsListBloc(Get.find()),
      fenix: true);
  Get.lazyPut<AuctionReviewBloc>(() => AuctionReviewBloc(Get.find()),
      fenix: true);
  Get.lazyPut<AuctionCancelBloc>(() => AuctionCancelBloc(Get.find()),
      fenix: true);
  Get.lazyPut<AuctionBuyOfferBloc>(() => AuctionBuyOfferBloc(Get.find()),
      fenix: true);
  Get.lazyPut<FavoriteAuctionBloc>(() => FavoriteAuctionBloc(Get.find()),
      fenix: true);
  Get.lazyPut<ProductImportBloc>(
      () => ProductImportBloc(repository: Get.find()),
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

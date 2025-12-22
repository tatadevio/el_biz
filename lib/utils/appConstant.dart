import 'package:el_biz/utils/Images.dart';

import '../data/model/base/language_model.dart';

class AppConstants {
  static const String baseUrl = "https://admin.elbiz.kg/";

  static const String appName = "El Biz";
  static const String countryCode = "+996";
  static const String currencyCode = "cом";
  // static const String appStoreLink = "";
  // static const String playStoreLink = "https://play.google.com/store/apps/details?id=com.isooq.tatadev";
  // static const int androidVersion = 2;
  // static const String iosVersion = "11";
  // static const String appStoreId = "6667114968";app
  // static const String googleMapApiKey = "AIzaSyDzA_aNns0_2hD7DgwxvxqlUwuxtwsZEYs";

  /// Auth
  static const String sendOtpUrl = "api/auth/send-otp";
  static const String verifyOtpUrl = "api/auth/verify-otp";
  static const String changePasswordUrl = "api/users/change-password";
  static const String loginUrl = "api/auth/login";

  /// User
  static const String userInfoUrl = "api/users/info";
  static const String updateUserUrl = "api/users/update";
  static const String updateFcmTokenUrl = "api/users/fcm-token-update";

  /// Tenders
  static const String tendersUrl = "api/tenders";
  static const String addTenderUrl = "api/tenders/store";
  static const String publicTendersUrl = "api/tender-list";
  static const String tenderStatusChangeUrl = "api/tenders/change-status";
  static const String deleteTenderImageUrl = "api/tenders/delete-images";
  static const String udpateTenderUrl = "api/tenders/update";
  static const String similarTendersUrl = "api/related-tenders";

  // auctions
  static const String publicAuctionsUrl = "api/auctions";
  static const String similarAuctionsUrl = "api/auctions/related";

  // Auction
  static const String addAuctionUrl = "api/auctions/store";

  /// Company
  static const String addCompanyUrl = "api/companies/store";
  static const String myCompaniesUrl = "api/companies/my";
  static const String companyDetailUrl = "api/companies";
  static const String companyDeleteUrl = "api/companies/delete";
  static const String deleteCompanyDocumentUrl =
      "api/companies/documents-delete";
  static const String companyProductsUrl = "api/products/my-list";
  static const String companyDocumentsUrl = "api/companies/documents";
  static const String addCompanyReviewUrl = "api/companies/store-review";
  static const String companyReviewsReplyUrl = "api/companies/review"; //2/reply
  static const String companyReviewsDeleteUrl = "api/companies/review/delete";
  static const String verifyTinNumberUrl = "api/companies/verify";
  static const String addCompanyDocumentUrl = "api/companies/documents-upload";
  static const String publicCompaniesUrl = "api/company-list";
  static const String updateCompanyUrl = "api/companies/update";

  static const String importProductTemplate = "api/product-imports/template";
  static const String importProductUpload = "api/product-imports/upload";
  static const String importProductStatus = "api/product-imports/status";
  static const String importProductError = "api/product-imports/errors";

  /// Categories
  static const String categoriesUrl = "api/categories";
  static const String categoryDetailUrl = "api/category"; // /api/category/1

  /// Account
  static const String myAccountsUrl = "api/accounts/my";
  static const String addAccountUrl = "api/accounts/store";
  static const String updateAccountUrl = "api/accounts/update";
  static const String deleteAccountUrl = "api/accounts/delete";
  static const String makePrimaryAccountUrl = "api/accounts/primary-account";

  /// Add Product
  static const String addProductUrl = "api/products/store";

  // product
  static const String productDetailUrl = "api/products";
  static const String publicProductUrl = "api/product-list";
  static const String productUpdateUrl = "api/products/update";
  static const String productStatusChangeUrl = "api/products/change-status";
  static const String deleteProductImageUrl = "api/products/delete-images";
  static const String relatedProductsUrl = "api/products/related";

  // product review
  static const String productReviewsUrl = "api/reviews";
  static const String addProductReviewUrl = "api/reviews/store";
  static const String approvieProductReviewUrl = "api/reviews/1/approve";
  static const String productReviewDeleteUrl = "api/reviews/delete";

  // Favorite
  static const String favoriteToggleUrl = "api/favorites/toggle";
  static const String favoriteProductsUrl = "api/favorites/products";
  static const String favoriteCompaniesUrl = "api/favorites/companies";
  static const String favoriteTendersUrl = "api/favorites/tenders";

  // notification
  static const String notificationUrl = "api/notifications";
  static const String notificationReadUrl = "api/notifications/mark-read";

  // Common
  static const String citiesUrl = "api/cities";
  static const String materialsUrl = "api/materials";
  static const String filterFieldsUrl = "api/filters-fields";

  /// common
  static const String termsUrl = "api/v1/terms";
  static const String privacyUrl = "api/v1/privacy";
  static const String aboutUrl = "api/v1/about";
  static const String configUrl = "api/v1/config";

  //chat

  static const String chatListUrl = "api/chats";
  static const String messagesUrl = "api/chat-init";
  static const String deleteChaturl = "api/chat-delete";
  static const String sendMediaUrl = "api/chats/3/upload-medias";
  static const String updateLastMessageUrl = "api/lastmessage/update";
  static const String updateReadCountUrl = "api/messages/read";

  // payment method
  static const String contractUrl = "api/contracts";
  static const String paymentMethodUrl = "api/paymentmethods";
  static const String storeContractUrl = "api/contracts/store";
  static const String updateContractUrl = "api/contracts/update";
  static const String mySalesCompaniesUrl = "api/contracts/my-sales-companies";
  static const String contractCompanyUrl = "api/contracts/company";
  static const String myPurchasesCompaniesUrl =
      "api/contracts/my-purchases-companies";
  static const String contractDetailUrl = "api/contracts/detail";
  static const String signContractUrl = "api/contracts/signing";
  static const String updateContractStatusUrl = "api/contracts/update-status";
  static const String relatedCompaniesUrl = "api/companies/related";

  static const String token = "token";

  // static const String userPassword = 'password';
  // static const String userNumber = 'number';
  static const String COUNTRY_CODE = 'country_code';
  static const String LANGUAGE_CODE = 'language_code';
  static const String selecteAccount = 'selected_account1';

  static List<LanguageModel> languages = [
    LanguageModel(
        imageUrl: Images.svgLock,
        languageName: 'Русский',
        countryCode: 'RU',
        languageCode: 'ru'),
    LanguageModel(
        imageUrl: Images.svgLock,
        languageName: 'English',
        countryCode: 'US',
        languageCode: 'en'),
    // LanguageModel(imageUrl: Images.svgLock, languageName: 'Кыргызча', countryCode: 'KG', languageCode: 'ky'),
  ];
}

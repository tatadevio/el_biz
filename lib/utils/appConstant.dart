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
  // static const String appStoreId = "6667114968";
  // static const String googleMapApiKey = "AIzaSyDzA_aNns0_2hD7DgwxvxqlUwuxtwsZEYs";

  /// Auth
  static const String sendOtpUrl = "api/auth/send-otp";
  static const String verifyOtpUrl = "api/auth/verify-otp";
  static const String changePasswordUrl = "api/users/change-password";
  static const String loginUrl = "api/auth/login";

  /// User
  static const String userInfoUrl = "api/users/info";
  static const String updateUserUrl = "api/users/update";

  /// Tenders
  static const String tendersUrl = "api/tenders";
  static const String addTenderUrl = "api/tenders/store";
  static const String publicTendersUrl = "api/tender-list";
  static const String tenderStatusChangeUrl = "api/tenders/change-status";
  static const String deleteTenderImageUrl = "api/tenders/delete-images";
  static const String udpateTenderUrl = "api/tenders/update";

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

  /// Categories
  static const String categoriesUrl = "api/categories";
  static const String categoryDetailUrl = "api/category"; // /api/category/1

  /// Account
  static const String myAccountsUrl = "api/accounts/my";
  static const String addAccountUrl = "api/accounts/store";
  static const String updateAccountUrl = "api/accounts/update";
  static const String deleteAccountUrl = "api/users/delete";

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
  // static const String chatSendUrl = "api/v1/chats/store";
  // static const String ticketUrl = "api/v1/chats";
  // static const String deleteMessage = "api/v1/chats/remove";
  // static const String clearAllMessage = "api/v1/chats/remove-all";

  // /// Likes product

  // static const String likeProductUrl = 'api/v1/likes/store';
  // static const String removeFromLikeProductUrl = 'api/v1/likes/remove';
  // static const String myLikesProduct = 'api/v1/products/likes';

  // ///Follow api
  // static const String followUrl = "api/v1/favourites/store";

  // /// Seller api

  // static const String sellerProductListUrl = "api/v1/products/seller-products";
  // static const String changeStatusUrl = "api/v1/products/change-status";
  // static const String companyCategoryUrl = "api/v1/company-categories";
  // static const String registerSellerUrl = "api/v1/sellers/register-company";
  // static const String completeSellerUrl = "api/v1/sellers/company-update";
  // static const String sellerInfoUrl = "api/v1/sellers/";

  // ///payment api's
  // static const String mBankInitializeUrl = "api/v1/mbank-initialize";
  // static const String mBankConfirmUrl = "api/v1/mbank-confirmed";
  // static const String megaPayCheckUrl = "api/v1/megapay-check";
  // static const String megaPayUrl = "api/v1/megapay-pay";
  // static const String finipayInitialize = "api/v1/finipay-initialize";
  // static const String walletCreditUrl = "api/v1/wallet/credit";

  static const String token = "token";

  // static const String userPassword = 'password';
  // static const String userNumber = 'number';
  static const String COUNTRY_CODE = 'country_code';
  static const String LANGUAGE_CODE = 'language_code';
  static const String selecteAccount = 'selected_account1';
  // static const String TOPIC = 'newsletter';
  // static const String THEME = 'turabekov_theme';
  // static const String ThemeId = 'theme';
  // static const String stepCount = 'step_count';
  // static const String userId = 'user_id';
  // static const String languageCode = 'languageCode';

  // static const String loginTitle = "Login";
  // static const String homeTitle = "Home";
  // static const String settingsTitle = "Settings";
  // static const String fullPhotoTitle = "Full Photo";

  static List<LanguageModel> languages = [
    LanguageModel(
        imageUrl: Images.svgLock,
        languageName: 'English',
        countryCode: 'US',
        languageCode: 'en'),
    LanguageModel(
        imageUrl: Images.svgLock,
        languageName: 'Русский',
        countryCode: 'RU',
        languageCode: 'ru'),
    // LanguageModel(imageUrl: Images.svgLock, languageName: 'Кыргызча', countryCode: 'KG', languageCode: 'ky'),
  ];
}

import 'package:el_biz/utils/Images.dart';

import '../data/model/base/language_model.dart';

class AppConstants {
  static const String baseUrl = "";
  // "https://isooq.kg/";
  static const String appName = "El Biz";
  static const String countryCode = "+996";
  // static const String currencyCode = "cом";
  // static const String appStoreLink = "";
  // static const String playStoreLink = "https://play.google.com/store/apps/details?id=com.isooq.tatadev";
  // static const int androidVersion = 2;
  // static const String iosVersion = "11";
  // static const String appStoreId = "6667114968";
  // static const String googleMapApiKey = "AIzaSyDzA_aNns0_2hD7DgwxvxqlUwuxtwsZEYs";

  /// Auth
  // static const String registerUrl = "api/v1/register";
  // static const String loginUrl = "api/v1/login";
  // static const String googleLoginUrl = "api/v1/google-login";
  // static const String appleLoginUrl = "api/v1/apple-login";
  // static const String checkPhoneUrl = "api/v1/check-phone-number-exists-or-create";

  /// Auth
  // static const String registration = "api/v1/users/update";
  // static const String loginViaOtp = "api/v1/login";
  // static const String loginWithExistingUrl = "api/v1/login-existing-account";

  /// User
  // static const String userInfoUrl = "api/v1/users/info";
  // static const String deleteAccountUrl = "api/v1/users/delete";
  // static const String imageUploadUrl = "api/v1/users/image-upload";
  // static const String changePasswordUrl = "api/v1/users/change-password";
  // static const String fcmTokenUrl = "api/v1/users/fcm-token-update";
  static const String aboutUrl = "api/v1/about";
  // static const String editProfileUrl = "api/v1/users/update";
  static const String configUrl = "api/v1/config";

  /// common
  // static const String bannersUrl = "api/v1/banners";
  static const String termsUrl = "api/v1/terms";
  static const String privacyUrl = "api/v1/privacy";
  // static const String homePageUrl = "api/v1/homepage";
  // static const String storiesDetailUrl = "api/v1/products/stories";
  static const String citiesUrl = "api/v1/cities";
  // static const String bankUrl = "api/v1/banks";
  // static const String adPromotionUrl = "api/v1/products/promotion";
  // static const String packagesUrl = "api/v1/packages";
  // static const String sellerStoriesUrl = "api/v1/products/userstories";

  // /// Posts
  // static const String postsUrl = "api/v1/posts";
  // static const String categoryPostUrl = "api/v1/posts/categories";

  /// Products
  // static const String productUrl = "api/v1/products";
  // static const String favoritesProductUrl = "api/v1/products/fevourites";
  static const String categoryProductUrl = "api/v1/products/categories";
  static const String productWithCatId = "api/v1/products?category_id=";
  // static const String addToFavoriteUrl = "api/v1/favourites/store";
  // static const String removeFavoriteUrl = "api/v1/favourites/remove";
  // static const String followSellerUri = "api/v1/follows/store";
  // static const String unFollowSellerUri = "api/v1/follows/remove";
  // static const String deleteFollowerUri = "api/v1/follows/delete";
  // static const String myFollowersUri = "api/v1/follows/me";
  // static const String myFollowingsUri = "api/v1/follows/to";
  // static const String sellerFollowersUri = "api/v1/follows/follower";
  // static const String sellerFollowingsUri = "api/v1/follows/following";
  // static const String myAdsUrl = "api/v1/products/my-list";
  // static const String editAdsUrl = "api/v1/products/edit";
  // static const String saveSearchUrl = "api/v1/products/save-search";
  // static const String searchFavoriteUrl = "api/v1/products/search-list";
  // static const String deleteSearchUrl = "api/v1/products/delete-search";
  // static const String favoriteUsersUri = "api/v1/favourites/users";
  // static const String relatedProductUrl = "api/v1/products/related";
  // static const String removeImageUrl = "api/v1/products/delete-image";
  // static const String deleteProductUrl = "api/v1/products/delete";
  // static const String productReportList = "api/v1/products/reports";
  // static const String addReport = "api/v1/products/add-report";

  // /// Add Product
  // static const String attributesUrl = "api/v1/products/attributes";
  // static const String addProductUrl = "api/v1/products/add";
  // static const String editProductUrl = "api/v1/products/edit";
  // static const String updateProductUrl = "api/v1/products/update";

  // ///chat

  // static const String chatListUrl = "api/v1/chats/list";
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

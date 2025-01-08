import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../view/screen/auth/login.dart';
import '../view/screen/settings/settings.dart';
import '../view/screen/splash/splash_screen.dart';

class RouteHelper {
  static const String initialRoute = "/";
  static const String splashRoute = "/splash";
  static const String dashBoardRoute = "/dashboard";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String ediProfileRoute = "/edit_profile";
  static const String settingRoute = "/setting";
  static const String productDetailRoute = "/product_detail";
  static const String likeAdsRoute = "/like-ads";

  static String getInitialRoute() => initialRoute;
  static String getDashboardRoute() => dashBoardRoute;
  static String getSplashRoute() => splashRoute;
  static String getLoginRoute() => loginRoute;
  static String getRegisterRoute() => registerRoute;
  static String getEditProfileRoute() => ediProfileRoute;
  static String getSettingRoute() => settingRoute;
  static String getProductDetailRoute() => productDetailRoute;
  static String getLikeAdsRoute() => likeAdsRoute;

  static List<GetPage> routes = [
    GetPage(name: initialRoute, page: () => getRoute(const SplashScreen())),
    GetPage(name: splashRoute, page: () => getRoute(const SplashScreen())),
    // GetPage(
    // name: dashBoardRoute, page: () => getRoute(const DashboardScreen())),
    GetPage(name: loginRoute, page: () => getRoute(const LoginScreen())),
    //GetPage(name: ediProfileRoute, page: () => getRoute(const EditProfile())),
    GetPage(name: settingRoute, page: () => getRoute(const SettingScreen())),
    // GetPage(
    //     name: productDetailRoute, page: () => getRoute(const ProductDetail())),
    // GetPage(name: likeAdsRoute, page: () => getRoute(const LikesAds())),
    //GetPage(name: registerRoute, page: () => getRoute(const RegisterScreen())),
  ];

  static getRoute(Widget navigateTo) {
    // int _minimumVersion = 0;
    if (GetPlatform.isAndroid) {
      //_minimumVersion = Get.find<SplashController>().configModel.appMinimumVersionAndroid;
    } else if (GetPlatform.isIOS) {
      //_minimumVersion = Get.find<SplashController>().configModel.appMinimumVersionIos;
    }
    return navigateTo;
  }
}

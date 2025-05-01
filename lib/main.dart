import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:el_biz/bloc/add_tender/add_tender_bloc.dart';
import 'package:el_biz/bloc/auth/auth_bloc.dart';
import 'package:el_biz/bloc/category/category_bloc.dart';
import 'package:el_biz/bloc/chat/chat_bloc.dart';
import 'package:el_biz/bloc/cities/cities_bloc.dart';
import 'package:el_biz/bloc/company/company_bloc.dart';
import 'package:el_biz/bloc/config/config_bloc.dart';
import 'package:el_biz/bloc/contracts/contracts_bloc.dart';
import 'package:el_biz/bloc/favorite/favorite_bloc.dart';
import 'package:el_biz/bloc/localization/localization_bloc.dart';
import 'package:el_biz/bloc/material/material_bloc.dart';
import 'package:el_biz/bloc/notification/notification_bloc.dart';
import 'package:el_biz/bloc/post_ad/post_ad_bloc.dart';
import 'package:el_biz/bloc/product/product_bloc.dart';
import 'package:el_biz/bloc/product_detail/product_detail_bloc.dart';
import 'package:el_biz/bloc/review/review_bloc.dart';
import 'package:el_biz/bloc/search/search_bloc.dart';
import 'package:el_biz/bloc/tender_detail/tender_detail_bloc.dart';
import 'package:el_biz/bloc/tenders/tenders_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/account/account_bloc.dart';
import 'bloc/add_product/add_product_bloc.dart';
import 'bloc/company_detail/company_detail_bloc.dart';
import 'bloc/tin_number/tin_bloc.dart';
import 'bloc/user/user_bloc.dart';
import 'firebase_options.dart';
import 'helper/route_helper.dart';
import 'theme/light_theme.dart';
import 'utils/appConstant.dart';
import 'utils/color_resources.dart';
import 'helper/get_di.dart' as di;
import 'utils/messages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeDateFormatting('ru_RU', null);
  // await Firebase.initializeApp();
  // HttpOverrides.global = MyHttpOverrides();

  Map<String, Map<String, String>> _languages = await di.init();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(
    languages: _languages,
    prefs: prefs,
  ));
  _requirestNotificationPermission();
}

void _requirestNotificationPermission() async {
  if (await Permission.notification.isDenied) {
    await Permission.notification.request();
  }
}

class MyApp extends StatelessWidget {
  final Map<String, Map<String, String>> languages;
  final SharedPreferences prefs;
  const MyApp({
    super.key,
    required this.languages,
    required this.prefs,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ConfigBloc(Get.find())),
        BlocProvider(create: (_) => TendersBloc(Get.find())),
        BlocProvider(create: (_) => SearchBloc(Get.find())),
        BlocProvider(create: (_) => ChatBloc(Get.find())),
        BlocProvider(create: (_) => FavoriteBloc(Get.find())),
        BlocProvider(create: (_) => NotificationBloc(Get.find())),
        BlocProvider(create: (_) => CategoryBloc(Get.find())),
        BlocProvider(create: (_) => AuthBloc(Get.find())),
        BlocProvider(create: (_) => CitiesBloc(Get.find())),
        BlocProvider(create: (_) => CompanyBloc(Get.find())),
        BlocProvider(create: (_) => ContractsBloc(Get.find())),
        BlocProvider(create: (_) => PostAdBloc(Get.find())),
        BlocProvider(create: (_) => ProductBloc(Get.find())),
        BlocProvider(create: (_) => ProductDetailBloc(Get.find())),
        BlocProvider(create: (_) => ReviewBloc(Get.find())),
        BlocProvider(create: (_) => LocalizationBloc(Get.find(), Get.find())),
        BlocProvider(create: (_) => UserBloc(Get.find())),
        BlocProvider(create: (_) => CompanyDetailBloc(Get.find())),
        BlocProvider(create: (_) => AccountBloc(Get.find())),
        BlocProvider(create: (_) => TinBloc(Get.find())),
        BlocProvider(create: (_) => AddProductBloc(Get.find())),
        BlocProvider(create: (_) => AddTenderBloc(Get.find())),
        BlocProvider(create: (_) => TenderDetailBloc(Get.find())),
        BlocProvider(create: (_) => MaterialBloc(Get.find())),
      ],
      child: BlocBuilder<LocalizationBloc, LocalizationState>(
          builder: (context, localizationController) {
        return GetMaterialApp(
          localizationsDelegates: const [
            FormBuilderLocalizations.delegate,
            //GlobalMaterialLocalizations.delegate,
            //GlobalWidgetsLocalizations.delegate,
          ],
          locale: localizationController.locale,
          translations: Messages(languages: languages),
          fallbackLocale: Locale(AppConstants.languages[0].languageCode,
              AppConstants.languages[0].countryCode),
          builder: BotToastInit(),
          title: AppConstants.appName,
          debugShowCheckedModeBanner: false,
          navigatorKey: Get.key,
          theme: light(
            color: ColorResources.primary,
          ).copyWith(
            unselectedWidgetColor: ColorResources.lgColor,
            progressIndicatorTheme: const ProgressIndicatorThemeData(
              color: ColorResources.primary,
            ),
            scaffoldBackgroundColor: ColorResources.backgroundColor,
            radioTheme: RadioThemeData(
              // fillColor: WidgetStateProperty.all(ColorResources.primary),
              fillColor: WidgetStateProperty.resolveWith<Color>((states) {
                if (states.contains(WidgetState.selected)) {
                  return ColorResources.primary;
                }
                return ColorResources.lgColor;
              }),
            ),
            checkboxTheme: const CheckboxThemeData(
                // fillColor: WidgetStateProperty.all(ColorResources.primary),
                // checkColor: WidgetStateProperty.all(ColorResources.blue),
                ),
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.white,
              scrolledUnderElevation: 0,
            ),
          ),
          initialRoute: RouteHelper.getSplashRoute(),
          getPages: RouteHelper.routes,
        );
      }),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

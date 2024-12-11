import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:el_biz/bloc/auth/auth_bloc.dart';
import 'package:el_biz/bloc/category/category_bloc.dart';
import 'package:el_biz/bloc/chat/chat_bloc.dart';
import 'package:el_biz/bloc/cities/cities_bloc.dart';
import 'package:el_biz/bloc/favorite/favorite_bloc.dart';
import 'package:el_biz/bloc/notification/notification_bloc.dart';
import 'package:el_biz/bloc/search/search_bloc.dart';
import 'package:el_biz/bloc/tenders/tenders_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controller/localization_controller.dart';
import 'helper/route_helper.dart';
import 'theme/light_theme.dart';
import 'utils/appConstant.dart';
import 'utils/color_resources.dart';
import 'helper/get_di.dart' as di;
import 'utils/messages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // HttpOverrides.global = MyHttpOverrides();

  Map<String, Map<String, String>> _languages = await di.init();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(
    languages: _languages,
    prefs: prefs,
  ));
}

class MyApp extends StatelessWidget {
  final Map<String, Map<String, String>> languages;
  final SharedPreferences prefs;
  MyApp({
    super.key,
    required this.languages,
    required this.prefs,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => TendersBloc(Get.find())),
        BlocProvider(create: (_) => SearchBloc(Get.find())),
        BlocProvider(create: (_) => ChatBloc(Get.find())),
        BlocProvider(create: (_) => FavoriteBloc(Get.find())),
        BlocProvider(create: (_) => NotificationBloc(Get.find())),
        BlocProvider(create: (_) => CategoryBloc(Get.find())),
        BlocProvider(create: (_) => AuthBloc(Get.find())),
        BlocProvider(create: (_) => CitiesBloc(Get.find())),
      ],
      child: GetBuilder<LocalizationController>(builder: (localizationController) {
        return GetMaterialApp(
          localizationsDelegates: const [
            FormBuilderLocalizations.delegate,
            //GlobalMaterialLocalizations.delegate,
            //GlobalWidgetsLocalizations.delegate,
          ],
          locale: localizationController.locale,
          translations: Messages(languages: languages),
          fallbackLocale: Locale(AppConstants.languages[0].languageCode, AppConstants.languages[0].countryCode),
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
            checkboxTheme: CheckboxThemeData(
                // fillColor: WidgetStateProperty.all(ColorResources.primary),
                // checkColor: WidgetStateProperty.all(ColorResources.blue),

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
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

import 'package:flutter/material.dart';

import '../utils/color_resources.dart';

ThemeData light({Color color = const Color(0xff76C09D)}) => ThemeData(
    fontFamily: "Inter",
    primaryColor: ColorResources.primary,
    //  const Color(0xffF809F3),
    primarySwatch: ColorResources.primaryMaterial,
    brightness: Brightness.light,
    highlightColor: Colors.white,
    hintColor: const Color(0xFFb8c2d6),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: Color(0xff76C09D), // Set the default color here
      circularTrackColor: Colors.white, // Optional: background track color
    ),
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.android: ZoomPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
    }),
    //colorScheme: ColorScheme.light(primary: color, secondary: color),
    //textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: color)),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: const BorderSide(color: ColorResources.dividerColor)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: const BorderSide(color: ColorResources.dividerColor)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: const BorderSide(color: ColorResources.primary)),
      disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: const BorderSide(color: ColorResources.dividerColor)),
      focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: ColorResources.dividerColor)),
      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0), borderSide: BorderSide(color: ColorResources.primaryRed.withOpacity(0.4))),
    ),
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        surfaceTintColor: Color(0xff101828).withOpacity(0.3),
        shadowColor: Color(0xff101828).withOpacity(0.3),
        // shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.only(
        //         bottomRight: Radius.circular(20.0),
        //         bottomLeft: Radius.circular(20.0))),
        centerTitle: false,
        elevation: 0,
        titleTextStyle: TextStyle(color: Color(0xff212020), fontSize: 16, fontWeight: FontWeight.w600)));

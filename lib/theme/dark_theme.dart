import 'package:flutter/material.dart';

import '../utils/color_resources.dart';

ThemeData dark({Color color = const Color(0xffF809F3)}) => ThemeData(
  fontFamily: 'Montserrat',
  primaryColor: color,
  primarySwatch: ColorResources.primaryMaterial,
  brightness: Brightness.light,
  highlightColor: Colors.white,
  hintColor: const Color(0xFFb8c2d6),
  pageTransitionsTheme: const PageTransitionsTheme(builders: {
    TargetPlatform.android: ZoomPageTransitionsBuilder(),
    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
  }),
  //colorScheme: ColorScheme.dark(primary: color, secondary: color),
  //textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(primary: color)),
);


/*theme: ThemeData(
            fontFamily: 'Montserrat',
            primaryColor: const Color(0xff6F0FC7),
            primarySwatch: ColorResources.PRIMARY_MATERIAL,
            brightness: Brightness.light,
            highlightColor: Colors.white,
            hintColor: const Color(0xffB7B7B7),
            pageTransitionsTheme: const PageTransitionsTheme(builders: {
              TargetPlatform.android: ZoomPageTransitionsBuilder(),
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
              TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
            }),
          ),*/


class Themes {
  static final light = ThemeData.light().copyWith(
    primaryColor: Color(0xff6F0FC7),
    brightness: Brightness.light,
    highlightColor: Colors.white,
    hintColor: const Color(0xFFb8c2d6),
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.android: ZoomPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
    }),
  );
  static final dark = ThemeData.dark().copyWith(
    primaryColor: Color(0xff9ACD50),
    brightness: Brightness.light,
    highlightColor: Colors.white,
    hintColor: const Color(0xFFb8c2d6),
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.android: ZoomPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
    }),
  );
}
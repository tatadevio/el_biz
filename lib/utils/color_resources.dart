import 'package:flutter/material.dart';

class ColorResources {
  static const Color backgroundColor = Color.fromRGBO(243, 243, 243, 1);
  static const Color primary = Color.fromRGBO(22, 77, 160, 1);
  // Color(0xff76C09D);
  static const Color primary1 = Color.fromRGBO(29, 171, 97, 1);
  static const Color black = Color(0xff1E293B);
  static const Color red = Color.fromRGBO(240, 68, 56, 1);
  static const Color darkGray = Color.fromRGBO(30, 30, 30, 1);
  static const Color gray = Color.fromRGBO(71, 84, 103, 1);
  static const Color blue = Color.fromRGBO(22, 77, 160, 1);
  static const Color lgColor = Color.fromRGBO(208, 213, 221, 1);
  static const Color green = Color.fromRGBO(19, 144, 110, 1);
  static const Color orange = Color.fromRGBO(234, 109, 43, 1);
  static const Color lightBlue = Color.fromRGBO(249, 250, 251, 1);
  static const Color white = Color.fromRGBO(255, 255, 255, 1);
  static const Color blackText = Color.fromRGBO(22, 22, 22, 1);
  static const Color primaryRed = Color.fromRGBO(229, 62, 62, 1);
  static const Color errorInput = Color.fromRGBO(253, 162, 155, 1);
  static const Color titleColor = Color.fromRGBO(16, 24, 40, 1);

  static const Color primaryGrey = Color(0xffF4F4F4);
  static const Color hintColor = Color(0xFFb8c2d6);
  static const Color dividerColor = Color(0xffD0D5DD);
  // static const Color primaryRed = Color(0xffFC6767);
  static const Color two = Color.fromRGBO(52, 170, 223, 1);
  static const Color five = Color.fromRGBO(118, 192, 157, 1);
  static Color iconColor = const Color(0xffb1bede).withOpacity(0.8);

  static const Color background = Color(0XFFF5F5F5); //#FCFCFE
  static const Color titleTextColor = Color(0xff5a5d85);
  static const Color subTitleTextColor = Color(0xff797878);
  static const Color bottonTitleTextColor = Color(0xffd4d4ea);
  static const Color grey11 = Color(0xff9D99A7);
  static const Color yellow = Color.fromRGBO(248, 215, 66, 1);
  static const Color lightGrey = Color(0xffDFE7DD);
  static const Color greyLight = Color(0xffBEBEC0);
  static const Color greyHard = Color(0xff8A8A8E);
  static const Color textBlack = Color(0xff344054);

  static const LinearGradient primaryGradient = LinearGradient(colors: [
    Color.fromRGBO(22, 77, 160, 1),
    Color.fromRGBO(22, 77, 160, 1),
  ]);

  static const BoxShadow greyLightShadow = BoxShadow();

  static const BoxShadow shadow1 = BoxShadow(
    color: Color.fromRGBO(16, 24, 40, 0.06),
    offset: Offset(0, 0),
    blurRadius: 2,
    spreadRadius: 0,
  );

  static const BoxShadow shadow2 = BoxShadow(
    color: Color.fromRGBO(16, 24, 40, 0.1),
    offset: Offset(0, 0),
    blurRadius: 3,
    spreadRadius: 0,
  );

  static const BoxShadow shadowXS = BoxShadow(
    color: Color.fromRGBO(16, 24, 40, 0.05),
    offset: Offset(0, 1),
    blurRadius: 2,
    spreadRadius: 0,
  );

  static const Map<int, Color> colorMap = {
    50: Color(0x10192D6B),
    100: Color(0x20192D6B),
    200: Color(0x30192D6B),
    300: Color(0x40192D6B),
    400: Color(0x50192D6B),
    500: Color(0x60192D6B),
    600: Color(0x70192D6B),
    700: Color(0x80192D6B),
    800: Color(0x90192D6B),
    900: Color(0xff192D6B),
  };

  static const MaterialColor primaryMaterial =
      MaterialColor(0xff76C09D, colorMap);

  static BoxShadow shadow = BoxShadow(
      color: Color(0xFFb8c2d6).withOpacity(0.4),
      offset: const Offset(0, 4),
      blurRadius: 12);
}

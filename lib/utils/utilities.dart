import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;

class Utilities {
  static bool isKeyboardShowing() {
    return WidgetsBinding.instance.window.viewInsets.bottom > 0;
  }

  static closeKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}

Color hexToColor(String hexString) {
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
  buffer.write(hexString.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}

bool isDirectionRTL() {
  final local = Get.locale?.languageCode;
  bool isDirectionRTL = intl.Bidi.isRtlLanguage(local);
  return isDirectionRTL;
}

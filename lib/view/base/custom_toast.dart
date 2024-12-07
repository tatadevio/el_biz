import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


void showShortToast(String message){
  BotToast.showText(text:message,duration: const Duration(seconds: 3));
}

void showCustomSnackBar(String message, {bool isError = true}) {
  if(message.isNotEmpty) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
      dismissDirection: DismissDirection.horizontal,
      margin: EdgeInsets.only(
        right: 10.0,
        top: 10.0, bottom: 10.0, left: 10.0,
      ),
      duration: Duration(seconds: 3),
      backgroundColor: isError ? Colors.red : Colors.green,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      content: Text(message, style: TextStyle(color: Colors.white)),
    ));
  }
}

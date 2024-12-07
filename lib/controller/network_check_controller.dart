// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import 'home_controller.dart';



// class NetworkConnectivityController extends GetxController{
//   final Connectivity _connectivity = Connectivity();


//   @override
//   void onInit() {
//     super.onInit();
//     _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
//   }


//   Future<void> _updateConnectionStatus(ConnectivityResult result) async {
//     if(ConnectivityResult.none == result){
//       Get.find<HomeController>().updateConnection(true);
//       Get.rawSnackbar(
//         backgroundColor: Colors.red,
//         duration: const Duration(seconds: 2),
//         messageText: Text("check_your_connection".tr)
//       );
//     }else{
//       Get.find<HomeController>().updateConnection(false);
//       if(Get.isSnackbarOpen){
//         Get.closeCurrentSnackbar();
//       }
//     }
//   }


// }
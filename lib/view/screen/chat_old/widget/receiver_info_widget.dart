// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../../controller/chat_controller.dart';
// import '../../../../controller/seller_controller.dart';
// import '../../../../utils/color_resources.dart';
// import '../../../base/custom_image.dart';

// class ReceiverInfoWidget extends StatefulWidget {
//   const ReceiverInfoWidget({super.key});

//   @override
//   State<ReceiverInfoWidget> createState() => _ReceiverInfoWidgetState();
// }

// class _ReceiverInfoWidgetState extends State<ReceiverInfoWidget> {
//   Timer? _timer;

//   @override
//   void initState() {
//     super.initState();
//     _startPeriodicApiCall();
//   }

//   @override
//   void dispose() {
//     _stopPeriodicApiCall();
//     print('api call after one mint disposed');
//     super.dispose();
//   }

//   void _startPeriodicApiCall() {
//     _timer = Timer.periodic(Duration(minutes: 1), (timer) {
//       _callApi();
//     });
//   }

//   void _stopPeriodicApiCall() {
//     _timer?.cancel();
//     _timer = null;
//   }

//   Future<void> _callApi() async {
//     try {
//       final sellerController = Get.find<SellerController>();
//       if (sellerController.sellerInfoModel != null && sellerController.sellerInfoModel!.data != null) {
//         sellerController.getSellerInfo(sellerController.sellerInfoModel!.data!.id.toString(), showLoading: false);
//       }
//       print("api call after one mint");
//     } catch (e) {
//       print("Error calling API: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ChatController>(builder: (chatController) {
//       return GetBuilder<SellerController>(builder: (sellerController) {
//         return GestureDetector(
//           onTap: () {
//             if (sellerController.sellerInfoModel != null && sellerController.sellerInfoModel!.data != null) {
//               String sellerId = sellerController.sellerInfoModel!.data!.id.toString();
//               Get.find<SellerController>().getSellerProduct(sellerId);
//               Get.find<SellerController>().getSellerInfo(sellerId);

//               // Get.to(() => SellerScreen(
//               //       isSeller: false,
//               //       sellerName: sellerController.sellerInfoModel!.data!.name,
//               //       sellerId: sellerController.sellerInfoModel!.data!.id,
//               //     ));
//             }
//           },
//           child: Row(
//             children: [
//               SizedBox(
//                 height: 40,
//                 width: 40,
//                 child: !sellerController.isLoading
//                     ? CircleAvatar(
//                         radius: 20,
//                         backgroundColor: Colors.black,
//                         child: Text(
//                           (sellerController.sellerInfoModel?.data != null && sellerController.sellerInfoModel?.data?.name != '') ? sellerController.sellerInfoModel!.data!.name![0].toUpperCase() : '',
//                           style: TextStyle(fontSize: 22, color: Colors.white),
//                         ),
//                       )
//                     // UserEmptyImageWidget(userName: sellerController.sellerInfoModel?.data?.name ?? '')
//                     : CustomImage(
//                         image: !sellerController.isLoading ? sellerController.sellerInfoModel?.data?.image ?? '' : "",
//                         height: 40,
//                         width: 40,
//                         radius: 50,
//                       ),
//               ),
//               const SizedBox(
//                 width: 10,
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     !chatController.isLoading ? chatController.receiverName : "",
//                     style: TextStyle(color: Color.fromRGBO(16, 24, 40, 1), fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Inter'),
//                   ),
//                   const SizedBox(
//                     height: 2,
//                   ),
//                   Text(
//                     !sellerController.isLoading
//                         ? sellerController.sellerInfoModel?.data?.isOnline == true
//                             ? 'online'.tr
//                             : sellerController.sellerInfoModel?.data?.lastSeenDif ?? ''
//                         : "",
//                     style: TextStyle(color: sellerController.sellerInfoModel?.data?.isOnline == true ? ColorResources.five : ColorResources.grey11, fontSize: 12, fontWeight: FontWeight.w400, fontFamily: 'Inter'),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         );
//       });
//     });
//   }
// }

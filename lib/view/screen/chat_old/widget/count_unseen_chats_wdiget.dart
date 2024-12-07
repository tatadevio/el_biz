
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../../controller/auth_controller.dart';
// import '../../../../controller/chat_controller.dart';
// import '../../../../controller/user_controller.dart';
// import '../../../../utils/custom_text_style.dart';

// class CountUnseenChats extends StatelessWidget {
//   const CountUnseenChats({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<AuthController>(builder: (authController) {
//       return GetBuilder<ChatController>(builder: (chatController) {
//         if (!authController.isLoggedIn() || Get.find<UserController>().userInfoModel == null) {
//           return const SizedBox();
//         }
//         if (chatController.ticketList.isEmpty) {
//           return const SizedBox();
//         }
//         return StreamBuilder(
//             stream: FirebaseFirestore.instance
//                 .collection('single')
//                 .where(
//                   FieldPath.documentId,
//                   whereIn: chatController.ticketList.map((ticket) => ticket.chatId.toString()).toList(),
//                 )
//                 // .orderBy('timestamp', descending: true)
//                 .snapshots(),
//             builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const SizedBox();
//                 // const SizedBox(height: 10, width: 10, child: CircularProgressIndicator());
//               }
//               if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                 return const SizedBox();
//                 // Text("No data found");
//               }

//               final selectedDocs = snapshot.data!.docs;

//               int unseenCount = 0;
//               unseenCount = selectedDocs.where((doc) => doc['is_seen'] == false && doc['sender_user_id'] != Get.find<UserController>().userInfoModel!.data.id.toString()).length;

//               return unseenCount > 0
//                   ? Container(
//                       padding: const EdgeInsets.all(4),
//                       constraints: const BoxConstraints(minHeight: 15, minWidth: 15),
//                       decoration: const BoxDecoration(
//                         color: Colors.red,
//                         shape: BoxShape.circle,
//                       ),
//                       alignment: Alignment.center,
//                       child: Text(
//                         (unseenCount).toString(),
//                         style: smallText.copyWith(color: Colors.white, fontSize: 12),
//                       ),
//                     )
//                   : const SizedBox();
//             });
//       });
//     });
//   }
// }

// import 'dart:async';

// import 'package:el_biz/view/screen/notification/notification_screen.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../controller/auth_controller.dart';
// import '../../../controller/chat_controller.dart';
// import '../../../controller/user_controller.dart';
// import '../../../helper/route_helper.dart';
// import '../../../utils/Images.dart';
// import '../../../utils/color_resources.dart';
// import '../../base/appbar_notification_button.dart';
// import '../../base/no_data.dart';

// class ChatScreen extends StatelessWidget {
//   ChatScreen({Key? key}) : super(key: key);
//   final TextEditingController _controller = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     bool isLogin = Get.find<AuthController>().isLoggedIn();
//     var size = MediaQuery.of(context).size;
//     double width = size.width;
//     double appbarSize = AppBar().preferredSize.height;

//     Timer? _debounce;

//     return Scaffold(
//       // backgroundColor: ColorResources.white,
//       backgroundColor: ColorResources.background,
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(appbarSize + 70),
//         child: AppBar(
//           backgroundColor: ColorResources.white,
//           automaticallyImplyLeading: false,
//           elevation: 0,
//           title: Text(
//             "chats".tr,
//             style: const TextStyle(color: ColorResources.textBlack, fontWeight: FontWeight.w700, fontSize: 18),
//           ),
//           actions: [
//             const AppbarNotificationButton(),
//             const SizedBox(
//               width: 10,
//             ),
//           ],
//           flexibleSpace: Column(
//             children: [
//               Spacer(),
//               SizedBox(
//                 height: Get.height * 0.062,
//                 width: Get.width * 0.9,
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(16),
//                   child: TextFormField(
//                     controller: _controller,
//                     onFieldSubmitted: (va) {
//                       FocusManager.instance.primaryFocus?.unfocus();
//                     },
//                     onEditingComplete: () {
//                       FocusManager.instance.primaryFocus?.unfocus();
//                     },
//                     onChanged: (value) {
//                       if (_debounce?.isActive ?? false) _debounce!.cancel();
//                       _debounce = Timer(const Duration(milliseconds: 300), () {
//                         Get.find<ChatController>().getSearchUserList(true, value);
//                       });
//                     },
//                     decoration: InputDecoration(
//                       border: InputBorder.none,
//                       enabledBorder: InputBorder.none,
//                       focusedBorder: InputBorder.none,

//                       // OutlineInputBorder(borderRadius: BorderRadius.circular(12.0), borderSide: BorderSide(color: ColorResources.hintColor.withOpacity(0.8))),
//                       // enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0), borderSide: BorderSide(color: ColorResources.hintColor.withOpacity(0.8))),
//                       // focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0), borderSide: BorderSide(color: ColorResources.hintColor.withOpacity(0.8))),
//                       fillColor: ColorResources.background,
//                       filled: true,
//                       prefixIcon: Padding(
//                         padding: const EdgeInsets.all(15.0),
//                         child: SvgPicture.asset(Images.svgSearch),

//                         // SvgPicture.asset(
//                         //   Images.svgSearch,
//                         //   color: ColorResources.textColor,
//                         // ),
//                       ),
//                       hintText: "Поиск...".tr,
//                       suffixIcon: InkWell(
//                           onTap: () {
//                             _controller.clear();
//                             Get.find<ChatController>().getTicket(true);
//                           },
//                           child: const Icon(Icons.clear)),
//                       hintStyle: const TextStyle(
//                         fontSize: 17,
//                         color: Color.fromRGBO(100, 100, 137, 1),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//             ],
//           ),
//         ),
//         // ClipPath(
//         //   clipper: AppBarClipper(),
//         //   child:

//         // ),
//       ),
//       body: isLogin
//           ? RefreshIndicator(
//               color: ColorResources.primary,
//               onRefresh: () async {
//                 await Get.find<ChatController>().getTicket(true);
//               },
//               child: Container(
//                 margin: const EdgeInsets.only(top: 10),
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(16),
//                     topRight: Radius.circular(16),
//                   ),
//                 ),
//                 child: Column(
//                   children: [
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     Expanded(
//                       child: SingleChildScrollView(
//                         physics: const AlwaysScrollableScrollPhysics(),
//                         child: Padding(
//                           padding: EdgeInsets.symmetric(horizontal: (kIsWeb && width > 600) ? width * 0.1 : 0),
//                           child: Column(
//                             children: [
//                               GetBuilder<UserController>(builder: (userController) {
//                                 return GetBuilder<ChatController>(builder: (chatController) {
//                                   if (chatController.isLoading || userController.isLoading) {
//                                     return const Center(
//                                       child: CircularProgressIndicator(),
//                                     );
//                                   }
//                                   if (chatController.ticketList.isEmpty) {
//                                     return Column(
//                                       children: [
//                                         const SizedBox(
//                                           height: 200,
//                                         ),
//                                         Row(
//                                           mainAxisAlignment: MainAxisAlignment.center,
//                                           children: [
//                                             Text(
//                                               "no_message".tr,
//                                               style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
//                                             ),
//                                           ],
//                                         ),
//                                         const SizedBox(
//                                           height: 30,
//                                         ),
//                                         Text(
//                                           "no_msg_desc1".tr + "no_msg_desc2".tr + "no_msg_desc3".tr,
//                                           style: const TextStyle(
//                                             fontSize: 14,
//                                             fontWeight: FontWeight.w400,
//                                             color: Colors.black45,
//                                           ),
//                                           textAlign: TextAlign.center,
//                                         ),
//                                         const SizedBox(
//                                           height: 1,
//                                         ),
//                                       ],
//                                     );
//                                   }

//                                   return Column(
//                                     children: [
//                                       // Padding(
//                                       //   padding: const EdgeInsets.all(8.0),
//                                       //   child: StreamBuilder(
//                                       //       stream: FirebaseFirestore.instance.collection('single').where(FieldPath.documentId, whereIn: chatController.ticketList.map((ticket) => ticket.chatId.toString()).toList()).snapshots(),
//                                       //       builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                                       //         if (snapshot.connectionState == ConnectionState.waiting) {
//                                       //           return CircularProgressIndicator();
//                                       //         }
//                                       //         if (!snapshot.hasData) {
//                                       //           return Text("No data found");
//                                       //         }

//                                       //         final selectedDocs = snapshot.data!.docs;

//                                       //         selectedDocs.sort((a, b) {
//                                       //           final timestampA = (a['timestamp'] as Timestamp?)?.toDate() ?? DateTime(0);
//                                       //           final timestampB = (b['timestamp'] as Timestamp?)?.toDate() ?? DateTime(0);
//                                       //           return timestampB.compareTo(timestampA);
//                                       //         });

//                                       //         List<TicketItem> chatItems = selectedDocs.map((doc) {
//                                       //           String ticketId = doc['ticket_id'];
//                                       //           return chatController.ticketList.firstWhere((item) => item.chatId == ticketId);
//                                       //         }).toList();

//                                       //         return ListView.builder(
//                                       //           shrinkWrap: true,
//                                       //           physics: NeverScrollableScrollPhysics(),
//                                       //           itemCount: selectedDocs.length,
//                                       //           itemBuilder: (context, i) {
//                                       //             return InkWell(
//                                       //               onTap: () {
//                                       //                 print('this is ticket id  = ${chatItems[i].chatId}');
//                                       //                 Get.find<ChatController>().updateProduct(selectedDocs[i]['product_name'], selectedDocs[i]['product_image']);
//                                       //                 Get.find<ChatController>().getChatList(chatItems[i].chatId.toString(), 1, true);
//                                       //                 Get.find<SellerController>().getSellerInfo(chatItems[i].seller.id == Get.find<UserController>().userInfoModel!.data.id ? chatItems[i].user.id.toString() : chatItems[i].seller.id.toString());
//                                       //                 Get.to(() => ChatConversation(
//                                       //                       productId: chatItems[i].chatId.toString(),
//                                       //                       receivedId: chatItems[i].seller.id == Get.find<UserController>().userInfoModel!.data.id ? chatItems[i].user.id.toString() : chatItems[i].seller.id.toString(),
//                                       //                       // selectedDocs[i]['receiver_user_id'].toString() == Get.find<UserController>().userInfoModel!.data.id.toString() ? selectedDocs[i]['sender_user_id'] : selectedDocs[i]['receiver_user_id'],
//                                       //                       // chatItems[i].seller.id.toString(),
//                                       //                       // senderFcm: chatItems[i].seller.id == Get.find<UserController>().userInfoModel!.data.id ? chatItems[i].seller.fcmToken.toString() : chatItems[i].user.fcmToken.toString(),
//                                       //                       // receiverFcm: chatItems[i].seller.id != Get.find<UserController>().userInfoModel!.data.id ? chatItems[i].seller.fcmToken.toString() : chatItems[i].user.fcmToken.toString(),
//                                       //                     ));
//                                       //               },
//                                       //               child: Container(
//                                       //                 color: (!selectedDocs[i]['is_seen'] && selectedDocs[i]['sender_user_id'] != Get.find<UserController>().userInfoModel!.data.id.toString()) ? ColorResources.background : Colors.white,
//                                       //                 child: Column(
//                                       //                   children: [
//                                       //                     if (selectedDocs[i]['timestamp'] != null)
//                                       //                       Row(
//                                       //                         mainAxisAlignment: MainAxisAlignment.end,
//                                       //                         children: [
//                                       //                           Padding(
//                                       //                             padding: const EdgeInsets.only(left: 8.0, right: 8),
//                                       //                             child: Text(
//                                       //                               DateFormat('hh:mm').format((selectedDocs[i]['timestamp'] as Timestamp).toDate()),
//                                       //                               style: TextStyle(color: ColorResources.grey),
//                                       //                               // style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
//                                       //                             ),
//                                       //                           ),
//                                       //                           const SizedBox(
//                                       //                             width: 20,
//                                       //                           ),
//                                       //                         ],
//                                       //                       ),
//                                       //                     Row(
//                                       //                       children: [
//                                       //                         const SizedBox(
//                                       //                           width: 10,
//                                       //                         ),
//                                       //                         // CustomImage(
//                                       //                         //   height: size.height * 0.07,
//                                       //                         //   width: size.height * 0.07,
//                                       //                         //   image: chatItems[i].seller.id == Get.find<UserController>().userInfoModel!.data.id ? chatItems[i].user.image : chatItems[i].image,
//                                       //                         //   radius: 120.0,
//                                       //                         // ),
//                                       //                         if (chatItems[i].user.image == "")
//                                       //                           UserEmptyImageWidget(
//                                       //                             userName: chatItems[i].user.name,
//                                       //                           )
//                                       //                         else
//                                       //                           CustomImage(
//                                       //                             height: size.height * 0.05,
//                                       //                             width: size.height * 0.05,
//                                       //                             image: chatItems[i].user.image,
//                                       //                             radius: 120.0,
//                                       //                           ),
//                                       //                         const SizedBox(
//                                       //                           width: 10,
//                                       //                         ),
//                                       //                         Expanded(
//                                       //                           child: Padding(
//                                       //                             padding: const EdgeInsets.only(left: 5, right: 10),
//                                       //                             child: SizedBox(
//                                       //                               child: Column(
//                                       //                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                       //                                 mainAxisAlignment: MainAxisAlignment.center,
//                                       //                                 children: [
//                                       //                                   const SizedBox(
//                                       //                                     height: 5,
//                                       //                                   ),
//                                       //                                   if (chatItems[i].seller.id == Get.find<UserController>().userInfoModel!.data.id)
//                                       //                                     Text(
//                                       //                                       chatItems[i].name,
//                                       //                                       style: TextStyle(color: ColorResources.black, fontSize: 17, fontWeight: FontWeight.w600, overflow: TextOverflow.ellipsis),
//                                       //                                       maxLines: 1,
//                                       //                                     )
//                                       //                                   else
//                                       //                                     Text(
//                                       //                                       chatItems[i].name,
//                                       //                                       style: TextStyle(color: ColorResources.black, fontSize: 17, fontWeight: FontWeight.w600, overflow: TextOverflow.ellipsis),
//                                       //                                       maxLines: 1,
//                                       //                                     ),
//                                       //                                   const SizedBox(
//                                       //                                     height: 5,
//                                       //                                   ),
//                                       //                                   Text(
//                                       //                                     selectedDocs[i]['message'],

//                                       //                                     style: TextStyle(
//                                       //                                       color: const Color.fromRGBO(181, 181, 181, 1),
//                                       //                                     ),
//                                       //                                     // const TextStyle(color: ColorResources.hintColor, fontSize: 16, fontWeight: FontWeight.w500),
//                                       //                                     maxLines: 2,
//                                       //                                     overflow: TextOverflow.ellipsis,
//                                       //                                   ),
//                                       //                                   // Text(chatItems[i].chatId.toString()),
//                                       //                                 ],
//                                       //                               ),
//                                       //                             ),
//                                       //                           ),
//                                       //                         ),

//                                       //                         (!selectedDocs[i]['is_seen'] && selectedDocs[i]['sender_user_id'] != Get.find<UserController>().userInfoModel!.data.id.toString())
//                                       //                             ? Icon(
//                                       //                                 Icons.circle,
//                                       //                                 color: Colors.blue,
//                                       //                                 size: 15,
//                                       //                               )
//                                       //                             : SizedBox(),
//                                       //                         Padding(
//                                       //                           padding: const EdgeInsets.only(left: 8.0),
//                                       //                           child: CustomImage(
//                                       //                             height: size.height * 0.06,
//                                       //                             width: size.height * 0.06,
//                                       //                             image: chatItems[i].image,
//                                       //                             radius: 10.0,
//                                       //                           ),
//                                       //                         ),
//                                       //                         const SizedBox(
//                                       //                           width: 10,
//                                       //                         ),
//                                       //                       ],
//                                       //                     ),
//                                       //                     const Divider(
//                                       //                       height: 4,
//                                       //                       color: ColorResources.background,
//                                       //                     ),
//                                       //                   ],
//                                       //                 ),
//                                       //               ),
//                                       //             );
//                                       //           },
//                                       //         );
//                                       //       }),
//                                       // ),
//                                     ],
//                                   );
//                                 });
//                               }),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           : Column(
//               children: [
//                 NoDataWidget(
//                   image: Images.logout,
//                   title: "authorize".tr,
//                   description: "logout_desc".tr,
//                   btnTxt: "login_by_number".tr,
//                   onTap: () {
//                     Get.offAllNamed(RouteHelper.getLoginRoute());
//                   },
//                 ),
//               ],
//             ),
//     );
//   }
// }

// import 'dart:async';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:el_biz/bloc/chat/chat_bloc.dart';
// import 'package:el_biz/data/model/response/company/company_product_model.dart';
// import 'package:el_biz/data/model/response/userinfo_model.dart';
// import 'package:el_biz/utils/Images.dart';
// import 'package:el_biz/utils/color_resources.dart';
// import 'package:el_biz/utils/custom_text_style.dart';
// import 'package:el_biz/view/base/custom_border_button.dart';
// import 'package:el_biz/view/base/custom_image.dart';
// import 'package:el_biz/view/screen/chat/widgets/new_message_widget.dart';
// import 'package:el_biz/view/screen/contracts/new_contract_screen.dart';
// import 'package:el_biz/view/screen/products/product_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';

// import '../../../bloc/product/product_bloc.dart';
// import '../../../bloc/user/user_bloc.dart';
// import 'widgets/message_item.dart';

// class ChatConversation extends StatefulWidget {
//   final bool isSeller;
//   final String receiverId;
//   final String senderId;
//   final bool isFirstMessage;
//   final String productId;
//   final String firebaseChatId;
//   final String chatId;
//   final int userUnread;
//   final int productUserId;
//   final int ownerUnread;
//   final String productName;
//   final String productPrice;
//   const ChatConversation({
//     super.key,
//     required this.isSeller,
//     this.receiverId = '',
//     required this.senderId,
//     required this.isFirstMessage,
//     required this.productId,
//     this.firebaseChatId = '',
//     this.chatId = '',
//     this.userUnread = 0,
//     this.ownerUnread = 0,
//     this.productUserId = 0,
//     required this.productName,
//     required this.productPrice,
//   });

//   @override
//   State<ChatConversation> createState() => _ChatConversationState();
// }

// class _ChatConversationState extends State<ChatConversation> {
//   late Stream<QuerySnapshot> _messagesStream;
//   String chatId = '';
//   @override
//   void initState() {
//     _messagesStream = _createOptimizedMessageStream();

//     Future.delayed(Duration.zero, () {
//       _listenToReceiverSeenStatus();
//       updateChatId();
//     });
//     super.initState();
//   }

//   updateChatId() async {
//     int myUserId = context.read<UserBloc>().state.userInfo!.data!.id!;
//     if (widget.chatId != '' && widget.isFirstMessage == false) {
//       setState(() {
//         chatId = widget.chatId;
//       });

//       context.read<ChatBloc>().add(UpdateUnReadCount(
//           chatId: widget.chatId,
//           userCount: widget.productUserId != myUserId ? 0 : widget.userUnread,
//           ownerCount:
//               widget.productUserId == myUserId ? 0 : widget.ownerUnread));
//     } else {
//       final completer = Completer<String>();

//       context.read<ChatBloc>().add(
//             SendMessage(productId: widget.productId, completer: completer),
//           );

//       try {
//         final newChatId = await completer.future;
//         setState(() {
//           chatId = newChatId;
//         });
//         print("Chat ID: $chatId");
//       } catch (e) {
//         print("Failed to get chat ID: $e");
//       }
//     }
//   }

//   Stream<QuerySnapshot> _createOptimizedMessageStream() {
//     return FirebaseFirestore.instance
//         .collection('chat')
//         .doc(widget.firebaseChatId)
//         .collection('messages')
//         .orderBy('timestamp', descending: true)
//         .snapshots();
//   }

//   void _markMessageAsSeen(String messageId) async {
//     String? currentUserId = FirebaseAuth.instance.currentUser?.uid;

//     await FirebaseFirestore.instance
//         .collection('chat')
//         .doc(widget.firebaseChatId)
//         .collection('messages')
//         .doc(messageId)
//         .update({
//       'read': true,
//       'seen_at': FieldValue.serverTimestamp(),
//       'seen_by': currentUserId,
//     });
//     await FirebaseFirestore.instance
//         .collection('chat')
//         .doc(widget.firebaseChatId)
//         .update({
//       'read': true,
//       'seen_at': FieldValue.serverTimestamp(),
//       'seen_by': currentUserId,
//     });
//   }

//   void _listenToReceiverSeenStatus() {
//     FirebaseFirestore.instance
//         .collection('chat')
//         .doc(widget.firebaseChatId)
//         .collection('messages')
//         .where('sender_type', isEqualTo: "user")
//         .where('read', isEqualTo: true)
//         .snapshots()
//         .listen((snapshot) {});
//     // }
//   }

//   void updateLastMessage(ProductListItem? selectedProduct) {
//     try {
//       context.read<ChatBloc>().add(UpdateLastMessage(
//             chatId: widget.chatId,
//             message: '🛍 ${selectedProduct?.name}',
//             userCount: 0,
//             ownerCount: 0,
//           ));
//     } catch (e) {
//       print("Error updating last message: $e");
//     }

//     try {
//       context.read<ProductBloc>().add(ClearSelectedProduct());
//     } catch (e) {
//       print("Error clearing product: $e");
//     }
//   }

//   void clearSelectedProduct() {
//     try {
//       context.read<ProductBloc>().add(ClearSelectedProduct());
//     } catch (e) {
//       print("Error clearing product: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: ListTile(
//           onTap: () {},
//           dense: true,
//           contentPadding: const EdgeInsets.all(0),
//           leading: CustomImage(image: '', height: 32, width: 32, radius: 5.3),
//           title: Text(
//             widget.productName,
//             // 'Садовая мебель Loft',
//             style: h16.copyWith(color: ColorResources.darkGray),
//           ),
//           subtitle: Text(
//             '${widget.productPrice} сом/шт',
//             style: body14.copyWith(color: ColorResources.blue),
//           ),
//         ),
//         bottom: PreferredSize(
//           preferredSize: const Size.fromHeight(55),
//           child: Column(
//             children: [
//               const Divider(
//                 height: 0,
//                 color: ColorResources.lgColor,
//               ),
//               SizedBox(
//                 height: 50,
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16),
//                   child: Row(
//                     children: [
//                       if (!widget.isSeller) ...[
//                         const Expanded(child: SizedBox()),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                       ],
//                       Expanded(
//                         child: CustomBorderButton(
//                           height: 36,
//                           width: Get.width,
//                           padding: const EdgeInsets.all(0),
//                           border:
//                               Border.all(width: 1, color: ColorResources.blue),
//                           borderRadius: BorderRadius.circular(8),
//                           boxShaow: const [ColorResources.shadow1],
//                           child: Text(
//                             'select_products'.tr,
//                             style: textSm.copyWith(color: ColorResources.blue),
//                           ),
//                           onTap: () {
//                             // clearSelectedProduct();
//                             UserData? myUser =
//                                 context.read<UserBloc>().state.userInfo?.data;
//                             Get.to(
//                               () => ProductScreen(
//                                 isSelectProduct: true,
//                                 onSendProduct: () async {
//                                   ProductListItem? selectedProduct = context
//                                       .read<ProductBloc>()
//                                       .state
//                                       .selectedProduct;
//                                   Map<String, dynamic> sendMessage = {
//                                     "read": false,
//                                     "sender_type":
//                                         widget.isSeller ? 'seller' : 'user',

//                                     "text": '',
//                                     "link": '',
//                                     "isProduct": true,
//                                     "type": 'product',
//                                     "product": selectedProduct?.toJson(),
//                                     'timestamp': FieldValue.serverTimestamp(),
//                                     'last_fcm': '',
//                                     // userModel.fcmToken ?? '',
//                                     "sender": {
//                                       "id": widget.senderId,
//                                       "name": myUser?.name ?? '',
//                                       // context
//                                       //             .read<UserBloc>()
//                                       //             .state
//                                       //             .selectedAccountModel
//                                       //             ?.isUser ==
//                                       //         true
//                                       //     ? context
//                                       //         .read<UserBloc>()
//                                       //         .state
//                                       //         .selectedAccountModel
//                                       //         ?.userName
//                                       //     : context
//                                       //         .read<UserBloc>()
//                                       //         .state
//                                       //         .selectedAccountModel
//                                       //         ?.companyName,
//                                       "image": myUser?.image ?? '',
//                                       // context
//                                       //             .read<UserBloc>()
//                                       //             .state
//                                       //             .selectedAccountModel
//                                       //             ?.isUser ==
//                                       //         true
//                                       //     ? context
//                                       //         .read<UserBloc>()
//                                       //         .state
//                                       //         .selectedAccountModel
//                                       //         ?.userImage
//                                       //     : context
//                                       //         .read<UserBloc>()
//                                       //         .state
//                                       //         .selectedAccountModel
//                                       //         ?.userImage,
//                                       "phone": myUser?.phone ?? '',
//                                       // context
//                                       //             .read<UserBloc>()
//                                       //             .state
//                                       //             .selectedAccountModel
//                                       //             ?.isUser ==
//                                       //         true
//                                       //     ? context
//                                       //         .read<UserBloc>()
//                                       //         .state
//                                       //         .selectedAccountModel
//                                       //         ?.userPhone
//                                       //     : context
//                                       //         .read<UserBloc>()
//                                       //         .state
//                                       //         .selectedAccountModel
//                                       //         ?.companyPhone,
//                                       "email": myUser?.email ?? '',
//                                       // context
//                                       //             .read<UserBloc>()
//                                       //             .state
//                                       //             .selectedAccountModel
//                                       //             ?.isUser ==
//                                       //         true
//                                       //     ? context
//                                       //         .read<UserBloc>()
//                                       //         .state
//                                       //         .selectedAccountModel
//                                       //         ?.userEmail
//                                       //     : context
//                                       //         .read<UserBloc>()
//                                       //         .state
//                                       //         .selectedAccountModel
//                                       //         ?.companyEmail,
//                                     },
//                                     "receiver": {
//                                       "id": widget.receiverId,
//                                     },
//                                   };
//                                   await FirebaseFirestore.instance
//                                       .collection('chat')
//                                       .doc(widget.firebaseChatId)
//                                       .collection('messages')
//                                       .add(sendMessage);
//                                   await FirebaseFirestore.instance
//                                       .collection('chat')
//                                       .doc(widget.firebaseChatId)
//                                       .set(sendMessage);
//                                   updateLastMessage(selectedProduct);
//                                   clearSelectedProduct();

//                                   Get.back();
//                                   // send isProduct message...
//                                 },
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                       if (widget.isSeller) ...[
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         Expanded(
//                           child: InkWell(
//                             borderRadius: BorderRadius.circular(8),
//                             onTap: () {
//                               Get.to(() => const NewContractScreen());
//                             },
//                             child: Container(
//                               height: 36,
//                               decoration: BoxDecoration(
//                                 color: ColorResources.green,
//                                 borderRadius: BorderRadius.circular(8),
//                                 border: Border.all(
//                                     width: 1, color: ColorResources.green),
//                                 boxShadow: const [ColorResources.shadow1],
//                               ),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   SvgPicture.asset(Images.svgPlus),
//                                   const SizedBox(
//                                     width: 5,
//                                   ),
//                                   Text(
//                                     'agreement'.tr,
//                                     style: textSm.copyWith(
//                                         color: ColorResources.white),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ],
//                   ),
//                 ),
//               ),
//               const Divider(
//                 height: 0,
//                 color: ColorResources.lgColor,
//               ),
//             ],
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: StreamBuilder(
//                 stream: _messagesStream,
//                 builder: (context, snapshot) {
//                   if (!snapshot.hasData) {
//                     return const Center(child: CircularProgressIndicator());
//                   } else if (snapshot.data == null) {
//                     return const SizedBox();
//                   }
//                   if (snapshot.data!.docs.isEmpty) {
//                     return Center(
//                       child: Text('start_chatting'.tr),
//                     );
//                   }
//                   return ListView.builder(
//                     // controller: _scrollController,
//                     reverse: true,
//                     itemCount: snapshot.data!.docs.length,
//                     itemBuilder: (context, index) {
//                       // if (index == snapshot.data!.docs.length) {
//                       //   return Padding(
//                       //     padding: const EdgeInsets.only(top: 20),
//                       //     child: Row(
//                       //       children: [
//                       //         const SizedBox(
//                       //           width: 20,
//                       //         ),
//                       //         Container(
//                       //           constraints: BoxConstraints(
//                       //             maxWidth:
//                       //                 MediaQuery.of(context).size.width * 0.65,
//                       //           ),
//                       //           child: IntrinsicWidth(
//                       //             child: Container(
//                       //               decoration: BoxDecoration(
//                       //                 color: ColorResources.backgroundColor,
//                       //                 borderRadius: BorderRadius.only(
//                       //                   topLeft: isDirectionRTL()
//                       //                       ? const Radius.circular(12)
//                       //                       : Radius.zero,
//                       //                   topRight: isDirectionRTL()
//                       //                       ? Radius.zero
//                       //                       : const Radius.circular(12),
//                       //                   bottomLeft: const Radius.circular(12),
//                       //                   bottomRight: const Radius.circular(12),
//                       //                 ),
//                       //               ),
//                       //               child: Padding(
//                       //                   padding: const EdgeInsets.all(15),
//                       //                   child: Text(
//                       //                     'welcome_chat'.tr,
//                       //                     style: const TextStyle(
//                       //                         fontWeight: FontWeight.w500,
//                       //                         color: Color(0xff29292D),
//                       //                         fontSize: 15),
//                       //                   )),
//                       //             ),
//                       //           ),
//                       //         ),
//                       //       ],
//                       //     ),
//                       //   );
//                       // }
//                       var messageData = snapshot.data!.docs[index];

//                       bool isMe = messageData['sender']['id'].toString() ==
//                           widget.senderId;

//                       if (!isMe && !messageData['read']) {
//                         _markMessageAsSeen(messageData.id);
//                       }

//                       // List<String> newMessageIds =
//                       //     snapshot.data!.docs.map((doc) => doc.id).toList();
//                       // if (newMessageIds.isNotEmpty &&
//                       //     newMessageIds != _messageIds) {
//                       //   if (_messageIds.isNotEmpty) {}
//                       //   _messageIds = newMessageIds;
//                       // }

//                       return ChatMessageWidget1(
//                         data: messageData,
//                         isMe: isMe,
//                       );
//                     },
//                   );
//                   // return ListView.builder(
//                   //   itemCount: 10,
//                   //   itemBuilder: (context, index) {
//                   //     return const SizedBox();
//                   //     // MessageBubble(chat: chatList[index], addDate: false);
//                   //   },
//                   // );
//                 }),
//           ),
//           NewMessageWidget(
//             firebaseChatId: widget.firebaseChatId,
//             chatId: chatId,
//             receiverId: widget.receiverId,
//             senderId: widget.senderId,
//             productId: widget.productId,
//             isFirstMessage: widget.isFirstMessage,
//             userUnread: widget.userUnread,
//             ownerUnread: widget.ownerUnread,
//             productUserId: widget.productUserId,
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:audioplayers/audioplayers.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/widgets.dart';
// import 'package:isooq/view/screen/chat/widget/image_preview_screen.dart';
// import 'package:isooq/view/screen/chat/widget/message_item.dart';
// import 'package:pie_menu/pie_menu.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:share_plus/share_plus.dart';
// import '../../../controller/chat_controller.dart';
// import '../../../controller/post_ad_controller.dart';
// import '../../../controller/product_controller.dart';
// import '../../../controller/product_detail_controller.dart';
// import '../../../controller/user_controller.dart';
// import '../../../data/model/response/userinfo_model.dart';
// import '../../../data/repo/product_repo.dart';
// import '../../../helper/route_helper.dart';
// import '../../../helper/send_notification.dart';
// import '../../../utils/Images.dart';
// import '../../../utils/appConstant.dart';
// import '../../../utils/color_resources.dart';
// import 'dart:io';

// import '../../../utils/dynamic_links.dart';
// import '../../base/custom_image.dart';
// import '../../base/custom_toast.dart';
// import '../profile/my_item_list.dart';
// import 'widget/receiver_info_widget.dart';

// class ChatConversation extends StatefulWidget {
//   final String productId;
//   final String receivedId;
//   final bool fromProduct;
//   final String message;
//   const ChatConversation({
//     Key? key,
//     required this.productId,
//     required this.receivedId,
//     this.fromProduct = false,
//     this.message = '',
//   }) : super(key: key);

//   @override
//   State<ChatConversation> createState() => _ChatConversationState();
// }

// class _ChatConversationState extends State<ChatConversation> {
//   TextEditingController _messageController = TextEditingController();
//   final ImagePicker _picker = ImagePicker();
//   QueryDocumentSnapshot? replyToMessage;
//   QueryDocumentSnapshot? editingMessage;
//   bool _showScrollToBottom = false;
//   ScrollController _scrollController = ScrollController();
//   final ImagePicker picker = ImagePicker();
//   final PieMenuController pieController = PieMenuController();
//   final AudioPlayer _audioPlayer = AudioPlayer();
//   List<String> _messageIds = [];

//   void _playNotificationSound() async {
//     await _audioPlayer.play(AssetSource('audio/success.mp3'));
//   }

//   @override
//   void initState() {
//     super.initState();
//     // _scrollController.addListener(_scrollListener);
//     _listenToReceiverSeenStatus();
//     if (widget.message != '') {
//       _sendOrUpdateMessage(message: widget.message);
//     }
//   }

//   @override
//   void dispose() {
//     // _scrollController.removeListener(_scrollListener);
//     _scrollController.dispose();
//     _audioPlayer.dispose();
//     super.dispose();
//   }

//   void _scrollListener() {
//     if (_scrollController.offset > 0 && !_showScrollToBottom) {
//       setState(() {
//         _showScrollToBottom = true;
//       });
//     } else if (_scrollController.offset == 0 && _showScrollToBottom) {
//       setState(() {
//         _showScrollToBottom = false;
//       });
//     }
//   }

//   void _scrollToBottom() {
//     _scrollController.animateTo(
//       0,
//       duration: const Duration(milliseconds: 300),
//       curve: Curves.easeOut,
//     );
//   }

//   void showPickImageBottom() {
//     Get.bottomSheet(
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//           topRight: Radius.circular(24.0),
//           topLeft: Radius.circular(24.0),
//         ),
//       ),
//       backgroundColor: Colors.white,
//       Container(
//         height: MediaQuery.sizeOf(context).height * .3,
//         decoration: const BoxDecoration(
//             borderRadius: BorderRadius.only(
//               topRight: Radius.circular(24.0),
//               topLeft: Radius.circular(24.0),
//             ),
//             color: Colors.white),
//         child: Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: Column(
//             children: [
//               const SizedBox(
//                 height: 15,
//               ),
//               ListTile(
//                 leading: const Icon(
//                   Icons.camera_alt_outlined,
//                   color: ColorResources.primary,
//                 ),
//                 onTap: () {
//                   Get.back();
//                   _pickImage(ImageSource.camera);
//                 },
//                 title: const Text("Camera"),
//                 trailing: const Icon(
//                   Icons.keyboard_arrow_right_outlined,
//                   color: ColorResources.grey,
//                 ),
//               ),
//               const Divider(
//                 thickness: 1,
//                 color: ColorResources.grey,
//               ),
//               ListTile(
//                 leading: const Icon(
//                   Icons.image_outlined,
//                   color: ColorResources.primary,
//                 ),
//                 onTap: () {
//                   Get.back();
//                   _pickImage(ImageSource.gallery);
//                 },
//                 title: const Text("Gallery"),
//                 trailing: const Icon(
//                   Icons.keyboard_arrow_right_outlined,
//                   color: ColorResources.grey,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   _showItemsBottom() {
//     return Get.bottomSheet(
//       backgroundColor: Colors.transparent,
//       isScrollControlled: true,
//       Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
//         child: GetBuilder<PostAdController>(builder: (postAdController) {
//           return Container(
//             height: MediaQuery.sizeOf(context).height * .75,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(24.0),
//               color: Colors.white,
//             ),
//             child: MyItemList(
//               callBack: () async {
//                 FirebaseDynamicLinkService firebaseDynamicLinkService = FirebaseDynamicLinkService();
//                 Uri response = await firebaseDynamicLinkService.createDynamicLink(
//                     true, postAdController.shareProduct!.id.toString(), "product", postAdController.shareProduct!.galleries[0].image, postAdController.shareProduct!.name, postAdController.shareProduct!.description);
//                 print("i am hereeeee");
//                 print(response);

//                 setState(() {
//                   _messageController.text = response.toString();
//                 });
//                 Get.find<ChatController>().toggleSendButtonActivity();
//               },
//             ),
//           );
//         }),
//       ),
//     );
//   }

//   Future<void> _pickImage(ImageSource source) async {
//     final XFile? image = await _picker.pickImage(source: source);
//     if (image != null) {
//       File imageFile = File(image.path);
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => ImagePreviewScreen(
//             imageFile: imageFile,
//             onSend: (String downloadURL, String caption) {
//               _sendOrUpdateMessage(imageUrl: downloadURL, message: caption);
//             },
//           ),
//         ),
//       );
//     }
//   }

//   String _formatTimestamp(Timestamp? timestamp) {
//     if (timestamp == null) {
//       return 'Just now';
//     }
//     DateTime dateTime = timestamp.toDate();
//     return '${dateTime.hour}:${dateTime.minute}';
//   }

//   void _handleReply(QueryDocumentSnapshot message) {
//     setState(() {
//       replyToMessage = message;
//     });
//   }

//   void _handleEdit(QueryDocumentSnapshot message) {
//     setState(() {
//       editingMessage = message;
//       _messageController.text = message['message'];
//     });
//   }

//   void _handleDelete(QueryDocumentSnapshot message) {
//     // Implement delete functionality
//     FirebaseFirestore.instance.collection('single').doc(widget.productId).collection('messages').doc(message.id).delete();
//   }

//   void _sendOrUpdateMessage({String? message, String? imageUrl}) async {
//     UserInfoModel userModel = Get.find<UserController>().userInfoModel!;
//     String? firebaseUid = FirebaseAuth.instance.currentUser?.uid;

//     if (editingMessage != null) {
//       // Update existing message
//       await FirebaseFirestore.instance.collection('single').doc(widget.productId).collection('messages').doc(editingMessage!.id).update({'message': message ?? ""});
//       await FirebaseFirestore.instance.collection('single').doc(widget.productId).update({'message': message ?? ""});
//       setState(() => editingMessage = null);
//     } else {
//       // Send new message
//       final chatController = Get.find<ChatController>();
//       Map<String, dynamic> messageData = {
//         'sender_name': userModel.data.name,
//         'sender_image': userModel.data.image,
//         'sender_user_id': userModel.data.id.toString(),
//         'receiver_user_id': widget.receivedId,
//         'sender_uid': firebaseUid,
//         'message': message ?? "",
//         'image_url': imageUrl ?? "",
//         "user_type": "",
//         'timestamp': FieldValue.serverTimestamp(),
//         'is_seen': false,
//         'seen_at': null,
//         'product_name': chatController.productName,
//         'ticket_id': widget.productId,
//         'product_image': chatController.productImage,
//         'seller_id': widget.receivedId,
//         'receiver_fcm': '',
//         'sender_fcm': '',
//         'reply_to': replyToMessage != null
//             ? {
//                 'message_id': replyToMessage!.id,
//                 'message': replyToMessage!['message'],
//                 'sender-name': replyToMessage!['sender_name'],
//               }
//             : null,
//       };
//       await FirebaseFirestore.instance.collection('single').doc(widget.productId).collection('messages').add(messageData);
//       await FirebaseFirestore.instance.collection('single').doc(widget.productId).set(messageData);

//       setState(() => replyToMessage = null);

//       String? _fcmToken = await getFcmToken(widget.receivedId);
//       print('fcm token for ${widget.receivedId} notification = $_fcmToken');
//       sendNotificationToToken(title: userModel.data.name, message: message, senderId: userModel.data.id.toString(), chatId: widget.productId, fcmToken: _fcmToken, type: 'chat', receiverId: widget.receivedId);
//       if (widget.fromProduct) {
//         chatController.sendMessage(widget.productId, message ?? '');
//       }
//     }
//     _messageController.clear();
//   }

//   Future<String?> getFcmToken(String userId) async {
//     try {
//       // Reference to the Firestore collection
//       DocumentSnapshot userDoc = await FirebaseFirestore.instance
//           .collection('users') // Replace 'users' with your collection name
//           .doc(userId) // Use the user_id to access the document
//           .get();
//       // Check if the document exists
//       if (userDoc.exists) {
//         // Get the fcmToken from the document data
//         String? fcmToken = userDoc.get('fcmToken'); // Replace with your field name
//         return fcmToken; // Return the fcmToken
//       } else {
//         print('User not found');
//         return null;
//       }
//     } catch (e) {
//       print('Error retrieving fcmToken: $e');
//       return null;
//     }
//   }

//   void _navigateToMessage(String messageId) {
//     // if (_messageKeys.containsKey(messageId)) {
//     //   Scrollable.ensureVisible(
//     //     _messageKeys[messageId]!.currentContext!,
//     //     alignment: 0.5, // Align to the center of the viewport
//     //     duration: Duration(milliseconds: 300),
//     //   );
//     // }

//     // final RenderBox renderBox = _targetKey.currentContext?.findRenderObject() as RenderBox;
//     // final position = renderBox.localToGlobal(Offset.zero); // Position relative to the global screen
//     //
//     // // Scroll to the widget's position
//     // _scrollController.animateTo(
//     //   position.dy + _scrollController.offset, // Add the offset if the list is already scrolled
//     //   duration: Duration(seconds: 1),
//     //   curve: Curves.easeInOut,
//     // );
//   }

//   void _markMessageAsSeen(String messageId) async {
//     String? currentUserId = FirebaseAuth.instance.currentUser?.uid;
//     await FirebaseFirestore.instance.collection('single').doc(widget.productId).collection('messages').doc(messageId).update({
//       'is_seen': true,
//       'seen_at': FieldValue.serverTimestamp(),
//       'seen_by': currentUserId,
//     });
//     await FirebaseFirestore.instance.collection('single').doc(widget.productId).update({
//       'is_seen': true,
//       'seen_at': FieldValue.serverTimestamp(),
//       'seen_by': currentUserId,
//     });
//   }

//   void _listenToReceiverSeenStatus() {
//     if (Get.find<UserController>().userInfoModel != null) {
//       FirebaseFirestore.instance
//           .collection('single')
//           .doc(widget.productId)
//           .collection('messages')
//           .where('sender_user_id', isEqualTo: Get.find<UserController>().userInfoModel!.data.id.toString())
//           .where('is_seen', isEqualTo: true)
//           .snapshots()
//           .listen((snapshot) {
//         // You can add any additional logic here, like updating UI or showing notifications
//         // print('Messages seen by receiver');
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     double appbarSize = AppBar().preferredSize.height;
//     return PieCanvas(
//       child: Scaffold(
//         backgroundColor: ColorResources.background,
//         appBar: PreferredSize(
//           preferredSize: Size.fromHeight(appbarSize),
//           child: AppBar(
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
//             elevation: 0,
//             backgroundColor: Colors.white,
//             // Theme.of(context).cardColor,
//             centerTitle: false,
//             actions: [
//               // GetBuilder<ChatController>(builder: (chatController) {
//               //   return InkWell(
//               //       onTap: () {
//               //         launchUrl(Uri.parse('tel:${chatController.receiverPhone}'));
//               //       },
//               //       child: Image.asset(
//               //         Images.phone,
//               //         color: ColorResources.primary,
//               //         height: 20,
//               //         width: 20,
//               //       ));
//               // }),
//               // const SizedBox(
//               //   width: 20,
//               // ),
//             ],
//             iconTheme: const IconThemeData(color: ColorResources.primary),
//             title: ReceiverInfoWidget(),
//           ),
//         ),
//         body: GestureDetector(
//           onTap: () {
//             FocusManager.instance.primaryFocus?.unfocus();
//           },
//           child: GetBuilder<UserController>(builder: (userController) {
//             return GetBuilder<ChatController>(builder: (chatController) {
//               return !userController.isLoading && userController.userInfoModel != null
//                   ? Column(
//                       children: [
//                         if (!chatController.isLoading)
//                           InkWell(
//                             onTap: () {
//                               Get.put(ProductRepo(Get.find(), Get.find()));
//                               Get.find<ProductController>().getRelatedProduct(chatController.productId);
//                               Get.find<ProductDetailController>().getProductDetail(chatController.productId);
//                               Get.toNamed(RouteHelper.getProductDetailRoute());
//                             },
//                             child: Container(
//                               // color: Theme.of(context).cardColor,
//                               decoration: BoxDecoration(
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.grey.withOpacity(0.3),
//                                     blurRadius: 10,
//                                   )
//                                 ],
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.only(
//                                   bottomLeft: Radius.circular(16),
//                                   bottomRight: Radius.circular(16),
//                                 ),
//                               ),
//                               child: Row(
//                                 children: [
//                                   Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: CustomImage(image: chatController.productImage, height: size.height * 0.07, width: size.width * 0.16, radius: 12.0),
//                                   ),
//                                   const SizedBox(
//                                     width: 8,
//                                   ),
//                                   SizedBox(
//                                     width: size.width * 0.68,
//                                     child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Text(
//                                           chatController.productName,
//                                           style: const TextStyle(
//                                             color: Colors.black,
//                                             fontSize: 16,
//                                             fontWeight: FontWeight.w700,
//                                           ),
//                                           maxLines: 1,
//                                           overflow: TextOverflow.clip,
//                                         ),
//                                         const SizedBox(
//                                           height: 5,
//                                         ),
//                                         Text(
//                                           chatController.productPrice + AppConstants.currencyCode,
//                                           style: const TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.w400),
//                                         ),
//                                         const SizedBox(
//                                           height: 8,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   const Icon(Icons.arrow_forward_ios)
//                                 ],
//                               ),
//                             ),
//                           ),
//                         Expanded(
//                           child: Padding(
//                             padding: const EdgeInsets.only(top: 12.0),
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.only(
//                                   topRight: Radius.circular(24.0),
//                                   topLeft: Radius.circular(24.0),
//                                 ),
//                               ),
//                               child: StreamBuilder(
//                                 stream: FirebaseFirestore.instance.collection('single').doc(widget.productId).collection('messages').orderBy('timestamp', descending: true).snapshots(),
//                                 builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                                   if (!snapshot.hasData) {
//                                     return const Center(child: CircularProgressIndicator());
//                                   } else if (snapshot.data == null) {
//                                     return const SizedBox();
//                                   }
//                                   return ListView.builder(
//                                     controller: _scrollController,
//                                     reverse: true,
//                                     itemCount: snapshot.data!.docs.length + 1,
//                                     itemBuilder: (context, index) {
//                                       if (index == snapshot.data!.docs.length) {
//                                         return Padding(
//                                             padding: const EdgeInsets.only(top: 20.0, bottom: 10, left: 12),
//                                             child: Row(
//                                               mainAxisAlignment: MainAxisAlignment.start,
//                                               crossAxisAlignment: CrossAxisAlignment.start,
//                                               children: [
//                                                 ClipRRect(
//                                                     borderRadius: BorderRadius.circular(120.0),
//                                                     child: Image.asset(
//                                                       Images.logo,
//                                                       height: 40,
//                                                       width: 40,
//                                                     )),
//                                                 SizedBox(
//                                                   width: 15,
//                                                 ),
//                                                 SizedBox(
//                                                   width: Get.width * .8,
//                                                   child: Column(
//                                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                                     children: [
//                                                       Text(
//                                                         "Будьте осторожны ",
//                                                         style: TextStyle(
//                                                           fontSize: 18,
//                                                           fontWeight: FontWeight.w700,
//                                                         ),
//                                                       ),
//                                                       Text(
//                                                         '\u2022 Не делитесь личной информацией',
//                                                       ),
//                                                       Text('\u2022 Встечайтесь в безопасных местах'),
//                                                       Text('\u2022 Проверяйте пользователей перед сделками.'),
//                                                       Text('Безопасная торговля на iSooq!'),
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ],
//                                             ));
//                                       }
//                                       var messageData = snapshot.data!.docs[index];
//                                       bool isMe = messageData['sender_user_id'].toString() == Get.find<UserController>().userInfoModel!.data.id.toString();

//                                       // Automatically mark messages as seen when viewed
//                                       if (!isMe && !messageData['is_seen']) {
//                                         _markMessageAsSeen(messageData.id);
//                                       }

//                                       // Check for new messages
//                                       List<String> newMessageIds = snapshot.data!.docs.map((doc) => doc.id).toList();
//                                       if (newMessageIds.isNotEmpty && newMessageIds != _messageIds) {
//                                         if (_messageIds.isNotEmpty) {
//                                           var lastMessageData = snapshot.data!.docs.first.data() as Map<String, dynamic>;
//                                           bool isReceivedMessage = lastMessageData['sender_user_id'].toString() != Get.find<UserController>().userInfoModel!.data.id.toString();

//                                           if (isReceivedMessage && !lastMessageData['is_seen']) {
//                                             _playNotificationSound(); // Play sound only for received messages
//                                           }
//                                         }
//                                         _messageIds = newMessageIds;
//                                       }

//                                       return ChatMessageWidget(
//                                         data: messageData,
//                                         isMe: isMe,
//                                         onReply: _handleReply,
//                                         onEdit: _handleEdit,
//                                         onDelete: _handleDelete,
//                                         onReplyTap: _navigateToMessage,
//                                       );
//                                     },
//                                   );
//                                 },
//                               ),
//                             ),
//                           ),
//                         ),
//                         if (replyToMessage != null)
//                           Container(
//                             padding: const EdgeInsets.all(8),
//                             color: Colors.grey[200],
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                   child: Text(
//                                     'Отвечая на : ${replyToMessage!['message']}',
//                                     maxLines: 1,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                 ),
//                                 IconButton(
//                                   icon: const Icon(Icons.close),
//                                   onPressed: () => setState(() => replyToMessage = null),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         Container(
//                           color: ColorResources.background,
//                           //  Theme.of(context).cardColor,
//                           child: Padding(
//                             padding: const EdgeInsets.only(top: 18.0, bottom: 20.0, left: 5, right: 5.0),
//                             child: Row(
//                               children: [
//                                 SizedBox(
//                                   width: size.width * 0.02,
//                                 ),
//                                 // SizedBox(
//                                 //   height: 200,
//                                 //   width: 200,
//                                 //   child: PieCanvas(
//                                 //     child:
//                                 PieMenu(
//                                   controller: pieController,
//                                   theme: const PieTheme(
//                                     delayDuration: Duration.zero,
//                                   ),
//                                   actions: [
//                                     PieAction(
//                                       child: const Icon(Icons.image),
//                                       buttonTheme: const PieButtonTheme(backgroundColor: ColorResources.primary, iconColor: Colors.white),
//                                       tooltip: const Text('Image'),
//                                       // iconData: Icons.image,
//                                       onSelect: () async {
//                                         _pickImage(ImageSource.gallery);
//                                       },
//                                     ),
//                                     PieAction(
//                                       buttonTheme: const PieButtonTheme(backgroundColor: ColorResources.primary, iconColor: Colors.white),

//                                       tooltip: const Text('Camera'),
//                                       // iconData: Icons.camera_alt_outlined,
//                                       child: const Icon(Icons.camera_alt_outlined),
//                                       onSelect: () async {
//                                         _pickImage(ImageSource.camera);
//                                       },
//                                     ),
//                                     PieAction(
//                                       buttonTheme: const PieButtonTheme(backgroundColor: ColorResources.primary, iconColor: Colors.white),

//                                       tooltip: const Text('My items'),
//                                       // iconData: Icons.camera_alt_outlined,
//                                       child: const Icon(Icons.add_moderator_outlined),
//                                       onSelect: () async {
//                                         _showItemsBottom();
//                                       },
//                                     ),
//                                   ],
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(left: 6.0),
//                                     child: Icon(
//                                       Icons.add,
//                                       color: Colors.black,
//                                       size: 30,
//                                     ),
//                                   ),
//                                 ),
//                                 //   ),
//                                 // ),

//                                 SizedBox(
//                                   width: size.width * 0.02,
//                                 ),

//                                 Expanded(
//                                   child: TextFormField(
//                                     maxLines: null,
//                                     controller: _messageController,
//                                     decoration: InputDecoration(
//                                         isDense: true,
//                                         border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0), borderSide: const BorderSide(color: Colors.transparent)),
//                                         enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0), borderSide: const BorderSide(color: Colors.transparent)),
//                                         focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0), borderSide: const BorderSide(color: Colors.transparent)),
//                                         errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0), borderSide: const BorderSide(color: Colors.transparent)),
//                                         hintText: "enter_your_message".tr,
//                                         filled: true,
//                                         hintStyle: const TextStyle(color: ColorResources.greyLight),
//                                         fillColor: Colors.white,
//                                         suffixIcon: InkWell(
//                                           onTap: () {
//                                             if (chatController.isSendButtonActive) {
//                                               if (_messageController.text.isNotEmpty) {
//                                                 _sendOrUpdateMessage(message: _messageController.text);
//                                               }
//                                               _messageController.text = '';
//                                             } else {
//                                               showShortToast(
//                                                 'write_something'.tr,
//                                               );
//                                             }
//                                           },
//                                           child: Container(
//                                             decoration: BoxDecoration(color: chatController.isSendButtonActive ? ColorResources.primary : Colors.grey[300], shape: BoxShape.circle),
//                                             child: const Icon(
//                                               Icons.arrow_upward,
//                                               color: Colors.white,
//                                             ),
//                                           ),
//                                         )),
//                                     onChanged: (String newText) {
//                                       if (newText.isNotEmpty && !chatController.isSendButtonActive) {
//                                         chatController.toggleSendButtonActivity();
//                                       } else if (newText.isEmpty && chatController.isSendButtonActive) {
//                                         chatController.toggleSendButtonActivity();
//                                       }
//                                     },
//                                     onEditingComplete: () {
//                                       if (chatController.isSendButtonActive) {
//                                         if (_messageController.text.isNotEmpty) {
//                                           _sendOrUpdateMessage(message: _messageController.text);
//                                         }
//                                         _messageController.text = '';
//                                       } else {
//                                         showShortToast(
//                                           'write_something'.tr,
//                                         );
//                                       }
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     )
//                   : Center(
//                       child: CircularProgressIndicator(),
//                     );
//             });
//           }),
//         ),
//       ),
//     );
//   }

//   Widget customDialogList(String title, String image, Function onTap) {
//     return InkWell(
//       onTap: () {
//         onTap();
//       },
//       child: Padding(
//         padding: EdgeInsets.symmetric(vertical: Get.height * 0.012),
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10.0),
//             color: Colors.white,
//             boxShadow: const [
//               BoxShadow(
//                 color: Color.fromRGBO(0, 0, 0, 0.25),
//                 offset: Offset(0, 0),
//                 blurRadius: 2,
//                 spreadRadius: 0,
//               ),
//             ],
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Image.asset(
//                   image,
//                   color: Colors.black,
//                   height: 20,
//                 ),
//                 const SizedBox(
//                   width: 8,
//                 ),
//                 Text(
//                   title,
//                   style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:el_biz/utils/Images.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_border_button.dart';
import 'package:el_biz/view/base/custom_image.dart';
import 'package:el_biz/view/screen/chat/widgets/new_message_widget.dart';
import 'package:el_biz/view/screen/contracts/new_contract_screen.dart';
import 'package:el_biz/view/screen/products/product_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../utils/utilities.dart';
import 'widgets/message_item.dart';

class ChatConversation extends StatefulWidget {
  final bool isSeller;
  final String userId;
  final String receiverId;
  const ChatConversation(
      {super.key,
      required this.isSeller,
      this.userId = 'userId',
      this.receiverId = 'tskJIEBnmogGnMFUreC8mdu9HFu2'});

  @override
  State<ChatConversation> createState() => _ChatConversationState();
}

class _ChatConversationState extends State<ChatConversation> {
  // String userId = '';
  // String receiverId = '';
  late Stream<QuerySnapshot> _messagesStream;
  @override
  void initState() {
    _messagesStream = _createOptimizedMessageStream();
    // setState(() {
    // userId = widget.userId;
    // receiverId = widget.receiverId;
    // });

    Future.delayed(Duration.zero, () {
      _listenToReceiverSeenStatus();
    });
    super.initState();
  }

  Stream<QuerySnapshot> _createOptimizedMessageStream() {
    // String userId = widget.userId;
    // Get.find<AuthController>().userData.id.toString();

    return FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userId)
        .collection('chat')
        .doc(widget.receiverId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  void _markMessageAsSeen(String messageId) async {
    String? currentUserId = FirebaseAuth.instance.currentUser?.uid;
    String? myId = widget.userId;
    // Get.find<AuthController>().userData.id.toString();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userId)
        .collection('chat')
        .doc(widget.receiverId)
        .collection('messages')
        .doc(messageId)
        .update({
      'read': true,
      'seen_at': FieldValue.serverTimestamp(),
      'seen_by': currentUserId,
    });
    await FirebaseFirestore.instance.collection('chat').doc(myId).update({
      'read': true,
      'seen_at': FieldValue.serverTimestamp(),
      'seen_by': currentUserId,
    });
  }

  void _listenToReceiverSeenStatus() {
    // if (Get.find<AuthController>().userData.id != null) {
    String userId = widget.userId;
    // Get.find<AuthController>().userData.id.toString();

    FirebaseFirestore.instance
        .collection('chat')
        .doc(userId)
        .collection('messages')
        .where('sender_type', isEqualTo: "user")
        .where('read', isEqualTo: true)
        .snapshots()
        .listen((snapshot) {});
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          onTap: () {},
          dense: true,
          contentPadding: const EdgeInsets.all(0),
          leading: CustomImage(image: '', height: 32, width: 32, radius: 5.3),
          title: Text(
            'Садовая мебель Loft',
            style: h16.copyWith(color: ColorResources.darkGray),
          ),
          subtitle: Text(
            '2 500 сом/шт',
            style: body14.copyWith(color: ColorResources.blue),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(55),
          child: Column(
            children: [
              const Divider(
                height: 0,
                color: ColorResources.lgColor,
              ),
              SizedBox(
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      if (!widget.isSeller) ...[
                        const Expanded(child: SizedBox()),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                      Expanded(
                        child: CustomBorderButton(
                          height: 36,
                          width: Get.width,
                          padding: const EdgeInsets.all(0),
                          border:
                              Border.all(width: 1, color: ColorResources.blue),
                          borderRadius: BorderRadius.circular(8),
                          boxShaow: const [ColorResources.shadow1],
                          child: Text(
                            'select_products'.tr,
                            style: textSm.copyWith(color: ColorResources.blue),
                          ),
                          onTap: () {
                            Get.to(
                              () => const ProductScreen(isSelectProduct: true),
                            );
                          },
                        ),
                      ),
                      if (widget.isSeller) ...[
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () {
                              Get.to(() => const NewContractScreen());
                            },
                            child: Container(
                              height: 36,
                              decoration: BoxDecoration(
                                color: ColorResources.green,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                    width: 1, color: ColorResources.green),
                                boxShadow: const [ColorResources.shadow1],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(Images.svgPlus),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'agreement'.tr,
                                    style: textSm.copyWith(
                                        color: ColorResources.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const Divider(
                height: 0,
                color: ColorResources.lgColor,
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
                stream: _messagesStream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.data == null) {
                    return const SizedBox();
                  }
                  if (snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Text('start_chatting'.tr),
                    );
                  }
                  return ListView.builder(
                    // controller: _scrollController,
                    reverse: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      // if (index == snapshot.data!.docs.length) {
                      //   return Padding(
                      //     padding: const EdgeInsets.only(top: 20),
                      //     child: Row(
                      //       children: [
                      //         const SizedBox(
                      //           width: 20,
                      //         ),
                      //         Container(
                      //           constraints: BoxConstraints(
                      //             maxWidth:
                      //                 MediaQuery.of(context).size.width * 0.65,
                      //           ),
                      //           child: IntrinsicWidth(
                      //             child: Container(
                      //               decoration: BoxDecoration(
                      //                 color: ColorResources.backgroundColor,
                      //                 borderRadius: BorderRadius.only(
                      //                   topLeft: isDirectionRTL()
                      //                       ? const Radius.circular(12)
                      //                       : Radius.zero,
                      //                   topRight: isDirectionRTL()
                      //                       ? Radius.zero
                      //                       : const Radius.circular(12),
                      //                   bottomLeft: const Radius.circular(12),
                      //                   bottomRight: const Radius.circular(12),
                      //                 ),
                      //               ),
                      //               child: Padding(
                      //                   padding: const EdgeInsets.all(15),
                      //                   child: Text(
                      //                     'welcome_chat'.tr,
                      //                     style: const TextStyle(
                      //                         fontWeight: FontWeight.w500,
                      //                         color: Color(0xff29292D),
                      //                         fontSize: 15),
                      //                   )),
                      //             ),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   );
                      // }
                      var messageData = snapshot.data!.docs[index];

                      bool isMe = messageData['sender']['id'].toString() ==
                          widget.userId;

                      if (!isMe && !messageData['read']) {
                        _markMessageAsSeen(messageData.id);
                      }

                      // List<String> newMessageIds =
                      //     snapshot.data!.docs.map((doc) => doc.id).toList();
                      // if (newMessageIds.isNotEmpty &&
                      //     newMessageIds != _messageIds) {
                      //   if (_messageIds.isNotEmpty) {}
                      //   _messageIds = newMessageIds;
                      // }

                      return ChatMessageWidget1(
                        data: messageData,
                        isMe: isMe,
                      );
                    },
                  );
                  // return ListView.builder(
                  //   itemCount: 10,
                  //   itemBuilder: (context, index) {
                  //     return const SizedBox();
                  //     // MessageBubble(chat: chatList[index], addDate: false);
                  //   },
                  // );
                }),
          ),
          NewMessageWidget(
            userId: widget.userId,
            receiverId: widget.receiverId,
          ),
        ],
      ),
    );
  }
}

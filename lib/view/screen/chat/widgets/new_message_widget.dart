import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:el_biz/bloc/chat/chat_bloc.dart';
import 'package:el_biz/bloc/user/user_bloc.dart';
import 'package:el_biz/utils/Images.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class NewMessageWidget extends StatefulWidget {
  // final String chatId;
  final String receiverId;
  final String senderId;
  final String productId;
  final bool isFirstMessage;
  final String firebaseChatId;
  const NewMessageWidget({
    super.key,
    // required this.chatId,
    required this.receiverId,
    required this.senderId,
    this.productId = '',
    required this.isFirstMessage,
    required this.firebaseChatId,
  });

  @override
  State<NewMessageWidget> createState() => _NewMessageWidgetState();
}

class _NewMessageWidgetState extends State<NewMessageWidget> {
  final TextEditingController textController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 50,
      padding: const EdgeInsets.all(5),
      // only(top: 5),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(width: 1, color: ColorResources.lgColor),
        ),
      ),
      child: Row(
        children: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.add,
                color: ColorResources.gray,
              )),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SingleChildScrollView(
                child: Container(
                  constraints: BoxConstraints(maxHeight: 100),
                  child: TextFormField(
                    readOnly: false,
                    controller: textController,
                    focusNode: focusNode,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      counterText: "",
                      suffixIcon: InkWell(
                        borderRadius: BorderRadius.circular(22),
                        onTap: () {
                          _sendOrUpdateMessage(
                            message: textController.text,
                          );
                          textController.clear();
                          // focusNode.unfocus();
                          setState(() {});
                        },
                        child: Container(
                          margin: const EdgeInsets.all(3),
                          height: 22,
                          width: 22,
                          decoration: BoxDecoration(
                            color: textController.text.isEmpty
                                ? ColorResources.lgColor
                                : ColorResources.blue,
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: SvgPicture.asset(Images.svgSendArrow),
                        ),
                      ),
                      isDense: true,
                      counterStyle:
                          const TextStyle(color: ColorResources.lightGrey),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              color: ColorResources.dividerColor)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              color: ColorResources.dividerColor)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              color: ColorResources.dividerColor)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                              color: ColorResources.primaryRed)),
                      hintText: '',
                      hintStyle: const TextStyle(color: Color(0xff646F7F)),
                    ),
                    maxLines: null,
                    onChanged: (value) {
                      if (textController.text.isEmpty) {
                        setState(() {});
                      } else {
                        if (textController.text.length == 1) {
                          setState(() {});
                        }
                      }
                    },
                  ),
                ),
              ),
            ),

            // CustomTextField(
            //   controller: textController,
            //   hintColor: '',
            //   inputType: TextInputType.text,
            //   leading: '',

            //   readOnly: false,
            // suffix: Container(
            //   height: 23,
            //   width: 23,
            //   decoration: BoxDecoration(
            //     color: textController.text.isEmpty ? ColorResources.lgColor : ColorResources.blue,
            //     shape: BoxShape.circle,
            //   ),
            //   alignment: Alignment.center,
            //   child: SvgPicture.asset(Images.svgSendArrow),
            // ),
            // ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }

  void senderData() {
    context.read<UserBloc>().state.selectedAccountModel;
  }

  void _sendOrUpdateMessage(
      {String? message, String? link, String? type = 'message'}) async {
    // UserModel userModel = Get.find<AuthController>().userData;
    // String userId = context.read<AuthBloc>().state.userData.

    Map<String, dynamic> sendMessage = {
      "read": false,
      "sender_type": 'user',
      "text": message?.trim() ?? '',
      "link": link ?? '',
      "isProduct": false,
      "type": type ?? '',
      'timestamp': FieldValue.serverTimestamp(),
      'last_fcm': '',
      // userModel.fcmToken ?? '',
      "sender": {
        "id": widget.senderId,
        "name": context.read<UserBloc>().state.selectedAccountModel?.isUser ==
                true
            ? context.read<UserBloc>().state.selectedAccountModel?.userName
            : context.read<UserBloc>().state.selectedAccountModel?.companyName,
        "image": context.read<UserBloc>().state.selectedAccountModel?.isUser ==
                true
            ? context.read<UserBloc>().state.selectedAccountModel?.userImage
            : context.read<UserBloc>().state.selectedAccountModel?.userImage,
        "phone": context.read<UserBloc>().state.selectedAccountModel?.isUser ==
                true
            ? context.read<UserBloc>().state.selectedAccountModel?.userPhone
            : context.read<UserBloc>().state.selectedAccountModel?.companyPhone,
        "email": context.read<UserBloc>().state.selectedAccountModel?.isUser ==
                true
            ? context.read<UserBloc>().state.selectedAccountModel?.userEmail
            : context.read<UserBloc>().state.selectedAccountModel?.companyEmail,
        "device": Platform.isAndroid
            ? "Android"
            : Platform.isIOS
                ? "IOS"
                : "Unknown",
      },
      "receiver": {
        "id": widget.receiverId,
      },
    };

//updaet message on sender side
    await FirebaseFirestore.instance
        .collection('chat')
        .doc(widget.firebaseChatId)
        .collection('messages')
        .add(sendMessage);
    await FirebaseFirestore.instance
        .collection('chat')
        .doc(widget.firebaseChatId)
        .set(sendMessage);
    if (widget.isFirstMessage) {
      context.read<ChatBloc>().add(SendMessage(
            productId: widget.productId,
          ));
    }

    //updaet message on receiver side

    // await FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(widget.receiverId)
    //     .collection('chat')
    //     .doc(widget.userId)
    //     .collection('messages')
    //     .add(sendMessage);
    // await FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(widget.receiverId)
    //     .collection('chat')
    //     .doc(widget.userId)
    //     .set(sendMessage);
    // }
    // _messageController.clear();

    // sendNotificationToToken(
    //   title: userModel.name,
    //   message: message ?? '',
    //   type: 'chat',
    //   chatId: userModel.id.toString(),
    //   fcmToken: await getAdminToken() ?? '',
    // );
  }
}

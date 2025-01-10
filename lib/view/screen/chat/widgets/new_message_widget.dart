import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:el_biz/utils/Images.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NewMessageWidget extends StatefulWidget {
  final String userId;
  final String receiverId;
  const NewMessageWidget(
      {super.key, required this.userId, required this.receiverId});

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

  void _sendOrUpdateMessage(
      {String? message, String? link, String? type = 'message'}) async {
    // UserModel userModel = Get.find<AuthController>().userData;
    // String userId = context.read<AuthBloc>().state.userData.

    Map<String, dynamic> sendMessage = {
      "read": false,
      "sender_type": 'user',
      "text": message?.trim() ?? '',
      "link": link ?? '',
      "type": type ?? '',
      'timestamp': FieldValue.serverTimestamp(),
      'last_fcm': '',
      // userModel.fcmToken ?? '',
      "sender": {
        "id": widget.userId,
        // "name": userModel.name ?? '',
        // "image": userModel.image ?? '',
        // "phone": userModel.mobile ?? '',
        // "email": userModel.email ?? "",
        "device": Platform.isAndroid
            ? "Android"
            : Platform.isIOS
                ? "IOS"
                : "Unknown",
        // "version": Platform.isIOS
        //     ? AppConstants.iosVersion.toString()
        //     : Platform.isAndroid
        //         ? AppConstants.androidVersion.toString()
        //         : 'unknown',
        // "ip": Get.find<AuthController>().ipAddress,
      },
      "receiver": {
        "id": widget.receiverId,
      },
    };

//updaet message on sender side
    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userId)
        .collection('chat')
        .doc(widget.receiverId)
        .collection('messages')
        .add(sendMessage);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userId)
        .collection('chat')
        .doc(widget.receiverId)
        .set(sendMessage);

    //updaet message on receiver side

    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.receiverId)
        .collection('chat')
        .doc(widget.userId)
        .collection('messages')
        .add(sendMessage);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.receiverId)
        .collection('chat')
        .doc(widget.userId)
        .set(sendMessage);
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

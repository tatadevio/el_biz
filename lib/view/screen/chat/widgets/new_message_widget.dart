import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:el_biz/bloc/chat/chat_bloc.dart';
import 'package:el_biz/bloc/user/user_bloc.dart';
import 'package:el_biz/utils/Images.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../data/model/response/chat/attachment_model.dart';
import '../image_preview_screen.dart';

class NewMessageWidget extends StatefulWidget {
  final String chatId;
  final String receiverId;
  final String senderId;
  final String productId;
  final bool isFirstMessage;
  final String firebaseChatId;
  const NewMessageWidget({
    super.key,
    required this.chatId,
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
      padding: EdgeInsets.only(
          top: 5,
          left: 10,
          right: 10,
          bottom: MediaQuery.of(context).viewPadding.bottom),
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
              onPressed: () {
                Get.bottomSheet(
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 4,
                                width: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: ColorResources.greyLight,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          // ListTile(
                          //   onTap: () {
                          //     _pickImage(ImageSource.gallery);
                          //   },
                          //   title: Text('select_image'.tr),
                          // ),

                          // children: [
                          ListTile(
                            onTap: () {
                              Get.back();
                              _pickImage(ImageSource.camera);
                            },
                            leading: const Icon(Icons.camera),
                            title: Text('camera'.tr),
                          ),
                          ListTile(
                            onTap: () {
                              Get.back();
                              _pickImage(ImageSource.gallery);
                            },
                            leading: const Icon(Icons.image),
                            title: Text('gallery'.tr),
                          ),
                          ListTile(
                            onTap: () {
                              Get.back();
                              _pickPdfFile();
                            },
                            leading: const Icon(Icons.picture_as_pdf),
                            title: Text('pdf'.tr),
                          ),
                          // ],
                        ],
                      ),
                    ),
                    backgroundColor: Colors.white,
                    isScrollControlled: true);
              },
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
      {String? message,
      String? link,
      String? type = 'message',
      String? size = ''}) async {
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
      'size': size,
      // userModel.fcmToken ?? '',
      "sender": {
        "id": widget.senderId,
        // context.read<UserBloc>().state.userInfo!.data!.id.toString(),
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
    // if (widget.isFirstMessage) {
    //   context.read<ChatBloc>().add(SendMessage(
    //         productId: widget.productId,
    //       ));
    // }
  }

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      File imageFile = File(image.path);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImagePreviewScreen(
            chatId: widget.chatId,
            imageFile: imageFile,
            onSend: (String downloadURL, String caption, String size) {
              _sendOrUpdateMessage(
                  message: caption, link: downloadURL, type: 'image');
            },
          ),
        ),
      );
    }
  }

  void _pickPdfFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.isNotEmpty) {
      final file = File(result.files.single.path!);
      final xFile = XFile(file.path);
      // emit(CompanyState(
      //   addCompanyModel:
      //       state.addCompanyModel.copyWith(certificateDocument: xFile),
      // ));

      final completer = Completer<AttachmentModel>();
      context.read<ChatBloc>().add(SendChatMedia(
          chatId: widget.chatId, media: xFile, completer: completer));

      try {
        final attachment = await completer.future;
        // widget.onSend(attachment.url ?? '', _captionController.text);
        _sendOrUpdateMessage(
            message: xFile.name,
            link: attachment.url,
            type: 'pdf',
            size: attachment.size.toString());
        // Get.back();
      } catch (e) {
        print("Failed to get chat ID: $e");
      }
    }
  }
}

import 'dart:async';

import 'package:el_biz/data/model/response/chat/attachment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'dart:io';

import 'package:get/get.dart';

import '../../../bloc/chat/chat_bloc.dart';

class ImagePreviewScreen extends StatefulWidget {
  final File imageFile;
  final String chatId;
  final Function(String, String, String) onSend;

  const ImagePreviewScreen({
    super.key,
    required this.imageFile,
    required this.chatId,
    required this.onSend,
  });

  @override
  _ImagePreviewScreenState createState() => _ImagePreviewScreenState();
}

class _ImagePreviewScreenState extends State<ImagePreviewScreen> {
  final TextEditingController _captionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () async {
              // Show loading indicator
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return const Center(child: CircularProgressIndicator());
                },
              );
              final completer = Completer<AttachmentModel>();
              context.read<ChatBloc>().add(SendChatMedia(
                  chatId: widget.chatId,
                  media: XFile(widget.imageFile.path),
                  completer: completer));

              try {
                final attachment = await completer.future;
                print(
                    'this is url getted in the preview  = ${attachment.toJson()}');
                widget.onSend(attachment.url ?? '', _captionController.text,
                    attachment.size.toString());
                Get.back();
                Get.back();
              } catch (e) {
                print("Failed to get chat ID: $e");
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Image.file(widget.imageFile),
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.5),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              controller: _captionController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'add_a_caption'.tr,
                hintStyle: const TextStyle(color: Colors.white70),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

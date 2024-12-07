import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_image.dart';
import 'package:el_biz/view/screen/chat/chat_conversation.dart';
import 'package:el_biz/view/screen/contracts/contracts_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatTile extends StatelessWidget {
  final bool unSeen;
  final bool isMessage;
  const ChatTile({super.key, this.unSeen = false, required this.isMessage});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        if (isMessage) {
          // go to the message conversation screen
          Get.to(() => ChatConversation(isSeller: unSeen));
        } else {
          //go to the agrement/contracts screen.
          Get.to(() => ContractsScreen());
        }
      },
      leading: CustomImage(image: '', height: 48, width: 48, radius: 48),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              'Садовая мебель Loft',
              style: h16.copyWith(color: ColorResources.darkGray),
            ),
          ),
          Text(
            '24 окт',
            style: body12.copyWith(color: ColorResources.gray),
          ),
        ],
      ),
      subtitle: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              'Мебель для предприятий и для дома',
              style: body14.copyWith(color: ColorResources.gray),
            ),
          ),
          if (unSeen)
            Icon(
              Icons.circle,
              color: ColorResources.green,
              size: 10,
            ),
        ],
      ),
    );
  }
}

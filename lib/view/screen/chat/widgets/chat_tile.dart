import 'package:el_biz/bloc/user/user_bloc.dart';
import 'package:el_biz/data/model/response/chat/chat_list_model.dart';
import 'package:el_biz/data/model/response/company/company_product_model.dart';
import 'package:el_biz/utils/color_resources.dart';
import 'package:el_biz/utils/custom_text_style.dart';
import 'package:el_biz/view/base/custom_image.dart';
import 'package:el_biz/view/screen/chat/chat_conversation.dart';
import 'package:el_biz/view/screen/contracts/contracts_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../helper/date_helper.dart';

class ChatTile extends StatelessWidget {
  final bool unSeen;
  final bool isMessage;
  final ChatItem? chatData;
  // final String? lastMessage;
  const ChatTile({
    super.key,
    this.unSeen = false,
    required this.isMessage,
    this.chatData,
    // this.lastMessage,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        if (isMessage) {
          // go to the message conversation screen
          String myUid =
              context.read<UserBloc>().state.userInfo!.data!.id.toString();
          print(
              'this is product user id: ${chatData?.product?.user?.id.toString()}');
          print('this is my uid: $myUid');
          // print('this is chat data: ${chatData?.product?.user?.id.toString()}');
          Get.to(() => ChatConversation(
                isSeller: chatData?.product?.user?.id.toString() == myUid,
                product: chatData?.product ?? ProductListItem(),
                isFirstMessage: false,
                firebaseChatId: chatData?.firebaseChatId ?? '',
                chatId: chatData?.chatId.toString() ?? '',
                senderId: myUid,
                productUserId: chatData?.product?.user?.id ?? 0,
                productId: chatData?.product?.id.toString() ?? '',
                userUnread: chatData?.userUnreadCount ?? 0,
                ownerUnread: chatData?.productOwnerUnreadCount ?? 0,
                productName: chatData?.product?.name ?? '',
                productPrice: "${chatData?.product?.price}",
                type: chatData?.type ?? '',
                tender: chatData?.tender,
              ));
        } else {
          //go to the agrement/contracts screen.
          Get.to(() => ContractsScreen());
        }
      },
      leading: CustomImage(
          image: chatData?.type == 'product'
              ? chatData?.product?.image ?? ''
              : chatData?.tender?.image ?? '',
          height: 48,
          width: 48,
          radius: 48),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              chatData?.type == 'product'
                  ? chatData?.product?.name ?? 'Садовая мебель Loft'
                  : chatData?.tender?.title ?? 'Садовая мебель Loft',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: h16.copyWith(color: ColorResources.darkGray),
            ),
          ),
          Text(
            isMessage
                ? formatDateInRu(chatData?.lastMessageDate.toString() ?? '')
                : '',
            // '24 окт',
            style: body12.copyWith(color: ColorResources.gray),
          ),
        ],
      ),
      subtitle: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              chatData?.lastMessage ?? 'Мебель для предприятий и для дома',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              // 'Мебель для предприятий и для дома',
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

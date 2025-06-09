
import 'package:el_biz/bloc/chat/chat_bloc.dart';
import 'package:el_biz/bloc/user/user_bloc.dart';
import 'package:el_biz/view/screen/chat/widgets/messages_list/get_products_chats_widget.dart';
import 'package:el_biz/view/screen/chat/widgets/messages_list/get_tenders_chats_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatListWidget extends StatelessWidget {
  const ChatListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(builder: (context, chatState) {
      if (chatState.isLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      final userId =
          context.read<UserBloc>().state.userInfo!.data!.id.toString();

      if (chatState.isShowAllMessage) {
        //showing all messages
        return GetProductsChatsWidget(
          currentUserId: userId,
        );
      } else {
        //showing unread messages
        return GetTendersChatsWidget(currentUserId: userId);
      }
    });
  }
}

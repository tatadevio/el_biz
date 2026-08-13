import 'package:el_biz/bloc/chat/chat_bloc.dart';
import 'package:el_biz/bloc/user/user_bloc.dart';
import 'package:el_biz/view/screen/chat/widgets/messages_list/get_products_chats_widget.dart';
import 'package:el_biz/view/screen/chat/widgets/messages_list/get_tenders_chats_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'get_companies_chat_widget.dart';

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

      // Add null checks for userInfo and userInfo.data
      // final userInfo = context.read<UserBloc>().state.userInfo;
      // final userData = userInfo?.data;
      String userId = '';

      var userData = context.read<UserBloc>().state.selectedAccountModel;
      if (userData == null || userData.userId == 0) {
        final userInfo = context.read<UserBloc>().state.userInfo?.data;
        userId = userInfo?.id.toString() ?? '';
        print("userId in chat list widget if part: $userId");
      } else {
        userId = userData.userId.toString();
        print("userId in chat list widget else: $userId");
      }

      print("userId in chat list widget: $userId");

      if (userId == "") {
        return Center(
          child: Text('Loading user data...'),
        );
      }

      if (chatState.isShowAllMessage == 'message') {
        //showing all messages
        return GetProductsChatsWidget(
          currentUserId: userId,
        );
      } else if (chatState.isShowAllMessage == 'company') {
        //showing unread messages
        return GetCompaniesChatsWidget(
          currentUserId: userId,
        );
        // GetTendersChatsWidget(currentUserId: userId);
      } else {
        //showing tenders
        return GetTendersChatsWidget(currentUserId: userId);
      }
    });
  }
}

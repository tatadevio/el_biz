import 'package:el_biz/bloc/chat/chat_bloc.dart';
import 'package:el_biz/view/screen/chat/widgets/chat_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class GetTendersChatsWidget extends StatelessWidget {
  final String currentUserId;

  const GetTendersChatsWidget({super.key, required this.currentUserId});

  reloadAllMessages(BuildContext context) async {
    context.read<ChatBloc>().add(GetChatTenderList(currentPage: 1));
  }

  void _callScrolling(BuildContext context, ScrollController scrollController) {
    final accountController = context.read<ChatBloc>();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 300 &&
          !accountController.state.isLoading &&
          !accountController.state.isLoadingTenderMore) {
        print('this is scroll view page ended....');
        int pageSize = accountController.state.pageTenderSize;
        if (accountController.state.currentTenderPage < pageSize) {
          int nextPage = accountController.state.currentTenderPage;

          accountController.add(GetChatTenderList(currentPage: nextPage + 1));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    _callScrolling(context, scrollController);
    return RefreshIndicator(
      onRefresh: () async => reloadAllMessages(context),
      child: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, chatState) {
          if (chatState.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (chatState.chatTenderList.isEmpty) {
            return Center(child: Text('no_chats_found'.tr));
          }

          return ListView.builder(
            controller: scrollController,
            itemCount: chatState.chatTenderList.length,
            itemBuilder: (context, index) {
              final chat = chatState.chatTenderList[index];
              return ChatTile(
                isMessage: true,
                chatData: chat,
              );
            },
          );
        },
      ),
    );
  }
}

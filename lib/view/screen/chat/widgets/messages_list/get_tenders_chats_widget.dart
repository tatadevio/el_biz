import 'package:el_biz/bloc/chat/chat_bloc.dart';
import 'package:el_biz/view/screen/chat/widgets/chat_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class GetTendersChatsWidget extends StatelessWidget {
  final String currentUserId;

  const GetTendersChatsWidget({super.key, required this.currentUserId});

  reloadAllMessages(BuildContext context) async {
    final chatState = context.read<ChatBloc>().state;
    if (chatState.tenderSearchQuery.isNotEmpty) {
      context.read<ChatBloc>().add(SearchChatTenders(
          query: chatState.tenderSearchQuery, currentPage: 1));
    } else {
      context.read<ChatBloc>().add(GetChatTenderList(currentPage: 1));
    }
  }

  void _callScrolling(BuildContext context, ScrollController scrollController) {
    final chatBloc = context.read<ChatBloc>();

    scrollController.addListener(() {
      final chatState = chatBloc.state;

      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 300 &&
          !chatState.isLoading &&
          !chatState.isLoadingTenderMore &&
          !chatState.isSearchingTenders &&
          !chatState.isLoadingTenderSearchMore) {
        if (chatState.tenderSearchQuery.isNotEmpty) {
          // Search pagination
          if (chatState.tenderSearchCurrentPage <
              chatState.tenderSearchPageSize) {
            chatBloc.add(SearchChatTenders(
              query: chatState.tenderSearchQuery,
              currentPage: chatState.tenderSearchCurrentPage + 1,
            ));
          }
        } else {
          // Normal pagination
          if (chatState.currentTenderPage < chatState.pageTenderSize) {
            chatBloc.add(GetChatTenderList(
                currentPage: chatState.currentTenderPage + 1));
          }
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
          if (chatState.isLoading || chatState.isSearchingTenders) {
            return const Center(child: CircularProgressIndicator());
          }

          // Use filtered results if search is active, otherwise use original list
          final displayList = chatState.tenderSearchQuery.isNotEmpty
              ? chatState.filteredChatTenderList
              : chatState.chatTenderList;

          if (displayList.isEmpty) {
            if (chatState.tenderSearchQuery.isNotEmpty) {
              return Center(child: Text('no_search_results'.tr));
            } else {
              return Center(child: Text('no_chats_found'.tr));
            }
          }

          return ListView.builder(
            controller: scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: displayList.length +
                (chatState.isLoadingTenderSearchMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == displayList.length &&
                  chatState.isLoadingTenderSearchMore) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              final chat = displayList[index];
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

import 'package:el_biz/bloc/chat/chat_bloc.dart';
import 'package:el_biz/view/screen/chat/widgets/chat_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class GetProductsChatsWidget extends StatelessWidget {
  final String currentUserId;

  const GetProductsChatsWidget({super.key, required this.currentUserId});

  reloadAllMessages(BuildContext context) async {
    final chatState = context.read<ChatBloc>().state;
    if (chatState.productSearchQuery.isNotEmpty) {
      context.read<ChatBloc>().add(SearchChatProducts(
          query: chatState.productSearchQuery, currentPage: 1));
    } else {
      context.read<ChatBloc>().add(GetChatProductList(currentPage: 1));
    }
  }

  void _callScrolling(BuildContext context, ScrollController scrollController) {
    final chatBloc = context.read<ChatBloc>();

    scrollController.addListener(() {
      final chatState = chatBloc.state;

      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 300 &&
          !chatState.isLoading &&
          !chatState.isLoadingMore &&
          !chatState.isSearchingProducts &&
          !chatState.isLoadingProductSearchMore) {
        if (chatState.productSearchQuery.isNotEmpty) {
          // Search pagination
          if (chatState.productSearchCurrentPage <
              chatState.productSearchPageSize) {
            chatBloc.add(SearchChatProducts(
              query: chatState.productSearchQuery,
              currentPage: chatState.productSearchCurrentPage + 1,
            ));
          }
        } else {
          // Normal pagination
          if (chatState.currentPage < chatState.pageSize) {
            chatBloc.add(
                GetChatProductList(currentPage: chatState.currentPage + 1));
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
          if (chatState.isLoading || chatState.isSearchingProducts) {
            return const Center(child: CircularProgressIndicator());
          }

          // Use filtered results if search is active, otherwise use original list
          final displayList = chatState.productSearchQuery.isNotEmpty
              ? chatState.filteredChatProductList
              : chatState.chatProductList;

          if (displayList.isEmpty) {
            if (chatState.productSearchQuery.isNotEmpty) {
              return Center(child: Text('no_search_results'.tr));
            } else {
              return Center(child: Text('no_chats_found'.tr));
            }
          }

          return ListView.builder(
            controller: scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: displayList.length +
                (chatState.isLoadingProductSearchMore ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == displayList.length &&
                  chatState.isLoadingProductSearchMore) {
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

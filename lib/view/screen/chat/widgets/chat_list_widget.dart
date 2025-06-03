import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:el_biz/bloc/chat/chat_bloc.dart';
import 'package:el_biz/view/screen/chat/widgets/chat_tile.dart';
import 'package:el_biz/view/screen/chat/widgets/get_all_chats_widget.dart';
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

      if (chatState.isShowAllMessage) {
        //showing all messages
        return GetAllChatsWidget();
        // return ListView.builder(
        //   itemCount: chatState.chatList.length,
        //   itemBuilder: (context, index) {
        //     return ChatTile(
        //       unSeen: index % 3 == 0,
        //       isMessage: true,
        //       chatData: chatState.chatList[index],
        //     );
        //   },
        // );
      } else {
        //showing unread messages
        return ListView.builder(
          itemCount: 4,
          itemBuilder: (context, index) {
            return const ChatTile(
              unSeen: true,
              isMessage: true,
            );
          },
        );
      }

      // Column(children: [

      // ],);
    });
  }

  Future<Map<String, Map<String, dynamic>>> fetchFirestoreChatData(
      List<String> chatIds) async {
    final firestore = FirebaseFirestore.instance;
    final Map<String, Map<String, dynamic>> chatDataMap = {};

    // If chatIds is more than 10, chunk them due to Firestore's whereIn limit
    final chunks = <List<String>>[];
    for (int i = 0; i < chatIds.length; i += 10) {
      chunks.add(chatIds.sublist(
          i, i + 10 > chatIds.length ? chatIds.length : i + 10));
    }

    for (final chunk in chunks) {
      final snapshot = await firestore
          .collection('chat')
          .where(FieldPath.documentId, whereIn: chunk)
          .get();

      for (final doc in snapshot.docs) {
        chatDataMap[doc.id] = doc.data(); // doc.id is the chatId
      }
    }

    return chatDataMap;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:el_biz/bloc/chat/chat_bloc.dart';
import 'package:el_biz/view/screen/chat/widgets/chat_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/model/response/chat/chat_list_model.dart';


class GetAllChatsWidget extends StatelessWidget {
  const GetAllChatsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, chatState) {
        if(chatState.isLoading) {
          return Center(child: CircularProgressIndicator(),);
        }
        if(chatState.chatList.isEmpty) {
          return Text('no_chat');
        }




    List<ChatData> chatList = chatState.chatList; // From API
List<String> chatIds = chatList.map((e) => e.chatId.toString()).toList();
// Map<String, Map<String, dynamic>> firestoreData = await fetchFirestoreChatData(chatIds);
// List<ChatData> enrichedChatList = chatList.map((chat) {
//   final extraData = firestoreData[chat.chatId] ?? {};





        return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .where(FieldPath.documentId,
                whereIn: chatIds.take(10).toList()) // Max 10
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          final firestoreDocs = snapshot.data!.docs;
          final Map<String, Map<String, dynamic>> firestoreMap = {
            for (var doc in firestoreDocs)
              doc.id: doc.data() as Map<String, dynamic>
          };

          final enrichedChatList = chatState.chatList.map((chat) {
            final extra = firestoreMap[chat.chatId] ?? {};
            return chat.copyWith(
              lastMessage: extra['lastMessage'],
              // unseenCount: extra['unseenCount'] ?? 0,
              // lastMessageTime: extra['lastMessageTime'],
            );
          }).toList();

          return ListView.builder(
            itemCount: enrichedChatList.length,
            itemBuilder: (context, index) {
              final chat = enrichedChatList[index];
              return ChatTile(
                unSeen: false,
                // chat.unseenCount > 0,
                isMessage: true,
                chatData: chat,
              );
            },
          );
        },
      );
      
      }
    );
  }
}
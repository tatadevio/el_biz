import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:el_biz/bloc/chat/chat_bloc.dart';
import 'package:el_biz/view/screen/chat/widgets/chat_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../data/model/response/chat/chat_list_model.dart';

class GetAllChatsWidget extends StatelessWidget {
  final String currentUserId;

  const GetAllChatsWidget({super.key, required this.currentUserId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, chatState) {
        if (chatState.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (chatState.chatList.isEmpty) {
          return const Center(child: Text('No chats found.'));
        }

        final List<ChatData> chatList = chatState.chatList;
        final List<String> chatIds =
            chatList.map((e) => e.firebaseChatId.toString()).toList();

        if (chatIds.isEmpty) {
          return const Center(child: Text('No valid chats.'));
        }

        // Firestore whereIn has a 10-item limit, split into batches if needed
        final limitedChatIds = chatIds.take(10).toList();

        return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('chat')
              .where(FieldPath.documentId, whereIn: limitedChatIds)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('No chat data available.'));
            }

            final firestoreDocs = snapshot.data!.docs;
            final Map<String, Map<String, dynamic>> firestoreMap = {
              for (var doc in firestoreDocs)
                doc.id: doc.data() as Map<String, dynamic>
            };

            final enrichedChats = chatList.map((chat) {
              final extra = firestoreMap[chat.firebaseChatId.toString()] ?? {};
              final lastMessage =
                  chat.lastMessage?.copyWith(message: extra['text']);
              bool notSeen = extra['read'] == false &&
                  extra['sender']['id'] != currentUserId;
              return chat.copyWith(
                lastMessage: lastMessage,
                isSeen: notSeen,
              );
            }).toList();

            return ListView.builder(
              itemCount: enrichedChats.length,
              itemBuilder: (context, index) {
                final chat = enrichedChats[index];
                return ChatTile(
                  unSeen: chat.isSeen == true,
                  isMessage: true,
                  chatData: chat,
                  lastMessage: chat.lastMessage?.message ?? '',
                );
              },
            );
          },
        );
      },
    );
  }
}

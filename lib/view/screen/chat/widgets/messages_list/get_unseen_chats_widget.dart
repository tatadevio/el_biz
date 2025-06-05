import 'package:el_biz/bloc/chat/chat_bloc.dart';
import 'package:el_biz/view/screen/chat/widgets/chat_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class GetUnseenChatsWidget extends StatelessWidget {
  final String currentUserId;

  const GetUnseenChatsWidget({super.key, required this.currentUserId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, chatState) {
        if (chatState.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (chatState.chatList.isEmpty) {
          return  Center(child: Text('no_chats_found'.tr));
        }

        return ListView.builder(
          itemCount: chatState.chatList.length,
          itemBuilder: (context, index) {
            final chat = chatState.chatList[index];
            return ChatTile(
              unSeen: true,
              isMessage: true,
              chatData: chat,
              // lastMessage: chat.lastMessage ?? '',
            );
          },
        );

        // final List<ChatData> chatList = chatState.chatList;
        // final List<String> chatIds =
        //     chatList.map((e) => e.firebaseChatId.toString()).toList();

        // if (chatIds.isEmpty) {
        //   return const Center(child: Text('No valid chats.'));
        // }

        // final limitedChatIds =
        //     chatIds.take(10).toList(); // consider batching if more

        // return StreamBuilder<QuerySnapshot>(
        //   stream: FirebaseFirestore.instance
        //       .collection('chat')
        //       .where(FieldPath.documentId, whereIn: limitedChatIds)
        //       .snapshots(),
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return const Center(child: CircularProgressIndicator());
        //     }

        //     if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
        //       return const Center(child: Text('No unseen chats.'));
        //     }

        //     final firestoreDocs = snapshot.data!.docs;
        //     final Map<String, Map<String, dynamic>> firestoreMap = {
        //       for (var doc in firestoreDocs)
        //         doc.id: doc.data() as Map<String, dynamic>
        //     };

        //     final unseenChats = chatList.where((chat) {
        //       final doc = firestoreMap[chat.firebaseChatId.toString()];
        //       if (doc == null || doc['text'] == null) return false;

        //       // final lastMessage = doc['text'];
        //       final isSeen = doc['read'] == true;
        //       final senderId = doc['sender']?['id']?.toString() ?? '';
        //       print(
        //           'this is the isSeen = $isSeen and sender id = $senderId and current user = $currentUserId');

        //       return !isSeen && senderId != currentUserId;
        //     }).map((chat) {
        //       final extra = firestoreMap[chat.firebaseChatId.toString()]!;
        //       final lastMessage =
        //           chat.lastMessage?.copyWith(message: extra['text']);
        //       return chat.copyWith(lastMessage: lastMessage);
        //     }).toList();

        //     if (unseenChats.isEmpty) {
        //       return const Center(child: Text('No unseen chats.'));
        //     }

        //   },
        // );
      },
    );
  }
}

import 'package:el_biz/data/repo/chat_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/response/chat/chat_list_model.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepo chatRepo;
  ChatBloc(this.chatRepo) : super(const ChatState()) {
    on<UpdateShowChat>(
      (event, emit) {
        print('value of update show chat  = ${event.showChat}');
        emit(state.copyWith(isShowChat: event.showChat));
      },
    );

    on<UpdateShowAllMessages>(
      (event, emit) {
        print('value of update show all messages = ${event.showAllMessages}');
        emit(state.copyWith(isShowAllMessage: event.showAllMessages));
      },
    );

    on<UpdateShowMySales>(
      (event, emit) {
        print('value of update show my sales = ${event.showMySales}');
        emit(state.copyWith(isShowMySales: event.showMySales));
      },
    );

    on<SendMessage>(
      (event, emit) async {
        try {
          final response = await chatRepo.sendMessage(event.productId);
          if (response.statusCode == 200) {
            print('new message added ${response.body}');
          } else {
            print('new message showing error ');
          }
        } catch (e) {
          e.toString();
        }
      },
    );
    on<GetChatList>(_onGetChatList);
  }

  Future<void> _onGetChatList(
      GetChatList event, Emitter<ChatState> emit) async {
    if (event.currentPage == 1) {
      emit(state.copyWith(isLoading: true));
    } else {
      emit(state.copyWith(isLoadingMore: true));
    }
    try {
      final res = await chatRepo.getChatList(event.currentPage);

      ChatListModel chatData = ChatListModel.fromJson(res.body);
      if (event.currentPage == 1) {
        final newList = chatData.data ?? [];
        emit(state.copyWith(chatList: newList));
      } else {
        List<ChatData> newItems = [
          ...state.chatList,
          ...chatData.data ?? [],
        ];
        emit(state.copyWith(chatList: newItems));
      }
      int currentPage = chatData.pagination?.currentPage ?? 1;
      int pageSize = chatData.pagination?.lastPage ?? 1;
      emit(state.copyWith(pageSize: pageSize, currentPage: currentPage));
    } catch (e) {
      print(e.toString());
    }
    emit(state.copyWith(isLoading: false, isLoadingMore: false));
  }
}

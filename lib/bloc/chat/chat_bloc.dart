import 'dart:async';

import 'package:el_biz/data/repo/chat_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/model/response/chat/attachment_model.dart';
import '../../data/model/response/chat/chat_list_model.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepo chatRepo;
  ChatBloc(this.chatRepo) : super(const ChatState()) {
    on<UpdateShowChat>(
      (event, emit) {
        emit(state.copyWith(isShowChat: event.showChat));
      },
    );

    on<UpdateShowAllMessages>(
      (event, emit) {
        emit(state.copyWith(isShowAllMessage: event.showAllMessages));
      },
    );

    on<UpdateShowMySales>(
      (event, emit) {
        emit(state.copyWith(isShowMySales: event.showMySales));
      },
    );

    on<SendMessage>(
      (event, emit) async {
        try {
          final response = await chatRepo.sendMessage(
              event.productId, event.tenderId, event.type);

          if (response.statusCode == 200 &&
              response.body['data']['chat_id'] != null) {
            final String chatId = response.body['data']['chat_id'].toString();

            print('new message added: $chatId');

            // Complete the completer with the chatId
            event.completer.complete(chatId);
          } else {
            print('Error in response');
            event.completer.completeError('Failed to get chat ID');
          }
        } catch (e) {
          print('Exception: $e');
          event.completer.completeError(e.toString());
        }
      },
    );

    // on<SendMessage>(
    //   (event, emit) async {
    //     try {
    //       final response = await chatRepo.sendMessage(event.productId);
    //       if (response.statusCode == 200) {
    //         print('new message added ${response.body}');
    //       } else {
    //         print('new message showing error ');
    //       }
    //     } catch (e) {
    //       e.toString();
    //     }
    //   },
    // );
    on<GetChatProductList>(_onGetChatProductList);
    on<GetChatTenderList>(_onGetChatTenderList);
    // on<DeleteChat>(_onDeleteChat);
    on<SendChatMedia>(_onSendChatMedia);
    on<UpdateLastMessage>(_onUpdateLastMessage);
    on<UpdateUnReadCount>(_onUpdateUnReadCount);
    on<SearchChatProducts>(_onSearchChatProducts);
    on<SearchChatTenders>(_onSearchChatTenders);
    on<ClearChatSearch>(_onClearChatSearch);
    on<FetchChatItemFromChatId>(_onFetchChatItemFromChatId);
  }

  Future<void> _onGetChatProductList(
      GetChatProductList event, Emitter<ChatState> emit) async {
    if (event.currentPage == 1) {
      if (event.reload) {
        emit(state.copyWith(isLoading: true));
      }
    } else {
      emit(state.copyWith(isLoadingMore: true));
    }
    try {
      final res = await chatRepo.getChatList('product', event.currentPage);

      ChatListModel chatData = ChatListModel.fromJson(res.body);
      if (event.currentPage == 1) {
        final newList = chatData.data?.items ?? [];
        emit(state.copyWith(
          chatProductList: newList,
          filteredChatProductList: newList,
        ));
      } else {
        List<ChatItem> newItems = [
          ...state.chatProductList,
          ...chatData.data?.items ?? [],
        ];
        emit(state.copyWith(chatProductList: newItems));
      }
      int currentPage = chatData.data?.currentPage ?? 1;
      int pageSize = chatData.data?.totalPages ?? 1;
      emit(state.copyWith(pageSize: pageSize, currentPage: currentPage));
    } catch (e) {
      print(e.toString());
    }
    emit(state.copyWith(isLoading: false, isLoadingMore: false));
  }

  Future<void> _onGetChatTenderList(
      GetChatTenderList event, Emitter<ChatState> emit) async {
    if (event.currentPage == 1) {
      if (event.reload) {
        emit(state.copyWith(isLoading: true));
      }
    } else {
      emit(state.copyWith(isLoadingTenderMore: true));
    }
    try {
      final res = await chatRepo.getChatList('tender', event.currentPage);

      ChatListModel chatData = ChatListModel.fromJson(res.body);
      if (event.currentPage == 1) {
        final newList = chatData.data?.items ?? [];
        emit(state.copyWith(
          chatTenderList: newList,
          filteredChatTenderList: newList,
        ));
      } else {
        List<ChatItem> newItems = [
          ...state.chatTenderList,
          ...chatData.data?.items ?? [],
        ];
        emit(state.copyWith(chatTenderList: newItems));
      }
      int currentPage = chatData.data?.currentPage ?? 1;
      int pageSize = chatData.data?.totalPages ?? 1;
      emit(state.copyWith(
          pageTenderSize: pageSize, currentTenderPage: currentPage));
    } catch (e) {
      print(e.toString());
    }
    emit(state.copyWith(isLoading: false, isLoadingTenderMore: false));
  }

  // Future<void> _onDeleteChat(DeleteChat event, Emitter<ChatState> emit) async {
  //   emit(state.copyWith(isLoading: true));
  //   try {
  //     final response = await chatRepo.deleteChat(event.chatId);
  //     if (response.statusCode == 200) {
  //       List<ChatItem> myChatList = state.chatList;
  //       int index = -1;
  //       index = myChatList
  //           .indexWhere((chat) => chat.chatId.toString() == event.chatId);
  //       if (index != -1) {
  //         myChatList.removeAt(index);
  //         emit(state.copyWith(chatList: myChatList));
  //       }
  //     }
  //   } catch (e) {}
  //   emit(state.copyWith(isLoading: false));
  // }

  Future<void> _onSendChatMedia(
      SendChatMedia event, Emitter<ChatState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      final response = await chatRepo.sendMedia(event.chatId, event.media);
      if (response.statusCode == 200) {
        // emit(state.copyWith(isLoading: false));

        AttachmentModel attachment =
            AttachmentModel.fromJson(response.body['attachments'][0]);

        event.completer.complete(attachment);
      } else {
        event.completer.completeError(response.body['message']);
      }
    } catch (e) {
      event.completer.completeError(e.toString());
    }
    emit(state.copyWith(isLoading: false));
  }

  Future<void> _onUpdateLastMessage(
      UpdateLastMessage event, Emitter<ChatState> emit) async {
    if (event.type == 'tender') {
      int index = -1;
      index = state.chatTenderList
          .indexWhere((chat) => chat.chatId.toString() == event.chatId);

      if (index != -1) {
        ChatItem chatItem = state.chatTenderList[index];

        ChatItem updatedChatItem = chatItem.copyWith(
          lastMessage: event.message,
          lastMessageDate: DateTime.now().add(Duration(days: 1)),
        );

        List<ChatItem> updatedChatList = List.from(state.chatTenderList);
        updatedChatList[index] = updatedChatItem;

        emit(state.copyWith(chatTenderList: updatedChatList));
      }
      try {
        final response = await chatRepo.updateLastMessage(
            event.chatId, event.message, event.userCount, event.ownerCount);
        print(response.body);
      } catch (e) {
        print(e.toString());
      }
    } else {
      int index = -1;
      index = state.chatProductList
          .indexWhere((chat) => chat.chatId.toString() == event.chatId);

      if (index != -1) {
        ChatItem chatItem = state.chatProductList[index];

        ChatItem updatedChatItem = chatItem.copyWith(
          lastMessage: event.message,
          lastMessageDate: DateTime.now().add(Duration(days: 1)),
        );

        List<ChatItem> updatedChatList = List.from(state.chatProductList);
        updatedChatList[index] = updatedChatItem;

        emit(state.copyWith(chatProductList: updatedChatList));
      }
      try {
        final response = await chatRepo.updateLastMessage(
            event.chatId, event.message, event.userCount, event.ownerCount);
        print(response.body);
      } catch (e) {
        print(e.toString());
      }
    }
  }

  Future<void> _onUpdateUnReadCount(
      UpdateUnReadCount event, Emitter<ChatState> emit) async {
    try {
      final response = await chatRepo.updateReadCount(
          event.chatId, event.userCount, event.ownerCount);
      // if(response.statusCode == 200)
      print(response.body);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _onSearchChatProducts(
      SearchChatProducts event, Emitter<ChatState> emit) async {
    final query = event.query;

    if (event.currentPage == 1) {
      emit(state.copyWith(
        productSearchQuery: query,
        isSearchingProducts: true,
        filteredChatProductList: const [],
        productSearchCurrentPage: 1,
      ));
    } else {
      emit(state.copyWith(isLoadingProductSearchMore: true));
    }

    try {
      if (query.isEmpty) {
        // If search is empty, load normal chat list
        final res = await chatRepo.getChatList('product', event.currentPage);
        ChatListModel chatData = ChatListModel.fromJson(res.body);

        if (event.currentPage == 1) {
          final newList = chatData.data?.items ?? [];
          emit(state.copyWith(
            filteredChatProductList: newList,
            productSearchCurrentPage: chatData.data?.currentPage ?? 1,
            productSearchPageSize: chatData.data?.totalPages ?? 1,
          ));
        } else {
          List<ChatItem> newItems = [
            ...state.filteredChatProductList,
            ...chatData.data?.items ?? [],
          ];
          emit(state.copyWith(
            filteredChatProductList: newItems,
            productSearchCurrentPage: chatData.data?.currentPage ?? 1,
            productSearchPageSize: chatData.data?.totalPages ?? 1,
          ));
        }
      } else {
        // Use search API
        final res = await chatRepo.getSearchChatList(
            'product', query, event.currentPage);
        ChatListModel chatData = ChatListModel.fromJson(res.body);

        if (event.currentPage == 1) {
          final newList = chatData.data?.items ?? [];
          emit(state.copyWith(
            filteredChatProductList: newList,
            productSearchCurrentPage: chatData.data?.currentPage ?? 1,
            productSearchPageSize: chatData.data?.totalPages ?? 1,
          ));
        } else {
          List<ChatItem> newItems = [
            ...state.filteredChatProductList,
            ...chatData.data?.items ?? [],
          ];
          emit(state.copyWith(
            filteredChatProductList: newItems,
            productSearchCurrentPage: chatData.data?.currentPage ?? 1,
            productSearchPageSize: chatData.data?.totalPages ?? 1,
          ));
        }
      }
    } catch (e) {
      print('Search products error: $e');
    }

    emit(state.copyWith(
      isSearchingProducts: false,
      isLoadingProductSearchMore: false,
    ));
  }

  Future<void> _onSearchChatTenders(
      SearchChatTenders event, Emitter<ChatState> emit) async {
    final query = event.query;

    if (event.currentPage == 1) {
      emit(state.copyWith(
        tenderSearchQuery: query,
        isSearchingTenders: true,
        filteredChatTenderList: const [],
        tenderSearchCurrentPage: 1,
      ));
    } else {
      emit(state.copyWith(isLoadingTenderSearchMore: true));
    }

    try {
      if (query.isEmpty) {
        // If search is empty, load normal chat list
        final res = await chatRepo.getChatList('tender', event.currentPage);
        ChatListModel chatData = ChatListModel.fromJson(res.body);

        if (event.currentPage == 1) {
          final newList = chatData.data?.items ?? [];
          emit(state.copyWith(
            filteredChatTenderList: newList,
            tenderSearchCurrentPage: chatData.data?.currentPage ?? 1,
            tenderSearchPageSize: chatData.data?.totalPages ?? 1,
          ));
        } else {
          List<ChatItem> newItems = [
            ...state.filteredChatTenderList,
            ...chatData.data?.items ?? [],
          ];
          emit(state.copyWith(
            filteredChatTenderList: newItems,
            tenderSearchCurrentPage: chatData.data?.currentPage ?? 1,
            tenderSearchPageSize: chatData.data?.totalPages ?? 1,
          ));
        }
      } else {
        // Use search API
        final res = await chatRepo.getSearchChatList(
            'tender', query, event.currentPage);
        ChatListModel chatData = ChatListModel.fromJson(res.body);

        if (event.currentPage == 1) {
          final newList = chatData.data?.items ?? [];
          emit(state.copyWith(
            filteredChatTenderList: newList,
            tenderSearchCurrentPage: chatData.data?.currentPage ?? 1,
            tenderSearchPageSize: chatData.data?.totalPages ?? 1,
          ));
        } else {
          List<ChatItem> newItems = [
            ...state.filteredChatTenderList,
            ...chatData.data?.items ?? [],
          ];
          emit(state.copyWith(
            filteredChatTenderList: newItems,
            tenderSearchCurrentPage: chatData.data?.currentPage ?? 1,
            tenderSearchPageSize: chatData.data?.totalPages ?? 1,
          ));
        }
      }
    } catch (e) {
      print('Search tenders error: $e');
    }

    emit(state.copyWith(
      isSearchingTenders: false,
      isLoadingTenderSearchMore: false,
    ));
  }

  Future<void> _onClearChatSearch(
      ClearChatSearch event, Emitter<ChatState> emit) async {
    emit(state.copyWith(
      productSearchQuery: '',
      tenderSearchQuery: '',
      filteredChatProductList: state.chatProductList,
      filteredChatTenderList: state.chatTenderList,
      productSearchCurrentPage: 1,
      tenderSearchCurrentPage: 1,
      productSearchPageSize: 1,
      tenderSearchPageSize: 1,
      isSearchingProducts: false,
      isSearchingTenders: false,
      isLoadingProductSearchMore: false,
      isLoadingTenderSearchMore: false,
    ));
  }

  Future<void> _onFetchChatItemFromChatId(
      FetchChatItemFromChatId event, Emitter<ChatState> emit) async {
    emit(state.copyWith(isLoading: true));
    final response = await chatRepo.getChatDetail(event.chatId);
    ChatItem chatItem = ChatItem.fromJson(response.body['data']);
    event.completer.complete(chatItem);
    emit(state.copyWith(isLoading: false));
  }
}

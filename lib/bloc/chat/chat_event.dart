part of 'chat_bloc.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class UpdateShowChat extends ChatEvent {
  final bool showChat;
  const UpdateShowChat({required this.showChat});

  @override
  List<Object> get props => [showChat];
}

class UpdateShowAllMessages extends ChatEvent {
  final bool showAllMessages;
  const UpdateShowAllMessages({required this.showAllMessages});

  @override
  List<Object> get props => [showAllMessages];
}

class UpdateShowMySales extends ChatEvent {
  final bool showMySales;
  const UpdateShowMySales({required this.showMySales});

  @override
  List<Object> get props => [showMySales];
}

class SendMessage extends ChatEvent {
  final String productId;
  final String tenderId;
  final String type;
  final Completer<String> completer;

  const SendMessage({
    required this.productId,
    required this.tenderId,
    required this.type,
    required this.completer,
  });

  @override
  List<Object> get props => [productId, completer];
}

class GetChatProductList extends ChatEvent {
  final int currentPage;

  const GetChatProductList({required this.currentPage});

  @override
  List<Object> get props => [currentPage];
}

class GetChatTenderList extends ChatEvent {
  final int currentPage;

  const GetChatTenderList({required this.currentPage});

  @override
  List<Object> get props => [currentPage];
}

class DeleteChat extends ChatEvent {
  final String chatId;
  const DeleteChat({required this.chatId});

  @override
  List<Object> get props => [chatId];
}

class SendChatMedia extends ChatEvent {
  final String chatId;
  final XFile media;
  final Completer<AttachmentModel> completer;
  const SendChatMedia(
      {required this.chatId, required this.media, required this.completer});

  @override
  List<Object> get props => [chatId, media, completer];
}

class UpdateLastMessage extends ChatEvent {
  final String chatId;
  final String message;
  final int userCount;
  final int ownerCount;
  final String type;
  const UpdateLastMessage(
      {required this.chatId,
      required this.message,
      required this.userCount,
      required this.ownerCount,
      required this.type});

  @override
  List<Object> get props => [chatId, message, userCount, ownerCount, type];
}

class UpdateUnReadCount extends ChatEvent {
  final String chatId;
  final int userCount;
  final int ownerCount;
  const UpdateUnReadCount(
      {required this.chatId,
      required this.userCount,
      required this.ownerCount});

  @override
  List<Object> get props => [chatId, userCount, ownerCount];
}

class SearchChatProducts extends ChatEvent {
  final String query;
  final int currentPage;
  const SearchChatProducts({required this.query, this.currentPage = 1});

  @override
  List<Object> get props => [query, currentPage];
}

class SearchChatTenders extends ChatEvent {
  final String query;
  final int currentPage;
  const SearchChatTenders({required this.query, this.currentPage = 1});

  @override
  List<Object> get props => [query, currentPage];
}

class ClearChatSearch extends ChatEvent {}

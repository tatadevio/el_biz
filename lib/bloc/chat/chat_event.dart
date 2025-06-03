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

  const SendMessage({
    required this.productId,
  });

  @override
  List<Object> get props => [productId];
}

class GetChatList extends ChatEvent {
  final int currentPage;

  const GetChatList({required this.currentPage});

  @override
  List<Object> get props => [currentPage];
}

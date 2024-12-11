part of 'chat_bloc.dart';

class ChatState extends Equatable {
  final bool isShowChat;
  final bool isShowAllMessage;
  final bool isShowMySales;
  const ChatState({this.isShowChat = true, this.isShowAllMessage = true, this.isShowMySales = false});

  ChatState copyWith({bool? isShowChat, bool? isShowAllMessage, bool? isShowMySales}) {
    return ChatState(isShowChat: isShowChat ?? this.isShowChat, isShowAllMessage: isShowAllMessage ?? this.isShowAllMessage, isShowMySales: isShowMySales ?? this.isShowMySales);
  }

  @override
  List<Object> get props => [isShowChat, isShowAllMessage, isShowMySales];
}

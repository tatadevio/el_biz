part of 'chat_bloc.dart';

class ChatState extends Equatable {
  final bool isShowChat;
  final bool isShowAllMessage;
  final bool isShowMySales;
  final List<ChatData> chatList;
  final bool isLoading;
  final bool isLoadingMore;
  final int currentPage;
  final int pageSize;
  const ChatState(
      {this.isShowChat = true,
      this.isShowAllMessage = true,
      this.isShowMySales = false,
      this.chatList = const [],
      this.isLoading = false,
      this.isLoadingMore = false,
      this.currentPage = 1,
      this.pageSize = 1});

  ChatState copyWith({
    bool? isShowChat,
    bool? isShowAllMessage,
    bool? isShowMySales,
    List<ChatData>? chatList,
    bool? isLoading,
    bool? isLoadingMore,
    int? currentPage,
    int? pageSize,
  }) {
    return ChatState(
      isShowChat: isShowChat ?? this.isShowChat,
      isShowAllMessage: isShowAllMessage ?? this.isShowAllMessage,
      isShowMySales: isShowMySales ?? this.isShowMySales,
      chatList: chatList ?? this.chatList,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      currentPage: currentPage ?? this.currentPage,
      pageSize: pageSize ?? this.pageSize,
    );
  }

  @override
  List<Object> get props => [
        isShowChat,
        isShowAllMessage,
        isShowMySales,
        chatList,
        isLoading,
        isLoadingMore,
        currentPage,
        pageSize,
      ];
}

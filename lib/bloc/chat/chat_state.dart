part of 'chat_bloc.dart';

class ChatState extends Equatable {
  final bool isShowChat;
  final bool isShowAllMessage;
  final bool isShowMySales;
  final List<ChatItem> chatProductList;
  final List<ChatItem> chatTenderList;
  final bool isLoading;
  final bool isLoadingMore;
  final int currentPage;
  final int pageSize;
  final bool isLoadingTenderMore;
  final int currentTenderPage;
  final int pageTenderSize;
  const ChatState({
    this.isShowChat = true,
    this.isShowAllMessage = true,
    this.isShowMySales = false,
    this.chatProductList = const [],
    this.chatTenderList = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.currentPage = 1,
    this.pageSize = 1,
    this.isLoadingTenderMore = false,
    this.currentTenderPage = 1,
    this.pageTenderSize = 1,
  });

  ChatState copyWith({
    bool? isShowChat,
    bool? isShowAllMessage,
    bool? isShowMySales,
    List<ChatItem>? chatProductList,
    List<ChatItem>? chatTenderList,
    bool? isLoading,
    bool? isLoadingMore,
    int? currentPage,
    int? pageSize,
    bool? isLoadingTenderMore,
    int? currentTenderPage,
    int? pageTenderSize,
  }) {
    return ChatState(
      isShowChat: isShowChat ?? this.isShowChat,
      isShowAllMessage: isShowAllMessage ?? this.isShowAllMessage,
      isShowMySales: isShowMySales ?? this.isShowMySales,
      chatProductList: chatProductList ?? this.chatProductList,
      chatTenderList: chatTenderList ?? this.chatTenderList,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      currentPage: currentPage ?? this.currentPage,
      pageSize: pageSize ?? this.pageSize,
      isLoadingTenderMore: isLoadingTenderMore ?? this.isLoadingTenderMore,
      currentTenderPage: currentTenderPage ?? this.currentTenderPage,
      pageTenderSize: pageTenderSize ?? this.pageTenderSize,
    );
  }

  @override
  List<Object> get props => [
        isShowChat,
        isShowAllMessage,
        isShowMySales,
        chatProductList,
        chatTenderList,
        isLoading,
        isLoadingMore,
        currentPage,
        pageSize,
        isLoadingTenderMore,
        currentTenderPage,
        pageTenderSize,
      ];
}

class SendMediaSuccess extends ChatState {
  final String url;
  const SendMediaSuccess(this.url);
}

class SendMediaError extends ChatState {
  final String error;
  const SendMediaError(this.error);
}

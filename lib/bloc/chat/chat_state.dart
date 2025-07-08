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
  final String productSearchQuery;
  final String tenderSearchQuery;
  final List<ChatItem> filteredChatProductList;
  final List<ChatItem> filteredChatTenderList;
  final bool isSearchingProducts;
  final bool isSearchingTenders;
  final bool isLoadingProductSearchMore;
  final bool isLoadingTenderSearchMore;
  final int productSearchCurrentPage;
  final int tenderSearchCurrentPage;
  final int productSearchPageSize;
  final int tenderSearchPageSize;
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
    this.productSearchQuery = '',
    this.tenderSearchQuery = '',
    this.filteredChatProductList = const [],
    this.filteredChatTenderList = const [],
    this.isSearchingProducts = false,
    this.isSearchingTenders = false,
    this.isLoadingProductSearchMore = false,
    this.isLoadingTenderSearchMore = false,
    this.productSearchCurrentPage = 1,
    this.tenderSearchCurrentPage = 1,
    this.productSearchPageSize = 1,
    this.tenderSearchPageSize = 1,
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
    String? productSearchQuery,
    String? tenderSearchQuery,
    List<ChatItem>? filteredChatProductList,
    List<ChatItem>? filteredChatTenderList,
    bool? isSearchingProducts,
    bool? isSearchingTenders,
    bool? isLoadingProductSearchMore,
    bool? isLoadingTenderSearchMore,
    int? productSearchCurrentPage,
    int? tenderSearchCurrentPage,
    int? productSearchPageSize,
    int? tenderSearchPageSize,
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
      productSearchQuery: productSearchQuery ?? this.productSearchQuery,
      tenderSearchQuery: tenderSearchQuery ?? this.tenderSearchQuery,
      filteredChatProductList:
          filteredChatProductList ?? this.filteredChatProductList,
      filteredChatTenderList:
          filteredChatTenderList ?? this.filteredChatTenderList,
      isSearchingProducts: isSearchingProducts ?? this.isSearchingProducts,
      isSearchingTenders: isSearchingTenders ?? this.isSearchingTenders,
      isLoadingProductSearchMore:
          isLoadingProductSearchMore ?? this.isLoadingProductSearchMore,
      isLoadingTenderSearchMore:
          isLoadingTenderSearchMore ?? this.isLoadingTenderSearchMore,
      productSearchCurrentPage:
          productSearchCurrentPage ?? this.productSearchCurrentPage,
      tenderSearchCurrentPage:
          tenderSearchCurrentPage ?? this.tenderSearchCurrentPage,
      productSearchPageSize:
          productSearchPageSize ?? this.productSearchPageSize,
      tenderSearchPageSize: tenderSearchPageSize ?? this.tenderSearchPageSize,
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
        productSearchQuery,
        tenderSearchQuery,
        filteredChatProductList,
        filteredChatTenderList,
        isSearchingProducts,
        isSearchingTenders,
        isLoadingProductSearchMore,
        isLoadingTenderSearchMore,
        productSearchCurrentPage,
        tenderSearchCurrentPage,
        productSearchPageSize,
        tenderSearchPageSize,
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
